# -*-makefile-*-
#
# Copyright (C) 2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON) += host-system-python
HOST_SYSTEM_PYTHON_LICENSE := ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-system-python.prepare:
	@$(call targetinfo)
	@echo "Checking for Python ..."
	@python -V >/dev/null 2>&1 || \
		ptxd_bailout "'python' not found! Please install.";
ifdef PTXCONF_HOST_SYSTEM_PYTHON_XML2
	@echo "Checking for Python libxml2 bindings ..."
	@python -c 'import libxml2' 2>/dev/null || \
		ptxd_bailout "Python libxml2 module not found! \
	Please install python-libxml2 (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON_ARGPARSE
	@echo "Checking for Python argparse ..."
	@python -c 'import argparse' 2>/dev/null || \
		ptxd_bailout "Python argparse module not found! \
	Please install python-argparse (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON_BZ2
	@echo "Checking for Python bz2 ..."
	@python -c 'import bz2' 2>/dev/null || \
		ptxd_bailout "Python bz2 module not found! \
	Please install python-bz2";
endif
	@echo
	@$(call touch)

# vim: syntax=make
