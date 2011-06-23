# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# generate for all packages:
# $(<PKG>_SOURCE) := <PKG>
#
define pkg_source
$(if $($(1)_SOURCE),$(eval $($(1)_SOURCE) := $(1)),)
endef
$(foreach pkg, $(PTX_PACKAGES_SELECTED), $(call pkg_source,$(PTX_MAP_TO_PACKAGE_$(pkg))))

#
# generic source rule. It uses the variables defined above
# to find the package for the source archive.
#
$(SRCDIR)/%:
	@$(call targetinfo)
	@$(call get, $($@))


$(STATEDIR)/%.get:
	@$(call targetinfo)
	@$(call world/get, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call world/check_src, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call touch)

world/get = \
	$(call world/env, $(1)) \
	ptxd_make_world_get

world/check_src = \
	$(call world/env, $(1)) \
	ptxd_make_world_check_src

#
# get
#
# Download a package from a given URL. This macro has some magic
# to handle different URLs; as wget is not able to transfer
# file URLs this case is being handed over to cp.
#
# $1: Packet Label; this macro gets $1_URL
#
get = \
	PTXCONF_SETUP_NO_DOWNLOAD="$(PTXCONF_SETUP_NO_DOWNLOAD)" \
	ptxd_make_get "$($(strip $(1))_SOURCE)" "$($(strip $(1))_URL)"

check_src = \
	ptxd_make_check_src "$($(strip $(1))_SOURCE)" "$($(strip $(1))_MD5)"

# vim: syntax=make
