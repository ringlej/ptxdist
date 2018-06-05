# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Grzeschik <mgr@pengutronix.de>
#               2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IMA_EVM_UTILS) += ima-evm-utils

#
# Paths and names
#
IMA_EVM_UTILS_VERSION	:= 1.0
IMA_EVM_UTILS_MD5	:= d0e4a4fb92b8fc7c22dfd092c50568ae
IMA_EVM_UTILS		:= ima-evm-utils-$(IMA_EVM_UTILS_VERSION)
IMA_EVM_UTILS_SUFFIX	:= tar.gz
IMA_EVM_UTILS_URL	:= $(call ptx/mirror, SF, linux-ima/$(IMA_EVM_UTILS).$(IMA_EVM_UTILS_SUFFIX))
IMA_EVM_UTILS_SOURCE	:= $(SRCDIR)/$(IMA_EVM_UTILS).$(IMA_EVM_UTILS_SUFFIX)
IMA_EVM_UTILS_DIR	:= $(BUILDDIR)/$(IMA_EVM_UTILS)
IMA_EVM_UTILS_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IMA_EVM_UTILS_CONF_TOOL := autoconf
IMA_EVM_UTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
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
	@$(call install_lib, ima-evm-utils, 0, 0, 0644, libimaevm)

	@$(call install_finish, ima-evm-utils)

	@$(call touch)

# vim: syntax=make
