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
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_XORG_DRIVER_VIDEO_ATI) += xorg-driver-video-ati
PACKAGES-$(PTXCONF_ARCH_PPC)-$(PTXCONF_XORG_DRIVER_VIDEO_ATI) += xorg-driver-video-ati

#
# Paths and names
#
XORG_DRIVER_VIDEO_ATI_VERSION	:= 6.13.2
XORG_DRIVER_VIDEO_ATI_MD5	:= a8f92fe3c458e511f4e2ead7f92c02b0
XORG_DRIVER_VIDEO_ATI		:= xf86-video-ati-$(XORG_DRIVER_VIDEO_ATI_VERSION)
XORG_DRIVER_VIDEO_ATI_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_ATI_URL	:= $(call ptx/mirror, XORG, individual/driver/$(XORG_DRIVER_VIDEO_ATI).$(XORG_DRIVER_VIDEO_ATI_SUFFIX))
XORG_DRIVER_VIDEO_ATI_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_ATI).$(XORG_DRIVER_VIDEO_ATI_SUFFIX)
XORG_DRIVER_VIDEO_ATI_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_ATI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DRIVER_VIDEO_ATI_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DRIVER_VIDEO_ATI)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DRIVER_VIDEO_ATI_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_ATI_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_ATI_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_XORG_DRIVER_VIDEO_ATI_DRI
XORG_DRIVER_VIDEO_ATI_AUTOCONF += --enable-dri
else
XORG_DRIVER_VIDEO_ATI_AUTOCONF += --disable-dri
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-ati.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-ati)
	@$(call install_fixup, xorg-driver-video-ati,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-ati,SECTION,base)
	@$(call install_fixup, xorg-driver-video-ati,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-ati,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-ati, 0, 0, 0755, -, /usr/lib/xorg/modules/drivers/ati_drv.so)
	@$(call install_copy, xorg-driver-video-ati, 0, 0, 0755, -, /usr/lib/xorg/modules/drivers/radeon_drv.so)
	@$(call install_copy, xorg-driver-video-ati, 0, 0, 0755, -, /usr/lib/xorg/modules/multimedia/theatre200_drv.so)
	@$(call install_copy, xorg-driver-video-ati, 0, 0, 0755, -, /usr/lib/xorg/modules/multimedia/theatre_detect_drv.so)
	@$(call install_copy, xorg-driver-video-ati, 0, 0, 0755, -, /usr/lib/xorg/modules/multimedia/theatre_drv.so)

	@$(call install_finish, xorg-driver-video-ati)

	@$(call touch)

# vim: syntax=make
