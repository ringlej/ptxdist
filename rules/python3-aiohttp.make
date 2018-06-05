# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_AIOHTTP) += python3-aiohttp

#
# Paths and names
#
PYTHON3_AIOHTTP_VERSION	:= 1.2.0
PYTHON3_AIOHTTP_MD5	:= a7b25d51bf887ec4f9b87463a6bff6d4
PYTHON3_AIOHTTP		:= aiohttp-$(PYTHON3_AIOHTTP_VERSION)
PYTHON3_AIOHTTP_SUFFIX	:= tar.gz
PYTHON3_AIOHTTP_URL	:= https://pypi.python.org/packages/e5/a5/ade96691f6423c56f7911a42a51ecd5454619efd6d5026df7e08a556a36a/$(PYTHON3_AIOHTTP).$(PYTHON3_AIOHTTP_SUFFIX)
PYTHON3_AIOHTTP_SOURCE	:= $(SRCDIR)/$(PYTHON3_AIOHTTP).$(PYTHON3_AIOHTTP_SUFFIX)
PYTHON3_AIOHTTP_DIR	:= $(BUILDDIR)/$(PYTHON3_AIOHTTP)
PYTHON3_AIOHTTP_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_AIOHTTP_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-aiohttp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-aiohttp)
	@$(call install_fixup, python3-aiohttp,PRIORITY,optional)
	@$(call install_fixup, python3-aiohttp,SECTION,base)
	@$(call install_fixup, python3-aiohttp,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-aiohttp,DESCRIPTION,missing)

	@$(call install_glob, python3-aiohttp, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/aiohttp,, *.py)

	@$(call install_finish, python3-aiohttp)

	@$(call touch)

# vim: syntax=make
