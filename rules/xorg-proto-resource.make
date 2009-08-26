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
PACKAGES-$(PTXCONF_XORG_PROTO_RESOURCE) += xorg-proto-resource

#
# Paths and names
#
XORG_PROTO_RESOURCE_VERSION	:= 1.1.0
XORG_PROTO_RESOURCE		:= resourceproto-$(XORG_PROTO_RESOURCE_VERSION)
XORG_PROTO_RESOURCE_SUFFIX	:= tar.bz2
XORG_PROTO_RESOURCE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_RESOURCE).$(XORG_PROTO_RESOURCE_SUFFIX)
XORG_PROTO_RESOURCE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RESOURCE).$(XORG_PROTO_RESOURCE_SUFFIX)
XORG_PROTO_RESOURCE_DIR		:= $(BUILDDIR)/$(XORG_PROTO_RESOURCE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-resource_get: $(STATEDIR)/xorg-proto-resource.get

$(STATEDIR)/xorg-proto-resource.get: $(xorg-proto-resource_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_RESOURCE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_RESOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-resource_extract: $(STATEDIR)/xorg-proto-resource.extract

$(STATEDIR)/xorg-proto-resource.extract: $(xorg-proto-resource_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_RESOURCE_DIR))
	@$(call extract, XORG_PROTO_RESOURCE)
	@$(call patchin, XORG_PROTO_RESOURCE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-resource_prepare: $(STATEDIR)/xorg-proto-resource.prepare

XORG_PROTO_RESOURCE_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_RESOURCE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_RESOURCE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-resource.prepare: $(xorg-proto-resource_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_RESOURCE_DIR)/config.cache)
	cd $(XORG_PROTO_RESOURCE_DIR) && \
		$(XORG_PROTO_RESOURCE_PATH) $(XORG_PROTO_RESOURCE_ENV) \
		./configure $(XORG_PROTO_RESOURCE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-resource_compile: $(STATEDIR)/xorg-proto-resource.compile

$(STATEDIR)/xorg-proto-resource.compile: $(xorg-proto-resource_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_RESOURCE_DIR) && $(XORG_PROTO_RESOURCE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-resource_install: $(STATEDIR)/xorg-proto-resource.install

$(STATEDIR)/xorg-proto-resource.install: $(xorg-proto-resource_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_RESOURCE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-resource_targetinstall: $(STATEDIR)/xorg-proto-resource.targetinstall

$(STATEDIR)/xorg-proto-resource.targetinstall: $(xorg-proto-resource_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-resource_clean:
	rm -rf $(STATEDIR)/xorg-proto-resource.*
	rm -rf $(PKGDIR)/xorg-proto-resource_*
	rm -rf $(XORG_PROTO_RESOURCE_DIR)

# vim: syntax=make

