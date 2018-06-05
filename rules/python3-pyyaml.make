# -*-makefile-*-
#
# Copyright (C) 2018 by Bastian Stender <bst@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_PYYAML) += python3-pyyaml

#
# Paths and names
#
PYTHON3_PYYAML_VERSION	:= 3.12
PYTHON3_PYYAML_MD5	:= 5c41a91fae3da4f5302e25e5d8f4deeb
PYTHON3_PYYAML		:= pyyaml-$(PYTHON3_PYYAML_VERSION)
PYTHON3_PYYAML_SUFFIX	:= tar.gz
PYTHON3_PYYAML_URL	:= https://github.com/yaml/pyyaml/archive/$(PYTHON3_PYYAML_VERSION).$(PYTHON3_PYYAML_SUFFIX)
PYTHON3_PYYAML_SOURCE	:= $(SRCDIR)/$(PYTHON3_PYYAML).$(PYTHON3_PYYAML_SUFFIX)
PYTHON3_PYYAML_DIR	:= $(BUILDDIR)/$(PYTHON3_PYYAML)
PYTHON3_PYYAML_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PYYAML_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pyyaml.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pyyaml)
	@$(call install_fixup, python3-pyyaml, PRIORITY, optional)
	@$(call install_fixup, python3-pyyaml, SECTION, base)
	@$(call install_fixup, python3-pyyaml, AUTHOR, "Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, python3-pyyaml, DESCRIPTION, missing)

	@$(call install_glob, python3-pyyaml, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/yaml,, *.py)

	@$(call install_finish, python3-pyyaml)

	@$(call touch)

# vim: syntax=make
