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
PACKAGES-$(PTXCONF_LIBUSB) += libusb

#
# Paths and names
#
LIBUSB_VERSION	:= 0.1.12
LIBUSB		:= libusb-$(LIBUSB_VERSION)
LIBUSB_SUFFIX	:= tar.gz
LIBUSB_URL	:= $(PTXCONF_SETUP_SFMIRROR)/libusb/$(LIBUSB).$(LIBUSB_SUFFIX)
LIBUSB_SOURCE	:= $(SRCDIR)/$(LIBUSB).$(LIBUSB_SUFFIX)
LIBUSB_DIR	:= $(BUILDDIR)/$(LIBUSB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libusb_get: $(STATEDIR)/libusb.get

$(STATEDIR)/libusb.get: $(libusb_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBUSB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBUSB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libusb_extract: $(STATEDIR)/libusb.extract

$(STATEDIR)/libusb.extract: $(libusb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBUSB_DIR))
	@$(call extract, LIBUSB)
	@$(call patchin, LIBUSB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libusb_prepare: $(STATEDIR)/libusb.prepare

LIBUSB_PATH	:= PATH=$(CROSS_PATH)
LIBUSB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBUSB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libusb.prepare: $(libusb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBUSB_DIR)/config.cache)
	cd $(LIBUSB_DIR) && \
		$(LIBUSB_PATH) $(LIBUSB_ENV) \
		./configure $(LIBUSB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libusb_compile: $(STATEDIR)/libusb.compile

$(STATEDIR)/libusb.compile: $(libusb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBUSB_DIR) && $(LIBUSB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libusb_install: $(STATEDIR)/libusb.install

$(STATEDIR)/libusb.install: $(libusb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBUSB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libusb_targetinstall: $(STATEDIR)/libusb.targetinstall

$(STATEDIR)/libusb.targetinstall: $(libusb_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libusb)
	@$(call install_fixup, libusb,PACKAGE,libusb)
	@$(call install_fixup, libusb,PRIORITY,optional)
	@$(call install_fixup, libusb,VERSION,$(LIBUSB_VERSION))
	@$(call install_fixup, libusb,SECTION,base)
	@$(call install_fixup, libusb,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libusb,DEPENDS,)
	@$(call install_fixup, libusb,DESCRIPTION,missing)

	@$(call install_copy, libusb, 0, 0, 0755, $(LIBUSB_DIR)/.libs/libusb-0.1.so.4.4.4, /usr/lib/libusb-0.1.so.4.4.4 )
	@$(call install_link, libusb, libusb-0.1.so.4.4.4, /usr/lib/libusb-0.1.so.4)
	@$(call install_link, libusb, libusb-0.1.so.4.4.4, /usr/lib/libusb.so)

	@$(call install_finish, libusb)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libusb_clean:
	rm -rf $(STATEDIR)/libusb.*
	rm -rf $(IMAGEDIR)/libusb_*
	rm -rf $(LIBUSB_DIR)

# vim: syntax=make
