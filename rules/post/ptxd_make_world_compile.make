# -*-makefile-*-
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/compile = \
	$(call world/env, $(1)) \
	ptxd_make_world_compile

compile = \
	pkg_make_opt="$(2)" \
	$(call world/compile, $(1))

$(STATEDIR)/%.compile:
	@$(call targetinfo)
	@$(call world/compile, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

# vim: syntax=make:
