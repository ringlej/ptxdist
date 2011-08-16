# -*-makefile-*-
#
# Copyright (C) 2007 by 
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_BIGREQS) += host-xorg-proto-bigreqs

#
# Paths and names
#
HOST_XORG_PROTO_BIGREQS_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_BIGREQS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_PROTO_BIGREQS_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_BIGREQS_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_BIGREQS_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-specs

# vim: syntax=make
