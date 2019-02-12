# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PHONY += ptx-package-info
ptx-package-info:

world/package-info = \
	$(call world/env, $(1)) \
	ptxd_make_world_package_info

$(STATEDIR)/%.package-info: ptx-package-info
	@$(call targetinfo)
	@$(call world/package-info, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call finish)

# vim: syntax=make
