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
PACKAGES-$(PTXCONF_XORG_PROTO_FIXES) += xorg-proto-fixes

#
# Paths and names
#
XORG_PROTO_FIXES_VERSION	:= 4.1.1
XORG_PROTO_FIXES		:= fixesproto-$(XORG_PROTO_FIXES_VERSION)
XORG_PROTO_FIXES_SUFFIX		:= tar.bz2
XORG_PROTO_FIXES_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_FIXES).$(XORG_PROTO_FIXES_SUFFIX)
XORG_PROTO_FIXES_SOURCE		:= $(SRCDIR)/$(XORG_PROTO_FIXES).$(XORG_PROTO_FIXES_SUFFIX)
XORG_PROTO_FIXES_DIR		:= $(BUILDDIR)/$(XORG_PROTO_FIXES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-fixes_get: $(STATEDIR)/xorg-proto-fixes.get

$(STATEDIR)/xorg-proto-fixes.get: $(xorg-proto-fixes_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_FIXES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_FIXES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-fixes_extract: $(STATEDIR)/xorg-proto-fixes.extract

$(STATEDIR)/xorg-proto-fixes.extract: $(xorg-proto-fixes_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_FIXES_DIR))
	@$(call extract, XORG_PROTO_FIXES)
	@$(call patchin, XORG_PROTO_FIXES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-fixes_prepare: $(STATEDIR)/xorg-proto-fixes.prepare

XORG_PROTO_FIXES_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_FIXES_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_FIXES_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-fixes.prepare: $(xorg-proto-fixes_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_FIXES_DIR)/config.cache)
	cd $(XORG_PROTO_FIXES_DIR) && \
		$(XORG_PROTO_FIXES_PATH) $(XORG_PROTO_FIXES_ENV) \
		./configure $(XORG_PROTO_FIXES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-fixes_compile: $(STATEDIR)/xorg-proto-fixes.compile

$(STATEDIR)/xorg-proto-fixes.compile: $(xorg-proto-fixes_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_FIXES_DIR) && $(XORG_PROTO_FIXES_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-fixes_install: $(STATEDIR)/xorg-proto-fixes.install

$(STATEDIR)/xorg-proto-fixes.install: $(xorg-proto-fixes_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_FIXES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-fixes_targetinstall: $(STATEDIR)/xorg-proto-fixes.targetinstall

$(STATEDIR)/xorg-proto-fixes.targetinstall: $(xorg-proto-fixes_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-fixes_clean:
	rm -rf $(STATEDIR)/xorg-proto-fixes.*
	rm -rf $(PKGDIR)/xorg-proto-fixes_*
	rm -rf $(XORG_PROTO_FIXES_DIR)

# vim: syntax=make

