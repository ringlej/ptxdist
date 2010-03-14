# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/patchin = \
	$(call world/env, $(1)) \
	pkg_patch_series="$(call ptx/escape,$(call remove_quotes, $(PTXCONF_$(strip $(1))_SERIES)))" \
	ptxd_make_world_patchin

patchin = \
	pkg_deprecated_patchin_dir="$(call ptx/escape,$(2))" \
	pkg_deprecated_patchin_series="$(call ptx/escape,$(3))" \
	$(call world/patchin, $(1))

# vim: syntax=make
