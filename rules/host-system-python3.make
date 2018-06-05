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
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_PYTHON3) += host-system-python3
HOST_SYSTEM_PYTHON3_LICENSE := ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSTEMPYTHON3 := $(shell PATH=$(HOST_PATH) type -P python3 || echo python3)

$(STATEDIR)/host-system-python3.prepare:
	@$(call targetinfo)
	@echo "Checking for Python 3 ..."
	@$(SYSTEMPYTHON3) -V >/dev/null 2>&1 || \
		ptxd_bailout "'python3' not found! Please install.";
	@echo
	@$(call touch)

# vim: syntax=make
