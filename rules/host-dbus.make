# -*-makefile-*-
# $Id$
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
HOST_PACKAGES-$(PTXCONF_HOST_DBUS) += host-dbus

#
# Paths and names
#
HOST_DBUS		= $(DBUS)
HOST_DBUS_DIR		= $(HOST_BUILDDIR)/$(HOST_DBUS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-dbus_get: $(STATEDIR)/host-dbus.get

$(STATEDIR)/host-dbus.get: $(STATEDIR)/dbus.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-dbus_extract: $(STATEDIR)/host-dbus.extract

$(STATEDIR)/host-dbus.extract: $(host-dbus_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_DBUS_DIR))
	@$(call extract, DBUS, $(HOST_BUILDDIR))
	@$(call patchin, DBUS, $(HOST_DBUS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-dbus_prepare: $(STATEDIR)/host-dbus.prepare

HOST_DBUS_PATH	:= PATH=$(HOST_PATH)
HOST_DBUS_ENV 	:= \
	$(HOST_ENV) \
        ac_cv_have_abstract_sockets=yes

#
# autoconf
#
HOST_DBUS_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--enable-abstract-sockets=yes \
	--with-xml=expat

$(STATEDIR)/host-dbus.prepare: $(host-dbus_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_DBUS_DIR)/config.cache)
	cd $(HOST_DBUS_DIR) && \
		$(HOST_DBUS_PATH) $(HOST_DBUS_ENV) \
		./configure $(HOST_DBUS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-dbus_compile: $(STATEDIR)/host-dbus.compile

$(STATEDIR)/host-dbus.compile: $(host-dbus_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_DBUS_DIR) && $(HOST_DBUS_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-dbus_install: $(STATEDIR)/host-dbus.install

$(STATEDIR)/host-dbus.install: $(host-dbus_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_DBUS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-dbus_clean:
	rm -rf $(STATEDIR)/host-dbus.*
	rm -rf $(HOST_DBUS_DIR)

# vim: syntax=make
