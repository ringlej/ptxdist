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

#
# provide the .config file for kconfig
#
world/kconfig-setup = \
	$(call world/env, $(1)) \
	ptx_config_mode=$(strip $(2)) \
	ptxd_make_world_kconfig_setup

#
# update the package config file from .config
#
world/kconfig-sync = \
	$(call world/env, $(1)) \
	ptxd_make_world_kconfig_sync

# vim: syntax=make
