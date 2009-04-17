# -*-makefile-*-
# $Id: template 5616 2006-06-02 13:50:47Z rsc $
#
# Copyright (C) 2006 by Erwin Rol
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_XORG_DRIVER_VIDEO_I810) += xorg-driver-video-i810

#
# Paths and names
#
XORG_DRIVER_VIDEO_I810_VERSION	:= 1.6.5
XORG_DRIVER_VIDEO_I810		:= xf86-video-i810-$(XORG_DRIVER_VIDEO_I810_VERSION)
XORG_DRIVER_VIDEO_I810_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_I810_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_I810).$(XORG_DRIVER_VIDEO_I810_SUFFIX)
XORG_DRIVER_VIDEO_I810_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_I810).$(XORG_DRIVER_VIDEO_I810_SUFFIX)
XORG_DRIVER_VIDEO_I810_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_I810)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DRIVER_VIDEO_I810_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DRIVER_VIDEO_I810)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DRIVER_VIDEO_I810_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_I810_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_file__usr_share_X11_sgml_defs_ent=no

#
# autoconf
#
XORG_DRIVER_VIDEO_I810_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_XORG_DRIVER_VIDEO_I810_DRI
XORG_DRIVER_VIDEO_I810_AUTOCONF += --enable-dri
XORG_DRIVER_VIDEO_I810_ENV += \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/dri.h)=yes \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/sarea.h)=yes \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/dristruct.h)=yes
else
XORG_DRIVER_VIDEO_I810_AUTOCONF += --disable-dri
XORG_DRIVER_VIDEO_I810_ENV += \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/dri.h)=no \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/sarea.h)=no \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/dristruct.h)=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-i810.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-i810)
	@$(call install_fixup,xorg-driver-video-i810,PACKAGE,xorg-driver-video-i810)
	@$(call install_fixup,xorg-driver-video-i810,PRIORITY,optional)
	@$(call install_fixup,xorg-driver-video-i810,VERSION,$(XORG_DRIVER_VIDEO_I810_VERSION))
	@$(call install_fixup,xorg-driver-video-i810,SECTION,base)
	@$(call install_fixup,xorg-driver-video-i810,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,xorg-driver-video-i810,DEPENDS,)
	@$(call install_fixup,xorg-driver-video-i810,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-i810, 0, 0, 0755, \
		$(XORG_DRIVER_VIDEO_I810_DIR)/src/.libs/i810_drv.so, \
		/usr/lib/xorg/modules/i810_drv.so)

	@$(call install_copy, xorg-driver-video-i810, 0, 0, 0644, \
		$(XORG_DRIVER_VIDEO_I810_DIR)/src/xvmc/.libs/libI810XvMC.so.1.0.0, \
		/usr/lib/libI810XvMC.so.1.0.0)
	@$(call install_link, xorg-driver-video-i810, \
		libI810XvMC.so.1.0.0, /usr/lib/libI810XvMC.so.1)
	@$(call install_link, xorg-driver-video-i810, \
		libI810XvMC.so.1.0.0, /usr/lib/libI810XvMC.so)

	@$(call install_finish,xorg-driver-video-i810)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-i810_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-i810.*
	rm -rf $(PKGDIR)/xorg-driver-video-i810_*
	rm -rf $(XORG_DRIVER_VIDEO_I810_DIR)

# vim: syntax=make
