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
PACKAGES-$(PTXCONF_XORG_PROTO_XEXT) += xorg-proto-xext

#
# Paths and names
#
XORG_PROTO_XEXT_VERSION := 7.1.1
XORG_PROTO_XEXT		:= xextproto-$(XORG_PROTO_XEXT_VERSION)
XORG_PROTO_XEXT_SUFFIX	:= tar.bz2
XORG_PROTO_XEXT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XEXT).$(XORG_PROTO_XEXT_SUFFIX)
XORG_PROTO_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XEXT).$(XORG_PROTO_XEXT_SUFFIX)
XORG_PROTO_XEXT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_XEXT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xext_get: $(STATEDIR)/xorg-proto-xext.get

$(STATEDIR)/xorg-proto-xext.get: $(xorg-proto-xext_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_XEXT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xext_extract: $(STATEDIR)/xorg-proto-xext.extract

$(STATEDIR)/xorg-proto-xext.extract: $(xorg-proto-xext_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XEXT_DIR))
	@$(call extract, XORG_PROTO_XEXT)
	@$(call patchin, XORG_PROTO_XEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xext_prepare: $(STATEDIR)/xorg-proto-xext.prepare

XORG_PROTO_XEXT_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XEXT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XEXT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xext.prepare: $(xorg-proto-xext_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XEXT_DIR)/config.cache)
	cd $(XORG_PROTO_XEXT_DIR) && \
		$(XORG_PROTO_XEXT_PATH) $(XORG_PROTO_XEXT_ENV) \
		./configure $(XORG_PROTO_XEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xext_compile: $(STATEDIR)/xorg-proto-xext.compile

$(STATEDIR)/xorg-proto-xext.compile: $(xorg-proto-xext_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XEXT_DIR) && $(XORG_PROTO_XEXT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xext_install: $(STATEDIR)/xorg-proto-xext.install

$(STATEDIR)/xorg-proto-xext.install: $(xorg-proto-xext_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xext_targetinstall: $(STATEDIR)/xorg-proto-xext.targetinstall

$(STATEDIR)/xorg-proto-xext.targetinstall: $(xorg-proto-xext_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xext_clean:
	rm -rf $(STATEDIR)/xorg-proto-xext.*
	rm -rf $(PKGDIR)/xorg-proto-xext_*
	rm -rf $(XORG_PROTO_XEXT_DIR)

# vim: syntax=make

