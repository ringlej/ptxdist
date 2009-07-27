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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_VESA) += xorg-driver-video-vesa

#
# Paths and names
#
XORG_DRIVER_VIDEO_VESA_VERSION	:= 2.2.0
XORG_DRIVER_VIDEO_VESA		:= xf86-video-vesa-$(XORG_DRIVER_VIDEO_VESA_VERSION)
XORG_DRIVER_VIDEO_VESA_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_VESA_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_VESA).$(XORG_DRIVER_VIDEO_VESA_SUFFIX)
XORG_DRIVER_VIDEO_VESA_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_VESA).$(XORG_DRIVER_VIDEO_VESA_SUFFIX)
XORG_DRIVER_VIDEO_VESA_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_VESA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-video-vesa_get: $(STATEDIR)/xorg-driver-video-vesa.get

$(STATEDIR)/xorg-driver-video-vesa.get: $(xorg-driver-video-vesa_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_VIDEO_VESA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_VIDEO_VESA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-video-vesa_extract: $(STATEDIR)/xorg-driver-video-vesa.extract

$(STATEDIR)/xorg-driver-video-vesa.extract: $(xorg-driver-video-vesa_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_VESA_DIR))
	@$(call extract, XORG_DRIVER_VIDEO_VESA)
	@$(call patchin, XORG_DRIVER_VIDEO_VESA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-video-vesa_prepare: $(STATEDIR)/xorg-driver-video-vesa.prepare

XORG_DRIVER_VIDEO_VESA_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_VESA_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_VESA_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-video-vesa.prepare: $(xorg-driver-video-vesa_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_VESA_DIR)/config.cache)
	cd $(XORG_DRIVER_VIDEO_VESA_DIR) && \
		$(XORG_DRIVER_VIDEO_VESA_PATH) $(XORG_DRIVER_VIDEO_VESA_ENV) \
		./configure $(XORG_DRIVER_VIDEO_VESA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-video-vesa_compile: $(STATEDIR)/xorg-driver-video-vesa.compile

$(STATEDIR)/xorg-driver-video-vesa.compile: $(xorg-driver-video-vesa_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_VIDEO_VESA_DIR) && $(XORG_DRIVER_VIDEO_VESA_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-video-vesa_install: $(STATEDIR)/xorg-driver-video-vesa.install

$(STATEDIR)/xorg-driver-video-vesa.install: $(xorg-driver-video-vesa_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_VIDEO_VESA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-video-vesa_targetinstall: $(STATEDIR)/xorg-driver-video-vesa.targetinstall

$(STATEDIR)/xorg-driver-video-vesa.targetinstall: $(xorg-driver-video-vesa_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-video-vesa)
	@$(call install_fixup,xorg-driver-video-vesa,PACKAGE,xorg-driver-video-vesa)
	@$(call install_fixup,xorg-driver-video-vesa,PRIORITY,optional)
	@$(call install_fixup,xorg-driver-video-vesa,VERSION,$(XORG_DRIVER_VIDEO_VESA_VERSION))
	@$(call install_fixup,xorg-driver-video-vesa,SECTION,base)
	@$(call install_fixup,xorg-driver-video-vesa,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-driver-video-vesa,DEPENDS,)
	@$(call install_fixup,xorg-driver-video-vesa,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-vesa, 0, 0, 0755, \
		$(XORG_DRIVER_VIDEO_VESA_DIR)/src/.libs/vesa_drv.so, \
		/usr/lib/xorg/modules/vesa_drv.so)

	@$(call install_finish,xorg-driver-video-vesa)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-vesa_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-vesa.*
	rm -rf $(PKGDIR)/xorg-driver-video-vesa_*
	rm -rf $(XORG_DRIVER_VIDEO_VESA_DIR)

# vim: syntax=make
