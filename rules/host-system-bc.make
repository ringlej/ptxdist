# -*-makefile-*-
#
# Copyright (C) 2017 by Markus Niebel <Markus Niebel@tq-group.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SYSTEM_BC) += host-system-bc
HOST_SYSTEM_BC_LICENSE := ignore

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-system-bc.prepare:
	@$(call targetinfo)
	@echo "Checking for bc ..."
	@bc --version >/dev/null 2>&1 || \
		ptxd_bailout "'bc' not found! Please install.";
	@$(call touch)

# vim: syntax=make
