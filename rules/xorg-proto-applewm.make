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
PACKAGES-$(PTXCONF_XORG_PROTO_APPLEWM) += xorg-proto-applewm

#
# Paths and names
#
XORG_PROTO_APPLEWM_VERSION	:= 1.0.3
XORG_PROTO_APPLEWM		:= applewmproto-$(XORG_PROTO_APPLEWM_VERSION)
XORG_PROTO_APPLEWM_SUFFIX	:= tar.bz2
XORG_PROTO_APPLEWM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/proto/$(XORG_PROTO_APPLEWM).$(XORG_PROTO_APPLEWM_SUFFIX)
XORG_PROTO_APPLEWM_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_APPLEWM).$(XORG_PROTO_APPLEWM_SUFFIX)
XORG_PROTO_APPLEWM_DIR		:= $(BUILDDIR)/$(XORG_PROTO_APPLEWM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-applewm_get: $(STATEDIR)/xorg-proto-applewm.get

$(STATEDIR)/xorg-proto-applewm.get: $(xorg-proto-applewm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_APPLEWM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_APPLEWM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-applewm_extract: $(STATEDIR)/xorg-proto-applewm.extract

$(STATEDIR)/xorg-proto-applewm.extract: $(xorg-proto-applewm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_APPLEWM_DIR))
	@$(call extract, XORG_PROTO_APPLEWM)
	@$(call patchin, XORG_PROTO_APPLEWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-applewm_prepare: $(STATEDIR)/xorg-proto-applewm.prepare

XORG_PROTO_APPLEWM_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_APPLEWM_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_APPLEWM_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-applewm.prepare: $(xorg-proto-applewm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_APPLEWM_DIR)/config.cache)
	cd $(XORG_PROTO_APPLEWM_DIR) && \
		$(XORG_PROTO_APPLEWM_PATH) $(XORG_PROTO_APPLEWM_ENV) \
		./configure $(XORG_PROTO_APPLEWM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-applewm_compile: $(STATEDIR)/xorg-proto-applewm.compile

$(STATEDIR)/xorg-proto-applewm.compile: $(xorg-proto-applewm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_APPLEWM_DIR) && $(XORG_PROTO_APPLEWM_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-applewm_install: $(STATEDIR)/xorg-proto-applewm.install

$(STATEDIR)/xorg-proto-applewm.install: $(xorg-proto-applewm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_APPLEWM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-applewm_targetinstall: $(STATEDIR)/xorg-proto-applewm.targetinstall

$(STATEDIR)/xorg-proto-applewm.targetinstall: $(xorg-proto-applewm_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-applewm_clean:
	rm -rf $(STATEDIR)/xorg-proto-applewm.*
	rm -rf $(PKGDIR)/xorg-proto-applewm_*
	rm -rf $(XORG_PROTO_APPLEWM_DIR)

# vim: syntax=make

