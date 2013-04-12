# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Grzeschik <mgr@pengutronix.de>
#

PACKAGES-$(PTXCONF_IMA_EVM_UTILS) += ima-evm-utils

#
# Paths and names
#
IMA_EVM_UTILS_VERSION	:= 0.2
IMA_EVM_UTILS_MD5	:= 3d31ff2bbd42690b6825068447b15dfd
IMA_EVM_UTILS		:= ima-evm-utils-$(IMA_EVM_UTILS_VERSION)
IMA_EVM_UTILS_SUFFIX	:= tar.gz
IMA_EVM_UTILS_URL	:= $(call ptx/mirror, SF, linux-ima/$(IMA_EVM_UTILS).$(IMA_EVM_UTILS_SUFFIX))
IMA_EVM_UTILS_SOURCE	:= $(SRCDIR)/$(IMA_EVM_UTILS).$(IMA_EVM_UTILS_SUFFIX)
IMA_EVM_UTILS_DIR	:= $(BUILDDIR)/$(IMA_EVM_UTILS)
IMA_EVM_UTILS_LICENSE	:= LGPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IMA_EVM_UTILS_CONF_TOOL	:= autoconf
IMA_EVM_UTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ima-evm-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ima-evm-utils)
	@$(call install_fixup, ima-evm-utils,PRIORITY,optional)
	@$(call install_fixup, ima-evm-utils,SECTION,base)
	@$(call install_fixup, ima-evm-utils,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, ima-evm-utils,DESCRIPTION,missing)

	@$(call install_copy, ima-evm-utils, 0, 0, 0755, -, /usr/bin/evmctl)
	@$(call install_tree, ima-evm-utils, 0, 0, -, /usr/lib/ima-evm-utils/)

	@$(call install_finish, ima-evm-utils)

	@$(call touch)

# vim: syntax=make
