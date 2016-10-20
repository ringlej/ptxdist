# -*-makefile-*-
#
# Copyright (C) 2016 by Florian Scherf <f.scherf@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_AIOHTTP_JSON_RPC) += python3-aiohttp-json-rpc

#
# Paths and names
#
PYTHON3_AIOHTTP_JSON_RPC_VERSION	:= 0.5.1
PYTHON3_AIOHTTP_JSON_RPC_MD5		:= 11ba906c51ff5bf8aab0b57004c3036d
PYTHON3_AIOHTTP_JSON_RPC		:= aiohttp-json-rpc-$(PYTHON3_AIOHTTP_JSON_RPC_VERSION)
PYTHON3_AIOHTTP_JSON_RPC_SUFFIX		:= tar.gz
PYTHON3_AIOHTTP_JSON_RPC_URL		:= https://pypi.python.org/packages/3b/a8/04a2b02bb68b8a7f9eff84ab2241fba8df14a2796613a830a70b8eeecaa6/$(PYTHON3_AIOHTTP_JSON_RPC).$(PYTHON3_AIOHTTP_JSON_RPC_SUFFIX)\#md5=$(PYTHON3_AIOHTTP_JSON_RPC_MD5)
PYTHON3_AIOHTTP_JSON_RPC_SOURCE		:= $(SRCDIR)/$(PYTHON3_AIOHTTP_JSON_RPC).$(PYTHON3_AIOHTTP_JSON_RPC_SUFFIX)
PYTHON3_AIOHTTP_JSON_RPC_DIR		:= $(BUILDDIR)/$(PYTHON3_AIOHTTP_JSON_RPC)
PYTHON3_AIOHTTP_JSON_RPC_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_AIOHTTP_JSON_RPC_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-aiohttp-json-rpc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-aiohttp-json-rpc)
	@$(call install_fixup, python3-aiohttp-json-rpc, PRIORITY, optional)
	@$(call install_fixup, python3-aiohttp-json-rpc, SECTION, base)
	@$(call install_fixup, python3-aiohttp-json-rpc, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-aiohttp-json-rpc, DESCRIPTION, missing)

	@$(call install_glob, python3-aiohttp-json-rpc, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/aiohttp_json_rpc,, *.py)

	@$(call install_finish, python3-aiohttp-json-rpc)

	@$(call touch)

# vim: syntax=make
