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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_DUMMY) += xorg-driver-video-dummy

#
# Paths and names
#
XORG_DRIVER_VIDEO_DUMMY_VERSION	:= 0.3.4
XORG_DRIVER_VIDEO_DUMMY_MD5	:= 1cf99415c998994f2e88575f942b364c
XORG_DRIVER_VIDEO_DUMMY		:= xf86-video-dummy-$(XORG_DRIVER_VIDEO_DUMMY_VERSION)
XORG_DRIVER_VIDEO_DUMMY_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_DUMMY_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_DUMMY).$(XORG_DRIVER_VIDEO_DUMMY_SUFFIX)
XORG_DRIVER_VIDEO_DUMMY_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_DUMMY).$(XORG_DRIVER_VIDEO_DUMMY_SUFFIX)
XORG_DRIVER_VIDEO_DUMMY_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_DUMMY)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DRIVER_VIDEO_DUMMY_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DRIVER_VIDEO_DUMMY)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DRIVER_VIDEO_DUMMY_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_DUMMY_ENV 	:=  $(CROSS_ENV) PKG_SYSROOT=$(SYSROOT)

#
# autoconf
#
XORG_DRIVER_VIDEO_DUMMY_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-dummy.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-dummy)
	@$(call install_fixup, xorg-driver-video-dummy,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-dummy,SECTION,base)
	@$(call install_fixup, xorg-driver-video-dummy,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-dummy,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-dummy, 0, 0, 0755, -, \
		/usr/lib/xorg/modules/drivers/dummy_drv.so)

	@$(call install_finish, xorg-driver-video-dummy)

	@$(call touch)

# vim: syntax=make
