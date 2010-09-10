# -*-makefile-*-
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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_V4L) += xorg-driver-video-v4l

#
# Paths and names
#
XORG_DRIVER_VIDEO_V4L_VERSION	:= 0.2.0
XORG_DRIVER_VIDEO_V4L		:= xf86-video-v4l-$(XORG_DRIVER_VIDEO_V4L_VERSION)
XORG_DRIVER_VIDEO_V4L_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_V4L_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_V4L).$(XORG_DRIVER_VIDEO_V4L_SUFFIX)
XORG_DRIVER_VIDEO_V4L_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_V4L).$(XORG_DRIVER_VIDEO_V4L_SUFFIX)
XORG_DRIVER_VIDEO_V4L_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_V4L)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DRIVER_VIDEO_V4L_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DRIVER_VIDEO_V4L)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DRIVER_VIDEO_V4L_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_V4L_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_V4L_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-v4l.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-v4l)
	@$(call install_fixup, xorg-driver-video-v4l,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-v4l,SECTION,base)
	@$(call install_fixup, xorg-driver-video-v4l,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-v4l,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-v4l, 0, 0, 0755, -, \
		/usr/lib/xorg/modules/drivers/v4l_drv.so)

	@$(call install_finish, xorg-driver-video-v4l)

	@$(call touch)

# vim: syntax=make
