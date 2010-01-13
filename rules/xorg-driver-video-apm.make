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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_APM) += xorg-driver-video-apm

#
# Paths and names
#
XORG_DRIVER_VIDEO_APM_VERSION	:= 1.2.2
XORG_DRIVER_VIDEO_APM		:= xf86-video-apm-$(XORG_DRIVER_VIDEO_APM_VERSION)
XORG_DRIVER_VIDEO_APM_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_APM_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_APM).$(XORG_DRIVER_VIDEO_APM_SUFFIX)
XORG_DRIVER_VIDEO_APM_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_APM).$(XORG_DRIVER_VIDEO_APM_SUFFIX)
XORG_DRIVER_VIDEO_APM_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_APM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DRIVER_VIDEO_APM_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DRIVER_VIDEO_APM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DRIVER_VIDEO_APM_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_APM_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_file__usr_share_X11_sgml_defs_ent=no

#
# autoconf
#
XORG_DRIVER_VIDEO_APM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-apm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-apm)
	@$(call install_fixup, xorg-driver-video-apm,PACKAGE,xorg-driver-video-apm)
	@$(call install_fixup, xorg-driver-video-apm,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-apm,VERSION,$(XORG_DRIVER_VIDEO_APM_VERSION))
	@$(call install_fixup, xorg-driver-video-apm,SECTION,base)
	@$(call install_fixup, xorg-driver-video-apm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-apm,DEPENDS,)
	@$(call install_fixup, xorg-driver-video-apm,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-apm, 0, 0, 0755, -, \
		/usr/lib/xorg/modules/drivers/apm_drv.so)

	@$(call install_finish, xorg-driver-video-apm)

	@$(call touch)

# vim: syntax=make
