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
PACKAGES-$(PTXCONF_XORG_DRIVER_INPUT_VOID) += xorg-driver-input-void

#
# Paths and names
#
XORG_DRIVER_INPUT_VOID_VERSION	:= 1.3.0
XORG_DRIVER_INPUT_VOID		:= xf86-input-void-$(XORG_DRIVER_INPUT_VOID_VERSION)
XORG_DRIVER_INPUT_VOID_SUFFIX	:= tar.bz2
XORG_DRIVER_INPUT_VOID_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_INPUT_VOID).$(XORG_DRIVER_INPUT_VOID_SUFFIX)
XORG_DRIVER_INPUT_VOID_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_INPUT_VOID).$(XORG_DRIVER_INPUT_VOID_SUFFIX)
XORG_DRIVER_INPUT_VOID_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_INPUT_VOID)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-input-void_get: $(STATEDIR)/xorg-driver-input-void.get

$(STATEDIR)/xorg-driver-input-void.get: $(xorg-driver-input-void_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_INPUT_VOID_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_INPUT_VOID)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-input-void_extract: $(STATEDIR)/xorg-driver-input-void.extract

$(STATEDIR)/xorg-driver-input-void.extract: $(xorg-driver-input-void_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_VOID_DIR))
	@$(call extract, XORG_DRIVER_INPUT_VOID)
	@$(call patchin, XORG_DRIVER_INPUT_VOID)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-input-void_prepare: $(STATEDIR)/xorg-driver-input-void.prepare

XORG_DRIVER_INPUT_VOID_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_INPUT_VOID_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_INPUT_VOID_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-input-void.prepare: $(xorg-driver-input-void_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_VOID_DIR)/config.cache)
	cd $(XORG_DRIVER_INPUT_VOID_DIR) && \
		$(XORG_DRIVER_INPUT_VOID_PATH) $(XORG_DRIVER_INPUT_VOID_ENV) \
		./configure $(XORG_DRIVER_INPUT_VOID_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-input-void_compile: $(STATEDIR)/xorg-driver-input-void.compile

$(STATEDIR)/xorg-driver-input-void.compile: $(xorg-driver-input-void_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_INPUT_VOID_DIR) && $(XORG_DRIVER_INPUT_VOID_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-input-void_install: $(STATEDIR)/xorg-driver-input-void.install

$(STATEDIR)/xorg-driver-input-void.install: $(xorg-driver-input-void_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_INPUT_VOID)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-input-void_targetinstall: $(STATEDIR)/xorg-driver-input-void.targetinstall

$(STATEDIR)/xorg-driver-input-void.targetinstall: $(xorg-driver-input-void_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-input-void)
	@$(call install_fixup, xorg-driver-input-void,PACKAGE,xorg-driver-input-void)
	@$(call install_fixup, xorg-driver-input-void,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-input-void,VERSION,$(XORG_DRIVER_INPUT_VOID_VERSION))
	@$(call install_fixup, xorg-driver-input-void,SECTION,base)
	@$(call install_fixup, xorg-driver-input-void,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-input-void,DEPENDS,)
	@$(call install_fixup, xorg-driver-input-void,DESCRIPTION,missing)

#FIXME


	@$(call install_finish, xorg-driver-input-void)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-input-void_clean:
	rm -rf $(STATEDIR)/xorg-driver-input-void.*
	rm -rf $(PKGDIR)/xorg-driver-input-void_*
	rm -rf $(XORG_DRIVER_INPUT_VOID_DIR)

# vim: syntax=make
