# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
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
XORG_DRIVER_INPUT_KEYBOARD_VERSION	:= 1.5.0
XORG_DRIVER_INPUT_KEYBOARD_MD5		:= b74d7162db5ce7899c17927c6cfa9522
XORG_DRIVER_INPUT_KEYBOARD		:= xf86-input-keyboard-$(XORG_DRIVER_INPUT_KEYBOARD_VERSION)
XORG_DRIVER_INPUT_KEYBOARD_SUFFIX	:= tar.bz2
XORG_DRIVER_INPUT_KEYBOARD_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_INPUT_KEYBOARD).$(XORG_DRIVER_INPUT_KEYBOARD_SUFFIX)
XORG_DRIVER_INPUT_KEYBOARD_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_INPUT_KEYBOARD).$(XORG_DRIVER_INPUT_KEYBOARD_SUFFIX)
XORG_DRIVER_INPUT_KEYBOARD_DIR		:= $(BUILDDIR)/$(XORG_DRIVER_INPUT_KEYBOARD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DRIVER_INPUT_KEYBOARD_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DRIVER_INPUT_KEYBOARD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DRIVER_INPUT_KEYBOARD_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_INPUT_KEYBOARD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_INPUT_KEYBOARD_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-input-keyboard.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-input-keyboard)
	@$(call install_fixup, xorg-driver-input-keyboard,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-input-keyboard,SECTION,base)
	@$(call install_fixup, xorg-driver-input-keyboard,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-input-keyboard,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-input-keyboard, 0, 0, 0755, -, \
		/usr/lib/xorg/modules/input/kbd_drv.so)

	@$(call install_finish, xorg-driver-input-keyboard)

	@$(call touch)

# vim: syntax=make
