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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86VIDMODE) += xorg-proto-xf86vidmode

#
# Paths and names
#
XORG_PROTO_XF86VIDMODE_VERSION	:= 2.3
XORG_PROTO_XF86VIDMODE		:= xf86vidmodeproto-$(XORG_PROTO_XF86VIDMODE_VERSION)
XORG_PROTO_XF86VIDMODE_SUFFIX	:= tar.bz2
XORG_PROTO_XF86VIDMODE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XF86VIDMODE).$(XORG_PROTO_XF86VIDMODE_SUFFIX)
XORG_PROTO_XF86VIDMODE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86VIDMODE).$(XORG_PROTO_XF86VIDMODE_SUFFIX)
XORG_PROTO_XF86VIDMODE_DIR	:= $(BUILDDIR)/$(XORG_PROTO_XF86VIDMODE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xf86vidmode_get: $(STATEDIR)/xorg-proto-xf86vidmode.get

$(STATEDIR)/xorg-proto-xf86vidmode.get: $(xorg-proto-xf86vidmode_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XF86VIDMODE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_XF86VIDMODE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xf86vidmode_extract: $(STATEDIR)/xorg-proto-xf86vidmode.extract

$(STATEDIR)/xorg-proto-xf86vidmode.extract: $(xorg-proto-xf86vidmode_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86VIDMODE_DIR))
	@$(call extract, XORG_PROTO_XF86VIDMODE)
	@$(call patchin, XORG_PROTO_XF86VIDMODE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xf86vidmode_prepare: $(STATEDIR)/xorg-proto-xf86vidmode.prepare

XORG_PROTO_XF86VIDMODE_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XF86VIDMODE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86VIDMODE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xf86vidmode.prepare: $(xorg-proto-xf86vidmode_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86VIDMODE_DIR)/config.cache)
	cd $(XORG_PROTO_XF86VIDMODE_DIR) && \
		$(XORG_PROTO_XF86VIDMODE_PATH) $(XORG_PROTO_XF86VIDMODE_ENV) \
		./configure $(XORG_PROTO_XF86VIDMODE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xf86vidmode_compile: $(STATEDIR)/xorg-proto-xf86vidmode.compile

$(STATEDIR)/xorg-proto-xf86vidmode.compile: $(xorg-proto-xf86vidmode_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XF86VIDMODE_DIR) && $(XORG_PROTO_XF86VIDMODE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xf86vidmode_install: $(STATEDIR)/xorg-proto-xf86vidmode.install

$(STATEDIR)/xorg-proto-xf86vidmode.install: $(xorg-proto-xf86vidmode_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XF86VIDMODE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xf86vidmode_targetinstall: $(STATEDIR)/xorg-proto-xf86vidmode.targetinstall

$(STATEDIR)/xorg-proto-xf86vidmode.targetinstall: $(xorg-proto-xf86vidmode_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xf86vidmode_clean:
	rm -rf $(STATEDIR)/xorg-proto-xf86vidmode.*
	rm -rf $(PKGDIR)/xorg-proto-xf86vidmode_*
	rm -rf $(XORG_PROTO_XF86VIDMODE_DIR)

# vim: syntax=make

