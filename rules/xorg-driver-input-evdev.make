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
PACKAGES-$(PTXCONF_XORG_DRIVER_INPUT_EVDEV) += xorg-driver-input-evdev

#
# Paths and names
#
XORG_DRIVER_INPUT_EVDEV_VERSION	:= 2.3.2
XORG_DRIVER_INPUT_EVDEV		:= xf86-input-evdev-$(XORG_DRIVER_INPUT_EVDEV_VERSION)
XORG_DRIVER_INPUT_EVDEV_SUFFIX	:= tar.bz2
XORG_DRIVER_INPUT_EVDEV_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/driver/$(XORG_DRIVER_INPUT_EVDEV).$(XORG_DRIVER_INPUT_EVDEV_SUFFIX)
XORG_DRIVER_INPUT_EVDEV_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_INPUT_EVDEV).$(XORG_DRIVER_INPUT_EVDEV_SUFFIX)
XORG_DRIVER_INPUT_EVDEV_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_INPUT_EVDEV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-input-evdev_get: $(STATEDIR)/xorg-driver-input-evdev.get

$(STATEDIR)/xorg-driver-input-evdev.get: $(xorg-driver-input-evdev_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_INPUT_EVDEV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_INPUT_EVDEV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-input-evdev_extract: $(STATEDIR)/xorg-driver-input-evdev.extract

$(STATEDIR)/xorg-driver-input-evdev.extract: $(xorg-driver-input-evdev_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_EVDEV_DIR))
	@$(call extract, XORG_DRIVER_INPUT_EVDEV)
	@$(call patchin, XORG_DRIVER_INPUT_EVDEV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-input-evdev_prepare: $(STATEDIR)/xorg-driver-input-evdev.prepare

XORG_DRIVER_INPUT_EVDEV_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_INPUT_EVDEV_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_INPUT_EVDEV_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-input-evdev.prepare: $(xorg-driver-input-evdev_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_EVDEV_DIR)/config.cache)
	cd $(XORG_DRIVER_INPUT_EVDEV_DIR) && \
		$(XORG_DRIVER_INPUT_EVDEV_PATH) $(XORG_DRIVER_INPUT_EVDEV_ENV) \
		./configure $(XORG_DRIVER_INPUT_EVDEV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-input-evdev_compile: $(STATEDIR)/xorg-driver-input-evdev.compile

$(STATEDIR)/xorg-driver-input-evdev.compile: $(xorg-driver-input-evdev_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_INPUT_EVDEV_DIR) && $(XORG_DRIVER_INPUT_EVDEV_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-input-evdev_install: $(STATEDIR)/xorg-driver-input-evdev.install

$(STATEDIR)/xorg-driver-input-evdev.install: $(xorg-driver-input-evdev_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_INPUT_EVDEV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-input-evdev_targetinstall: $(STATEDIR)/xorg-driver-input-evdev.targetinstall

$(STATEDIR)/xorg-driver-input-evdev.targetinstall: $(xorg-driver-input-evdev_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-input-evdev)
	@$(call install_fixup, xorg-driver-input-evdev,PACKAGE,xorg-driver-input-evdev)
	@$(call install_fixup, xorg-driver-input-evdev,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-input-evdev,VERSION,$(XORG_DRIVER_INPUT_EVDEV_VERSION))
	@$(call install_fixup, xorg-driver-input-evdev,SECTION,base)
	@$(call install_fixup, xorg-driver-input-evdev,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-input-evdev,DEPENDS,)
	@$(call install_fixup, xorg-driver-input-evdev,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-input-evdev, 0, 0, 0755, $(XORG_DRIVER_INPUT_EVDEV_DIR)/src/.libs/evdev_drv.so, /usr/lib/xorg/modules/evdev_drv.so)

	@$(call install_finish, xorg-driver-input-evdev)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-input-evdev_clean:
	rm -rf $(STATEDIR)/xorg-driver-input-evdev.*
	rm -rf $(PKGDIR)/xorg-driver-input-evdev_*
	rm -rf $(XORG_DRIVER_INPUT_EVDEV_DIR)

# vim: syntax=make
