# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(STATEDIR)/%.tags: FORCE
	@$(call targetinfo)
	@$(call world/tags, $(PTX_MAP_TO_PACKAGE_$(*)))

#
# tags for target, cross and host packages
#
world/tags = \
	$(call world/env, $1) \
	ptxd_make_world_tags

# vim: syntax=make
