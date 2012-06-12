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
XCB_PROTO_VERSION	:= 1.7.1
XCB_PROTO_MD5		:= 948fec39dd42f3694edd5d9689735ec4
XCB_PROTO		:= xcb-proto-$(XCB_PROTO_VERSION)
XCB_PROTO_SUFFIX	:= tar.bz2
XCB_PROTO_URL		:= http://xcb.freedesktop.org/dist/$(XCB_PROTO).$(XCB_PROTO_SUFFIX)
XCB_PROTO_SOURCE	:= $(SRCDIR)/$(XCB_PROTO).$(XCB_PROTO_SUFFIX)
XCB_PROTO_DIR		:= $(BUILDDIR)/$(XCB_PROTO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XCB_PROTO_CONF_TOOL := autoconf

# vim: syntax=make
