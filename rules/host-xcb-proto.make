# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_XCB_PROTO) += host-xcb-proto

#
# Paths and names
#
HOST_XCB_PROTO_DIR	= $(HOST_BUILDDIR)/$(XCB_PROTO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XCB_PROTO_PATH	:= PATH=$(HOST_PATH)
HOST_XCB_PROTO_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XCB_PROTO_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
