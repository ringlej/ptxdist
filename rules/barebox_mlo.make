# -*-makefile-*-
#
# Copyright (C) 2012 Jan Weitzel <j.weitzel@phytec.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BAREBOX_MLO) += barebox_mlo

#
# Paths and names
#
BAREBOX_MLO_VERSION	:= $(call remove_quotes,$(PTXCONF_BAREBOX_MLO_VERSION))
BAREBOX_MLO_MD5		:= $(call remove_quotes,$(PTXCONF_BAREBOX_MLO_MD5))
BAREBOX_MLO		:= barebox-$(BAREBOX_MLO_VERSION)
BAREBOX_MLO_URL		= http://www.barebox.org/download/$(BAREBOX_MLO).$(BAREBOX_SUFFIX)
BAREBOX_MLO_DIR		:= $(BUILDDIR)/barebox_mlo-$(BAREBOX_MLO_VERSION)
BAREBOX_MLO_SOURCE	= $(SRCDIR)/$(BAREBOX_MLO).$(BAREBOX_SUFFIX)
BAREBOX_MLO_LICENSE	:= GPL-2.0-only

BAREBOX_MLO_CONFIG	:= $(call ptx/in-platformconfigdir, \
		$(call remove_quotes, $(PTXCONF_BAREBOX_MLO_CONFIG)))

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BAREBOX_MLO_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

BAREBOX_MLO_PATH	:= PATH=$(CROSS_PATH)
BAREBOX_MLO_CONF_ENV	:= KCONFIG_NOTIMESTAMP=1
BAREBOX_MLO_CONF_TOOL	:= kconfig
BAREBOX_MLO_CONF_OPT	:= \
			V=$(PTXDIST_VERBOSE) \
			HOSTCC=$(HOSTCC) \
			ARCH=$(PTXCONF_BAREBOX_MLO_ARCH_STRING) \
			CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE)

BAREBOX_MLO_MAKE_OPT	:= $(BAREBOX_MLO_CONF_OPT)

ifdef PTXCONF_BAREBOX_MLO
$(BAREBOX_MLO_CONFIG):
	@echo
	@echo "****************************************************************************"
	@echo "*Please generate a barebox MLO config with 'ptxdist menuconfig barebox_mlo'*"
	@echo "****************************************************************************"
	@echo
	@echo
	@exit 1
endif

$(STATEDIR)/barebox_mlo.prepare: $(BAREBOX_MLO_CONFIG)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox_mlo.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox_mlo.targetinstall:
	@$(call targetinfo)
#	#barebox renamed barebox.bin.ift to MLO, so fall back to barebox.bin.ift
	@rm -f $(IMAGEDIR)/MLO
	@for image in `ls $(BAREBOX_MLO_DIR)/images/barebox-*.img`; do \
		install -D -m644 $$image $(IMAGEDIR)/`basename $$image`; \
		if [ ! -e "$(IMAGEDIR)/MLO" ]; then \
			ln -sf `basename $$image` $(IMAGEDIR)/MLO; \
		fi; \
	done
	@if [ ! -e "$(IMAGEDIR)/MLO" ]; then \
		ptxd_get_path "$(BAREBOX_MLO_DIR)/MLO" \
			"$(BAREBOX_MLO_DIR)/barebox.bin.ift" && \
		install -D -m644 "$${ptxd_reply}" "$(IMAGEDIR)/MLO"; \
	fi

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox_mlo.clean:
	@$(call targetinfo)
	@$(call clean_pkg, BAREBOX_MLO)
	rm -rf $(IMAGEDIR)/MLO

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

barebox_mlo_oldconfig barebox_mlo_menuconfig: $(STATEDIR)/barebox_mlo.extract
	@if test -e $(BAREBOX_MLO_CONFIG); then \
		cp $(BAREBOX_MLO_CONFIG) $(BAREBOX_MLO_DIR)/.config; \
	fi
	cd $(BAREBOX_MLO_DIR) && \
		$(BAREBOX_MLO_PATH) $(BAREBOX_MLO_CONF_ENV) $(MAKE) \
			$(BAREBOX_MLO_CONF_OPT) $(subst barebox_mlo_,,$@)
	@if cmp -s $(BAREBOX_MLO_DIR)/.config $(BAREBOX_MLO_CONFIG); then \
		echo "barebox_mlo configuration unchanged"; \
	else \
		cp $(BAREBOX_MLO_DIR)/.config $(BAREBOX_MLO_CONFIG); \
	fi

# vim: syntax=make
