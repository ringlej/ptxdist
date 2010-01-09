# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_XCMISC) += host-xorg-proto-xcmisc

#
# Paths and names
#
HOST_XORG_PROTO_XCMISC_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_XCMISC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-proto-xcmisc.get: $(STATEDIR)/xorg-proto-xcmisc.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_PROTO_XCMISC_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_XCMISC_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_XCMISC_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-xcmisc_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-xcmisc.*
	rm -rf $(HOST_XORG_PROTO_XCMISC_DIR)

# vim: syntax=make
