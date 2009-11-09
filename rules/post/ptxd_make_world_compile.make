# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

$(STATEDIR)/%.compile:
	@$(call targetinfo)
	@$(call world/compile, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

#
# compile for target cross and host packages
#
world/compile = \
	$(call world/env, $1) \
	ptxd_make_world_compile

compile = \
	$(call world/env, $(1)) \
	pkg_make_opt="$(2)" \
	ptxd_make_world_compile

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
