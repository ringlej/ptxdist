# -*-makefile-*-
# $Id: template 3345 2005-11-14 17:14:19Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBMODBUS) += libmodbus

#
# Paths and names
#
LIBMODBUS_VERSION	= 2.0.3
LIBMODBUS		= libmodbus-$(LIBMODBUS_VERSION)
LIBMODBUS_SUFFIX	= tar.gz
LIBMODBUS_URL		= http://launchpad.net/libmodbus/trunk/2.0.3/+download/$(LIBMODBUS).$(LIBMODBUS_SUFFIX)
LIBMODBUS_SOURCE	= $(SRCDIR)/$(LIBMODBUS).$(LIBMODBUS_SUFFIX)
LIBMODBUS_DIR		= $(BUILDDIR)/$(LIBMODBUS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libmodbus_get: $(STATEDIR)/libmodbus.get

$(STATEDIR)/libmodbus.get: $(libmodbus_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBMODBUS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBMODBUS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libmodbus_extract: $(STATEDIR)/libmodbus.extract

$(STATEDIR)/libmodbus.extract: $(libmodbus_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBMODBUS_DIR))
	@$(call extract, LIBMODBUS)
	@$(call patchin, LIBMODBUS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libmodbus_prepare: $(STATEDIR)/libmodbus.prepare

LIBMODBUS_PATH	=  PATH=$(CROSS_PATH)
LIBMODBUS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBMODBUS_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libmodbus.prepare: $(libmodbus_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBMODBUS_DIR)/config.cache)
	cd $(LIBMODBUS_DIR) && \
		$(LIBMODBUS_PATH) $(LIBMODBUS_ENV) \
		./configure $(LIBMODBUS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libmodbus_compile: $(STATEDIR)/libmodbus.compile

$(STATEDIR)/libmodbus.compile: $(libmodbus_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBMODBUS_DIR) && $(LIBMODBUS_ENV) $(LIBMODBUS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libmodbus_install: $(STATEDIR)/libmodbus.install

$(STATEDIR)/libmodbus.install: $(libmodbus_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBMODBUS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libmodbus_targetinstall: $(STATEDIR)/libmodbus.targetinstall

$(STATEDIR)/libmodbus.targetinstall: $(libmodbus_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, libmodbus)
	@$(call install_fixup, libmodbus,PACKAGE,libmodbus)
	@$(call install_fixup, libmodbus,PRIORITY,optional)
	@$(call install_fixup, libmodbus,VERSION,$(LIBMODBUS_VERSION))
	@$(call install_fixup, libmodbus,SECTION,base)
	@$(call install_fixup, libmodbus,AUTHOR,"Josef Holzmayr <holzmayr\@rsi-elektrotechnik.de>")
	@$(call install_fixup, libmodbus,DEPENDS,)
	@$(call install_fixup, libmodbus,DESCRIPTION,missing)

	@$(call install_copy, libmodbus, 0, 0, 0644, \
		$(LIBMODBUS_DIR)/modbus/.libs/libmodbus.so.2.0.0, \
		/usr/lib/libmodbus.so.2.0.0, y)

	@$(call install_link, libmodbus, libmodbus.so.2.0.0, /usr/lib/libmodbus.so.2)
	@$(call install_link, libmodbus, libmodbus.so.2.0.0, /usr/lib/libmodbus.so)

	@$(call install_finish, libmodbus)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libmodbus_clean:
	rm -rf $(STATEDIR)/libmodbus.*
	rm -rf $(PKGDIR)/libmodbus_*
	rm -rf $(LIBMODBUS_DIR)

# vim: syntax=make
