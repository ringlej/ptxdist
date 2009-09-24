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
PACKAGES-$(PTXCONF_XORG_PROTO_X) += xorg-proto-x

#
# Paths and names
#
XORG_PROTO_X_VERSION 	:= 7.0.16
XORG_PROTO_X		:= xproto-$(XORG_PROTO_X_VERSION)
XORG_PROTO_X_SUFFIX	:= tar.bz2
XORG_PROTO_X_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_X).$(XORG_PROTO_X_SUFFIX)
XORG_PROTO_X_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_X).$(XORG_PROTO_X_SUFFIX)
XORG_PROTO_X_DIR	:= $(BUILDDIR)/$(XORG_PROTO_X)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-x_get: $(STATEDIR)/xorg-proto-x.get

$(STATEDIR)/xorg-proto-x.get: $(xorg-proto-x_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_X_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_X)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-x_extract: $(STATEDIR)/xorg-proto-x.extract

$(STATEDIR)/xorg-proto-x.extract: $(xorg-proto-x_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_X_DIR))
	@$(call extract, XORG_PROTO_X)
	@$(call patchin, XORG_PROTO_X)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-x_prepare: $(STATEDIR)/xorg-proto-x.prepare

XORG_PROTO_X_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_X_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_X_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

#
# this was valid for an x86 target. Check on other
# architectures and do not trust the autodetection
#
XORG_PROTO_X_AUTOCONF += \
	--enable-const-prototypes \
	--enable-function-prototypes \
	--enable-varargs-prototypes \
	--enable-nested-prototypes \
	--enable-wide-prototypes=no

$(STATEDIR)/xorg-proto-x.prepare: $(xorg-proto-x_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_X_DIR)/config.cache)
	cd $(XORG_PROTO_X_DIR) && \
		$(XORG_PROTO_X_PATH) $(XORG_PROTO_X_ENV) \
		./configure $(XORG_PROTO_X_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-x_compile: $(STATEDIR)/xorg-proto-x.compile

$(STATEDIR)/xorg-proto-x.compile: $(xorg-proto-x_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_X_DIR) && $(XORG_PROTO_X_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-x_install: $(STATEDIR)/xorg-proto-x.install

$(STATEDIR)/xorg-proto-x.install: $(xorg-proto-x_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_X)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-x_targetinstall: $(STATEDIR)/xorg-proto-x.targetinstall

$(STATEDIR)/xorg-proto-x.targetinstall: $(xorg-proto-x_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-x_clean:
	rm -rf $(STATEDIR)/xorg-proto-x.*
	rm -rf $(PKGDIR)/xorg-proto-x_*
	rm -rf $(XORG_PROTO_X_DIR)

# vim: syntax=make

