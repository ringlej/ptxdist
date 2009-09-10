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
PACKAGES-$(PTXCONF_XORG_DRIVER_INPUT_MOUSE) += xorg-driver-input-mouse

#
# Paths and names
#
XORG_DRIVER_INPUT_MOUSE_VERSION	:= 1.5.0
XORG_DRIVER_INPUT_MOUSE		:= xf86-input-mouse-$(XORG_DRIVER_INPUT_MOUSE_VERSION)
XORG_DRIVER_INPUT_MOUSE_SUFFIX	:= tar.bz2
XORG_DRIVER_INPUT_MOUSE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_INPUT_MOUSE).$(XORG_DRIVER_INPUT_MOUSE_SUFFIX)
XORG_DRIVER_INPUT_MOUSE_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_INPUT_MOUSE).$(XORG_DRIVER_INPUT_MOUSE_SUFFIX)
XORG_DRIVER_INPUT_MOUSE_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_INPUT_MOUSE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-input-mouse_get: $(STATEDIR)/xorg-driver-input-mouse.get

$(STATEDIR)/xorg-driver-input-mouse.get: $(xorg-driver-input-mouse_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_INPUT_MOUSE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_INPUT_MOUSE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-input-mouse_extract: $(STATEDIR)/xorg-driver-input-mouse.extract

$(STATEDIR)/xorg-driver-input-mouse.extract: $(xorg-driver-input-mouse_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_MOUSE_DIR))
	@$(call extract, XORG_DRIVER_INPUT_MOUSE)
	@$(call patchin, XORG_DRIVER_INPUT_MOUSE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-input-mouse_prepare: $(STATEDIR)/xorg-driver-input-mouse.prepare

XORG_DRIVER_INPUT_MOUSE_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_INPUT_MOUSE_ENV 	:=  $(CROSS_ENV) \
	ac_cv_file__usr_share_sgml_X11_defs_ent=no

#
# autoconf
#
XORG_DRIVER_INPUT_MOUSE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/xorg-driver-input-mouse.prepare: $(xorg-driver-input-mouse_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_MOUSE_DIR)/config.cache)
	cd $(XORG_DRIVER_INPUT_MOUSE_DIR) && \
		$(XORG_DRIVER_INPUT_MOUSE_PATH) $(XORG_DRIVER_INPUT_MOUSE_ENV) \
		./configure $(XORG_DRIVER_INPUT_MOUSE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-input-mouse_compile: $(STATEDIR)/xorg-driver-input-mouse.compile

$(STATEDIR)/xorg-driver-input-mouse.compile: $(xorg-driver-input-mouse_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_INPUT_MOUSE_DIR) && $(XORG_DRIVER_INPUT_MOUSE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-input-mouse_install: $(STATEDIR)/xorg-driver-input-mouse.install

$(STATEDIR)/xorg-driver-input-mouse.install: $(xorg-driver-input-mouse_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_INPUT_MOUSE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-input-mouse_targetinstall: $(STATEDIR)/xorg-driver-input-mouse.targetinstall

$(STATEDIR)/xorg-driver-input-mouse.targetinstall: $(xorg-driver-input-mouse_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-input-mouse)
	@$(call install_fixup, xorg-driver-input-mouse,PACKAGE,xorg-driver-input-mouse)
	@$(call install_fixup, xorg-driver-input-mouse,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-input-mouse,VERSION,$(XORG_DRIVER_INPUT_MOUSE_VERSION))
	@$(call install_fixup, xorg-driver-input-mouse,SECTION,base)
	@$(call install_fixup, xorg-driver-input-mouse,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-input-mouse,DEPENDS,)
	@$(call install_fixup, xorg-driver-input-mouse,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-input-mouse, 0, 0, 0755, $(XORG_DRIVER_INPUT_MOUSE_DIR)/src/.libs/mouse_drv.so, /usr/lib/xorg/modules/mouse_drv.so)

	@$(call install_finish, xorg-driver-input-mouse)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-input-mouse_clean:
	rm -rf $(STATEDIR)/xorg-driver-input-mouse.*
	rm -rf $(PKGDIR)/xorg-driver-input-mouse_*
	rm -rf $(XORG_DRIVER_INPUT_MOUSE_DIR)

# vim: syntax=make
