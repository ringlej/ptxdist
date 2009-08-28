# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2009 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_PROTO_DMX) += xorg-proto-dmx

#
# Paths and names
#
XORG_PROTO_DMX_VERSION	:= 2.3
XORG_PROTO_DMX		:= dmxproto-$(XORG_PROTO_DMX_VERSION)
XORG_PROTO_DMX_SUFFIX	:= tar.bz2
XORG_PROTO_DMX_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_DMX).$(XORG_PROTO_DMX_SUFFIX)
XORG_PROTO_DMX_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_DMX).$(XORG_PROTO_DMX_SUFFIX)
XORG_PROTO_DMX_DIR	:= $(BUILDDIR)/$(XORG_PROTO_DMX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-dmx_get: $(STATEDIR)/xorg-proto-dmx.get

$(STATEDIR)/xorg-proto-dmx.get: $(xorg-proto-dmx_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_DMX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_DMX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-dmx_extract: $(STATEDIR)/xorg-proto-dmx.extract

$(STATEDIR)/xorg-proto-dmx.extract: $(xorg-proto-dmx_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_DMX_DIR))
	@$(call extract, XORG_PROTO_DMX)
	@$(call patchin, XORG_PROTO_DMX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-dmx_prepare: $(STATEDIR)/xorg-proto-dmx.prepare

XORG_PROTO_DMX_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_DMX_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_DMX_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-dmx.prepare: $(xorg-proto-dmx_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_DMX_DIR)/config.cache)
	cd $(XORG_PROTO_DMX_DIR) && \
		$(XORG_PROTO_DMX_PATH) $(XORG_PROTO_DMX_ENV) \
		./configure $(XORG_PROTO_DMX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-dmx_compile: $(STATEDIR)/xorg-proto-dmx.compile

$(STATEDIR)/xorg-proto-dmx.compile: $(xorg-proto-dmx_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_DMX_DIR) && $(XORG_PROTO_DMX_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-dmx_install: $(STATEDIR)/xorg-proto-dmx.install

$(STATEDIR)/xorg-proto-dmx.install: $(xorg-proto-dmx_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_DMX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-dmx_targetinstall: $(STATEDIR)/xorg-proto-dmx.targetinstall

$(STATEDIR)/xorg-proto-dmx.targetinstall: $(xorg-proto-dmx_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-dmx_clean:
	rm -rf $(STATEDIR)/xorg-proto-dmx.*
	rm -rf $(PKGDIR)/xorg-proto-dmx_*
	rm -rf $(XORG_PROTO_DMX_DIR)

# vim: syntax=make

