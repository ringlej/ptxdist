# -*-makefile-*-
#
# Copyright (C) 2008 by Remy Bohmer <linux@bohmer.net>
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
PACKAGES-$(PTXCONF_AT91BOOTSTRAP) += at91bootstrap

#
# Paths and names
#
AT91BOOTSTRAP_VERSION	:= $(call remove_quotes,$(PTXCONF_AT91BOOTSTRAP_VERSION))
AT91BOOTSTRAP_MD5	:= $(call remove_quotes,$(PTXCONF_AT91BOOTSTRAP_MD5))
AT91BOOTSTRAP_SUFFIX	:= zip
AT91BOOTSTRAP		:= Bootstrap-v$(AT91BOOTSTRAP_VERSION)
AT91BOOTSTRAP_TARBALL	:= AT91Bootstrap$(AT91BOOTSTRAP_VERSION).$(AT91BOOTSTRAP_SUFFIX)
AT91BOOTSTRAP_URL	:= \
        http://www.atmel.com/dyn/resources/prod_documents/$(AT91BOOTSTRAP_TARBALL) \
        http://sources.buildroot.net/$(AT91BOOTSTRAP_TARBALL)
AT91BOOTSTRAP_SOURCE	:= $(SRCDIR)/$(AT91BOOTSTRAP_TARBALL)
AT91BOOTSTRAP_DIR	:= $(BUILDDIR)/$(AT91BOOTSTRAP)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

AT91BOOTSTRAP_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

AT91BOOTSTRAP_ENV 	:= \
    CROSS_COMPILE=$(COMPILER_PREFIX) \
    pkg_wrapper_blacklist="$(AT91BOOTSTRAP_WRAPPER_BLACKLIST)"

AT91BOOTSTRAP_BOOTMEDIA-$(PTXCONF_AT91BOOTSTRAP_BOOT_DATAFLASH) += dataflash
AT91BOOTSTRAP_BOOTMEDIA-$(PTXCONF_AT91BOOTSTRAP_BOOT_NAND)	+= nandflash

AT91BOOTSTRAP_BOARDDIR  := \
	$(AT91BOOTSTRAP_DIR)/board/${PTXCONF_AT91BOOTSTRAP_CONFIG}/$(AT91BOOTSTRAP_BOOTMEDIA-y)

$(STATEDIR)/at91bootstrap.compile:
	@$(call targetinfo)
	@cd $(AT91BOOTSTRAP_BOARDDIR) && \
		$(AT91BOOTSTRAP_PATH) $(AT91BOOTSTRAP_ENV) \
		$(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap.targetinstall:
	@$(call targetinfo)
	@install -m644 $(AT91BOOTSTRAP_BOARDDIR)/$(AT91BOOTSTRAP_BOOTMEDIA-y)_${PTXCONF_AT91BOOTSTRAP_CONFIG}.bin \
		$(IMAGEDIR)/at91bootstrap.bin
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/at91bootstrap.clean:
	@$(call targetinfo)
	@$(call clean_pkg, AT91BOOTSTRAP)
	@rm -rf $(IMAGEDIR)/at91bootstrap*

# vim: syntax=make
