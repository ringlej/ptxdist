# -*-makefile-*-
# $Id: template-make 8008 2008-04-15 07:39:46Z mkl $
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
XCB_PROTO_VERSION	:= 1.5
XCB_PROTO		:= xcb-proto-$(XCB_PROTO_VERSION)
XCB_PROTO_SUFFIX	:= tar.bz2
XCB_PROTO_URL		:= http://xcb.freedesktop.org/dist/$(XCB_PROTO).$(XCB_PROTO_SUFFIX)
XCB_PROTO_SOURCE	:= $(SRCDIR)/$(XCB_PROTO).$(XCB_PROTO_SUFFIX)
XCB_PROTO_DIR		:= $(BUILDDIR)/$(XCB_PROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/xcb-proto.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XCB_PROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XCB_PROTO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/xcb-proto.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(XCB_PROTO_DIR))
	@$(call extract, XCB_PROTO)
	@$(call patchin, XCB_PROTO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XCB_PROTO_PATH	:= PATH=$(CROSS_PATH)
XCB_PROTO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XCB_PROTO_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xcb-proto.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(XCB_PROTO_DIR)/config.cache)
	cd $(XCB_PROTO_DIR) && \
		$(XCB_PROTO_PATH) $(XCB_PROTO_ENV) \
		./configure $(XCB_PROTO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xcb-proto.compile:
	@$(call targetinfo, $@)
	cd $(XCB_PROTO_DIR) && $(XCB_PROTO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xcb-proto.install:
	@$(call targetinfo, $@)
	@$(call install, XCB_PROTO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xcb-proto.targetinstall:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xcb-proto_clean:
	rm -rf $(STATEDIR)/xcb-proto.*
	rm -rf $(PKGDIR)/xcb-proto_*
	rm -rf $(XCB_PROTO_DIR)

# vim: syntax=make
