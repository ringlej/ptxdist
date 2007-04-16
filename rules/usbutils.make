# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_USBUTILS) += usbutils

#
# Paths and names
#
USBUTILS_VERSION	:= 0.72
USBUTILS		:= usbutils-$(USBUTILS_VERSION)
USBUTILS_SUFFIX		:= tar.gz
USBUTILS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/linux-usb/$(USBUTILS).$(USBUTILS_SUFFIX)
USBUTILS_SOURCE		:= $(SRCDIR)/$(USBUTILS).$(USBUTILS_SUFFIX)
USBUTILS_DIR		:= $(BUILDDIR)/$(USBUTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

usbutils_get: $(STATEDIR)/usbutils.get

$(STATEDIR)/usbutils.get: $(usbutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(USBUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, USBUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

usbutils_extract: $(STATEDIR)/usbutils.extract

$(STATEDIR)/usbutils.extract: $(usbutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(USBUTILS_DIR))
	@$(call extract, USBUTILS)
	@$(call patchin, USBUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

usbutils_prepare: $(STATEDIR)/usbutils.prepare

USBUTILS_PATH	:= PATH=$(CROSS_PATH)
USBUTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
USBUTILS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/usbutils.prepare: $(usbutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(USBUTILS_DIR)/config.cache)
	cd $(USBUTILS_DIR) && \
		$(USBUTILS_PATH) $(USBUTILS_ENV) \
		./configure $(USBUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

usbutils_compile: $(STATEDIR)/usbutils.compile

$(STATEDIR)/usbutils.compile: $(usbutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(USBUTILS_DIR) && $(USBUTILS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

usbutils_install: $(STATEDIR)/usbutils.install

$(STATEDIR)/usbutils.install: $(usbutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, USBUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

usbutils_targetinstall: $(STATEDIR)/usbutils.targetinstall

$(STATEDIR)/usbutils.targetinstall: $(usbutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, usbutils)
	@$(call install_fixup, usbutils,PACKAGE,usbutils)
	@$(call install_fixup, usbutils,PRIORITY,optional)
	@$(call install_fixup, usbutils,VERSION,$(USBUTILS_VERSION))
	@$(call install_fixup, usbutils,SECTION,base)
	@$(call install_fixup, usbutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, usbutils,DEPENDS,)
	@$(call install_fixup, usbutils,DESCRIPTION,missing)
ifdef PTXCONF_USBUTILS_LSUSB
	@$(call install_copy, usbutils, 0, 0, 0755, $(USBUTILS_DIR)/lsusb, /usr/bin/lsusb)
endif
	@$(call install_copy, usbutils, 0, 0, 0755, $(USBUTILS_DIR)/usb.ids, /usr/share/usb.ids)

	@$(call install_finish, usbutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

usbutils_clean:
	rm -rf $(STATEDIR)/usbutils.*
	rm -rf $(IMAGEDIR)/usbutils_*
	rm -rf $(USBUTILS_DIR)

# vim: syntax=make
