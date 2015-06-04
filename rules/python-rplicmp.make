# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON_RPLICMP) += python-rplicmp

#
# Paths and names
#
PYTHON_RPLICMP_VERSION	:= 1.0
PYTHON_RPLICMP_MD5	:= b2d9a93beb095826fce6e4752fb63491
PYTHON_RPLICMP		:= python_rplicmp-$(PYTHON_RPLICMP_VERSION)
PYTHON_RPLICMP_SUFFIX	:= tar.gz
PYTHON_RPLICMP_URL	:= http://cakelab.org/~eintopf/RPL/$(PYTHON_RPLICMP).$(PYTHON_RPLICMP_SUFFIX)
PYTHON_RPLICMP_SOURCE	:= $(SRCDIR)/$(PYTHON_RPLICMP).$(PYTHON_RPLICMP_SUFFIX)
PYTHON_RPLICMP_DIR	:= $(BUILDDIR)/$(PYTHON_RPLICMP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_RPLICMP_CONF_TOOL	:= python

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python-rplicmp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python-rplicmp)
	@$(call install_fixup, python-rplicmp,PRIORITY,optional)
	@$(call install_fixup, python-rplicmp,SECTION,base)
	@$(call install_fixup, python-rplicmp,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, python-rplicmp,DESCRIPTION,missing)

	@$(call install_copy, python-rplicmp, 0, 0, 0644, -, $(PYTHON_SITEPACKAGES)/RplIcmp.so)

	@$(call install_finish, python-rplicmp)

	@$(call touch)

# vim: syntax=make
