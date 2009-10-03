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
PACKAGES-$(PTXCONF_XORG_PROTO_FONTCACHE) += xorg-proto-fontcache

#
# Paths and names
#
XORG_PROTO_FONTCACHE_VERSION	:= 0.1.3
XORG_PROTO_FONTCACHE		:= fontcacheproto-$(XORG_PROTO_FONTCACHE_VERSION)
XORG_PROTO_FONTCACHE_SUFFIX	:= tar.bz2
XORG_PROTO_FONTCACHE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_FONTCACHE).$(XORG_PROTO_FONTCACHE_SUFFIX)
XORG_PROTO_FONTCACHE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_FONTCACHE).$(XORG_PROTO_FONTCACHE_SUFFIX)
XORG_PROTO_FONTCACHE_DIR	:= $(BUILDDIR)/$(XORG_PROTO_FONTCACHE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-fontcache_get: $(STATEDIR)/xorg-proto-fontcache.get

$(STATEDIR)/xorg-proto-fontcache.get: $(xorg-proto-fontcache_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_FONTCACHE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_FONTCACHE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-fontcache_extract: $(STATEDIR)/xorg-proto-fontcache.extract

$(STATEDIR)/xorg-proto-fontcache.extract: $(xorg-proto-fontcache_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_FONTCACHE_DIR))
	@$(call extract, XORG_PROTO_FONTCACHE)
	@$(call patchin, XORG_PROTO_FONTCACHE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-fontcache_prepare: $(STATEDIR)/xorg-proto-fontcache.prepare

XORG_PROTO_FONTCACHE_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_FONTCACHE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_FONTCACHE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-fontcache.prepare: $(xorg-proto-fontcache_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_FONTCACHE_DIR)/config.cache)
	cd $(XORG_PROTO_FONTCACHE_DIR) && \
		$(XORG_PROTO_FONTCACHE_PATH) $(XORG_PROTO_FONTCACHE_ENV) \
		./configure $(XORG_PROTO_FONTCACHE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-fontcache_compile: $(STATEDIR)/xorg-proto-fontcache.compile

$(STATEDIR)/xorg-proto-fontcache.compile: $(xorg-proto-fontcache_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_FONTCACHE_DIR) && $(XORG_PROTO_FONTCACHE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-fontcache_install: $(STATEDIR)/xorg-proto-fontcache.install

$(STATEDIR)/xorg-proto-fontcache.install: $(xorg-proto-fontcache_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_FONTCACHE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-fontcache_targetinstall: $(STATEDIR)/xorg-proto-fontcache.targetinstall

$(STATEDIR)/xorg-proto-fontcache.targetinstall: $(xorg-proto-fontcache_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-fontcache_clean:
	rm -rf $(STATEDIR)/xorg-proto-fontcache.*
	rm -rf $(PKGDIR)/xorg-proto-fontcache_*
	rm -rf $(XORG_PROTO_FONTCACHE_DIR)

# vim: syntax=make

