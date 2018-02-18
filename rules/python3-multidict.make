# -*-makefile-*-
#
# Copyright (C) 2017 by Pim Klanke <pim@protonic.nl>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_MULTIDICT) += python3-multidict

#
# Paths and names
#
PYTHON3_MULTIDICT_VERSION	:= 2.1.4
PYTHON3_MULTIDICT_MD5		:= 051d92edec87fd98e43ea83f3ce6072d
PYTHON3_MULTIDICT		:= multidict-$(PYTHON3_MULTIDICT_VERSION)
PYTHON3_MULTIDICT_SUFFIX	:= tar.gz
PYTHON3_MULTIDICT_URL		:= https://pypi.python.org/packages/2a/df/eaea73e46a58fd780c35ecc304ca42364fa3c1f4cd03568ed33b9d2c7547/$(PYTHON3_MULTIDICT).$(PYTHON3_MULTIDICT_SUFFIX)
PYTHON3_MULTIDICT_SOURCE	:= $(SRCDIR)/$(PYTHON3_MULTIDICT).$(PYTHON3_MULTIDICT_SUFFIX)
PYTHON3_MULTIDICT_DIR		:= $(BUILDDIR)/$(PYTHON3_MULTIDICT)
PYTHON3_MULTIDICT_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_MULTIDICT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-multidict.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-multidict)
	@$(call install_fixup, python3-multidict, PRIORITY, optional)
	@$(call install_fixup, python3-multidict, SECTION, base)
	@$(call install_fixup, python3-multidict, AUTHOR, "Pim Klanke <pim@protonic.nl>")
	@$(call install_fixup, python3-multidict, DESCRIPTION, missing)

	@$(call install_glob, python3-multidict, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/multidict,, *.py)

	@$(call install_finish, python3-multidict)

	@$(call touch)

# vim: syntax=make
