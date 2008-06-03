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
PACKAGES-$(PTXCONF_XORG_PROTO_XPROXYMANAGEMENT) += xorg-proto-xproxymanagement

#
# Paths and names
#
XORG_PROTO_XPROXYMANAGEMENT_VERSION	:= 1.0.2
XORG_PROTO_XPROXYMANAGEMENT		:= xproxymanagementprotocol-$(XORG_PROTO_XPROXYMANAGEMENT_VERSION)
XORG_PROTO_XPROXYMANAGEMENT_SUFFIX	:= tar.bz2
XORG_PROTO_XPROXYMANAGEMENT_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/proto/$(XORG_PROTO_XPROXYMANAGEMENT).$(XORG_PROTO_XPROXYMANAGEMENT_SUFFIX)
XORG_PROTO_XPROXYMANAGEMENT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XPROXYMANAGEMENT).$(XORG_PROTO_XPROXYMANAGEMENT_SUFFIX)
XORG_PROTO_XPROXYMANAGEMENT_DIR		:= $(BUILDDIR)/$(XORG_PROTO_XPROXYMANAGEMENT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xproxymanagement_get: $(STATEDIR)/xorg-proto-xproxymanagement.get

$(STATEDIR)/xorg-proto-xproxymanagement.get: $(xorg-proto-xproxymanagement_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XPROXYMANAGEMENT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_XPROXYMANAGEMENT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xproxymanagement_extract: $(STATEDIR)/xorg-proto-xproxymanagement.extract

$(STATEDIR)/xorg-proto-xproxymanagement.extract: $(xorg-proto-xproxymanagement_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XPROXYMANAGEMENT_DIR))
	@$(call extract, XORG_PROTO_XPROXYMANAGEMENT)
	@$(call patchin, XORG_PROTO_XPROXYMANAGEMENT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xproxymanagement_prepare: $(STATEDIR)/xorg-proto-xproxymanagement.prepare

XORG_PROTO_XPROXYMANAGEMENT_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XPROXYMANAGEMENT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XPROXYMANAGEMENT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xproxymanagement.prepare: $(xorg-proto-xproxymanagement_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XPROXYMANAGEMENT_DIR)/config.cache)
	cd $(XORG_PROTO_XPROXYMANAGEMENT_DIR) && \
		$(XORG_PROTO_XPROXYMANAGEMENT_PATH) $(XORG_PROTO_XPROXYMANAGEMENT_ENV) \
		./configure $(XORG_PROTO_XPROXYMANAGEMENT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xproxymanagement_compile: $(STATEDIR)/xorg-proto-xproxymanagement.compile

$(STATEDIR)/xorg-proto-xproxymanagement.compile: $(xorg-proto-xproxymanagement_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XPROXYMANAGEMENT_DIR) && $(XORG_PROTO_XPROXYMANAGEMENT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xproxymanagement_install: $(STATEDIR)/xorg-proto-xproxymanagement.install

$(STATEDIR)/xorg-proto-xproxymanagement.install: $(xorg-proto-xproxymanagement_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XPROXYMANAGEMENT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xproxymanagement_targetinstall: $(STATEDIR)/xorg-proto-xproxymanagement.targetinstall

$(STATEDIR)/xorg-proto-xproxymanagement.targetinstall: $(xorg-proto-xproxymanagement_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xproxymanagement_clean:
	rm -rf $(STATEDIR)/xorg-proto-xproxymanagement.*
	rm -rf $(PKGDIR)/xorg-proto-xproxymanagement_*
	rm -rf $(XORG_PROTO_XPROXYMANAGEMENT_DIR)

# vim: syntax=make

