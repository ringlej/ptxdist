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
PACKAGES-$(PTXCONF_XORG_PROTO_DAMAGE) += xorg-proto-damage

#
# Paths and names
#
XORG_PROTO_DAMAGE_VERSION	:= 1.2.0
XORG_PROTO_DAMAGE		:= damageproto-$(XORG_PROTO_DAMAGE_VERSION)
XORG_PROTO_DAMAGE_SUFFIX	:= tar.bz2
XORG_PROTO_DAMAGE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_DAMAGE).$(XORG_PROTO_DAMAGE_SUFFIX)
XORG_PROTO_DAMAGE_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_DAMAGE).$(XORG_PROTO_DAMAGE_SUFFIX)
XORG_PROTO_DAMAGE_DIR		:= $(BUILDDIR)/$(XORG_PROTO_DAMAGE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-damage_get: $(STATEDIR)/xorg-proto-damage.get

$(STATEDIR)/xorg-proto-damage.get: $(xorg-proto-damage_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_DAMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_DAMAGE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-damage_extract: $(STATEDIR)/xorg-proto-damage.extract

$(STATEDIR)/xorg-proto-damage.extract: $(xorg-proto-damage_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_DAMAGE_DIR))
	@$(call extract, XORG_PROTO_DAMAGE)
	@$(call patchin, XORG_PROTO_DAMAGE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-damage_prepare: $(STATEDIR)/xorg-proto-damage.prepare

XORG_PROTO_DAMAGE_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_DAMAGE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_DAMAGE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-damage.prepare: $(xorg-proto-damage_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_DAMAGE_DIR)/config.cache)
	cd $(XORG_PROTO_DAMAGE_DIR) && \
		$(XORG_PROTO_DAMAGE_PATH) $(XORG_PROTO_DAMAGE_ENV) \
		./configure $(XORG_PROTO_DAMAGE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-damage_compile: $(STATEDIR)/xorg-proto-damage.compile

$(STATEDIR)/xorg-proto-damage.compile: $(xorg-proto-damage_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_DAMAGE_DIR) && $(XORG_PROTO_DAMAGE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-damage_install: $(STATEDIR)/xorg-proto-damage.install

$(STATEDIR)/xorg-proto-damage.install: $(xorg-proto-damage_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_DAMAGE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-damage_targetinstall: $(STATEDIR)/xorg-proto-damage.targetinstall

$(STATEDIR)/xorg-proto-damage.targetinstall: $(xorg-proto-damage_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-damage_clean:
	rm -rf $(STATEDIR)/xorg-proto-damage.*
	rm -rf $(PKGDIR)/xorg-proto-damage_*
	rm -rf $(XORG_PROTO_DAMAGE_DIR)

# vim: syntax=make

