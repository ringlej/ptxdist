# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# world/install
#
world/install = \
	$(call world/env, $(1)) \
	ptxd_make_world_install

#
# world/install.post
#
world/install.post = \
	$(call world/env, $1) \
	ptxd_make_world_install_post

#
# Perform standard install actions
#
# $1: label of the packet
# $2: optional: alternative directory
# $3: optional: "h" = install as a host tool
# $4: optional: args to pass to make install call
#
install = \
	pkg_deprecated_install_builddir="$(call ptx/escape, $(2))" \
	pkg_deprecated_install_hosttool="$(call ptx/escape, $(3))" \
	pkg_deprecated_install_opt="$(call ptx/escape, $(4))" \
	$(call world/install, $(1))

$(STATEDIR)/%.install:
	@$(call targetinfo)
	@$(call world/install, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

$(STATEDIR)/%.install.post:
	@$(call targetinfo)
	@$(call world/install.post, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

# vim: syntax=make
