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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86DGA) += xorg-proto-xf86dga

#
# Paths and names
#
XORG_PROTO_XF86DGA_VERSION	:= 2.1
XORG_PROTO_XF86DGA		:= xf86dgaproto-$(XORG_PROTO_XF86DGA_VERSION)
XORG_PROTO_XF86DGA_SUFFIX	:= tar.bz2
XORG_PROTO_XF86DGA_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XF86DGA).$(XORG_PROTO_XF86DGA_SUFFIX)
XORG_PROTO_XF86DGA_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86DGA).$(XORG_PROTO_XF86DGA_SUFFIX)
XORG_PROTO_XF86DGA_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86DGA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xf86dga_get: $(STATEDIR)/xorg-proto-xf86dga.get

$(STATEDIR)/xorg-proto-xf86dga.get: $(xorg-proto-xf86dga_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XF86DGA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_XF86DGA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xf86dga_extract: $(STATEDIR)/xorg-proto-xf86dga.extract

$(STATEDIR)/xorg-proto-xf86dga.extract: $(xorg-proto-xf86dga_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86DGA_DIR))
	@$(call extract, XORG_PROTO_XF86DGA)
	@$(call patchin, XORG_PROTO_XF86DGA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xf86dga_prepare: $(STATEDIR)/xorg-proto-xf86dga.prepare

XORG_PROTO_XF86DGA_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XF86DGA_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86DGA_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xf86dga.prepare: $(xorg-proto-xf86dga_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86DGA_DIR)/config.cache)
	cd $(XORG_PROTO_XF86DGA_DIR) && \
		$(XORG_PROTO_XF86DGA_PATH) $(XORG_PROTO_XF86DGA_ENV) \
		./configure $(XORG_PROTO_XF86DGA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xf86dga_compile: $(STATEDIR)/xorg-proto-xf86dga.compile

$(STATEDIR)/xorg-proto-xf86dga.compile: $(xorg-proto-xf86dga_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XF86DGA_DIR) && $(XORG_PROTO_XF86DGA_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xf86dga_install: $(STATEDIR)/xorg-proto-xf86dga.install

$(STATEDIR)/xorg-proto-xf86dga.install: $(xorg-proto-xf86dga_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XF86DGA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xf86dga_targetinstall: $(STATEDIR)/xorg-proto-xf86dga.targetinstall

$(STATEDIR)/xorg-proto-xf86dga.targetinstall: $(xorg-proto-xf86dga_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xf86dga_clean:
	rm -rf $(STATEDIR)/xorg-proto-xf86dga.*
	rm -rf $(PKGDIR)/xorg-proto-xf86dga_*
	rm -rf $(XORG_PROTO_XF86DGA_DIR)

# vim: syntax=make

