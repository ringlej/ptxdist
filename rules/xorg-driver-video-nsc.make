# -*-makefile-*-
# $Id: template 5616 2006-06-02 13:50:47Z rsc $
#
# Copyright (C) 2006 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_NSC) += xorg-driver-video-nsc

#
# Paths and names
#
XORG_DRIVER_VIDEO_NSC_VERSION	:= 2.8.3
XORG_DRIVER_VIDEO_NSC		:= xf86-video-nsc-$(XORG_DRIVER_VIDEO_NSC_VERSION)
XORG_DRIVER_VIDEO_NSC_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_NSC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_NSC).$(XORG_DRIVER_VIDEO_NSC_SUFFIX)
XORG_DRIVER_VIDEO_NSC_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_NSC).$(XORG_DRIVER_VIDEO_NSC_SUFFIX)
XORG_DRIVER_VIDEO_NSC_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_NSC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-video-nsc_get: $(STATEDIR)/xorg-driver-video-nsc.get

$(STATEDIR)/xorg-driver-video-nsc.get: $(xorg-driver-video-nsc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_VIDEO_NSC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_VIDEO_NSC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-video-nsc_extract: $(STATEDIR)/xorg-driver-video-nsc.extract

$(STATEDIR)/xorg-driver-video-nsc.extract: $(xorg-driver-video-nsc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_NSC_DIR))
	@$(call extract, XORG_DRIVER_VIDEO_NSC)
	@$(call patchin, XORG_DRIVER_VIDEO_NSC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-video-nsc_prepare: $(STATEDIR)/xorg-driver-video-nsc.prepare

XORG_DRIVER_VIDEO_NSC_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_NSC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_VIDEO_NSC_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/xorg-driver-video-nsc.prepare: $(xorg-driver-video-nsc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_NSC_DIR)/config.cache)
	cd $(XORG_DRIVER_VIDEO_NSC_DIR) && \
		$(XORG_DRIVER_VIDEO_NSC_PATH) $(XORG_DRIVER_VIDEO_NSC_ENV) \
		./configure $(XORG_DRIVER_VIDEO_NSC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-video-nsc_compile: $(STATEDIR)/xorg-driver-video-nsc.compile

$(STATEDIR)/xorg-driver-video-nsc.compile: $(xorg-driver-video-nsc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_VIDEO_NSC_DIR) && $(XORG_DRIVER_VIDEO_NSC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-video-nsc_install: $(STATEDIR)/xorg-driver-video-nsc.install

$(STATEDIR)/xorg-driver-video-nsc.install: $(xorg-driver-video-nsc_install_deps_default)
	$(call targetinfo, $@)
	$(call install, XORG_DRIVER_VIDEO_NSC)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-video-nsc_targetinstall: $(STATEDIR)/xorg-driver-video-nsc.targetinstall

$(STATEDIR)/xorg-driver-video-nsc.targetinstall: $(xorg-driver-video-nsc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-video-nsc)
	@$(call install_fixup,xorg-driver-video-nsc,PACKAGE,xorg-driver-video-nsc)
	@$(call install_fixup,xorg-driver-video-nsc,PRIORITY,optional)
	@$(call install_fixup,xorg-driver-video-nsc,VERSION,$(XORG_DRIVER_VIDEO_NSC_VERSION))
	@$(call install_fixup,xorg-driver-video-nsc,SECTION,base)
	@$(call install_fixup,xorg-driver-video-nsc,AUTHOR,"Juergen Beisert")
	@$(call install_fixup,xorg-driver-video-nsc,DEPENDS,)
	@$(call install_fixup,xorg-driver-video-nsc,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-nsc, 0, 0, 0755, \
		$(XORG_DRIVER_VIDEO_NSC_DIR)/src/.libs/nsc_drv.so, \
		/usr/lib/xorg/modules/nsc_drv.so)

	@$(call install_finish,xorg-driver-video-nsc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-nsc_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-nsc.*
	rm -rf $(PKGDIR)/xorg-driver-video-nsc_*
	rm -rf $(XORG_DRIVER_VIDEO_NSC_DIR)

# vim: syntax=make
