# -*-makefile-*-
#
# Copyright (C) 2015 by Bastian Stender <bst@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_GBULB) += python3-gbulb

#
# Paths and names
#
PYTHON3_GBULB_VERSION	:= 0.6.1
PYTHON3_GBULB_MD5	:= f3389e58474bdcd80ec2bae0292f2652
PYTHON3_GBULB		:= gbulb-$(PYTHON3_GBULB_VERSION)
PYTHON3_GBULB_SUFFIX	:= zip
PYTHON3_GBULB_URL	:= https://github.com/nathan-hoad/gbulb/archive/$(PYTHON3_GBULB_VERSION).$(PYTHON3_GBULB_SUFFIX)
PYTHON3_GBULB_SOURCE	:= $(SRCDIR)/$(PYTHON3_GBULB).$(PYTHON3_GBULB_SUFFIX)
PYTHON3_GBULB_DIR	:= $(BUILDDIR)/$(PYTHON3_GBULB)
PYTHON3_GBULB_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_GBULB_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-gbulb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-gbulb)
	@$(call install_fixup, python3-gbulb, PRIORITY, optional)
	@$(call install_fixup, python3-gbulb, SECTION, base)
	@$(call install_fixup, python3-gbulb, AUTHOR, "Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, python3-gbulb, DESCRIPTION, \
		"A Python library that implements a PEP 3156 interface for the GLib main event loop.")

	@$(call install_glob, python3-gbulb, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/gbulb,, *.py)

	@$(call install_finish, python3-gbulb)

	@$(call touch)

# vim: syntax=make
