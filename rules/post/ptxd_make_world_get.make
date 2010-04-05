# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(STATEDIR)/%.get:
	@$(call targetinfo)
	@$(call world/get, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

world/get = \
	$(call world/env, $(1)) \
	ptxd_make_world_get

# vim: syntax=make
