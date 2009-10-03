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
PACKAGES-$(PTXCONF_XORG_PROTO_COMPOSITE) += xorg-proto-composite

#
# Paths and names
#
XORG_PROTO_COMPOSITE_VERSION 	:= 0.4.1
XORG_PROTO_COMPOSITE		:= compositeproto-$(XORG_PROTO_COMPOSITE_VERSION)
XORG_PROTO_COMPOSITE_SUFFIX	:= tar.bz2
XORG_PROTO_COMPOSITE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_COMPOSITE).$(XORG_PROTO_COMPOSITE_SUFFIX)
XORG_PROTO_COMPOSITE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_COMPOSITE).$(XORG_PROTO_COMPOSITE_SUFFIX)
XORG_PROTO_COMPOSITE_DIR	:= $(BUILDDIR)/$(XORG_PROTO_COMPOSITE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-composite_get: $(STATEDIR)/xorg-proto-composite.get

$(STATEDIR)/xorg-proto-composite.get: $(xorg-proto-composite_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_COMPOSITE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_COMPOSITE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-composite_extract: $(STATEDIR)/xorg-proto-composite.extract

$(STATEDIR)/xorg-proto-composite.extract: $(xorg-proto-composite_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_COMPOSITE_DIR))
	@$(call extract, XORG_PROTO_COMPOSITE)
	@$(call patchin, XORG_PROTO_COMPOSITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-composite_prepare: $(STATEDIR)/xorg-proto-composite.prepare

XORG_PROTO_COMPOSITE_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_COMPOSITE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_COMPOSITE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-composite.prepare: $(xorg-proto-composite_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_COMPOSITE_DIR)/config.cache)
	cd $(XORG_PROTO_COMPOSITE_DIR) && \
		$(XORG_PROTO_COMPOSITE_PATH) $(XORG_PROTO_COMPOSITE_ENV) \
		./configure $(XORG_PROTO_COMPOSITE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-composite_compile: $(STATEDIR)/xorg-proto-composite.compile

$(STATEDIR)/xorg-proto-composite.compile: $(xorg-proto-composite_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_COMPOSITE_DIR) && $(XORG_PROTO_COMPOSITE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-composite_install: $(STATEDIR)/xorg-proto-composite.install

$(STATEDIR)/xorg-proto-composite.install: $(xorg-proto-composite_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_COMPOSITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-composite_targetinstall: $(STATEDIR)/xorg-proto-composite.targetinstall

$(STATEDIR)/xorg-proto-composite.targetinstall: $(xorg-proto-composite_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-composite_clean:
	rm -rf $(STATEDIR)/xorg-proto-composite.*
	rm -rf $(PKGDIR)/xorg-proto-composite_*
	rm -rf $(XORG_PROTO_COMPOSITE_DIR)

# vim: syntax=make

