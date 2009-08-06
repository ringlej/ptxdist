# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_FBDEV) += xorg-driver-video-fbdev

#
# Paths and names
#
XORG_DRIVER_VIDEO_FBDEV_VERSION	:= 0.4.1
XORG_DRIVER_VIDEO_FBDEV		:= xf86-video-fbdev-$(XORG_DRIVER_VIDEO_FBDEV_VERSION)
XORG_DRIVER_VIDEO_FBDEV_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_FBDEV_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_FBDEV).$(XORG_DRIVER_VIDEO_FBDEV_SUFFIX)
XORG_DRIVER_VIDEO_FBDEV_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_FBDEV).$(XORG_DRIVER_VIDEO_FBDEV_SUFFIX)
XORG_DRIVER_VIDEO_FBDEV_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_FBDEV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-video-fbdev_get: $(STATEDIR)/xorg-driver-video-fbdev.get

$(STATEDIR)/xorg-driver-video-fbdev.get: $(xorg-driver-video-fbdev_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_VIDEO_FBDEV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_VIDEO_FBDEV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-video-fbdev_extract: $(STATEDIR)/xorg-driver-video-fbdev.extract

$(STATEDIR)/xorg-driver-video-fbdev.extract: $(xorg-driver-video-fbdev_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_FBDEV_DIR))
	@$(call extract, XORG_DRIVER_VIDEO_FBDEV)
	@$(call patchin, XORG_DRIVER_VIDEO_FBDEV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-video-fbdev_prepare: $(STATEDIR)/xorg-driver-video-fbdev.prepare

XORG_DRIVER_VIDEO_FBDEV_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_FBDEV_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_FBDEV_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-video-fbdev.prepare: $(xorg-driver-video-fbdev_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_FBDEV_DIR)/config.cache)
	cd $(XORG_DRIVER_VIDEO_FBDEV_DIR) && \
		$(XORG_DRIVER_VIDEO_FBDEV_PATH) $(XORG_DRIVER_VIDEO_FBDEV_ENV) \
		./configure $(XORG_DRIVER_VIDEO_FBDEV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-video-fbdev_compile: $(STATEDIR)/xorg-driver-video-fbdev.compile

$(STATEDIR)/xorg-driver-video-fbdev.compile: $(xorg-driver-video-fbdev_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_VIDEO_FBDEV_DIR) && $(XORG_DRIVER_VIDEO_FBDEV_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-video-fbdev_install: $(STATEDIR)/xorg-driver-video-fbdev.install

$(STATEDIR)/xorg-driver-video-fbdev.install: $(xorg-driver-video-fbdev_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_VIDEO_FBDEV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-video-fbdev_targetinstall: $(STATEDIR)/xorg-driver-video-fbdev.targetinstall

$(STATEDIR)/xorg-driver-video-fbdev.targetinstall: $(xorg-driver-video-fbdev_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-video-fbdev)
	@$(call install_fixup, xorg-driver-video-fbdev,PACKAGE,xorg-driver-video-fbdev)
	@$(call install_fixup, xorg-driver-video-fbdev,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-fbdev,VERSION,$(XORG_DRIVER_VIDEO_FBDEV_VERSION))
	@$(call install_fixup, xorg-driver-video-fbdev,SECTION,base)
	@$(call install_fixup, xorg-driver-video-fbdev,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-fbdev,DEPENDS,)
	@$(call install_fixup, xorg-driver-video-fbdev,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-fbdev, 0, 0, 0755, $(XORG_DRIVER_VIDEO_FBDEV_DIR)/src/.libs/fbdev_drv.so, /usr/lib/xorg/modules/fbdev_drv.so)

	@$(call install_finish, xorg-driver-video-fbdev)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-fbdev_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-fbdev.*
	rm -rf $(PKGDIR)/xorg-driver-video-fbdev_*
	rm -rf $(XORG_DRIVER_VIDEO_FBDEV_DIR)

# vim: syntax=make
