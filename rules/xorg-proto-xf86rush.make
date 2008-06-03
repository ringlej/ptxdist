# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_PROTO_XF86RUSH) += xorg-proto-xf86rush

#
# Paths and names
#
XORG_PROTO_XF86RUSH_VERSION	:= 1.1.2
XORG_PROTO_XF86RUSH		:= xf86rushproto-$(XORG_PROTO_XF86RUSH_VERSION)
XORG_PROTO_XF86RUSH_SUFFIX	:= tar.bz2
XORG_PROTO_XF86RUSH_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/proto/$(XORG_PROTO_XF86RUSH).$(XORG_PROTO_XF86RUSH_SUFFIX)
XORG_PROTO_XF86RUSH_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86RUSH).$(XORG_PROTO_XF86RUSH_SUFFIX)
XORG_PROTO_XF86RUSH_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86RUSH)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xf86rush_get: $(STATEDIR)/xorg-proto-xf86rush.get

$(STATEDIR)/xorg-proto-xf86rush.get: $(xorg-proto-xf86rush_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XF86RUSH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_XF86RUSH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xf86rush_extract: $(STATEDIR)/xorg-proto-xf86rush.extract

$(STATEDIR)/xorg-proto-xf86rush.extract: $(xorg-proto-xf86rush_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86RUSH_DIR))
	@$(call extract, XORG_PROTO_XF86RUSH)
	@$(call patchin, XORG_PROTO_XF86RUSH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xf86rush_prepare: $(STATEDIR)/xorg-proto-xf86rush.prepare

XORG_PROTO_XF86RUSH_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XF86RUSH_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86RUSH_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xf86rush.prepare: $(xorg-proto-xf86rush_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86RUSH_DIR)/config.cache)
	cd $(XORG_PROTO_XF86RUSH_DIR) && \
		$(XORG_PROTO_XF86RUSH_PATH) $(XORG_PROTO_XF86RUSH_ENV) \
		./configure $(XORG_PROTO_XF86RUSH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xf86rush_compile: $(STATEDIR)/xorg-proto-xf86rush.compile

$(STATEDIR)/xorg-proto-xf86rush.compile: $(xorg-proto-xf86rush_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XF86RUSH_DIR) && $(XORG_PROTO_XF86RUSH_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xf86rush_install: $(STATEDIR)/xorg-proto-xf86rush.install

$(STATEDIR)/xorg-proto-xf86rush.install: $(xorg-proto-xf86rush_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XF86RUSH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xf86rush_targetinstall: $(STATEDIR)/xorg-proto-xf86rush.targetinstall

$(STATEDIR)/xorg-proto-xf86rush.targetinstall: $(xorg-proto-xf86rush_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xf86rush_clean:
	rm -rf $(STATEDIR)/xorg-proto-xf86rush.*
	rm -rf $(PKGDIR)/xorg-proto-xf86rush_*
	rm -rf $(XORG_PROTO_XF86RUSH_DIR)

# vim: syntax=make

