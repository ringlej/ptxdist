# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
U_BOOT_URL	:= ftp://ftp.denx.de/pub/u-boot/$(U_BOOT).$(U_BOOT_SUFFIX)
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
U_BOOT_ENV 	:= CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE)
U_BOOT_MAKE_PAR	:= NO

$(STATEDIR)/u-boot.prepare:
	@$(call targetinfo)
	cd $(U_BOOT_DIR) && \
		$(U_BOOT_PATH) $(U_BOOT_ENV) \
		$(MAKE) $(PTXCONF_U_BOOT_CONFIG)
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

$(STATEDIR)/u-boot.clean:
	@$(call targetinfo)
	@$(call clean_pkg, U_BOOT)
	@rm -rf $(IMAGEDIR)/u-boot.bin

# vim: syntax=make
