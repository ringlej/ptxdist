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
PACKAGES-$(PTXCONF_PYTHON3_PEXPECT) += python3-pexpect

#
# Paths and names
#
PYTHON3_PEXPECT_VERSION	:= 4.6.0
PYTHON3_PEXPECT_MD5	:= d4f3372965a996238d57d19b95d2e03a
PYTHON3_PEXPECT		:= pexpect-$(PYTHON3_PEXPECT_VERSION)
PYTHON3_PEXPECT_SUFFIX	:= tar.gz
PYTHON3_PEXPECT_URL	:= https://pypi.io/packages/source/p/pexpect/$(PYTHON3_PEXPECT).$(PYTHON3_PEXPECT_SUFFIX)
PYTHON3_PEXPECT_SOURCE	:= $(SRCDIR)/$(PYTHON3_PEXPECT).$(PYTHON3_PEXPECT_SUFFIX)
PYTHON3_PEXPECT_DIR	:= $(BUILDDIR)/$(PYTHON3_PEXPECT)
PYTHON3_PEXPECT_LICENSE	:= ISC

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_PEXPECT_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-pexpect.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-pexpect)
	@$(call install_fixup, python3-pexpect, PRIORITY, optional)
	@$(call install_fixup, python3-pexpect, SECTION, base)
	@$(call install_fixup, python3-pexpect, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-pexpect, DESCRIPTION, missing)

	@$(call install_glob, python3-pexpect, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/pexpect,, *.py)

	@$(call install_finish, python3-pexpect)

	@$(call touch)

# vim: syntax=make
