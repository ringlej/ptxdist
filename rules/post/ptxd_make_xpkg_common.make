# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# $1: PKG, uppercase pkg name
# $2: xpkg label
#
xpkg/env/impl = \
	$(call world/env, $(1)) \
	pkg_xpkg="$(call ptx/escape,$(2))" \
	pkg_ipkg_extra_args=$(PTXCONF_IMAGE_IPKG_EXTRA_ARGS) \
	pkg_xpkg_type="ipkg"

#
# $1: xpkg label
#
xpkg/env = \
	$(call xpkg/env/impl, $(PTX_MAP_TO_PACKAGE_$(notdir $(basename $(basename $(@))))), $(strip $(1)))

# vim: syntax=make
