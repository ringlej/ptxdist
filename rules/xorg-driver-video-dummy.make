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
PACKAGES-$(PTXCONF_XORG_DRIVER_VIDEO_DUMMY) += xorg-driver-video-dummy

#
# Paths and names
#
XORG_DRIVER_VIDEO_DUMMY_VERSION	:= 0.3.3
XORG_DRIVER_VIDEO_DUMMY		:= xf86-video-dummy-$(XORG_DRIVER_VIDEO_DUMMY_VERSION)
XORG_DRIVER_VIDEO_DUMMY_SUFFIX	:= tar.bz2
XORG_DRIVER_VIDEO_DUMMY_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_VIDEO_DUMMY).$(XORG_DRIVER_VIDEO_DUMMY_SUFFIX)
XORG_DRIVER_VIDEO_DUMMY_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_VIDEO_DUMMY).$(XORG_DRIVER_VIDEO_DUMMY_SUFFIX)
XORG_DRIVER_VIDEO_DUMMY_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_VIDEO_DUMMY)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-video-dummy_get: $(STATEDIR)/xorg-driver-video-dummy.get

$(STATEDIR)/xorg-driver-video-dummy.get: $(xorg-driver-video-dummy_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_VIDEO_DUMMY_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_VIDEO_DUMMY)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-video-dummy_extract: $(STATEDIR)/xorg-driver-video-dummy.extract

$(STATEDIR)/xorg-driver-video-dummy.extract: $(xorg-driver-video-dummy_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_DUMMY_DIR))
	@$(call extract, XORG_DRIVER_VIDEO_DUMMY)
	@$(call patchin, XORG_DRIVER_VIDEO_DUMMY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-video-dummy_prepare: $(STATEDIR)/xorg-driver-video-dummy.prepare

XORG_DRIVER_VIDEO_DUMMY_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_VIDEO_DUMMY_ENV 	:=  $(CROSS_ENV) PKG_SYSROOT=$(SYSROOT)

#
# autoconf
#
XORG_DRIVER_VIDEO_DUMMY_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-video-dummy.prepare: $(xorg-driver-video-dummy_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_VIDEO_DUMMY_DIR)/config.cache)
	cd $(XORG_DRIVER_VIDEO_DUMMY_DIR) && \
		$(XORG_DRIVER_VIDEO_DUMMY_PATH) $(XORG_DRIVER_VIDEO_DUMMY_ENV) \
		./configure $(XORG_DRIVER_VIDEO_DUMMY_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-video-dummy_compile: $(STATEDIR)/xorg-driver-video-dummy.compile

$(STATEDIR)/xorg-driver-video-dummy.compile: $(xorg-driver-video-dummy_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_VIDEO_DUMMY_DIR) && $(XORG_DRIVER_VIDEO_DUMMY_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-video-dummy_install: $(STATEDIR)/xorg-driver-video-dummy.install

$(STATEDIR)/xorg-driver-video-dummy.install: $(xorg-driver-video-dummy_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_VIDEO_DUMMY)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-video-dummy_targetinstall: $(STATEDIR)/xorg-driver-video-dummy.targetinstall

$(STATEDIR)/xorg-driver-video-dummy.targetinstall: $(xorg-driver-video-dummy_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-video-dummy)
	@$(call install_fixup, xorg-driver-video-dummy,PACKAGE,xorg-driver-video-dummy)
	@$(call install_fixup, xorg-driver-video-dummy,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-video-dummy,VERSION,$(XORG_DRIVER_VIDEO_DUMMY_VERSION))
	@$(call install_fixup, xorg-driver-video-dummy,SECTION,base)
	@$(call install_fixup, xorg-driver-video-dummy,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-video-dummy,DEPENDS,)
	@$(call install_fixup, xorg-driver-video-dummy,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-video-dummy, 0, 0, 0755, $(XORG_DRIVER_VIDEO_DUMMY_DIR)/src/.libs/dummy_drv.so, /usr/lib/xorg/modules/dummy_drv.so)

	@$(call install_finish, xorg-driver-video-dummy)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-video-dummy_clean:
	rm -rf $(STATEDIR)/xorg-driver-video-dummy.*
	rm -rf $(PKGDIR)/xorg-driver-video-dummy_*
	rm -rf $(XORG_DRIVER_VIDEO_DUMMY_DIR)

# vim: syntax=make
