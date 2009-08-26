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
PACKAGES-$(PTXCONF_XORG_PROTO_SCRNSAVER) += xorg-proto-scrnsaver

#
# Paths and names
#
XORG_PROTO_SCRNSAVER_VERSION 	:= 1.2.0
XORG_PROTO_SCRNSAVER		:= scrnsaverproto-$(XORG_PROTO_SCRNSAVER_VERSION)
XORG_PROTO_SCRNSAVER_SUFFIX	:= tar.bz2
XORG_PROTO_SCRNSAVER_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_SCRNSAVER).$(XORG_PROTO_SCRNSAVER_SUFFIX)
XORG_PROTO_SCRNSAVER_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_SCRNSAVER).$(XORG_PROTO_SCRNSAVER_SUFFIX)
XORG_PROTO_SCRNSAVER_DIR	:= $(BUILDDIR)/$(XORG_PROTO_SCRNSAVER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-scrnsaver_get: $(STATEDIR)/xorg-proto-scrnsaver.get

$(STATEDIR)/xorg-proto-scrnsaver.get: $(xorg-proto-scrnsaver_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_SCRNSAVER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_SCRNSAVER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-scrnsaver_extract: $(STATEDIR)/xorg-proto-scrnsaver.extract

$(STATEDIR)/xorg-proto-scrnsaver.extract: $(xorg-proto-scrnsaver_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_SCRNSAVER_DIR))
	@$(call extract, XORG_PROTO_SCRNSAVER)
	@$(call patchin, XORG_PROTO_SCRNSAVER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-scrnsaver_prepare: $(STATEDIR)/xorg-proto-scrnsaver.prepare

XORG_PROTO_SCRNSAVER_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_SCRNSAVER_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_SCRNSAVER_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-scrnsaver.prepare: $(xorg-proto-scrnsaver_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_SCRNSAVER_DIR)/config.cache)
	cd $(XORG_PROTO_SCRNSAVER_DIR) && \
		$(XORG_PROTO_SCRNSAVER_PATH) $(XORG_PROTO_SCRNSAVER_ENV) \
		./configure $(XORG_PROTO_SCRNSAVER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-scrnsaver_compile: $(STATEDIR)/xorg-proto-scrnsaver.compile

$(STATEDIR)/xorg-proto-scrnsaver.compile: $(xorg-proto-scrnsaver_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_SCRNSAVER_DIR) && $(XORG_PROTO_SCRNSAVER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-scrnsaver_install: $(STATEDIR)/xorg-proto-scrnsaver.install

$(STATEDIR)/xorg-proto-scrnsaver.install: $(xorg-proto-scrnsaver_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_SCRNSAVER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-scrnsaver_targetinstall: $(STATEDIR)/xorg-proto-scrnsaver.targetinstall

$(STATEDIR)/xorg-proto-scrnsaver.targetinstall: $(xorg-proto-scrnsaver_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-scrnsaver_clean:
	rm -rf $(STATEDIR)/xorg-proto-scrnsaver.*
	rm -rf $(PKGDIR)/xorg-proto-scrnsaver_*
	rm -rf $(XORG_PROTO_SCRNSAVER_DIR)

# vim: syntax=make

