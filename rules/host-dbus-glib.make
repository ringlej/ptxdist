# -*-makefile-*-
# $Id$
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
HOST_PACKAGES-$(PTXCONF_HOST_DBUS_GLIB) += host-dbus-glib

#
# Paths and names
#
HOST_DBUS_GLIB_DIR	= $(HOST_BUILDDIR)/$(DBUS_GLIB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-dbus-glib_get: $(STATEDIR)/host-dbus-glib.get

$(STATEDIR)/host-dbus-glib.get: $(STATEDIR)/dbus-glib.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-dbus-glib_extract: $(STATEDIR)/host-dbus-glib.extract

$(STATEDIR)/host-dbus-glib.extract: $(host-dbus-glib_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_DBUS_GLIB_DIR))
	@$(call extract, DBUS_GLIB, $(HOST_BUILDDIR))
	@$(call patchin, DBUS_GLIB, $(HOST_DBUS_GLIB_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-dbus-glib_prepare: $(STATEDIR)/host-dbus-glib.prepare

HOST_DBUS_GLIB_PATH	:= PATH=$(HOST_PATH)

HOST_DBUS_GLIB_ENV := \
	$(HOST_ENV) \
	ac_cv_func_posix_getpwnam_r=yes \
	ac_cv_have_abstract_sockets=yes

#
# autoconf
#
HOST_DBUS_GLIB_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-tests \
	--disable-doxygen-docs \
	--disable-gcov \
	--disable-gtk-doc

$(STATEDIR)/host-dbus-glib.prepare: $(host-dbus-glib_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_DBUS_GLIB_DIR)/config.cache)
	cd $(HOST_DBUS_GLIB_DIR) && \
		$(HOST_DBUS_GLIB_PATH) $(HOST_DBUS_GLIB_ENV) \
		./configure $(HOST_DBUS_GLIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-dbus-glib_compile: $(STATEDIR)/host-dbus-glib.compile

$(STATEDIR)/host-dbus-glib.compile: $(host-dbus-glib_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_DBUS_GLIB_DIR) && $(HOST_DBUS_GLIB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-dbus-glib_install: $(STATEDIR)/host-dbus-glib.install

$(STATEDIR)/host-dbus-glib.install: $(host-dbus-glib_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_DBUS_GLIB,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-dbus-glib_clean:
	rm -rf $(STATEDIR)/host-dbus-glib.*
	rm -rf $(HOST_DBUS_GLIB_DIR)

# vim: syntax=make
