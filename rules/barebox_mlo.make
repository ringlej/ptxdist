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
BAREBOX_MLO_VERSION	= $(BAREBOX_VERSION)
BAREBOX_MLO_MD5		= $(BAREBOX_MD5)
BAREBOX_MLO		= $(BAREBOX)
BAREBOX_MLO_DIR		= $(BUILDDIR)/barebox_mlo-$(BAREBOX_MLO_VERSION)
BAREBOX_MLO_SOURCE	= $(BAREBOX_SOURCE)
BAREBOX_MLO_LICENSE	:= GPLv2

BAREBOX_MLO_CONFIG	:= $(call remove_quotes, \
		$(PTXDIST_PLATFORMCONFIGDIR)/$(PTXCONF_BAREBOX_MLO_CONFIG))

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------
BAREBOX_MLO_CONF_ENV	:= KCONFIG_NOTIMESTAMP=1
BAREBOX_MLO_CONF_TOOL	:= kconfig
BAREBOX_MLO_CONF_OPT	:= \
			HOSTCC=$(HOSTCC) \
			ARCH=$(PTXCONF_BAREBOX_ARCH_STRING) \
			CROSS_COMPILE=$(BOOTLOADER_CROSS_COMPILE)

BAREBOX_MLO_MAKE_OPT	:= $(BAREBOX_MLO_CONF_OPT)

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
	@ptxd_get_path "$(BAREBOX_MLO_DIR)/MLO" \
		"$(BAREBOX_MLO_DIR)/barebox.bin.ift" && \
	install -D -m644 "$${ptxd_reply}" "$(IMAGEDIR)/MLO"

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
		$(BAREBOX_MLO_PATH) $(BAREBOX_MLO_ENV) $(MAKE) \
			$(BAREBOX_MLO_MAKEVARS) $(subst barebox_mlo_,,$@)
	@if cmp -s $(BAREBOX_MLO_DIR)/.config $(BAREBOX_MLO_CONFIG); then \
		echo "barebox_mlo configuration unchanged"; \
	else \
		cp $(BAREBOX_MLO_DIR)/.config $(BAREBOX_MLO_CONFIG); \
	fi

# vim: syntax=make
