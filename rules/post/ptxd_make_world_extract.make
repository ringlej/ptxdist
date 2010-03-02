# -*-makefile-*-
#
# Copyright (C) 2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

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
	@$(call extract, $(PTX_MAP_TO_PACKAGE_klibc-$(*)), $(INITRAMFS_BUILDDIR))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_klibc-$(*)), $($(PTX_MAP_TO_PACKAGE_klibc-$(*))_DIR))
	@$(call touch)


### --- for INITRAMFS packages only ---

$(STATEDIR)/initramfs-%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_initramfs-$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_initramfs-$(*)), $(INITRAMFS_BUILDDIR))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_initramfs-$(*)), $($(PTX_MAP_TO_PACKAGE_initramfs-$(*))_DIR))
	@$(call touch)


### --- for TARGET packages only ---

$(STATEDIR)/%.extract:
	@$(call targetinfo)
	@$(call clean, $($(PTX_MAP_TO_PACKAGE_$(*))_DIR))
	@$(call extract, $(PTX_MAP_TO_PACKAGE_$(*)))
	@$(call patchin, $(PTX_MAP_TO_PACKAGE_$(*)), $($(PTX_MAP_TO_PACKAGE_$(*))_DIR))
	@$(call touch)

# vim: syntax=make
