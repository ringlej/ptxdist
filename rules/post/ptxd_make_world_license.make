# -*-makefile-*-
#
# Copyright (C) 2011-2013 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# world/license
#
world/license = \
	$(call world/env, $(1)) \
	ptxd_make_world_license

$(STATEDIR)/%.report:
	@$(call targetinfo)
	@$(call world/license, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

# vim: syntax=make
