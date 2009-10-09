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
PACKAGES-$(PTXCONF_XORG_PROTO_RANDR) += xorg-proto-randr

#
# Paths and names
#
XORG_PROTO_RANDR_VERSION:= 1.3.1
XORG_PROTO_RANDR	:= randrproto-$(XORG_PROTO_RANDR_VERSION)
XORG_PROTO_RANDR_SUFFIX	:= tar.bz2
XORG_PROTO_RANDR_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_RANDR).$(XORG_PROTO_RANDR_SUFFIX)
XORG_PROTO_RANDR_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RANDR).$(XORG_PROTO_RANDR_SUFFIX)
XORG_PROTO_RANDR_DIR	:= $(BUILDDIR)/$(XORG_PROTO_RANDR)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-randr_get: $(STATEDIR)/xorg-proto-randr.get

$(STATEDIR)/xorg-proto-randr.get: $(xorg-proto-randr_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_RANDR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_RANDR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-randr_extract: $(STATEDIR)/xorg-proto-randr.extract

$(STATEDIR)/xorg-proto-randr.extract: $(xorg-proto-randr_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_RANDR_DIR))
	@$(call extract, XORG_PROTO_RANDR)
	@$(call patchin, XORG_PROTO_RANDR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-randr_prepare: $(STATEDIR)/xorg-proto-randr.prepare

XORG_PROTO_RANDR_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_RANDR_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_RANDR_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-randr.prepare: $(xorg-proto-randr_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_RANDR_DIR)/config.cache)
	cd $(XORG_PROTO_RANDR_DIR) && \
		$(XORG_PROTO_RANDR_PATH) $(XORG_PROTO_RANDR_ENV) \
		./configure $(XORG_PROTO_RANDR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-randr_compile: $(STATEDIR)/xorg-proto-randr.compile

$(STATEDIR)/xorg-proto-randr.compile: $(xorg-proto-randr_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_RANDR_DIR) && $(XORG_PROTO_RANDR_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-randr_install: $(STATEDIR)/xorg-proto-randr.install

$(STATEDIR)/xorg-proto-randr.install: $(xorg-proto-randr_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_RANDR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-randr_targetinstall: $(STATEDIR)/xorg-proto-randr.targetinstall

$(STATEDIR)/xorg-proto-randr.targetinstall: $(xorg-proto-randr_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-randr_clean:
	rm -rf $(STATEDIR)/xorg-proto-randr.*
	rm -rf $(PKGDIR)/xorg-proto-randr_*
	rm -rf $(XORG_PROTO_RANDR_DIR)

# vim: syntax=make

