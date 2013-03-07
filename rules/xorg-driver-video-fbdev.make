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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_FBDEV) += xorg-driver-video-fbdev

#
# Paths and names
#
XORG_DRIVER_VIDEO_FBDEV_VERSION	:= 0.4.2
XORG_DRIVER_VIDEO_FBDEV_MD5	:= 53a533d9e0c2da50962282526bace074
XORG_DRIVER_VIDEO_FBDEV		:= xf86-video-fbdev-$(XORG_DRIVER_VIDEO_FBDEV_VERSION)
XORG_DRIVER_VIDEO_FBDEV_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_FBDEV_URL	:= $(call ptx/mirror, XORG, individual/driver/$(XORG_DRIVER_VIDEO_FBDEV).$(XORG_DRIVER_VIDEO_FBDEV_SUFFIX))
XORG_DRIVER_VIDEO_FBDEV_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_FBDEV).$(XORG_DRIVER_VIDEO_FBDEV_SUFFIX)
XORG_DRIVER_VIDEO_FBDEV_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_FBDEV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# Do not resolve symbols in fbdev_drv.so at load time, so it has a chance
# to load the libfbdevhw.so submodule before using its symbols.
# This fixes the following error when starting Xorg:
# (EE) Failed to load /usr/lib/xorg/modules/drivers/fbdev_drv.so: /usr/lib/xorg/modules/drivers/fbdev_drv.so: undefined symbol: fbdevHWSave
XORG_DRIVER_VIDEO_FBDEV_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_BINDNOW

XORG_DRIVER_VIDEO_FBDEV_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_FBDEV_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_FBDEV_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-fbdev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-fbdev)
	@$(call install_fixup, xorg-driver-video-fbdev,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-fbdev,SECTION,base)
	@$(call install_fixup, xorg-driver-video-fbdev,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-fbdev,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-fbdev, 0, 0, 0755, -, \
		/usr/lib/xorg/modules/drivers/fbdev_drv.so)

	@$(call install_finish, xorg-driver-video-fbdev)

	@$(call touch)

# vim: syntax=make
