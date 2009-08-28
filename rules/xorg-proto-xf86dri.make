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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86DRI) += xorg-proto-xf86dri

#
# Paths and names
#
XORG_PROTO_XF86DRI_VERSION	:= 2.1.0
XORG_PROTO_XF86DRI		:= xf86driproto-$(XORG_PROTO_XF86DRI_VERSION)
XORG_PROTO_XF86DRI_SUFFIX	:= tar.bz2
XORG_PROTO_XF86DRI_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XF86DRI).$(XORG_PROTO_XF86DRI_SUFFIX)
XORG_PROTO_XF86DRI_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86DRI).$(XORG_PROTO_XF86DRI_SUFFIX)
XORG_PROTO_XF86DRI_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86DRI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_get: $(STATEDIR)/xorg-proto-xf86dri.get

$(STATEDIR)/xorg-proto-xf86dri.get: $(xorg-proto-xf86dri_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XF86DRI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_XF86DRI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_extract: $(STATEDIR)/xorg-proto-xf86dri.extract

$(STATEDIR)/xorg-proto-xf86dri.extract: $(xorg-proto-xf86dri_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86DRI_DIR))
	@$(call extract, XORG_PROTO_XF86DRI)
	@$(call patchin, XORG_PROTO_XF86DRI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_prepare: $(STATEDIR)/xorg-proto-xf86dri.prepare

XORG_PROTO_XF86DRI_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XF86DRI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86DRI_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xf86dri.prepare: $(xorg-proto-xf86dri_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86DRI_DIR)/config.cache)
	cd $(XORG_PROTO_XF86DRI_DIR) && \
		$(XORG_PROTO_XF86DRI_PATH) $(XORG_PROTO_XF86DRI_ENV) \
		./configure $(XORG_PROTO_XF86DRI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_compile: $(STATEDIR)/xorg-proto-xf86dri.compile

$(STATEDIR)/xorg-proto-xf86dri.compile: $(xorg-proto-xf86dri_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XF86DRI_DIR) && $(XORG_PROTO_XF86DRI_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_install: $(STATEDIR)/xorg-proto-xf86dri.install

$(STATEDIR)/xorg-proto-xf86dri.install: $(xorg-proto-xf86dri_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XF86DRI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_targetinstall: $(STATEDIR)/xorg-proto-xf86dri.targetinstall

$(STATEDIR)/xorg-proto-xf86dri.targetinstall: $(xorg-proto-xf86dri_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xf86dri_clean:
	rm -rf $(STATEDIR)/xorg-proto-xf86dri.*
	rm -rf $(PKGDIR)/xorg-proto-xf86dri_*
	rm -rf $(XORG_PROTO_XF86DRI_DIR)

# vim: syntax=make

