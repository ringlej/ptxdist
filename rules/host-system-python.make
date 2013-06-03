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
	@echo
	@$(call touch)

# vim: syntax=make
