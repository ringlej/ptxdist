# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_XVMC) += xorg-lib-xvmc

#
# Paths and names
#
XORG_LIB_XVMC_VERSION	:= 1.0.5
XORG_LIB_XVMC		:= libXvMC-$(XORG_LIB_XVMC_VERSION)
XORG_LIB_XVMC_SUFFIX	:= tar.bz2
XORG_LIB_XVMC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XVMC).$(XORG_LIB_XVMC_SUFFIX)
XORG_LIB_XVMC_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XVMC).$(XORG_LIB_XVMC_SUFFIX)
XORG_LIB_XVMC_DIR	:= $(BUILDDIR)/$(XORG_LIB_XVMC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xvmc_get: $(STATEDIR)/xorg-lib-xvmc.get

$(STATEDIR)/xorg-lib-xvmc.get: $(xorg-lib-xvmc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XVMC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XVMC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xvmc_extract: $(STATEDIR)/xorg-lib-xvmc.extract

$(STATEDIR)/xorg-lib-xvmc.extract: $(xorg-lib-xvmc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XVMC_DIR))
	@$(call extract, XORG_LIB_XVMC)
	@$(call patchin, XORG_LIB_XVMC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xvmc_prepare: $(STATEDIR)/xorg-lib-xvmc.prepare

XORG_LIB_XVMC_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XVMC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XVMC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xvmc.prepare: $(xorg-lib-xvmc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XVMC_DIR)/config.cache)
	cd $(XORG_LIB_XVMC_DIR) && \
		$(XORG_LIB_XVMC_PATH) $(XORG_LIB_XVMC_ENV) \
		./configure $(XORG_LIB_XVMC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xvmc_compile: $(STATEDIR)/xorg-lib-xvmc.compile

$(STATEDIR)/xorg-lib-xvmc.compile: $(xorg-lib-xvmc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XVMC_DIR) && $(XORG_LIB_XVMC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xvmc_install: $(STATEDIR)/xorg-lib-xvmc.install

$(STATEDIR)/xorg-lib-xvmc.install: $(xorg-lib-xvmc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XVMC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xvmc_targetinstall: $(STATEDIR)/xorg-lib-xvmc.targetinstall

$(STATEDIR)/xorg-lib-xvmc.targetinstall: $(xorg-lib-xvmc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xvmc)
	@$(call install_fixup, xorg-lib-xvmc,PACKAGE,xorg-lib-xvmc)
	@$(call install_fixup, xorg-lib-xvmc,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xvmc,VERSION,$(XORG_LIB_XVMC_VERSION))
	@$(call install_fixup, xorg-lib-xvmc,SECTION,base)
	@$(call install_fixup, xorg-lib-xvmc,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xvmc,DEPENDS,)
	@$(call install_fixup, xorg-lib-xvmc,DESCRIPTION,missing)

# FIXME

	@$(call install_finish, xorg-lib-xvmc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xvmc_clean:
	rm -rf $(STATEDIR)/xorg-lib-xvmc.*
	rm -rf $(PKGDIR)/xorg-lib-xvmc_*
	rm -rf $(XORG_LIB_XVMC_DIR)

# vim: syntax=make
