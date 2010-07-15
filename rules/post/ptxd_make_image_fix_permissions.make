# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

### --- internal ---

PTX_FIXPERM_RUN    := $(STATEDIR)/fix-permissions.run

#
# only run if make goal is "world", i.e. don't run during images_world
#
ifeq ($(MAKECMDGOALS)-$(PTXCONF_FIX_PERMISSIONS)-$(PTXDIST_QUIET),world-y-)
world: $(PTX_FIXPERM_RUN)
endif

$(PTX_FIXPERM_RUN): $(PTX_PERMISSIONS) $(STATEDIR)/world.targetinstall
	@$(call image/env) \
	ptxd_make_image_fix_permissions -p "$<"

# vim: syntax=make
