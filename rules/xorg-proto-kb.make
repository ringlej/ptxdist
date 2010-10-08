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
PACKAGES-$(PTXCONF_XORG_PROTO_KB) += xorg-proto-kb

#
# Paths and names
#
XORG_PROTO_KB_VERSION 	:= 1.0.5
XORG_PROTO_KB_MD5	:= e7edb59a3f54af15f749e8f3e314ee62
XORG_PROTO_KB		:= kbproto-$(XORG_PROTO_KB_VERSION)
XORG_PROTO_KB_SUFFIX	:= tar.bz2
XORG_PROTO_KB_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_KB).$(XORG_PROTO_KB_SUFFIX)
XORG_PROTO_KB_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_KB).$(XORG_PROTO_KB_SUFFIX)
XORG_PROTO_KB_DIR	:= $(BUILDDIR)/$(XORG_PROTO_KB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_KB_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_KB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_KB_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_KB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_KB_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-kb.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

