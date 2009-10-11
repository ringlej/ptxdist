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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86MISC) += xorg-proto-xf86misc

#
# Paths and names
#
XORG_PROTO_XF86MISC_VERSION	:= 0.9.3
XORG_PROTO_XF86MISC		:= xf86miscproto-$(XORG_PROTO_XF86MISC_VERSION)
XORG_PROTO_XF86MISC_SUFFIX	:= tar.bz2
XORG_PROTO_XF86MISC_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XF86MISC).$(XORG_PROTO_XF86MISC_SUFFIX)
XORG_PROTO_XF86MISC_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86MISC).$(XORG_PROTO_XF86MISC_SUFFIX)
XORG_PROTO_XF86MISC_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XF86MISC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xf86misc_get: $(STATEDIR)/xorg-proto-xf86misc.get

$(STATEDIR)/xorg-proto-xf86misc.get: $(xorg-proto-xf86misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XF86MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_XF86MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xf86misc_extract: $(STATEDIR)/xorg-proto-xf86misc.extract

$(STATEDIR)/xorg-proto-xf86misc.extract: $(xorg-proto-xf86misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86MISC_DIR))
	@$(call extract, XORG_PROTO_XF86MISC)
	@$(call patchin, XORG_PROTO_XF86MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xf86misc_prepare: $(STATEDIR)/xorg-proto-xf86misc.prepare

XORG_PROTO_XF86MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XF86MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86MISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xf86misc.prepare: $(xorg-proto-xf86misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86MISC_DIR)/config.cache)
	cd $(XORG_PROTO_XF86MISC_DIR) && \
		$(XORG_PROTO_XF86MISC_PATH) $(XORG_PROTO_XF86MISC_ENV) \
		./configure $(XORG_PROTO_XF86MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xf86misc_compile: $(STATEDIR)/xorg-proto-xf86misc.compile

$(STATEDIR)/xorg-proto-xf86misc.compile: $(xorg-proto-xf86misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XF86MISC_DIR) && $(XORG_PROTO_XF86MISC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xf86misc_install: $(STATEDIR)/xorg-proto-xf86misc.install

$(STATEDIR)/xorg-proto-xf86misc.install: $(xorg-proto-xf86misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XF86MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xf86misc_targetinstall: $(STATEDIR)/xorg-proto-xf86misc.targetinstall

$(STATEDIR)/xorg-proto-xf86misc.targetinstall: $(xorg-proto-xf86misc_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xf86misc_clean:
	rm -rf $(STATEDIR)/xorg-proto-xf86misc.*
	rm -rf $(PKGDIR)/xorg-proto-xf86misc_*
	rm -rf $(XORG_PROTO_XF86MISC_DIR)

# vim: syntax=make

