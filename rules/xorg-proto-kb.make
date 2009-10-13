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
PACKAGES-$(PTXCONF_XORG_PROTO_KB) += xorg-proto-kb

#
# Paths and names
#
XORG_PROTO_KB_VERSION 	:= 1.0.4
XORG_PROTO_KB		:= kbproto-$(XORG_PROTO_KB_VERSION)
XORG_PROTO_KB_SUFFIX	:= tar.bz2
XORG_PROTO_KB_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_KB).$(XORG_PROTO_KB_SUFFIX)
XORG_PROTO_KB_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_KB).$(XORG_PROTO_KB_SUFFIX)
XORG_PROTO_KB_DIR	:= $(BUILDDIR)/$(XORG_PROTO_KB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-kb_get: $(STATEDIR)/xorg-proto-kb.get

$(STATEDIR)/xorg-proto-kb.get: $(xorg-proto-kb_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_KB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_KB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-kb_extract: $(STATEDIR)/xorg-proto-kb.extract

$(STATEDIR)/xorg-proto-kb.extract: $(xorg-proto-kb_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_KB_DIR))
	@$(call extract, XORG_PROTO_KB)
	@$(call patchin, XORG_PROTO_KB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-kb_prepare: $(STATEDIR)/xorg-proto-kb.prepare

XORG_PROTO_KB_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_KB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_KB_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-kb.prepare: $(xorg-proto-kb_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_KB_DIR)/config.cache)
	cd $(XORG_PROTO_KB_DIR) && \
		$(XORG_PROTO_KB_PATH) $(XORG_PROTO_KB_ENV) \
		./configure $(XORG_PROTO_KB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-kb_compile: $(STATEDIR)/xorg-proto-kb.compile

$(STATEDIR)/xorg-proto-kb.compile: $(xorg-proto-kb_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_KB_DIR) && $(XORG_PROTO_KB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-kb_install: $(STATEDIR)/xorg-proto-kb.install

$(STATEDIR)/xorg-proto-kb.install: $(xorg-proto-kb_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_KB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-kb_targetinstall: $(STATEDIR)/xorg-proto-kb.targetinstall

$(STATEDIR)/xorg-proto-kb.targetinstall: $(xorg-proto-kb_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-kb_clean:
	rm -rf $(STATEDIR)/xorg-proto-kb.*
	rm -rf $(PKGDIR)/xorg-proto-kb_*
	rm -rf $(XORG_PROTO_KB_DIR)

# vim: syntax=make

