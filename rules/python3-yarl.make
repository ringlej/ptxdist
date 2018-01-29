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
PACKAGES-$(PTXCONF_PYTHON3_YARL) += python3-yarl

#
# Paths and names
#
PYTHON3_YARL_VERSION	:= 0.8.1
PYTHON3_YARL_MD5	:= 34f60a148ab55e3bfde2c0efd7026308
PYTHON3_YARL		:= yarl-$(PYTHON3_YARL_VERSION)
PYTHON3_YARL_SUFFIX	:= tar.gz
PYTHON3_YARL_URL	:= https://pypi.python.org/packages/10/1b/be30529bde22c85c2975a4e21cf7f13edbcb291350fbbde8bc13938620c8/$(PYTHON3_YARL).$(PYTHON3_YARL_SUFFIX)
PYTHON3_YARL_SOURCE	:= $(SRCDIR)/$(PYTHON3_YARL).$(PYTHON3_YARL_SUFFIX)
PYTHON3_YARL_DIR	:= $(BUILDDIR)/$(PYTHON3_YARL)
PYTHON3_YARL_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_YARL_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-yarl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-yarl)
	@$(call install_fixup, python3-yarl, PRIORITY, optional)
	@$(call install_fixup, python3-yarl, SECTION, base)
	@$(call install_fixup, python3-yarl, AUTHOR, "Pim Klanke <pim@protonic.nl>")
	@$(call install_fixup, python3-yarl, DESCRIPTION, missing)

	@$(call install_glob, python3-yarl, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/yarl,, *.py)

	@$(call install_finish, python3-yarl)

	@$(call touch)

# vim: syntax=make
