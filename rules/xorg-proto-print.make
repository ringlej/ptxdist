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
PACKAGES-$(PTXCONF_XORG_PROTO_PRINT) += xorg-proto-print

#
# Paths and names
#
XORG_PROTO_PRINT_VERSION:= 1.0.4
XORG_PROTO_PRINT	:= printproto-$(XORG_PROTO_PRINT_VERSION)
XORG_PROTO_PRINT_SUFFIX	:= tar.bz2
XORG_PROTO_PRINT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_PRINT).$(XORG_PROTO_PRINT_SUFFIX)
XORG_PROTO_PRINT_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_PRINT).$(XORG_PROTO_PRINT_SUFFIX)
XORG_PROTO_PRINT_DIR	:= $(BUILDDIR)/$(XORG_PROTO_PRINT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-print_get: $(STATEDIR)/xorg-proto-print.get

$(STATEDIR)/xorg-proto-print.get: $(xorg-proto-print_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_PRINT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_PRINT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-print_extract: $(STATEDIR)/xorg-proto-print.extract

$(STATEDIR)/xorg-proto-print.extract: $(xorg-proto-print_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_PRINT_DIR))
	@$(call extract, XORG_PROTO_PRINT)
	@$(call patchin, XORG_PROTO_PRINT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-print_prepare: $(STATEDIR)/xorg-proto-print.prepare

XORG_PROTO_PRINT_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_PRINT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_PRINT_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-print.prepare: $(xorg-proto-print_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_PRINT_DIR)/config.cache)
	cd $(XORG_PROTO_PRINT_DIR) && \
		$(XORG_PROTO_PRINT_PATH) $(XORG_PROTO_PRINT_ENV) \
		./configure $(XORG_PROTO_PRINT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-print_compile: $(STATEDIR)/xorg-proto-print.compile

$(STATEDIR)/xorg-proto-print.compile: $(xorg-proto-print_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_PRINT_DIR) && $(XORG_PROTO_PRINT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-print_install: $(STATEDIR)/xorg-proto-print.install

$(STATEDIR)/xorg-proto-print.install: $(xorg-proto-print_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_PRINT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-print_targetinstall: $(STATEDIR)/xorg-proto-print.targetinstall

$(STATEDIR)/xorg-proto-print.targetinstall: $(xorg-proto-print_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-print_clean:
	rm -rf $(STATEDIR)/xorg-proto-print.*
	rm -rf $(PKGDIR)/xorg-proto-print_*
	rm -rf $(XORG_PROTO_PRINT_DIR)

# vim: syntax=make

