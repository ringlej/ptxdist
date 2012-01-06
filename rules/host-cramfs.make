# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CRAMFS) += host-cramfs

#
# Paths and names
#
HOST_CRAMFS_VERSION	:= 1.1
HOST_CRAMFS_MD5		:= d3912b9f7bf745fbfea68f6a9b9de30f
HOST_CRAMFS		:= cramfs-$(HOST_CRAMFS_VERSION)
HOST_CRAMFS_SUFFIX	:= tar.gz
HOST_CRAMFS_URL		:= $(call ptx/mirror, SF, cramfs/$(HOST_CRAMFS).$(HOST_CRAMFS_SUFFIX))
HOST_CRAMFS_SOURCE	:= $(SRCDIR)/$(HOST_CRAMFS).$(HOST_CRAMFS_SUFFIX)
HOST_CRAMFS_DIR		:= $(HOST_BUILDDIR)/$(HOST_CRAMFS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_CRAMFS_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_CRAMFS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CRAMFS_PATH	:= PATH=$(HOST_PATH)
HOST_CRAMFS_MAKE_ENV	:= $(HOST_ENV)
HOST_CRAMFS_MAKE_OPT	:= CPPFLAGS="-I. $(HOST_CPPFLAGS)"

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-cramfs.install:
	@$(call targetinfo)
	cp $(HOST_CRAMFS_DIR)/mkcramfs $(PTXCONF_SYSROOT_HOST)/bin
	cp $(HOST_CRAMFS_DIR)/cramfsck $(PTXCONF_SYSROOT_HOST)/bin
	@$(call touch)

# vim: syntax=make
