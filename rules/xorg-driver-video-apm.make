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

xorg-driver-video-apm_get: $(STATEDIR)/xorg-driver-video-apm.get

$(STATEDIR)/xorg-driver-video-apm.get: $(xorg-driver-video-apm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_VIDEO_APM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_VIDEO_APM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-video-apm_extract: $(STATEDIR)/xorg-driver-video-apm.extract

$(STATEDIR)/xorg-driver-video-apm.extract: $(xorg-driver-video-apm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_APM_DIR))
	@$(call extract, XORG_DRIVER_VIDEO_APM)
	@$(call patchin, XORG_DRIVER_VIDEO_APM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-video-apm_prepare: $(STATEDIR)/xorg-driver-video-apm.prepare

XORG_DRIVER_VIDEO_APM_PATH	:= PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_APM_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_file__usr_share_X11_sgml_defs_ent=no

#
# autoconf
#
XORG_DRIVER_VIDEO_APM_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-video-apm.prepare: $(xorg-driver-video-apm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_APM_DIR)/config.cache)
	cd $(XORG_DRIVER_VIDEO_APM_DIR) && \
		$(XORG_DRIVER_VIDEO_APM_PATH) $(XORG_DRIVER_VIDEO_APM_ENV) \
		./configure $(XORG_DRIVER_VIDEO_APM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-video-apm_compile: $(STATEDIR)/xorg-driver-video-apm.compile

$(STATEDIR)/xorg-driver-video-apm.compile: $(xorg-driver-video-apm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_VIDEO_APM_DIR) && $(XORG_DRIVER_VIDEO_APM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-video-apm_install: $(STATEDIR)/xorg-driver-video-apm.install

$(STATEDIR)/xorg-driver-video-apm.install: $(xorg-driver-video-apm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_VIDEO_APM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-video-apm_targetinstall: $(STATEDIR)/xorg-driver-video-apm.targetinstall

$(STATEDIR)/xorg-driver-video-apm.targetinstall: $(xorg-driver-video-apm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-video-apm)
	@$(call install_fixup, xorg-driver-video-apm,PACKAGE,xorg-driver-video-apm)
	@$(call install_fixup, xorg-driver-video-apm,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-apm,VERSION,$(XORG_DRIVER_VIDEO_APM_VERSION))
	@$(call install_fixup, xorg-driver-video-apm,SECTION,base)
	@$(call install_fixup, xorg-driver-video-apm,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-apm,DEPENDS,)
	@$(call install_fixup, xorg-driver-video-apm,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-apm, 0, 0, 0755, \
		$(XORG_DRIVER_VIDEO_APM_DIR)/src/.libs/apm_drv.so, \
		/usr/lib/xorg/modules/apm_drv.so)

	@$(call install_finish, xorg-driver-video-apm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-apm_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-apm.*
	rm -rf $(PKGDIR)/xorg-driver-video-apm_*
	rm -rf $(XORG_DRIVER_VIDEO_APM_DIR)

# vim: syntax=make
