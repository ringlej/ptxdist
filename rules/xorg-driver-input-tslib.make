# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Sascha Hauer
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_DRIVER_INPUT_TSLIB) += xorg-driver-input-tslib

#
# Paths and names
#
XORG_DRIVER_INPUT_TSLIB_VERSION	:= 0.0.3
XORG_DRIVER_INPUT_TSLIB		:= xf86-input-tslib-$(XORG_DRIVER_INPUT_TSLIB_VERSION)
XORG_DRIVER_INPUT_TSLIB_SUFFIX	:= tar.bz2
XORG_DRIVER_INPUT_TSLIB_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XORG_DRIVER_INPUT_TSLIB).$(XORG_DRIVER_INPUT_TSLIB_SUFFIX)
XORG_DRIVER_INPUT_TSLIB_SOURCE	:= $(SRCDIR)/$(XORG_DRIVER_INPUT_TSLIB).$(XORG_DRIVER_INPUT_TSLIB_SUFFIX)
XORG_DRIVER_INPUT_TSLIB_DIR	:= $(BUILDDIR)/$(XORG_DRIVER_INPUT_TSLIB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-driver-input-tslib_get: $(STATEDIR)/xorg-driver-input-tslib.get

$(STATEDIR)/xorg-driver-input-tslib.get: $(xorg-driver-input-tslib_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_DRIVER_INPUT_TSLIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_DRIVER_INPUT_TSLIB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-driver-input-tslib_extract: $(STATEDIR)/xorg-driver-input-tslib.extract

$(STATEDIR)/xorg-driver-input-tslib.extract: $(xorg-driver-input-tslib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_TSLIB_DIR))
	@$(call extract, XORG_DRIVER_INPUT_TSLIB)
	@$(call patchin, XORG_DRIVER_INPUT_TSLIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-driver-input-tslib_prepare: $(STATEDIR)/xorg-driver-input-tslib.prepare

XORG_DRIVER_INPUT_TSLIB_PATH	:=  PATH=$(CROSS_PATH)
XORG_DRIVER_INPUT_TSLIB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_DRIVER_INPUT_TSLIB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-driver-input-tslib.prepare: $(xorg-driver-input-tslib_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_DRIVER_INPUT_TSLIB_DIR)/config.cache)
	cd $(XORG_DRIVER_INPUT_TSLIB_DIR) && \
		$(XORG_DRIVER_INPUT_TSLIB_PATH) $(XORG_DRIVER_INPUT_TSLIB_ENV) \
		./configure $(XORG_DRIVER_INPUT_TSLIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-driver-input-tslib_compile: $(STATEDIR)/xorg-driver-input-tslib.compile

$(STATEDIR)/xorg-driver-input-tslib.compile: $(xorg-driver-input-tslib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_DRIVER_INPUT_TSLIB_DIR) && $(XORG_DRIVER_INPUT_TSLIB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-driver-input-tslib_install: $(STATEDIR)/xorg-driver-input-tslib.install

$(STATEDIR)/xorg-driver-input-tslib.install: $(xorg-driver-input-tslib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_DRIVER_INPUT_TSLIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-driver-input-tslib_targetinstall: $(STATEDIR)/xorg-driver-input-tslib.targetinstall

$(STATEDIR)/xorg-driver-input-tslib.targetinstall: $(xorg-driver-input-tslib_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-driver-input-tslib)
	@$(call install_fixup, xorg-driver-input-tslib,PACKAGE,xorg-driver-input-tslib)
	@$(call install_fixup, xorg-driver-input-tslib,PRIORITY,optional)
	@$(call install_fixup, xorg-driver-input-tslib,VERSION,$(XORG_DRIVER_INPUT_TSLIB_VERSION))
	@$(call install_fixup, xorg-driver-input-tslib,SECTION,base)
	@$(call install_fixup, xorg-driver-input-tslib,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-driver-input-tslib,DEPENDS,)
	@$(call install_fixup, xorg-driver-input-tslib,DESCRIPTION,missing)

	@$(call install_copy, xorg-driver-input-tslib, 0, 0, 0755, $(XORG_DRIVER_INPUT_TSLIB_DIR)/src/.libs/tslib_drv.so, /usr/lib/xorg/modules/tslib_drv.so)

	@$(call install_finish, xorg-driver-input-tslib)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-driver-input-tslib_clean:
	rm -rf $(STATEDIR)/xorg-driver-input-tslib.*
	rm -rf $(IMAGEDIR)/xorg-driver-input-tslib_*
	rm -rf $(XORG_DRIVER_INPUT_TSLIB_DIR)

# vim: syntax=make
