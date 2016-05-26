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
PACKAGES-$(PTXCONF_PYTHON3_PTYPROCESS) += python3-ptyprocess

#
# Paths and names
#
PYTHON3_PTYPROCESS_VERSION	:= 0.5.1
PYTHON3_PTYPROCESS_MD5		:= 94e537122914cc9ec9c1eadcd36e73a1
PYTHON3_PTYPROCESS		:= ptyprocess-$(PYTHON3_PTYPROCESS_VERSION)
PYTHON3_PTYPROCESS_SUFFIX	:= tar.gz
PYTHON3_PTYPROCESS_URL		:= https://pypi.python.org/packages/source/p/ptyprocess/$(PYTHON3_PTYPROCESS).$(PYTHON3_PTYPROCESS_SUFFIX)\#md5=$(PYTHON3_PTYPROCESS_MD5)
PYTHON3_PTYPROCESS_SOURCE	:= $(SRCDIR)/$(PYTHON3_PTYPROCESS).$(PYTHON3_PTYPROCESS_SUFFIX)
PYTHON3_PTYPROCESS_DIR		:= $(BUILDDIR)/$(PYTHON3_PTYPROCESS)
PYTHON3_PTYPROCESS_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PTYPROCESS_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-ptyprocess.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-ptyprocess)
	@$(call install_fixup, python3-ptyprocess, PRIORITY, optional)
	@$(call install_fixup, python3-ptyprocess, SECTION, base)
	@$(call install_fixup, python3-ptyprocess, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-ptyprocess, DESCRIPTION, missing)

	@$(call install_glob, python3-ptyprocess, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/ptyprocess,, *.py)

	@$(call install_finish, python3-ptyprocess)

	@$(call touch)

# vim: syntax=make
