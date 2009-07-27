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
PACKAGES-$(PTXCONF_XORG_PROTO_RENDER) += xorg-proto-render

#
# Paths and names
#
XORG_PROTO_RENDER_VERSION	:= 0.11
XORG_PROTO_RENDER		:= renderproto-$(XORG_PROTO_RENDER_VERSION)
XORG_PROTO_RENDER_SUFFIX	:= tar.bz2
XORG_PROTO_RENDER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_RENDER).$(XORG_PROTO_RENDER_SUFFIX)
XORG_PROTO_RENDER_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RENDER).$(XORG_PROTO_RENDER_SUFFIX)
XORG_PROTO_RENDER_DIR		:= $(BUILDDIR)/$(XORG_PROTO_RENDER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-render_get: $(STATEDIR)/xorg-proto-render.get

$(STATEDIR)/xorg-proto-render.get: $(xorg-proto-render_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_RENDER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_RENDER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-render_extract: $(STATEDIR)/xorg-proto-render.extract

$(STATEDIR)/xorg-proto-render.extract: $(xorg-proto-render_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_RENDER_DIR))
	@$(call extract, XORG_PROTO_RENDER)
	@$(call patchin, XORG_PROTO_RENDER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-render_prepare: $(STATEDIR)/xorg-proto-render.prepare

XORG_PROTO_RENDER_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_RENDER_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_RENDER_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-render.prepare: $(xorg-proto-render_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_RENDER_DIR)/config.cache)
	cd $(XORG_PROTO_RENDER_DIR) && \
		$(XORG_PROTO_RENDER_PATH) $(XORG_PROTO_RENDER_ENV) \
		./configure $(XORG_PROTO_RENDER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-render_compile: $(STATEDIR)/xorg-proto-render.compile

$(STATEDIR)/xorg-proto-render.compile: $(xorg-proto-render_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_RENDER_DIR) && $(XORG_PROTO_RENDER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-render_install: $(STATEDIR)/xorg-proto-render.install

$(STATEDIR)/xorg-proto-render.install: $(xorg-proto-render_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_RENDER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-render_targetinstall: $(STATEDIR)/xorg-proto-render.targetinstall

$(STATEDIR)/xorg-proto-render.targetinstall: $(xorg-proto-render_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-render_clean:
	rm -rf $(STATEDIR)/xorg-proto-render.*
	rm -rf $(PKGDIR)/xorg-proto-render_*
	rm -rf $(XORG_PROTO_RENDER_DIR)

# vim: syntax=make

