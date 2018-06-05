# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON3_CHARDET) += python3-chardet

#
# Paths and names
#
PYTHON3_CHARDET_VERSION	:= 2.3.0
PYTHON3_CHARDET_MD5	:= 25274d664ccb5130adae08047416e1a8
PYTHON3_CHARDET		:= chardet-$(PYTHON3_CHARDET_VERSION)
PYTHON3_CHARDET_SUFFIX	:= tar.gz
PYTHON3_CHARDET_URL	:= https://pypi.python.org/packages/source/c/chardet/$(PYTHON3_CHARDET).$(PYTHON3_CHARDET_SUFFIX)
PYTHON3_CHARDET_SOURCE	:= $(SRCDIR)/$(PYTHON3_CHARDET).$(PYTHON3_CHARDET_SUFFIX)
PYTHON3_CHARDET_DIR	:= $(BUILDDIR)/$(PYTHON3_CHARDET)
PYTHON3_CHARDET_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON3_CHARDET_CONF_TOOL	:= python3
# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python3-chardet.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python3-chardet)
	@$(call install_fixup, python3-chardet,PRIORITY,optional)
	@$(call install_fixup, python3-chardet,SECTION,base)
	@$(call install_fixup, python3-chardet,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, python3-chardet,DESCRIPTION,missing)

	@$(call install_glob, python3-chardet, 0, 0, -, \
		/usr/lib/python$(PYTHON3_MAJORMINOR)/site-packages/chardet,, *.py)

	@$(call install_finish, python3-chardet)

	@$(call touch)

# vim: syntax=make
