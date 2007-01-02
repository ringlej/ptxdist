# -*-makefile-*-
# $Id: template 6487 2006-12-07 20:55:55Z rsc $
#
# Copyright (C) 2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBDBUS_CXX) += libdbus-cxx

#
# Paths and names
#
LIBDBUS_CXX_VERSION	:= 0.5.0
LIBDBUS_CXX		:= libdbus-c++-$(LIBDBUS_CXX_VERSION)
LIBDBUS_CXX_SUFFIX	:= tar.gz
LIBDBUS_CXX_URL		:= FIXME/$(LIBDBUS_CXX).$(LIBDBUS_CXX_SUFFIX)
LIBDBUS_CXX_SOURCE	:= $(SRCDIR)/$(LIBDBUS_CXX).$(LIBDBUS_CXX_SUFFIX)
LIBDBUS_CXX_DIR		:= $(BUILDDIR)/$(LIBDBUS_CXX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libdbus-cxx_get: $(STATEDIR)/libdbus-cxx.get

$(STATEDIR)/libdbus-cxx.get: $(libdbus-cxx_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBDBUS_CXX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBDBUS_CXX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libdbus-cxx_extract: $(STATEDIR)/libdbus-cxx.extract

$(STATEDIR)/libdbus-cxx.extract: $(libdbus-cxx_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBDBUS_CXX_DIR))
	@$(call extract, LIBDBUS_CXX)
	@$(call patchin, LIBDBUS_CXX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libdbus-cxx_prepare: $(STATEDIR)/libdbus-cxx.prepare

LIBDBUS_CXX_PATH := \
	PATH=$(CROSS_PATH)

LIBDBUS_CXX_ENV	:= \
	$(CROSS_ENV) \
	CXX_FOR_BUILD=$(HOSTCXX)

#
# autoconf
#
LIBDBUS_CXX_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--with-build-libdbus-cxx=$(HOST_LIBDBUS_CXX_DIR)

$(STATEDIR)/libdbus-cxx.prepare: $(libdbus-cxx_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBDBUS_CXX_DIR)/config.cache)
	cd $(LIBDBUS_CXX_DIR) && \
		$(LIBDBUS_CXX_PATH) $(LIBDBUS_CXX_ENV) \
		./configure $(LIBDBUS_CXX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libdbus-cxx_compile: $(STATEDIR)/libdbus-cxx.compile

$(STATEDIR)/libdbus-cxx.compile: $(libdbus-cxx_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBDBUS_CXX_DIR) && $(LIBDBUS_CXX_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libdbus-cxx_install: $(STATEDIR)/libdbus-cxx.install

$(STATEDIR)/libdbus-cxx.install: $(libdbus-cxx_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBDBUS_CXX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libdbus-cxx_targetinstall: $(STATEDIR)/libdbus-cxx.targetinstall

$(STATEDIR)/libdbus-cxx.targetinstall: $(libdbus-cxx_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libdbus-cxx)
	@$(call install_fixup, libdbus-cxx,PACKAGE,libdbus-cxx)
	@$(call install_fixup, libdbus-cxx,PRIORITY,optional)
	@$(call install_fixup, libdbus-cxx,VERSION,$(LIBDBUS_CXX_VERSION))
	@$(call install_fixup, libdbus-cxx,SECTION,base)
	@$(call install_fixup, libdbus-cxx,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libdbus-cxx,DEPENDS,)
	@$(call install_fixup, libdbus-cxx,DESCRIPTION,missing)

	@$(call install_copy, libdbus-cxx, 0, 0, 0755, \
		$(LIBDBUS_CXX_DIR)/src/.libs/libdbus-c++-1.so.0.0.0, \
		/usr/lib/libdbus-c++-1.so.0.0.0)
	@$(call install_link, libdbus-cxx, libdbus-c++-1.so.0.0.0, /usr/lib/libdbus-c++-1.so.0)
	@$(call install_link, libdbus-cxx, libdbus-c++-1.so.0.0.0, /usr/lib/libdbus-c++-1.so)

	@$(call install_finish, libdbus-cxx)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libdbus-cxx_clean:
	rm -rf $(STATEDIR)/libdbus-cxx.*
	rm -rf $(IMAGEDIR)/libdbus-cxx_*
	rm -rf $(LIBDBUS_CXX_DIR)

# vim: syntax=make
