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
PACKAGES-$(PTXCONF_XORG_PROTO_EVIEEXT) += xorg-proto-evieext

#
# Paths and names
#
XORG_PROTO_EVIEEXT_VERSION	:= 1.1.0
XORG_PROTO_EVIEEXT		:= evieext-$(XORG_PROTO_EVIEEXT_VERSION)
XORG_PROTO_EVIEEXT_SUFFIX	:= tar.bz2
XORG_PROTO_EVIEEXT_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_EVIEEXT).$(XORG_PROTO_EVIEEXT_SUFFIX)
XORG_PROTO_EVIEEXT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_EVIEEXT).$(XORG_PROTO_EVIEEXT_SUFFIX)
XORG_PROTO_EVIEEXT_DIR		:= $(BUILDDIR)/$(XORG_PROTO_EVIEEXT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-evieext_get: $(STATEDIR)/xorg-proto-evieext.get

$(STATEDIR)/xorg-proto-evieext.get: $(xorg-proto-evieext_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_EVIEEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_EVIEEXT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-evieext_extract: $(STATEDIR)/xorg-proto-evieext.extract

$(STATEDIR)/xorg-proto-evieext.extract: $(xorg-proto-evieext_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_EVIEEXT_DIR))
	@$(call extract, XORG_PROTO_EVIEEXT)
	@$(call patchin, XORG_PROTO_EVIEEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-evieext_prepare: $(STATEDIR)/xorg-proto-evieext.prepare

XORG_PROTO_EVIEEXT_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_EVIEEXT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_EVIEEXT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-evieext.prepare: $(xorg-proto-evieext_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_EVIEEXT_DIR)/config.cache)
	cd $(XORG_PROTO_EVIEEXT_DIR) && \
		$(XORG_PROTO_EVIEEXT_PATH) $(XORG_PROTO_EVIEEXT_ENV) \
		./configure $(XORG_PROTO_EVIEEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-evieext_compile: $(STATEDIR)/xorg-proto-evieext.compile

$(STATEDIR)/xorg-proto-evieext.compile: $(xorg-proto-evieext_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_EVIEEXT_DIR) && $(XORG_PROTO_EVIEEXT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-evieext_install: $(STATEDIR)/xorg-proto-evieext.install

$(STATEDIR)/xorg-proto-evieext.install: $(xorg-proto-evieext_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_EVIEEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-evieext_targetinstall: $(STATEDIR)/xorg-proto-evieext.targetinstall

$(STATEDIR)/xorg-proto-evieext.targetinstall: $(xorg-proto-evieext_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-evieext_clean:
	rm -rf $(STATEDIR)/xorg-proto-evieext.*
	rm -rf $(PKGDIR)/xorg-proto-evieext_*
	rm -rf $(XORG_PROTO_EVIEEXT_DIR)

# vim: syntax=make

