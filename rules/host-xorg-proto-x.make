# -*-makefile-*-
#
# Copyright (C) 2006 by 
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_X) += host-xorg-proto-x

#
# Paths and names
#
HOST_XORG_PROTO_X_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_X)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-proto-x.get: $(STATEDIR)/xorg-proto-x.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_PROTO_X_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_X_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_X_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-x_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-x.*
	rm -rf $(HOST_XORG_PROTO_X_DIR)

# vim: syntax=make
