# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# run kconfig for the package
#
world/kconfig = \
	$(call world/env, $(1)) \
	ptx_config_target=$(strip $(2)) \
	ptxd_make_world_kconfig

# vim: syntax=make
