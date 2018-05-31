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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON) += host-system-python
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
ifdef PTXCONF_HOST_SYSTEM_PYTHON_MAKO
	@echo "Checking for Python Mako ..."
	@python -c 'import mako' 2>/dev/null || \
		ptxd_bailout "Python mako module not found! \
	Please install python-mako (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON_SIX
	@echo "Checking for Python Six ..."
	@python -c 'import six' 2>/dev/null || \
		ptxd_bailout "Python six module not found! \
	Please install python-six (debian)";
endif
ifdef PTXCONF_HOST_SYSTEM_PYTHON_NUMPY
	@echo "Checking for Python Numpy ..."
	@python -c 'import numpy' 2>/dev/null || \
		ptxd_bailout "Python numpy module not found! \
	Please install python-numpy (debian)";
endif
	@echo
	@$(call touch)

# vim: syntax=make
