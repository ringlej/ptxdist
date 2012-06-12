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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_VESA) += xorg-driver-video-vesa

#
# Paths and names
#
XORG_DRIVER_VIDEO_VESA_VERSION	:= 2.3.1
XORG_DRIVER_VIDEO_VESA_MD5	:= 02e6eacc2d1e07ac893b62481905d6f0
XORG_DRIVER_VIDEO_VESA		:= xf86-video-vesa-$(XORG_DRIVER_VIDEO_VESA_VERSION)
XORG_DRIVER_VIDEO_VESA_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_VESA_URL	:= $(call ptx/mirror, XORG, individual/driver/$(XORG_DRIVER_VIDEO_VESA).$(XORG_DRIVER_VIDEO_VESA_SUFFIX))
XORG_DRIVER_VIDEO_VESA_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_VESA).$(XORG_DRIVER_VIDEO_VESA_SUFFIX)
XORG_DRIVER_VIDEO_VESA_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_VESA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_DRIVER_VIDEO_VESA_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-vesa.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-vesa)
	@$(call install_fixup, xorg-driver-video-vesa,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-vesa,SECTION,base)
	@$(call install_fixup, xorg-driver-video-vesa,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-vesa,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-vesa, 0, 0, 0755, -, \
		/usr/lib/xorg/modules/drivers/vesa_drv.so)

	@$(call install_finish, xorg-driver-video-vesa)

	@$(call touch)

# vim: syntax=make
