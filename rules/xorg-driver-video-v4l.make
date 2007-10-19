# -*-makefile-*-
# $Id: template 5616 2006-06-02 13:50:47Z rsc $
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
XORG_DRIVER_VIDEO_V4L_VERSION	:= 0.1.1
XORG_DRIVER_VIDEO_V4L		:= xf86-video-v4l-$(XORG_DRIVER_VIDEO_V4L_VERSION)
XORG_DRIVER_VIDEO_V4L_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_V4L_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/driver/$(XORG_DRIVER_VIDEO_V4L).$(XORG_DRIVER_VIDEO_V4L_SUFFIX)
XORG_DRIVER_VIDEO_V4L_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_V4L).$(XORG_DRIVER_VIDEO_V4L_SUFFIX)
XORG_DRIVER_VIDEO_V4L_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_V4L)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-video-v4l_get: $(STATEDIR)/xorg-driver-video-v4l.get

$(STATEDIR)/xorg-driver-video-v4l.get: $(xorg-driver-video-v4l_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_VIDEO_V4L_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_VIDEO_V4L)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-video-v4l_extract: $(STATEDIR)/xorg-driver-video-v4l.extract

$(STATEDIR)/xorg-driver-video-v4l.extract: $(xorg-driver-video-v4l_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_V4L_DIR))
	@$(call extract, XORG_DRIVER_VIDEO_V4L)
	@$(call patchin, XORG_DRIVER_VIDEO_V4L)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-video-v4l_prepare: $(STATEDIR)/xorg-driver-video-v4l.prepare

XORG_DRIVER_VIDEO_V4L_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_V4L_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_V4L_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-video-v4l.prepare: $(xorg-driver-video-v4l_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_V4L_DIR)/config.cache)
	cd $(XORG_DRIVER_VIDEO_V4L_DIR) && \
		$(XORG_DRIVER_VIDEO_V4L_PATH) $(XORG_DRIVER_VIDEO_V4L_ENV) \
		./configure $(XORG_DRIVER_VIDEO_V4L_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-video-v4l_compile: $(STATEDIR)/xorg-driver-video-v4l.compile

$(STATEDIR)/xorg-driver-video-v4l.compile: $(xorg-driver-video-v4l_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_VIDEO_V4L_DIR) && $(XORG_DRIVER_VIDEO_V4L_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-video-v4l_install: $(STATEDIR)/xorg-driver-video-v4l.install

$(STATEDIR)/xorg-driver-video-v4l.install: $(xorg-driver-video-v4l_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_VIDEO_V4L)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-video-v4l_targetinstall: $(STATEDIR)/xorg-driver-video-v4l.targetinstall

$(STATEDIR)/xorg-driver-video-v4l.targetinstall: $(xorg-driver-video-v4l_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-video-v4l)
	@$(call install_fixup,xorg-driver-video-v4l,PACKAGE,xorg-driver-video-v4l)
	@$(call install_fixup,xorg-driver-video-v4l,PRIORITY,optional)
	@$(call install_fixup,xorg-driver-video-v4l,VERSION,$(XORG_DRIVER_VIDEO_V4L_VERSION))
	@$(call install_fixup,xorg-driver-video-v4l,SECTION,base)
	@$(call install_fixup,xorg-driver-video-v4l,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-driver-video-v4l,DEPENDS,)
	@$(call install_fixup,xorg-driver-video-v4l,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-v4l, 0, 0, 0755, \
		$(XORG_DRIVER_VIDEO_V4L_DIR)/src/.libs/v4l_drv.so, \
		/usr/lib/xorg/modules/v4l_drv.so)

	@$(call install_finish,xorg-driver-video-v4l)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-v4l_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-v4l.*
	rm -rf $(IMAGEDIR)/xorg-driver-video-v4l_*
	rm -rf $(XORG_DRIVER_VIDEO_V4L_DIR)

# vim: syntax=make
