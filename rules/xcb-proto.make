# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XCB_PROTO) += xcb-proto

#
# Paths and names
#
XCB_PROTO_VERSION	:= 1.6
XCB_PROTO		:= xcb-proto-$(XCB_PROTO_VERSION)
XCB_PROTO_SUFFIX	:= tar.bz2
XCB_PROTO_URL		:= http://xcb.freedesktop.org/dist/$(XCB_PROTO).$(XCB_PROTO_SUFFIX)
XCB_PROTO_SOURCE	:= $(SRCDIR)/$(XCB_PROTO).$(XCB_PROTO_SUFFIX)
XCB_PROTO_DIR		:= $(BUILDDIR)/$(XCB_PROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XCB_PROTO_SOURCE):
	@$(call targetinfo)
	@$(call get, XCB_PROTO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XCB_PROTO_PATH	:= PATH=$(CROSS_PATH)
XCB_PROTO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XCB_PROTO_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xcb-proto.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
