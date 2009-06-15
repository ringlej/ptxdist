# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(STATEDIR)/%.prepare:
	@$(call targetinfo)
	@$(call world/prepare, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

#
# prepare for target autoconf and cmake packages
#
world/prepare = \
	$(call world/env, $1) \
	ptxd_make_world_prepare

# vim: syntax=make
