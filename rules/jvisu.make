# $Id$
#
# Copyright (C) 2005 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_JVISU) += jvisu

#
# Paths and names
#
JVISU_VERSION	:= 1.0.0
JVISU		:= JVisu-$(JVISU_VERSION)
JVISU_SUFFIX	:= tgz
JVISU_URL	:= http://www.pengutronix.de/software/jvisu/download/archive/$(JVISU).$(JVISU_SUFFIX)
JVISU_SOURCE	:= $(SRCDIR)/$(JVISU).$(JVISU_SUFFIX)
JVISU_DIR	:= $(BUILDDIR)/$(JVISU)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

jvisu_get: $(STATEDIR)/jvisu.get

$(STATEDIR)/jvisu.get: $(jvisu_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(JVISU_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, JVISU)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

jvisu_extract: $(STATEDIR)/jvisu.extract

$(STATEDIR)/jvisu.extract: $(jvisu_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(JVISU_DIR))
	@$(call extract, JVISU)
	@$(call patchin, JVISU)

	# FIXME: we cannot currently overwrite the JAVAPATH on the command line,
	# so we tweak it here in a way that it works at least with Debian
	sed -i -e "s,^JAVAPATH=.*$$,JAVAPATH=$(PTXCONF_SETUP_JAVA_SDK),g" $(JVISU_DIR)/build.properties

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

jvisu_prepare: $(STATEDIR)/jvisu.prepare

JVISU_PATH	=  PATH=$(PTXCONF_SETUP_JAVA_SDK)/bin:$(CROSS_PATH)
JVISU_ENV 	=  $(CROSS_ENV)
JVISU_ENV	+= JAVA_HOME=$(PTXCONF_SETUP_JAVA_SDK)

$(STATEDIR)/jvisu.prepare: $(jvisu_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(JVISU_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

jvisu_compile: $(STATEDIR)/jvisu.compile

$(STATEDIR)/jvisu.compile: $(jvisu_compile_deps_default)
	@$(call targetinfo, $@)

	# FIXME: we need ant to do this; should we make it a host tool? 
	cd $(JVISU_DIR) && $(JVISU_ENV) $(JVISU_PATH) ./build.sh jar

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

jvisu_install: $(STATEDIR)/jvisu.install

$(STATEDIR)/jvisu.install: $(jvisu_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

jvisu_targetinstall: $(STATEDIR)/jvisu.targetinstall

$(STATEDIR)/jvisu.targetinstall: $(jvisu_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, jvisu)
	@$(call install_fixup, jvisu,PACKAGE,jvisu)
	@$(call install_fixup, jvisu,PRIORITY,optional)
	@$(call install_fixup, jvisu,VERSION,$(JVISU_VERSION))
	@$(call install_fixup, jvisu,SECTION,base)
	@$(call install_fixup, jvisu,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, jvisu,DEPENDS,)
	@$(call install_fixup, jvisu,DESCRIPTION,missing)

ifdef PTXCONF_JVISU_APPLET
	# User: www; Group: www
	@$(call install_copy, jvisu, 12, 102, 0644, $(JVISU_DIR)/jar/jvisu.jar, $(PTXCONF_JVISU_APPLET_PATH)/jvisu.jar, n)
endif

	@$(call install_finish, jvisu)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

jvisu_clean:
	rm -rf $(STATEDIR)/jvisu.*
	rm -rf $(IMAGEDIR)/jvisu_*
	rm -rf $(JVISU_DIR)

# vim: syntax=make
