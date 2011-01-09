# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
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
XORG_DRIVER_INPUT_MOUSE_VERSION	:= 1.6.0
XORG_DRIVER_INPUT_MOUSE		:= xf86-input-mouse-$(XORG_DRIVER_INPUT_MOUSE_VERSION)
XORG_DRIVER_INPUT_MOUSE_SUFFIX	:= tar.bz2
XORG_DRIVER_INPUT_MOUSE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_INPUT_MOUSE).$(XORG_DRIVER_INPUT_MOUSE_SUFFIX)
XORG_DRIVER_INPUT_MOUSE_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_INPUT_MOUSE).$(XORG_DRIVER_INPUT_MOUSE_SUFFIX)
XORG_DRIVER_INPUT_MOUSE_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_INPUT_MOUSE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DRIVER_INPUT_MOUSE_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DRIVER_INPUT_MOUSE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DRIVER_INPUT_MOUSE_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_INPUT_MOUSE_ENV 	:=  $(CROSS_ENV) \
	ac_cv_file__usr_share_sgml_X11_defs_ent=no

#
# autoconf
#
XORG_DRIVER_INPUT_MOUSE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-input-mouse.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-input-mouse)
	@$(call install_fixup, xorg-driver-input-mouse,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-input-mouse,SECTION,base)
	@$(call install_fixup, xorg-driver-input-mouse,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-input-mouse,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-input-mouse, 0, 0, 0755, -, \
		/usr/lib/xorg/modules/input/mouse_drv.so)

	@$(call install_finish, xorg-driver-input-mouse)

	@$(call touch)

# vim: syntax=make
