# -*-makefile-*-
#
# Copyright (C) 2016 by Steffen Trumtrar <s.trumtrar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBP11) += host-libp11

#
# Paths and names
#
HOST_LIBP11_VERSION	:= 0.4.0
HOST_LIBP11_MD5		:= 00b3e41db5be840d822bda12f3ab2ca7
HOST_LIBP11		:= libp11-$(HOST_LIBP11_VERSION)
HOST_LIBP11_SUFFIX	:= tar.gz
HOST_LIBP11_URL		:= https://github.com/OpenSC/libp11/releases/download/$(HOST_LIBP11)/$(HOST_LIBP11).$(HOST_LIBP11_SUFFIX)
HOST_LIBP11_SOURCE	:= $(SRCDIR)/$(HOST_LIBP11).$(HOST_LIBP11_SUFFIX)
HOST_LIBP11_DIR		:= $(HOST_BUILDDIR)/$(HOST_LIBP11)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_LIBP11_CONF_TOOL	:= autoconf
HOST_LIBP11_MAKE_PAR	:= NO

# vim: syntax=make
