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
PACKAGES-$(PTXCONF_PYTHON3_IPYTHON_GENUTILS) += python3-ipython-genutils

#
# Paths and names
#
PYTHON3_IPYTHON_GENUTILS_VERSION	:= 0.1.0
PYTHON3_IPYTHON_GENUTILS_MD5		:= 9a8afbe0978adbcbfcb3b35b2d015a56
PYTHON3_IPYTHON_GENUTILS		:= ipython_genutils-$(PYTHON3_IPYTHON_GENUTILS_VERSION)
PYTHON3_IPYTHON_GENUTILS_SUFFIX		:= tar.gz
PYTHON3_IPYTHON_GENUTILS_URL		:= https://pypi.python.org/packages/source/i/ipython_genutils/$(PYTHON3_IPYTHON_GENUTILS).$(PYTHON3_IPYTHON_GENUTILS_SUFFIX)\#md5=$(PYTHON3_IPYTHON_GENUTILS_MD5)
PYTHON3_IPYTHON_GENUTILS_SOURCE		:= $(SRCDIR)/$(PYTHON3_IPYTHON_GENUTILS).$(PYTHON3_IPYTHON_GENUTILS_SUFFIX)
PYTHON3_IPYTHON_GENUTILS_DIR		:= $(BUILDDIR)/$(PYTHON3_IPYTHON_GENUTILS)
PYTHON3_IPYTHON_GENUTILS_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_IPYTHON_GENUTILS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-ipython-genutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-ipython-genutils)
	@$(call install_fixup, python3-ipython-genutils, PRIORITY, optional)
	@$(call install_fixup, python3-ipython-genutils, SECTION, base)
	@$(call install_fixup, python3-ipython-genutils, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-ipython-genutils, DESCRIPTION, missing)

	@$(call install_glob, python3-ipython-genutils, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/ipython_genutils,, *.py)

	@$(call install_finish, python3-ipython-genutils)

	@$(call touch)

# vim: syntax=make
