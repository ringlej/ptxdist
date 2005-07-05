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
ifdef PTXCONF_JVISU
PACKAGES += jvisu
endif

#
# Paths and names
#
JVISU_VERSION	= 1.0.0
JVISU		= JVisu-$(JVISU_VERSION)
JVISU_SUFFIX	= tgz
JVISU_URL	= http://www.jvisu.com/download/archive/$(JVISU).$(JVISU_SUFFIX)
JVISU_SOURCE	= $(SRCDIR)/$(JVISU).$(JVISU_SUFFIX)
JVISU_DIR	= $(BUILDDIR)/$(JVISU)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

jvisu_get: $(STATEDIR)/jvisu.get

jvisu_get_deps = $(JVISU_SOURCE)

$(STATEDIR)/jvisu.get: $(jvisu_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(JVISU))
	touch $@

$(JVISU_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(JVISU_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

jvisu_extract: $(STATEDIR)/jvisu.extract

jvisu_extract_deps = $(STATEDIR)/jvisu.get

$(STATEDIR)/jvisu.extract: $(jvisu_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(JVISU_DIR))
	@$(call extract, $(JVISU_SOURCE))
	@$(call patchin, $(JVISU))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

jvisu_prepare: $(STATEDIR)/jvisu.prepare

#
# dependencies
#
jvisu_prepare_deps = \
	$(STATEDIR)/jvisu.extract \
	$(STATEDIR)/virtual-xchain.install

JVISU_PATH	=  PATH=$(CROSS_PATH)
JVISU_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/jvisu.prepare: $(jvisu_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(JVISU_DIR)/config.cache)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

jvisu_compile: $(STATEDIR)/jvisu.compile

jvisu_compile_deps = $(STATEDIR)/jvisu.prepare

$(STATEDIR)/jvisu.compile: $(jvisu_compile_deps)
	@$(call targetinfo, $@)

	# FIXME: we need ant to do this; should we make it a host tool? 
	cd $(JVISU_DIR) && $(JVISU_ENV) $(JVISU_PATH) ./build.sh jar

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

jvisu_install: $(STATEDIR)/jvisu.install

$(STATEDIR)/jvisu.install: $(STATEDIR)/jvisu.compile
	@$(call targetinfo, $@)
	cd $(JVISU_DIR) && $(JVISU_ENV) $(JVISU_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

jvisu_targetinstall: $(STATEDIR)/jvisu.targetinstall

jvisu_targetinstall_deps = $(STATEDIR)/jvisu.compile

$(STATEDIR)/jvisu.targetinstall: $(jvisu_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,jvisu)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(JVISU_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(COREUTILS_DIR)/foobar, /dev/null)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

jvisu_clean:
	rm -rf $(STATEDIR)/jvisu.*
	rm -rf $(IMAGEDIR)/jvisu_*
	rm -rf $(JVISU_DIR)

# vim: syntax=make
