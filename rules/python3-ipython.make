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
PACKAGES-$(PTXCONF_PYTHON3_IPYTHON) += python3-ipython

#
# Paths and names
#
PYTHON3_IPYTHON_VERSION		:= 4.1.1
PYTHON3_IPYTHON_MD5		:= 3da622447b3b7ca7d41c868c80bb8b0e
PYTHON3_IPYTHON			:= ipython-$(PYTHON3_IPYTHON_VERSION)
PYTHON3_IPYTHON_SUFFIX		:= tar.gz
PYTHON3_IPYTHON_URL		:= https://pypi.python.org/packages/source/i/ipython/$(PYTHON3_IPYTHON).$(PYTHON3_IPYTHON_SUFFIX)\#md5=3da622447b3b7ca7d41c868c80bb8b0e
PYTHON3_IPYTHON_SOURCE		:= $(SRCDIR)/$(PYTHON3_IPYTHON).$(PYTHON3_IPYTHON_SUFFIX)
PYTHON3_IPYTHON_DIR		:= $(BUILDDIR)/$(PYTHON3_IPYTHON)
PYTHON3_IPYTHON_LICENSE		:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_IPYTHON_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-ipython.install:
	@$(call targetinfo)
	@$(call world/install, PYTHON3_IPYTHON)
	@sed -i 's;#!/.*;#!/usr/bin/python$(PYTHON3_MAJORMINOR);' \
		$(PYTHON3_IPYTHON_PKGDIR)/usr/bin/*
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-ipython.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-ipython)
	@$(call install_fixup, python3-ipython, PRIORITY, optional)
	@$(call install_fixup, python3-ipython, SECTION, base)
	@$(call install_fixup, python3-ipython, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-ipython, DESCRIPTION, missing)

#	# We have to install the source code to avoid python3 error: "OSError: could not get source code"
	@$(call install_glob, python3-ipython, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/IPython,, *.pyc)

	@$(call install_copy, python3-ipython, 0, 0, 0755, -, /usr/bin/ipython3)

	@$(call install_finish, python3-ipython)

	@$(call touch)

# vim: syntax=make
