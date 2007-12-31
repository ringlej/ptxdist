# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSFSUTILS) += sysfsutils

#
# Paths and names
#
SYSFSUTILS_VERSION	:= 2.0.0
SYSFSUTILS		:= sysfsutils-$(SYSFSUTILS_VERSION)
SYSFSUTILS_SUFFIX	:= tar.gz
SYSFSUTILS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/linux-diag/$(SYSFSUTILS).$(SYSFSUTILS_SUFFIX)
SYSFSUTILS_SOURCE	:= $(SRCDIR)/$(SYSFSUTILS).$(SYSFSUTILS_SUFFIX)
SYSFSUTILS_DIR		:= $(BUILDDIR)/$(SYSFSUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sysfsutils_get: $(STATEDIR)/sysfsutils.get

$(STATEDIR)/sysfsutils.get: $(sysfsutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SYSFSUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SYSFSUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sysfsutils_extract: $(STATEDIR)/sysfsutils.extract

$(STATEDIR)/sysfsutils.extract: $(sysfsutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSFSUTILS_DIR))
	@$(call extract, SYSFSUTILS)
	@$(call patchin, SYSFSUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sysfsutils_prepare: $(STATEDIR)/sysfsutils.prepare

SYSFSUTILS_PATH	:= PATH=$(CROSS_PATH)
SYSFSUTILS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SYSFSUTILS_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/sysfsutils.prepare: $(sysfsutils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSFSUTILS_DIR)/config.cache)
	cd $(SYSFSUTILS_DIR) && \
		$(SYSFSUTILS_PATH) $(SYSFSUTILS_ENV) \
		./configure $(SYSFSUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sysfsutils_compile: $(STATEDIR)/sysfsutils.compile

$(STATEDIR)/sysfsutils.compile: $(sysfsutils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SYSFSUTILS_DIR) && $(SYSFSUTILS_ENV) $(SYSFSUTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sysfsutils_install: $(STATEDIR)/sysfsutils.install

$(STATEDIR)/sysfsutils.install: $(sysfsutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SYSFSUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sysfsutils_targetinstall: $(STATEDIR)/sysfsutils.targetinstall

$(STATEDIR)/sysfsutils.targetinstall: $(sysfsutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, sysfsutils)
	@$(call install_fixup, sysfsutils,PACKAGE,sysfsutils)
	@$(call install_fixup, sysfsutils,PRIORITY,optional)
	@$(call install_fixup, sysfsutils,VERSION,$(SYSFSUTILS_VERSION))
	@$(call install_fixup, sysfsutils,SECTION,base)
	@$(call install_fixup, sysfsutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, sysfsutils,DEPENDS,)
	@$(call install_fixup, sysfsutils,DESCRIPTION,missing)

ifdef PTXCONF_SYSFSUTILS_LIB
	@$(call install_copy, sysfsutils, 0, 0, 0644, $(SYSFSUTILS_DIR)/lib/.libs/libsysfs.so.2.0.0, /lib/libsysfs.so.2.0.0)
	@$(call install_link, sysfsutils, libsysfs.so.2.0.0, /lib/libsysfs.so.2)
	@$(call install_link, sysfsutils, libsysfs.so.2.0.0, /lib/libsysfs.so)
endif
ifdef PTXCONF_SYSFSUTILS_SYSTOOL
	@$(call install_copy, sysfsutils, 0, 0, 0775, $(SYSFSUTILS_DIR)/cmd/.libs/systool, /bin/systool, n)
endif
	@$(call install_finish, sysfsutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sysfsutils_clean:
	rm -rf $(STATEDIR)/sysfsutils.*
	rm -rf $(IMAGEDIR)/sysfsutils_*
	rm -rf $(SYSFSUTILS_DIR)

# vim: syntax=make
