# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by George McCollister <george.mccollister@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# $1: xpkg label
# $2: PKG, uppercase pkg name
#
xpkg/env/impl = \
	$(call world/env, $(2))							\
	CROSS_STRIP="$(call ptx/escape,$(CROSS_STRIP))"				\
	pkg_xpkg="$(call ptx/escape,$(1))"					\
	pkg_ipkg_extra_args=$(PTXCONF_IMAGE_IPKG_EXTRA_ARGS)			\
	pkg_opkg_extra_args=$(PTXCONF_IMAGE_OPKG_EXTRA_ARGS)			\
	pkg_xpkg_type=$(PTXCONF_HOST_PACKAGE_MANAGEMENT)

#
# $1: xpkg label
#
xpkg/env = \
	$(call xpkg/env/impl, $(strip $(1)), $(PTX_MAP_TO_PACKAGE_$(notdir $(basename $(basename $(@))))))

# vim: syntax=make
