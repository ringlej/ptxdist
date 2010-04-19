# -*-makefile-*-
#
# Copyright (C) 2006,2010 by Erwin Rol <erwin@erwinrol.com>
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
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_XORG_DRIVER_VIDEO_INTEL) += xorg-driver-video-intel

#
# Paths and names
#
XORG_DRIVER_VIDEO_INTEL_VERSION	:= 2.10.0
XORG_DRIVER_VIDEO_INTEL		:= xf86-video-intel-$(XORG_DRIVER_VIDEO_INTEL_VERSION)
XORG_DRIVER_VIDEO_INTEL_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_INTEL_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_INTEL).$(XORG_DRIVER_VIDEO_INTEL_SUFFIX)
XORG_DRIVER_VIDEO_INTEL_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_INTEL).$(XORG_DRIVER_VIDEO_INTEL_SUFFIX)
XORG_DRIVER_VIDEO_INTEL_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_INTEL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_DRIVER_VIDEO_INTEL_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_DRIVER_VIDEO_INTEL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_DRIVER_VIDEO_INTEL_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_INTEL_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_file__usr_share_X11_sgml_defs_ent=no

#
# autoconf
#
XORG_DRIVER_VIDEO_INTEL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-xorg-module-dir=/usr/lib/xorg/modules \
	--disable-video-debug

ifdef PTXCONF_XORG_DRIVER_VIDEO_INTEL_XVMC
XORG_DRIVER_VIDEO_INTEL_AUTOCONF += --enable-xvmc
else
XORG_DRIVER_VIDEO_INTEL_AUTOCONF += --disable-xvmc
endif

ifdef PTXCONF_XORG_DRIVER_VIDEO_INTEL_KMS_ONLY
XORG_DRIVER_VIDEO_INTEL_AUTOCONF += --enable-kms-only
else
XORG_DRIVER_VIDEO_INTEL_AUTOCONF += --disable-kms-only
endif

ifdef PTXCONF_XORG_DRIVER_VIDEO_INTEL_DRI
XORG_DRIVER_VIDEO_INTEL_AUTOCONF += --enable-dri
XORG_DRIVER_VIDEO_INTEL_ENV += \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/dri.h)=yes \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/sarea.h)=yes \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/dristruct.h)=yes
else
XORG_DRIVER_VIDEO_INTEL_AUTOCONF += --disable-dri
XORG_DRIVER_VIDEO_INTEL_ENV += \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/dri.h)=no \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/sarea.h)=no \
	ac_cv_file_$(call tr_sh,$(SYSROOT)/usr/include/xorg/dristruct.h)=no
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-intel.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-intel)
	@$(call install_fixup,xorg-driver-video-intel,PACKAGE,xorg-driver-video-intel)
	@$(call install_fixup,xorg-driver-video-intel,PRIORITY,optional)
	@$(call install_fixup,xorg-driver-video-intel,VERSION,$(XORG_DRIVER_VIDEO_INTEL_VERSION))
	@$(call install_fixup,xorg-driver-video-intel,SECTION,base)
	@$(call install_fixup,xorg-driver-video-intel,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,xorg-driver-video-intel,DEPENDS,)
	@$(call install_fixup,xorg-driver-video-intel,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-intel, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/drivers/intel_drv.so)

ifdef PTXCONF_XORG_DRIVER_VIDEO_INTEL_XVMC
	@$(call install_copy, xorg-driver-video-intel, 0, 0, 0644, -, \
		/usr/lib/libI810XvMC.so.1.0.0)
	@$(call install_link, xorg-driver-video-intel, \
		libI810XvMC.so.1.0.0, \
		/usr/lib/libI810XvMC.so.1)
	@$(call install_link, xorg-driver-video-intel, \
		libI810XvMC.so.1.0.0, \
		/usr/lib/libI810XvMC.so)

	@$(call install_copy, xorg-driver-video-intel, 0, 0, 0644, -, \
		/usr/lib/libIntelXvMC.so.1.0.0)
	@$(call install_link, xorg-driver-video-intel, \
		libIntelXvMC.so.1.0.0, \
		/usr/lib/libIntelXvMC.so.1)
	@$(call install_link, xorg-driver-video-intel, \
		libIntelXvMC.so.1.0.0, \
		/usr/lib/libIntelXvMC.so)
endif

	@$(call install_finish,xorg-driver-video-intel)

	@$(call touch)

# vim: syntax=make
