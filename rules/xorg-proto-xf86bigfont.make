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
PACKAGES-$(PTXCONF_XORG_PROTO_XF86BIGFONT) += xorg-proto-xf86bigfont

#
# Paths and names
#
XORG_PROTO_XF86BIGFONT_VERSION	:= 1.2.0
XORG_PROTO_XF86BIGFONT		:= xf86bigfontproto-$(XORG_PROTO_XF86BIGFONT_VERSION)
XORG_PROTO_XF86BIGFONT_SUFFIX	:= tar.bz2
XORG_PROTO_XF86BIGFONT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_XF86BIGFONT).$(XORG_PROTO_XF86BIGFONT_SUFFIX)
XORG_PROTO_XF86BIGFONT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_XF86BIGFONT).$(XORG_PROTO_XF86BIGFONT_SUFFIX)
XORG_PROTO_XF86BIGFONT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_XF86BIGFONT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-xf86bigfont_get: $(STATEDIR)/xorg-proto-xf86bigfont.get

$(STATEDIR)/xorg-proto-xf86bigfont.get: $(xorg-proto-xf86bigfont_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_XF86BIGFONT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_XF86BIGFONT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-xf86bigfont_extract: $(STATEDIR)/xorg-proto-xf86bigfont.extract

$(STATEDIR)/xorg-proto-xf86bigfont.extract: $(xorg-proto-xf86bigfont_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86BIGFONT_DIR))
	@$(call extract, XORG_PROTO_XF86BIGFONT)
	@$(call patchin, XORG_PROTO_XF86BIGFONT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-xf86bigfont_prepare: $(STATEDIR)/xorg-proto-xf86bigfont.prepare

XORG_PROTO_XF86BIGFONT_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_XF86BIGFONT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_XF86BIGFONT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-xf86bigfont.prepare: $(xorg-proto-xf86bigfont_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_XF86BIGFONT_DIR)/config.cache)
	cd $(XORG_PROTO_XF86BIGFONT_DIR) && \
		$(XORG_PROTO_XF86BIGFONT_PATH) $(XORG_PROTO_XF86BIGFONT_ENV) \
		./configure $(XORG_PROTO_XF86BIGFONT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-xf86bigfont_compile: $(STATEDIR)/xorg-proto-xf86bigfont.compile

$(STATEDIR)/xorg-proto-xf86bigfont.compile: $(xorg-proto-xf86bigfont_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_XF86BIGFONT_DIR) && $(XORG_PROTO_XF86BIGFONT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-xf86bigfont_install: $(STATEDIR)/xorg-proto-xf86bigfont.install

$(STATEDIR)/xorg-proto-xf86bigfont.install: $(xorg-proto-xf86bigfont_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_XF86BIGFONT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-xf86bigfont_targetinstall: $(STATEDIR)/xorg-proto-xf86bigfont.targetinstall

$(STATEDIR)/xorg-proto-xf86bigfont.targetinstall: $(xorg-proto-xf86bigfont_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-xf86bigfont_clean:
	rm -rf $(STATEDIR)/xorg-proto-xf86bigfont.*
	rm -rf $(PKGDIR)/xorg-proto-xf86bigfont_*
	rm -rf $(XORG_PROTO_XF86BIGFONT_DIR)

# vim: syntax=make

