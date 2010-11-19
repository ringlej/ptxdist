# -*-makefile-*-
#
# Copyright (C) 2007 by Sascha Hauer
#               2008, 2009 by Marc Kleine-Budde
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX) += barebox

#
# Paths and names
#
BAREBOX_VERSION	:= $(call remove_quotes,$(PTXCONF_BAREBOX_VERSION))
BAREBOX_MD5	:= $(call remove_quotes,$(PTXCONF_BAREBOX_MD5))
BAREBOX		:= barebox-$(BAREBOX_VERSION)
BAREBOX_SUFFIX	:= tar.bz2
BAREBOX_URL	:= http://www.barebox.org/download/$(BAREBOX).$(BAREBOX_SUFFIX)
BAREBOX_SOURCE	:= $(SRCDIR)/$(BAREBOX).$(BAREBOX_SUFFIX)
BAREBOX_DIR	:= $(BUILDDIR)/$(BAREBOX)
BAREBOX_LICENSE	:= GPLv2

BAREBOX_CONFIG	:= $(call remove_quotes, $(PTXDIST_PLATFORMCONFIGDIR)/$(PTXCONF_BAREBOX_CONFIG))

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BAREBOX_SOURCE):
	@$(call targetinfo)
	@$(call get, BAREBOX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_PATH	:= PATH=$(CROSS_PATH)
BAREBOX_ENV 	:= KCONFIG_NOTIMESTAMP=1
BAREBOX_MAKEVARS := \
	HOSTCC=$(HOSTCC) \
	ARCH=$(PTXCONF_BAREBOX_ARCH_STRING) \
	CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE)

ifdef PTXCONF_BAREBOX_BTCS
BAREBOX_MAKEVARS += \
	CFLAGS_btcs.o+=-I"$(KERNEL_HEADERS_INCLUDE_DIR)"
endif

ifdef PTXCONF_BAREBOX
$(BAREBOX_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo "**** Please generate a barebox config with 'ptxdist menuconfig barebox' ****"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox.prepare: $(BAREBOX_CONFIG)
	@$(call targetinfo)

	@echo "Using barebox config file: $(BAREBOX_CONFIG)"
	@install -m 644 $(BAREBOX_CONFIG) $(BAREBOX_DIR)/.config

ifdef PTXCONF_BAREBOX_EXTRA_ENV
	@rm -rf $(BAREBOX_DIR)/.ptxdist-defaultenv
	@ptxd_source_kconfig "${PTXDIST_PTXCONFIG}" && \
	ptxd_source_kconfig "${PTXDIST_PLATFORMCONFIG}" && \
	ptxd_filter_dir "$(PTXCONF_BAREBOX_EXTRA_ENV_PATH)" \
		$(BAREBOX_DIR)/.ptxdist-defaultenv
	@sed -i -e "s,^\(CONFIG_DEFAULT_ENVIRONMENT_PATH=.*\)\"$$,\1 .ptxdist-defaultenv\"," \
		$(BAREBOX_DIR)/.config
endif

	@$(call ptx/oldconfig, BAREBOX)

	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox.compile:
	@$(call targetinfo)
	cd $(BAREBOX_DIR) && $(BAREBOX_PATH) $(MAKE) $(BAREBOX_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox.install:
	@$(call targetinfo)
	@install -D -m755 $(BAREBOX_DIR)/scripts/bareboxenv $(PTXCONF_SYSROOT_HOST)/bin/bareboxenv
ifdef PTXCONF_ARCH_X86
	@install -D -m755 $(BAREBOX_DIR)/scripts/setupmbr/setupmbr $(PTXCONF_SYSROOT_HOST)/bin/setupmbr
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox.targetinstall:
	@$(call targetinfo)
	@install -D -m644 $(BAREBOX_DIR)/barebox.bin $(IMAGEDIR)/barebox-image
	@install -D -m644 $(BAREBOX_DIR)/barebox_default_env $(IMAGEDIR)/barebox-default-environment
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX)
	rm -rf $(IMAGEDIR)/barebox-image

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox_oldconfig barebox_menuconfig: $(STATEDIR)/barebox.extract
	@if test -e $(BAREBOX_CONFIG); then \
		cp $(BAREBOX_CONFIG) $(BAREBOX_DIR)/.config; \
	fi
	cd $(BAREBOX_DIR) && \
		$(BAREBOX_PATH) $(BAREBOX_ENV) $(MAKE) $(BAREBOX_MAKEVARS) $(subst barebox_,,$@)
	@if cmp -s $(BAREBOX_DIR)/.config $(BAREBOX_CONFIG); then \
		echo "barebox configuration unchanged"; \
	else \
		cp $(BAREBOX_DIR)/.config $(BAREBOX_CONFIG); \
	fi

# vim: syntax=make
