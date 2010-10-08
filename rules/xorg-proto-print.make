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
XORG_PROTO_PRINT_VERSION:= 1.0.4
XORG_PROTO_PRINT_MD5	:= 7321847a60748b4d2f1fa16db4b6ede8
XORG_PROTO_PRINT	:= printproto-$(XORG_PROTO_PRINT_VERSION)
XORG_PROTO_PRINT_SUFFIX	:= tar.bz2
XORG_PROTO_PRINT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_PRINT).$(XORG_PROTO_PRINT_SUFFIX)
XORG_PROTO_PRINT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_PRINT).$(XORG_PROTO_PRINT_SUFFIX)
XORG_PROTO_PRINT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_PRINT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_PRINT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_PRINT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_PRINT_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_PRINT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_PRINT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-print.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

