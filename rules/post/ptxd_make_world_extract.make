# -*-makefile-*-
#
# Copyright (C) 2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# extract
#
# Extract a source archive into a directory. This stage is
# skipped if $1_URL points to a local directory instead of
# an archive or online URL.
#
# $1: Packet label; we extract $1_SOURCE
# $2: dir to extract into; if $2 is not given we extract to $(BUILDDIR)
#
extract = \
	$(call world/env, $(1)) \
	ptxd_make_extract \
		-d "$(strip $(2))"


### --- for CROSS packages only ---

$(STATEDIR)/cross-%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_cross-$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_cross-$(*)), $(CROSS_BUILDDIR))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_cross-$(*)), $($(PTX_MAP_TO_PACKAGE_cross-$(*))_DIR))
	@$(call touch)


### --- for HOST packages only ---

$(STATEDIR)/host-%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_host-$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_host-$(*)), $(HOST_BUILDDIR))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_host-$(*)), $($(PTX_MAP_TO_PACKAGE_host-$(*))_DIR))
	@$(call touch)


### --- for KLIBC packages only ---

$(STATEDIR)/klibc-%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_klibc-$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_klibc-$(*)), $(KLIBC_BUILDDIR))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_klibc-$(*)), $($(PTX_MAP_TO_PACKAGE_klibc-$(*))_DIR))
	@$(call touch)


### --- for TARGET packages only ---

$(STATEDIR)/%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_$(*)), $($(PTX_MAP_TO_PACKAGE_$(*))_DIR))
	@$(call touch)

# vim: syntax=make
