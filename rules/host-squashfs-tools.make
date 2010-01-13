# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle <jon@ringle.org>
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SQUASHFS_TOOLS) += host-squashfs-tools

#
# Paths and names
#
HOST_SQUASHFS_TOOLS_VERSION	:= $(call ptx/ifdef, PTXCONF_HOST_SQUASHFS_TOOLS_V3X, 3.4, 4.0)
HOST_SQUASHFS_TOOLS		:= squashfs$(HOST_SQUASHFS_TOOLS_VERSION)
HOST_SQUASHFS_TOOLS_SUFFIX	:= tar.gz
HOST_SQUASHFS_TOOLS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/squashfs/$(HOST_SQUASHFS_TOOLS).$(HOST_SQUASHFS_TOOLS_SUFFIX)
HOST_SQUASHFS_TOOLS_SOURCE	:= $(SRCDIR)/$(HOST_SQUASHFS_TOOLS).$(HOST_SQUASHFS_TOOLS_SUFFIX)
HOST_SQUASHFS_TOOLS_DIR		:= $(HOST_BUILDDIR)/$(HOST_SQUASHFS_TOOLS)/squashfs-tools

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_SQUASHFS_TOOLS_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_SQUASHFS_TOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_SQUASHFS_TOOLS_COMPILE_ENV := \
	$(HOST_ENV)

HOST_SQUASHFS_TOOLS_MAKEVARS	:= \
	INSTALL_DIR="$(PTXCONF_SYSROOT_HOST)/sbin"

$(STATEDIR)/host-squashfs-tools.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-squashfs-tools.compile:
	@$(call targetinfo)
	cd $(HOST_SQUASHFS_TOOLS_DIR) && \
		$(HOST_SQUASHFS_TOOLS_PATH) \
		$(HOST_SQUASHFS_TOOLS_COMPILE_ENV) \
		$(MAKE) $(HOST_SQUASHFS_TOOLS_MAKEVARS) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# vim: syntax=make
