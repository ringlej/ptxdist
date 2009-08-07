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
PACKAGES-$(PTXCONF_XORG_PROTO_INPUT) += xorg-proto-input

#
# Paths and names
#
XORG_PROTO_INPUT_VERSION:= 2.0
XORG_PROTO_INPUT	:= inputproto-$(XORG_PROTO_INPUT_VERSION)
XORG_PROTO_INPUT_SUFFIX	:= tar.bz2
XORG_PROTO_INPUT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_INPUT).$(XORG_PROTO_INPUT_SUFFIX)
XORG_PROTO_INPUT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_INPUT).$(XORG_PROTO_INPUT_SUFFIX)
XORG_PROTO_INPUT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_INPUT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-input_get: $(STATEDIR)/xorg-proto-input.get

$(STATEDIR)/xorg-proto-input.get: $(xorg-proto-input_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_INPUT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_INPUT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-input_extract: $(STATEDIR)/xorg-proto-input.extract

$(STATEDIR)/xorg-proto-input.extract: $(xorg-proto-input_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_INPUT_DIR))
	@$(call extract, XORG_PROTO_INPUT)
	@$(call patchin, XORG_PROTO_INPUT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-input_prepare: $(STATEDIR)/xorg-proto-input.prepare

XORG_PROTO_INPUT_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_INPUT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_INPUT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-input.prepare: $(xorg-proto-input_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_INPUT_DIR)/config.cache)
	cd $(XORG_PROTO_INPUT_DIR) && \
		$(XORG_PROTO_INPUT_PATH) $(XORG_PROTO_INPUT_ENV) \
		./configure $(XORG_PROTO_INPUT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-input_compile: $(STATEDIR)/xorg-proto-input.compile

$(STATEDIR)/xorg-proto-input.compile: $(xorg-proto-input_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_INPUT_DIR) && $(XORG_PROTO_INPUT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-input_install: $(STATEDIR)/xorg-proto-input.install

$(STATEDIR)/xorg-proto-input.install: $(xorg-proto-input_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_INPUT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-input_targetinstall: $(STATEDIR)/xorg-proto-input.targetinstall

$(STATEDIR)/xorg-proto-input.targetinstall: $(xorg-proto-input_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-input_clean:
	rm -rf $(STATEDIR)/xorg-proto-input.*
	rm -rf $(PKGDIR)/xorg-proto-input_*
	rm -rf $(XORG_PROTO_INPUT_DIR)

# vim: syntax=make

