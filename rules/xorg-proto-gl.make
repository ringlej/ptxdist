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
PACKAGES-$(PTXCONF_XORG_PROTO_GL) += xorg-proto-gl

#
# Paths and names
#
XORG_PROTO_GL_VERSION 	:= 1.4.10
XORG_PROTO_GL		:= glproto-$(XORG_PROTO_GL_VERSION)
XORG_PROTO_GL_SUFFIX	:= tar.bz2
XORG_PROTO_GL_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_GL).$(XORG_PROTO_GL_SUFFIX)
XORG_PROTO_GL_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_GL).$(XORG_PROTO_GL_SUFFIX)
XORG_PROTO_GL_DIR	:= $(BUILDDIR)/$(XORG_PROTO_GL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-gl_get: $(STATEDIR)/xorg-proto-gl.get

$(STATEDIR)/xorg-proto-gl.get: $(xorg-proto-gl_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_GL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_GL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-gl_extract: $(STATEDIR)/xorg-proto-gl.extract

$(STATEDIR)/xorg-proto-gl.extract: $(xorg-proto-gl_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_GL_DIR))
	@$(call extract, XORG_PROTO_GL)
	@$(call patchin, XORG_PROTO_GL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-gl_prepare: $(STATEDIR)/xorg-proto-gl.prepare

XORG_PROTO_GL_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_GL_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_GL_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-gl.prepare: $(xorg-proto-gl_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_GL_DIR)/config.cache)
	cd $(XORG_PROTO_GL_DIR) && \
		$(XORG_PROTO_GL_PATH) $(XORG_PROTO_GL_ENV) \
		./configure $(XORG_PROTO_GL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-gl_compile: $(STATEDIR)/xorg-proto-gl.compile

$(STATEDIR)/xorg-proto-gl.compile: $(xorg-proto-gl_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_GL_DIR) && $(XORG_PROTO_GL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-gl_install: $(STATEDIR)/xorg-proto-gl.install

$(STATEDIR)/xorg-proto-gl.install: $(xorg-proto-gl_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_GL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-gl_targetinstall: $(STATEDIR)/xorg-proto-gl.targetinstall

$(STATEDIR)/xorg-proto-gl.targetinstall: $(xorg-proto-gl_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-gl_clean:
	rm -rf $(STATEDIR)/xorg-proto-gl.*
	rm -rf $(PKGDIR)/xorg-proto-gl_*
	rm -rf $(XORG_PROTO_GL_DIR)

# vim: syntax=make

