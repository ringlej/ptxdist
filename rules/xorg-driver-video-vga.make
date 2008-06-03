# -*-makefile-*-
# $Id: template 5616 2006-06-02 13:50:47Z rsc $
#
# Copyright (C) 2006 by Erwin rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_VGA) += xorg-driver-video-vga

#
# Paths and names
#
XORG_DRIVER_VIDEO_VGA_VERSION	:= 4.1.0
XORG_DRIVER_VIDEO_VGA		:= xf86-video-vga-$(XORG_DRIVER_VIDEO_VGA_VERSION)
XORG_DRIVER_VIDEO_VGA_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_VGA_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/driver/$(XORG_DRIVER_VIDEO_VGA).$(XORG_DRIVER_VIDEO_VGA_SUFFIX)
XORG_DRIVER_VIDEO_VGA_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_VGA).$(XORG_DRIVER_VIDEO_VGA_SUFFIX)
XORG_DRIVER_VIDEO_VGA_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_VGA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-video-vga_get: $(STATEDIR)/xorg-driver-video-vga.get

$(STATEDIR)/xorg-driver-video-vga.get: $(xorg-driver-video-vga_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_VIDEO_VGA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_VIDEO_VGA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-video-vga_extract: $(STATEDIR)/xorg-driver-video-vga.extract

$(STATEDIR)/xorg-driver-video-vga.extract: $(xorg-driver-video-vga_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_VGA_DIR))
	@$(call extract, XORG_DRIVER_VIDEO_VGA)
	@$(call patchin, XORG_DRIVER_VIDEO_VGA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-video-vga_prepare: $(STATEDIR)/xorg-driver-video-vga.prepare

XORG_DRIVER_VIDEO_VGA_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_VGA_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_VGA_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-video-vga.prepare: $(xorg-driver-video-vga_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_VGA_DIR)/config.cache)
	cd $(XORG_DRIVER_VIDEO_VGA_DIR) && \
		$(XORG_DRIVER_VIDEO_VGA_PATH) $(XORG_DRIVER_VIDEO_VGA_ENV) \
		./configure $(XORG_DRIVER_VIDEO_VGA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-video-vga_compile: $(STATEDIR)/xorg-driver-video-vga.compile

$(STATEDIR)/xorg-driver-video-vga.compile: $(xorg-driver-video-vga_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_VIDEO_VGA_DIR) && $(XORG_DRIVER_VIDEO_VGA_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-video-vga_install: $(STATEDIR)/xorg-driver-video-vga.install

$(STATEDIR)/xorg-driver-video-vga.install: $(xorg-driver-video-vga_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_VIDEO_VGA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-video-vga_targetinstall: $(STATEDIR)/xorg-driver-video-vga.targetinstall

$(STATEDIR)/xorg-driver-video-vga.targetinstall: $(xorg-driver-video-vga_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-video-vga)
	@$(call install_fixup,xorg-driver-video-vga,PACKAGE,xorg-driver-video-vga)
	@$(call install_fixup,xorg-driver-video-vga,PRIORITY,optional)
	@$(call install_fixup,xorg-driver-video-vga,VERSION,$(XORG_DRIVER_VIDEO_VGA_VERSION))
	@$(call install_fixup,xorg-driver-video-vga,SECTION,base)
	@$(call install_fixup,xorg-driver-video-vga,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-driver-video-vga,DEPENDS,)
	@$(call install_fixup,xorg-driver-video-vga,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-vga, 0, 0, 0755, \
		$(XORG_DRIVER_VIDEO_VGA_DIR)/src/.libs/vga_drv.so, \
		/usr/lib/xorg/modules/vga_drv.so)

	@$(call install_finish,xorg-driver-video-vga)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-vga_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-vga.*
	rm -rf $(PKGDIR)/xorg-driver-video-vga_*
	rm -rf $(XORG_DRIVER_VIDEO_VGA_DIR)

# vim: syntax=make
