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
PACKAGES-$(PTXCONF_PYTHON3_SIMPLEGENERIC) += python3-simplegeneric

#
# Paths and names
#
PYTHON3_SIMPLEGENERIC_VERSION	:= 0.8.1
PYTHON3_SIMPLEGENERIC_MD5	:= f9c1fab00fd981be588fc32759f474e3
PYTHON3_SIMPLEGENERIC		:= simplegeneric-$(PYTHON3_SIMPLEGENERIC_VERSION)
PYTHON3_SIMPLEGENERIC_SUFFIX	:= zip
PYTHON3_SIMPLEGENERIC_URL	:= https://pypi.python.org/packages/source/s/simplegeneric/$(PYTHON3_SIMPLEGENERIC).$(PYTHON3_SIMPLEGENERIC_SUFFIX)\#md5=$(PYTHON3_SIMPLEGENERIC_MD5)
PYTHON3_SIMPLEGENERIC_SOURCE	:= $(SRCDIR)/$(PYTHON3_SIMPLEGENERIC).$(PYTHON3_SIMPLEGENERIC_SUFFIX)
PYTHON3_SIMPLEGENERIC_DIR	:= $(BUILDDIR)/$(PYTHON3_SIMPLEGENERIC)
PYTHON3_SIMPLEGENERIC_LICENSE	:= ZPL-2.1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_SIMPLEGENERIC_CONF_TOOL	:= python3

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-simplegeneric.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-simplegeneric)
	@$(call install_fixup, python3-simplegeneric, PRIORITY, optional)
	@$(call install_fixup, python3-simplegeneric, SECTION, base)
	@$(call install_fixup, python3-simplegeneric, AUTHOR, "Florian Scherf <f.scherf@pengutronix.de>")
	@$(call install_fixup, python3-simplegeneric, DESCRIPTION, missing)

	@$(call install_copy, python3-simplegeneric, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/simplegeneric.pyc)

	@$(call install_finish, python3-simplegeneric)

	@$(call touch)

# vim: syntax=make
