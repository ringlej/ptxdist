# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_CALIBRATOR) += calibrator

#
# Paths and names
#
CALIBRATOR_VERSION	:= 20070821-1
CALIBRATOR		:= calibrator-$(CALIBRATOR_VERSION)
CALIBRATOR_SUFFIX	:= tar.bz2
CALIBRATOR_URL		:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(CALIBRATOR).$(CALIBRATOR_SUFFIX)
CALIBRATOR_SOURCE	:= $(SRCDIR)/$(CALIBRATOR).$(CALIBRATOR_SUFFIX)
CALIBRATOR_DIR		:= $(BUILDDIR)/$(CALIBRATOR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

calibrator_get: $(STATEDIR)/calibrator.get

$(STATEDIR)/calibrator.get: $(calibrator_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CALIBRATOR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CALIBRATOR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

calibrator_extract: $(STATEDIR)/calibrator.extract

$(STATEDIR)/calibrator.extract: $(calibrator_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CALIBRATOR_DIR))
	@$(call extract, CALIBRATOR)
	@$(call patchin, CALIBRATOR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

calibrator_prepare: $(STATEDIR)/calibrator.prepare

CALIBRATOR_PATH	:= PATH=$(CROSS_PATH)
CALIBRATOR_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CALIBRATOR_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/calibrator.prepare: $(calibrator_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

calibrator_compile: $(STATEDIR)/calibrator.compile

$(STATEDIR)/calibrator.compile: $(calibrator_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CALIBRATOR_DIR) && $(CALIBRATOR_PATH) CC=$(CROSS_CC) LDFLAGS=-lm $(MAKE) $(PARALLELMFLAGS) calibrator
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

calibrator_install: $(STATEDIR)/calibrator.install

$(STATEDIR)/calibrator.install: $(calibrator_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

calibrator_targetinstall: $(STATEDIR)/calibrator.targetinstall

$(STATEDIR)/calibrator.targetinstall: $(calibrator_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, calibrator)
	@$(call install_fixup, calibrator,PACKAGE,calibrator)
	@$(call install_fixup, calibrator,PRIORITY,optional)
	@$(call install_fixup, calibrator,VERSION,$(CALIBRATOR_VERSION))
	@$(call install_fixup, calibrator,SECTION,base)
	@$(call install_fixup, calibrator,AUTHOR,"Michael Olbrich <m.olbrich\@pengutronix.de>")
	@$(call install_fixup, calibrator,DEPENDS,)
	@$(call install_fixup, calibrator,DESCRIPTION,missing)

	@$(call install_copy, calibrator, 0, 0, 0755, $(CALIBRATOR_DIR)/calibrator, /usr/bin/calibrator)

	@$(call install_finish, calibrator)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

calibrator_clean:
	rm -rf $(STATEDIR)/calibrator.*
	rm -rf $(PKGDIR)/calibrator_*
	rm -rf $(CALIBRATOR_DIR)

# vim: syntax=make
