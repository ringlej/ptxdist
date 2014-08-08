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
XORG_DRIVER_VIDEO_INTEL_VERSION	:= 2.21.15
XORG_DRIVER_VIDEO_INTEL_MD5	:= 8b646d257ace8197d6ab4e5ddeb8efb2
XORG_DRIVER_VIDEO_INTEL		:= xf86-video-intel-$(XORG_DRIVER_VIDEO_INTEL_VERSION)
XORG_DRIVER_VIDEO_INTEL_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_INTEL_URL	:= $(call ptx/mirror, XORG, individual/driver/$(XORG_DRIVER_VIDEO_INTEL).$(XORG_DRIVER_VIDEO_INTEL_SUFFIX))
XORG_DRIVER_VIDEO_INTEL_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_INTEL).$(XORG_DRIVER_VIDEO_INTEL_SUFFIX)
XORG_DRIVER_VIDEO_INTEL_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_INTEL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_DRIVER_VIDEO_INTEL_CONF_TOOL	:= autoconf
XORG_DRIVER_VIDEO_INTEL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-gen4asm \
	--enable-udev \
	--$(call ptx/endis, PTXCONF_XORG_DRIVER_VIDEO_INTEL_DRI)-dri \
	--$(call ptx/endis, PTXCONF_XORG_DRIVER_VIDEO_INTEL_XVMC)-xvmc \
	--enable-kms-only \
	--disable-ums-only \
	--disable-sna \
	--enable-uxa \
	--disable-glamor \
	--disable-xaa \
	--disable-dga \
	--disable-create2 \
	--disable-userptr \
	--disable-async-swap \
	--disable-wt \
	--disable-debug \
	--disable-valgrind

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-driver-video-intel.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-driver-video-intel)
	@$(call install_fixup, xorg-driver-video-intel,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-intel,SECTION,base)
	@$(call install_fixup, xorg-driver-video-intel,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-intel,DESCRIPTION,missing)

	@$(call install_lib, xorg-driver-video-intel, 0, 0, 0644, \
		xorg/modules/drivers/intel_drv)

ifdef PTXCONF_XORG_DRIVER_VIDEO_INTEL_XVMC
	@$(call install_lib, xorg-driver-video-intel, 0, 0, 0644, libIntelXvMC)
endif
	@$(call install_finish, xorg-driver-video-intel)

	@$(call touch)

# vim: syntax=make
