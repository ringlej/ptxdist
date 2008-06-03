# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSIGCPP) += libsigcpp

#
# Paths and names
#
LIBSIGCPP_VERSION	:= 2.0.18
LIBSIGCPP		:= libsigc++-$(LIBSIGCPP_VERSION)
LIBSIGCPP_SUFFIX	:= tar.bz2
LIBSIGCPP_URL		:= http://ftp.gnome.org/pub/GNOME/sources/libsigc++/2.0/$(LIBSIGCPP).$(LIBSIGCPP_SUFFIX)
LIBSIGCPP_SOURCE	:= $(SRCDIR)/$(LIBSIGCPP).$(LIBSIGCPP_SUFFIX)
LIBSIGCPP_DIR		:= $(BUILDDIR)/$(LIBSIGCPP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libsigcpp_get: $(STATEDIR)/libsigcpp.get

$(STATEDIR)/libsigcpp.get: $(libsigcpp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBSIGCPP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBSIGCPP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libsigcpp_extract: $(STATEDIR)/libsigcpp.extract

$(STATEDIR)/libsigcpp.extract: $(libsigcpp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBSIGCPP_DIR))
	@$(call extract, LIBSIGCPP)
	@$(call patchin, LIBSIGCPP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libsigcpp_prepare: $(STATEDIR)/libsigcpp.prepare

LIBSIGCPP_PATH	:= PATH=$(CROSS_PATH)
LIBSIGCPP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBSIGCPP_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libsigcpp.prepare: $(libsigcpp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBSIGCPP_DIR)/config.cache)
	cd $(LIBSIGCPP_DIR) && \
		$(LIBSIGCPP_PATH) $(LIBSIGCPP_ENV) \
		./configure $(LIBSIGCPP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libsigcpp_compile: $(STATEDIR)/libsigcpp.compile

$(STATEDIR)/libsigcpp.compile: $(libsigcpp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBSIGCPP_DIR) && $(LIBSIGCPP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libsigcpp_install: $(STATEDIR)/libsigcpp.install

$(STATEDIR)/libsigcpp.install: $(libsigcpp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBSIGCPP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libsigcpp_targetinstall: $(STATEDIR)/libsigcpp.targetinstall

$(STATEDIR)/libsigcpp.targetinstall: $(libsigcpp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libsigcpp)
	@$(call install_fixup, libsigcpp,PACKAGE,libsigcpp)
	@$(call install_fixup, libsigcpp,PRIORITY,optional)
	@$(call install_fixup, libsigcpp,VERSION,$(LIBSIGCPP_VERSION))
	@$(call install_fixup, libsigcpp,SECTION,base)
	@$(call install_fixup, libsigcpp,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libsigcpp,DEPENDS,)
	@$(call install_fixup, libsigcpp,DESCRIPTION,missing)

	@$(call install_copy, libsigcpp, 0, 0, 0644, \
		$(LIBSIGCPP_DIR)/sigc++/.libs/libsigc-2.0.so, \
		/usr/lib/libsigc-2.0.so.0.0.0)
	@$(call install_link, libsigcpp, libsigc-2.0.so.0.0.0, /usr/lib/libsigc-2.0.so.0)
	@$(call install_link, libsigcpp, libsigc-2.0.so.0.0.0, /usr/lib/libsigc-2.0.so)

	@$(call install_finish, libsigcpp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libsigcpp_clean:
	rm -rf $(STATEDIR)/libsigcpp.*
	rm -rf $(PKGDIR)/libsigcpp_*
	rm -rf $(LIBSIGCPP_DIR)

# vim: syntax=make
