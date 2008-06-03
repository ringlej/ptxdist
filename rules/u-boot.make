# -*-makefile-*-
# $Id: u-boot.make,v 1.5 2007-07-03 13:29:45 michl Exp $
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
PACKAGES-$(PTXCONF_U_BOOT) += u-boot

#
# Paths and names
#
U_BOOT_VERSION	:= $(call remove_quotes,$(PTXCONF_U_BOOT_VERSION))
U_BOOT		:= u-boot-$(U_BOOT_VERSION)
U_BOOT_SUFFIX	:= tar.bz2
U_BOOT_URL	:= ftp://ftp.denx.de/pub/u-boot//$(U_BOOT).$(U_BOOT_SUFFIX)
U_BOOT_SOURCE	:= $(SRCDIR)/$(U_BOOT).$(U_BOOT_SUFFIX)
U_BOOT_DIR	:= $(BUILDDIR)/$(U_BOOT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

u-boot_get: $(STATEDIR)/u-boot.get

$(STATEDIR)/u-boot.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(U_BOOT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, U_BOOT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

u-boot_extract: $(STATEDIR)/u-boot.extract

$(STATEDIR)/u-boot.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(U_BOOT_DIR))
	@$(call extract, U_BOOT)
	@$(call patchin, U_BOOT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

u-boot_prepare: $(STATEDIR)/u-boot.prepare

U_BOOT_PATH	:= PATH=$(CROSS_PATH)
U_BOOT_ENV 	:= CROSS_COMPILE=$(COMPILER_PREFIX)

#
# autoconf
#
U_BOOT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/u-boot.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(U_BOOT_DIR)/config.cache)
	cd $(U_BOOT_DIR) && \
		$(U_BOOT_PATH) $(U_BOOT_ENV) \
		$(MAKE) $(PTXCONF_U_BOOT_CONFIG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

u-boot_compile: $(STATEDIR)/u-boot.compile

$(STATEDIR)/u-boot.compile:
	@$(call targetinfo, $@)
# release 1.2.0 seems not be able to massive build in parallel
	@cd $(U_BOOT_DIR) && \
		$(U_BOOT_PATH) $(U_BOOT_ENV) \
		$(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

u-boot_install: $(STATEDIR)/u-boot.install

$(STATEDIR)/u-boot.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

u-boot_targetinstall: $(STATEDIR)/u-boot.targetinstall

$(STATEDIR)/u-boot.targetinstall:
	@$(call targetinfo, $@)

	@install -D -m644 $(U_BOOT_DIR)/u-boot.bin $(IMAGEDIR)/u-boot.bin

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

u-boot_clean:
	@rm -rf $(STATEDIR)/u-boot.*
	@rm -rf $(PKGDIR)/u-boot_*
	@rm -rf $(U_BOOT_DIR)

# vim: syntax=make
