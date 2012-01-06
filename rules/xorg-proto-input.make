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
PACKAGES-$(PTXCONF_XORG_PROTO_INPUT) += xorg-proto-input

#
# Paths and names
#
XORG_PROTO_INPUT_VERSION:= 2.0.1
XORG_PROTO_INPUT_MD5	:= da9bf9e5d174163f597d2d72757d9038
XORG_PROTO_INPUT	:= inputproto-$(XORG_PROTO_INPUT_VERSION)
XORG_PROTO_INPUT_SUFFIX	:= tar.bz2
XORG_PROTO_INPUT_URL	:= $(call ptx/mirror, XORG, individual/proto/$(XORG_PROTO_INPUT).$(XORG_PROTO_INPUT_SUFFIX))
XORG_PROTO_INPUT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_INPUT).$(XORG_PROTO_INPUT_SUFFIX)
XORG_PROTO_INPUT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_INPUT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_PROTO_INPUT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_PROTO_INPUT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_PROTO_INPUT_PATH	:= PATH=$(CROSS_PATH)
XORG_PROTO_INPUT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_INPUT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-proto-input.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make

