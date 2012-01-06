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
PACKAGES-$(PTXCONF_XORG_PROTO_BIGREQS) += xorg-proto-bigreqs

#
# Paths and names
#
XORG_PROTO_BIGREQS_VERSION	:= 1.1.1
XORG_PROTO_BIGREQS_MD5		:= 6f6c24436c2b3ab235eb14a85b9aaacf
XORG_PROTO_BIGREQS		:= bigreqsproto-$(XORG_PROTO_BIGREQS_VERSION)
XORG_PROTO_BIGREQS_SUFFIX	:= tar.bz2
XORG_PROTO_BIGREQS_URL		:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_BIGREQS).$(XORG_PROTO_BIGREQS_SUFFIX))
XORG_PROTO_BIGREQS_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_BIGREQS).$(XORG_PROTO_BIGREQS_SUFFIX)
XORG_PROTO_BIGREQS_DIR		:= $(BUILDDIR)/$(XORG_PROTO_BIGREQS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_BIGREQS_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_BIGREQS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_BIGREQS_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_BIGREQS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_BIGREQS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-specs

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-bigreqs.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

