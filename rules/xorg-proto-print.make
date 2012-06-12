# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2009 by Robert Schwebel
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
PACKAGES-$(PTXCONF_XORG_PROTO_PRINT) += xorg-proto-print

#
# Paths and names
#
XORG_PROTO_PRINT_VERSION:= 1.0.5
XORG_PROTO_PRINT_MD5	:= 99d0e25feea2fead7d8325b7000b41c3
XORG_PROTO_PRINT	:= printproto-$(XORG_PROTO_PRINT_VERSION)
XORG_PROTO_PRINT_SUFFIX	:= tar.bz2
XORG_PROTO_PRINT_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_PRINT).$(XORG_PROTO_PRINT_SUFFIX))
XORG_PROTO_PRINT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_PRINT).$(XORG_PROTO_PRINT_SUFFIX)
XORG_PROTO_PRINT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_PRINT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_PROTO_PRINT_CONF_TOOL := autoconf

# vim: syntax=make

