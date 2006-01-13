# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CLEMENTINE) += clementine

#
# Paths and names
#
CLEMENTINE_VERSION	= 0.0.7
CLEMENTINE		= clementine-$(CLEMENTINE_VERSION)
CLEMENTINE_SUFFIX	= tar.gz
CLEMENTINE_URL		= $(PTXCONF_SETUP_SFMIRROR)/clementine/$(CLEMENTINE).$(CLEMENTINE_SUFFIX)
CLEMENTINE_SOURCE	= $(SRCDIR)/$(CLEMENTINE).$(CLEMENTINE_SUFFIX)
CLEMENTINE_DIR		= $(BUILDDIR)/$(CLEMENTINE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

clementine_get: $(STATEDIR)/clementine.get

$(STATEDIR)/clementine.get: $(clementine_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CLEMENTINE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CLEMENTINE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

clementine_extract: $(STATEDIR)/clementine.extract

$(STATEDIR)/clementine.extract: $(clementine_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CLEMENTINE_DIR))
	@$(call extract, $(CLEMENTINE_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

clementine_prepare: $(STATEDIR)/clementine.prepare

CLEMENTINE_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
CLEMENTINE_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/clementine.prepare: $(clementine_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CLEMENTINE_BUILDDIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

clementine_compile: $(STATEDIR)/clementine.compile

$(STATEDIR)/clementine.compile: $(clementine_compile_deps_default)
	@$(call targetinfo, $@)
	$(CLEMENTINE_PATH) $(CLEMENTINE_ENV) make -C $(CLEMENTINE_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

clementine_install: $(STATEDIR)/clementine.install

$(STATEDIR)/clementine.install: $(clementine_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, CLEMENTINE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

clementine_targetinstall: $(STATEDIR)/clementine.targetinstall

$(STATEDIR)/clementine.targetinstall: $(clementine_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,clementine)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(CLEMENTINE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(CLEMENTINE_DIR)/clementine, /usr/X11R6/bin/clementine)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

clementine_clean:
	rm -rf $(STATEDIR)/clementine.*
	rm -rf $(IMAGEDIR)/clementine_*
	rm -rf $(CLEMENTINE_DIR)

# vim: syntax=make
