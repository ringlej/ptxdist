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
PACKAGES-$(PTXCONF_XORG_PROTO_EVIEEXT) += xorg-proto-evieext

#
# Paths and names
#
XORG_PROTO_EVIEEXT_VERSION	:= 1.1.0
XORG_PROTO_EVIEEXT_MD5		:= 5c74f61d6f77b2e6a083b2b31000be42
XORG_PROTO_EVIEEXT		:= evieext-$(XORG_PROTO_EVIEEXT_VERSION)
XORG_PROTO_EVIEEXT_SUFFIX	:= tar.bz2
XORG_PROTO_EVIEEXT_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_EVIEEXT).$(XORG_PROTO_EVIEEXT_SUFFIX)
XORG_PROTO_EVIEEXT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_EVIEEXT).$(XORG_PROTO_EVIEEXT_SUFFIX)
XORG_PROTO_EVIEEXT_DIR		:= $(BUILDDIR)/$(XORG_PROTO_EVIEEXT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_EVIEEXT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_EVIEEXT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_EVIEEXT_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_EVIEEXT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_EVIEEXT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-evieext.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

