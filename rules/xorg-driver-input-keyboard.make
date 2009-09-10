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
PACKAGES-$(PTXCONF_XORG_DRIVER_INPUT_KEYBOARD) += xorg-driver-input-keyboard

#
# Paths and names
#
XORG_DRIVER_INPUT_KEYBOARD_VERSION	:= 1.4.0
XORG_DRIVER_INPUT_KEYBOARD		:= xf86-input-keyboard-$(XORG_DRIVER_INPUT_KEYBOARD_VERSION)
XORG_DRIVER_INPUT_KEYBOARD_SUFFIX	:= tar.bz2
XORG_DRIVER_INPUT_KEYBOARD_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_INPUT_KEYBOARD).$(XORG_DRIVER_INPUT_KEYBOARD_SUFFIX)
XORG_DRIVER_INPUT_KEYBOARD_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_INPUT_KEYBOARD).$(XORG_DRIVER_INPUT_KEYBOARD_SUFFIX)
XORG_DRIVER_INPUT_KEYBOARD_DIR		:= $(BUILDDIR)/$(XORG_DRIVER_INPUT_KEYBOARD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-input-keyboard_get: $(STATEDIR)/xorg-driver-input-keyboard.get

$(STATEDIR)/xorg-driver-input-keyboard.get: $(xorg-driver-input-keyboard_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_INPUT_KEYBOARD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_INPUT_KEYBOARD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-input-keyboard_extract: $(STATEDIR)/xorg-driver-input-keyboard.extract

$(STATEDIR)/xorg-driver-input-keyboard.extract: $(xorg-driver-input-keyboard_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_KEYBOARD_DIR))
	@$(call extract, XORG_DRIVER_INPUT_KEYBOARD)
	@$(call patchin, XORG_DRIVER_INPUT_KEYBOARD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-input-keyboard_prepare: $(STATEDIR)/xorg-driver-input-keyboard.prepare

XORG_DRIVER_INPUT_KEYBOARD_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_INPUT_KEYBOARD_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_INPUT_KEYBOARD_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-input-keyboard.prepare: $(xorg-driver-input-keyboard_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_KEYBOARD_DIR)/config.cache)
	cd $(XORG_DRIVER_INPUT_KEYBOARD_DIR) && \
		$(XORG_DRIVER_INPUT_KEYBOARD_PATH) $(XORG_DRIVER_INPUT_KEYBOARD_ENV) \
		./configure $(XORG_DRIVER_INPUT_KEYBOARD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-input-keyboard_compile: $(STATEDIR)/xorg-driver-input-keyboard.compile

$(STATEDIR)/xorg-driver-input-keyboard.compile: $(xorg-driver-input-keyboard_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_INPUT_KEYBOARD_DIR) && $(XORG_DRIVER_INPUT_KEYBOARD_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-input-keyboard_install: $(STATEDIR)/xorg-driver-input-keyboard.install

$(STATEDIR)/xorg-driver-input-keyboard.install: $(xorg-driver-input-keyboard_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_INPUT_KEYBOARD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-input-keyboard_targetinstall: $(STATEDIR)/xorg-driver-input-keyboard.targetinstall

$(STATEDIR)/xorg-driver-input-keyboard.targetinstall: $(xorg-driver-input-keyboard_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-input-keyboard)
	@$(call install_fixup, xorg-driver-input-keyboard,PACKAGE,xorg-driver-input-keyboard)
	@$(call install_fixup, xorg-driver-input-keyboard,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-input-keyboard,VERSION,$(XORG_DRIVER_INPUT_KEYBOARD_VERSION))
	@$(call install_fixup, xorg-driver-input-keyboard,SECTION,base)
	@$(call install_fixup, xorg-driver-input-keyboard,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-input-keyboard,DEPENDS,)
	@$(call install_fixup, xorg-driver-input-keyboard,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-input-keyboard, 0, 0, 0755, $(XORG_DRIVER_INPUT_KEYBOARD_DIR)/src/.libs/kbd_drv.so, /usr/lib/xorg/modules/kbd_drv.so)

	@$(call install_finish, xorg-driver-input-keyboard)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-input-keyboard_clean:
	rm -rf $(STATEDIR)/xorg-driver-input-keyboard.*
	rm -rf $(PKGDIR)/xorg-driver-input-keyboard_*
	rm -rf $(XORG_DRIVER_INPUT_KEYBOARD_DIR)

# vim: syntax=make
