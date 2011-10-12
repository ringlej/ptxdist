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

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
# without this special prefix the xcb-proto.pc is broken
HOST_XCB_PROTO_AUTOCONF	:= --prefix=/.

# vim: syntax=make
