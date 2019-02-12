# -*-makefile-*-
#
# Copyright (C) 2012 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

ptx/collection = $(PACKAGES-y) $(filter $(foreach PKG,$(call ptx/force-shell, sed -n 's/^PTXCONF_\([^_][^=]*\)=y$$/\1/p' "$(strip $(1))"),$(PTX_MAP_TO_package_$(PKG))), $(PACKAGES-m))

# vim: syntax=make
