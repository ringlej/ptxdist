# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
# 		2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBXMLCONFIG) += libxmlconfig

#
# Paths and names
#
LIBXMLCONFIG_VERSION	:= 1.0.8
LIBXMLCONFIG		:= libxmlconfig-$(LIBXMLCONFIG_VERSION)
LIBXMLCONFIG_SUFFIX	:= tar.bz2
LIBXMLCONFIG_URL	:= http://www.pengutronix.de/software/libxmlconfig/download/$(LIBXMLCONFIG).$(LIBXMLCONFIG_SUFFIX)
LIBXMLCONFIG_SOURCE	:= $(SRCDIR)/$(LIBXMLCONFIG).$(LIBXMLCONFIG_SUFFIX)
LIBXMLCONFIG_DIR	:= $(BUILDDIR)/$(LIBXMLCONFIG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libxmlconfig_get: $(STATEDIR)/libxmlconfig.get

$(STATEDIR)/libxmlconfig.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBXMLCONFIG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBXMLCONFIG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libxmlconfig_extract: $(STATEDIR)/libxmlconfig.extract

$(STATEDIR)/libxmlconfig.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXMLCONFIG_DIR))
	@$(call extract, LIBXMLCONFIG)
	@$(call patchin, LIBXMLCONFIG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libxmlconfig_prepare: $(STATEDIR)/libxmlconfig.prepare

LIBXMLCONFIG_PATH	:=  PATH=$(CROSS_PATH)
LIBXMLCONFIG_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
LIBXMLCONFIG_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/libxmlconfig.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIBXMLCONFIG_DIR)/config.cache)
	cd $(LIBXMLCONFIG_DIR) && \
		$(LIBXMLCONFIG_PATH) $(LIBXMLCONFIG_ENV) \
		./configure $(LIBXMLCONFIG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libxmlconfig_compile: $(STATEDIR)/libxmlconfig.compile

$(STATEDIR)/libxmlconfig.compile:
	@$(call targetinfo, $@)
	cd $(LIBXMLCONFIG_DIR) && $(LIBXMLCONFIG_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libxmlconfig_install: $(STATEDIR)/libxmlconfig.install

$(STATEDIR)/libxmlconfig.install:
	@$(call targetinfo, $@)
	@$(call install, LIBXMLCONFIG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libxmlconfig_targetinstall: $(STATEDIR)/libxmlconfig.targetinstall

$(STATEDIR)/libxmlconfig.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, libxmlconfig)
	@$(call install_fixup, libxmlconfig,PACKAGE,libxmlconfig)
	@$(call install_fixup, libxmlconfig,PRIORITY,optional)
	@$(call install_fixup, libxmlconfig,VERSION,$(LIBXMLCONFIG_VERSION))
	@$(call install_fixup, libxmlconfig,SECTION,base)
	@$(call install_fixup, libxmlconfig,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libxmlconfig,DEPENDS,)
	@$(call install_fixup, libxmlconfig,DESCRIPTION,missing)

	@$(call install_copy, libxmlconfig, 0, 0, 0644, $(LIBXMLCONFIG_DIR)/.libs/libxmlconfig.so.0.0.0, /usr/lib/libxmlconfig.so.0.0.0)
	@$(call install_link, libxmlconfig, libxmlconfig.so.0.0.0, /usr/lib/libxmlconfig.so.0)
	@$(call install_link, libxmlconfig, libxmlconfig.so.0.0.0, /usr/lib/libxmlconfig.so)

	@$(call install_finish, libxmlconfig)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libxmlconfig_clean:
	rm -rf $(STATEDIR)/libxmlconfig.*
	rm -rf $(IMAGEDIR)/libxmlconfig_*
	rm -rf $(LIBXMLCONFIG_DIR)

# vim: syntax=make
