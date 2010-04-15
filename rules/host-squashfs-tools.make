# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle <jon@ringle.org>
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
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
HOST_SQUASHFS_TOOLS_DIR		= $(HOST_BUILDDIR)/$(SQUASHFS_TOOLS)
HOST_SQUASHFS_TOOLS_SUBDIR	:= squashfs-tools

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

HOST_SQUASHFS_TOOLS_MAKE_ENV := $(HOST_ENV)
HOST_SQUASHFS_TOOLS_MAKE_PAR := NO
HOST_SQUASHFS_TOOLS_INSTALL_OPT := install INSTALL_DIR="$(HOST_SQUASHFS_TOOLS_PKGDIR)/sbin"

# vim: syntax=make
