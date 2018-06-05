# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RTPS) += rtps

RTPS_VERSION	:= 1.0
RTPS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rtps.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rtps)
	@$(call install_fixup, rtps,PRIORITY,optional)
	@$(call install_fixup, rtps,SECTION,base)
	@$(call install_fixup, rtps,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, rtps,DESCRIPTION,missing)

	@$(call install_alternative, rtps, 0, 0, 0755, /usr/bin/rtps)

	@$(call install_finish, rtps)

	@$(call touch)

# vim: syntax=make
