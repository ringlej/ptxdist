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
LIBMODBUS_VERSION	= 1.0.1
LIBMODBUS		= libmodbus-$(LIBMODBUS_VERSION)
LIBMODBUS_SUFFIX	= tar.gz
LIBMODBUS_URL		= http://www.pengutronix.de/software/libmodbus/download/v1.0/$(LIBMODBUS).$(LIBMODBUS_SUFFIX)
LIBMODBUS_SOURCE	= $(SRCDIR)/$(LIBMODBUS).$(LIBMODBUS_SUFFIX)
LIBMODBUS_DIR		= $(BUILDDIR)/$(LIBMODBUS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libmodbus_get: $(STATEDIR)/libmodbus.get

libmodbus_get_deps = $(LIBMODBUS_SOURCE)

$(STATEDIR)/libmodbus.get: $(libmodbus_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBMODBUS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBMODBUS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libmodbus_extract: $(STATEDIR)/libmodbus.extract

libmodbus_extract_deps = $(STATEDIR)/libmodbus.get

$(STATEDIR)/libmodbus.extract: $(libmodbus_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBMODBUS_DIR))
	@$(call extract, $(LIBMODBUS_SOURCE))
	@$(call patchin, $(LIBMODBUS))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libmodbus_prepare: $(STATEDIR)/libmodbus.prepare

#
# dependencies
#
libmodbus_prepare_deps = \
	$(STATEDIR)/libmodbus.extract \
	$(STATEDIR)/virtual-xchain.install

LIBMODBUS_PATH	=  PATH=$(CROSS_PATH)
LIBMODBUS_ENV 	=  $(CROSS_ENV)
LIBMODBUS_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

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

libmodbus_compile_deps = $(STATEDIR)/libmodbus.prepare

$(STATEDIR)/libmodbus.compile: $(libmodbus_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBMODBUS_DIR) && $(LIBMODBUS_ENV) $(LIBMODBUS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libmodbus_install: $(STATEDIR)/libmodbus.install

$(STATEDIR)/libmodbus.install: $(STATEDIR)/libmodbus.compile
	@$(call targetinfo, $@)
	@$(call install, LIBMODBUS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libmodbus_targetinstall: $(STATEDIR)/libmodbus.targetinstall

libmodbus_targetinstall_deps = $(STATEDIR)/libmodbus.compile

$(STATEDIR)/libmodbus.targetinstall: $(libmodbus_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,libmodbus)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBMODBUS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(LIBMODBUS_DIR)/src/.libs/libmodbus.so.0.0.0, \
		/usr/lib/libmodbus.so.0.0.0, y)

	@$(call install_link, libmodbus.so.0.0.0, /usr/lib/libmodbus.so.0)
	@$(call install_link, libmodbus.so.0.0.0, /usr/lib/libmodbus.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libmodbus_clean:
	rm -rf $(STATEDIR)/libmodbus.*
	rm -rf $(IMAGEDIR)/libmodbus_*
	rm -rf $(LIBMODBUS_DIR)

# vim: syntax=make
