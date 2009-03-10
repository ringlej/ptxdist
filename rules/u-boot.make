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

$(U_BOOT_SOURCE):
	@$(call targetinfo)
	@$(call get, U_BOOT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

U_BOOT_PATH	:= PATH=$(CROSS_PATH)
U_BOOT_ENV 	:= CROSS_COMPILE=$(COMPILER_PREFIX)

#
# autoconf
#
U_BOOT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/u-boot.prepare:
	@$(call targetinfo)
	cd $(U_BOOT_DIR) && \
		$(U_BOOT_PATH) $(U_BOOT_ENV) \
		$(MAKE) $(PTXCONF_U_BOOT_CONFIG)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot.compile:
	@$(call targetinfo)
# release 1.2.0 seems not be able to massive build in parallel
	@cd $(U_BOOT_DIR) && \
		$(U_BOOT_PATH) $(U_BOOT_ENV) \
		$(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/u-boot.targetinstall:
	@$(call targetinfo)

	@install -D -m644 $(U_BOOT_DIR)/u-boot.bin $(IMAGEDIR)/u-boot.bin

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

u-boot_clean:
	@rm -rf $(STATEDIR)/u-boot.*
	@rm -rf $(PKGDIR)/u-boot_*
	@rm -rf $(U_BOOT_DIR)

# vim: syntax=make
