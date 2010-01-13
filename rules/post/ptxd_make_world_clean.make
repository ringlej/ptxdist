# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

%_clean: $(STATEDIR)/%.clean
	@# empty rule

$(STATEDIR)/%.clean: FORCE
	@$(call targetinfo)
	@$(call world/clean, $(PTX_MAP_TO_PACKAGE_$(*)))

#
# clean
#
world/clean = \
	$(call world/env, $1) \
	ptxd_make_world_clean

#
# clean_pkg
#
# remove all temporary files for the current package
#
clean_pkg = \
	$(call world/clean $(PTX_MAP_TO_PACKAGE_$(*)))

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
