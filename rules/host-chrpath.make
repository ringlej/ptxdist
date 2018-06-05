# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CHRPATH) += host-chrpath

#
# Paths and names
#
HOST_CHRPATH_VERSION	:= 0.16
HOST_CHRPATH_MD5	:= 2bf8d1d1ee345fc8a7915576f5649982
HOST_CHRPATH		:= chrpath-$(HOST_CHRPATH_VERSION)
HOST_CHRPATH_SUFFIX	:= tar.gz
HOST_CHRPATH_URL	:= https://alioth.debian.org/frs/download.php/file/3979/$(HOST_CHRPATH).$(HOST_CHRPATH_SUFFIX)
HOST_CHRPATH_SOURCE	:= $(SRCDIR)/$(HOST_CHRPATH).$(HOST_CHRPATH_SUFFIX)
HOST_CHRPATH_DIR	:= $(HOST_BUILDDIR)/$(HOST_CHRPATH)
HOST_CHRPATH_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CHRPATH_CONF_TOOL	:= autoconf

# vim: syntax=make
