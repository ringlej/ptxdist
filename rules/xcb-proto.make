# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
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
XCB_PROTO_VERSION		:= 1.0
XCB_PROTO			:= xcb-proto-$(XCB_PROTO_VERSION)
XCB_PROTO_SUFFIX		:= tar.bz2
XCB_PROTO_URL		:= http://xcb.freedesktop.org/dist/$(XCB_PROTO).$(XCB_PROTO_SUFFIX)
XCB_PROTO_SOURCE		:= $(SRCDIR)/$(XCB_PROTO).$(XCB_PROTO_SUFFIX)
XCB_PROTO_DIR		:= $(BUILDDIR)/$(XCB_PROTO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xcb-proto_get: $(STATEDIR)/xcb-proto.get

$(STATEDIR)/xcb-proto.get: $(xcb-proto_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XCB_PROTO_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XCB_PROTO)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xcb-proto_extract: $(STATEDIR)/xcb-proto.extract

$(STATEDIR)/xcb-proto.extract: $(xcb-proto_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XCB_PROTO_DIR))
	@$(call extract, XCB_PROTO)
	@$(call patchin, XCB_PROTO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xcb-proto_prepare: $(STATEDIR)/xcb-proto.prepare

XCB_PROTO_PATH	:= PATH=$(CROSS_PATH)
XCB_PROTO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XCB_PROTO_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xcb-proto.prepare: $(xcb-proto_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XCB_PROTO_DIR)/config.cache)
	cd $(XCB_PROTO_DIR) && \
		$(XCB_PROTO_PATH) $(XCB_PROTO_ENV) \
		./configure $(XCB_PROTO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xcb-proto_compile: $(STATEDIR)/xcb-proto.compile

$(STATEDIR)/xcb-proto.compile: $(xcb-proto_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XCB_PROTO_DIR) && $(XCB_PROTO_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xcb-proto_install: $(STATEDIR)/xcb-proto.install

$(STATEDIR)/xcb-proto.install: $(xcb-proto_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XCB_PROTO)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xcb-proto_targetinstall: $(STATEDIR)/xcb-proto.targetinstall

$(STATEDIR)/xcb-proto.targetinstall: $(xcb-proto_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xcb-proto)
	@$(call install_fixup, xcb-proto,PACKAGE,xcb-proto)
	@$(call install_fixup, xcb-proto,PRIORITY,optional)
	@$(call install_fixup, xcb-proto,VERSION,$(XCB_PROTO_VERSION))
	@$(call install_fixup, xcb-proto,SECTION,base)
	@$(call install_fixup, xcb-proto,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xcb-proto,DEPENDS,)
	@$(call install_fixup, xcb-proto,DESCRIPTION,missing)

	@$(call install_finish, xcb-proto)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xcb-proto_clean:
	rm -rf $(STATEDIR)/xcb-proto.*
	rm -rf $(IMAGEDIR)/xcb-proto_*
	rm -rf $(XCB_PROTO_DIR)

# vim: syntax=make
