# -*-makefile-*-
# $Id: template 3821 2006-01-12 08:09:04Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MESA) += mesa

#
# Paths and names
#
MESA_VERSION	= 6.4.1
MESA		= mesa-$(MESA_VERSION)
MESA_SUFFIX	= tar.bz
MESA_URL	= $(PTXCONF_SETUP_SFMIRROR)/sourceforge/mesa3d/$(MESA).$(MESA_SUFFIX)
MESA_SOURCE	= $(SRCDIR)/$(MESA).$(MESA_SUFFIX)
MESA_DIR	= $(BUILDDIR)/$(MESA)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mesa_get: $(STATEDIR)/mesa.get

$(STATEDIR)/mesa.get: $(MESA_SOURCE)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MESA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MESA_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mesa_extract: $(STATEDIR)/mesa.extract

$(STATEDIR)/mesa.extract: $(mesa_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MESA_DIR))
	@$(call extract, $(MESA_SOURCE))
	@$(call patchin, $(MESA))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mesa_prepare: $(STATEDIR)/mesa.prepare

MESA_PATH	=  PATH=$(CROSS_PATH)
MESA_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
MESA_AUTOCONF =  $(CROSS_AUTOCONF_USR)
MESA_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/mesa.prepare: $(mesa_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MESA_DIR)/config.cache)
	cd $(MESA_DIR) && \
		$(MESA_PATH) $(MESA_ENV) \
		./configure $(MESA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mesa_compile: $(STATEDIR)/mesa.compile

$(STATEDIR)/mesa.compile: $(mesa_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(MESA_DIR) && $(MESA_ENV) $(MESA_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mesa_install: $(STATEDIR)/mesa.install

$(STATEDIR)/mesa.install: $(STATEDIR)/mesa.compile
	@$(call targetinfo, $@)
	@$(call install, MESA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mesa_targetinstall: $(STATEDIR)/mesa.targetinstall

$(STATEDIR)/mesa.targetinstall: $(mesa_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,mesa)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(MESA_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(MESA_DIR)/foobar, /dev/null)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mesa_clean:
	rm -rf $(STATEDIR)/mesa.*
	rm -rf $(IMAGEDIR)/mesa_*
	rm -rf $(MESA_DIR)

# vim: syntax=make
