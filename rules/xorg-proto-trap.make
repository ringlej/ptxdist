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
PACKAGES-$(PTXCONF_XORG_PROTO_TRAP) += xorg-proto-trap

#
# Paths and names
#
XORG_PROTO_TRAP_VERSION := 3.4.3
XORG_PROTO_TRAP		:= trapproto-$(XORG_PROTO_TRAP_VERSION)
XORG_PROTO_TRAP_SUFFIX	:= tar.bz2
XORG_PROTO_TRAP_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/proto/$(XORG_PROTO_TRAP).$(XORG_PROTO_TRAP_SUFFIX)
XORG_PROTO_TRAP_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_TRAP).$(XORG_PROTO_TRAP_SUFFIX)
XORG_PROTO_TRAP_DIR	:= $(BUILDDIR)/$(XORG_PROTO_TRAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-trap_get: $(STATEDIR)/xorg-proto-trap.get

$(STATEDIR)/xorg-proto-trap.get: $(xorg-proto-trap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_TRAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_TRAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-trap_extract: $(STATEDIR)/xorg-proto-trap.extract

$(STATEDIR)/xorg-proto-trap.extract: $(xorg-proto-trap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_TRAP_DIR))
	@$(call extract, XORG_PROTO_TRAP)
	@$(call patchin, XORG_PROTO_TRAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-trap_prepare: $(STATEDIR)/xorg-proto-trap.prepare

XORG_PROTO_TRAP_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_TRAP_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_TRAP_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-trap.prepare: $(xorg-proto-trap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_TRAP_DIR)/config.cache)
	cd $(XORG_PROTO_TRAP_DIR) && \
		$(XORG_PROTO_TRAP_PATH) $(XORG_PROTO_TRAP_ENV) \
		./configure $(XORG_PROTO_TRAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-trap_compile: $(STATEDIR)/xorg-proto-trap.compile

$(STATEDIR)/xorg-proto-trap.compile: $(xorg-proto-trap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_TRAP_DIR) && $(XORG_PROTO_TRAP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-trap_install: $(STATEDIR)/xorg-proto-trap.install

$(STATEDIR)/xorg-proto-trap.install: $(xorg-proto-trap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_TRAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-trap_targetinstall: $(STATEDIR)/xorg-proto-trap.targetinstall

$(STATEDIR)/xorg-proto-trap.targetinstall: $(xorg-proto-trap_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-trap_clean:
	rm -rf $(STATEDIR)/xorg-proto-trap.*
	rm -rf $(PKGDIR)/xorg-proto-trap_*
	rm -rf $(XORG_PROTO_TRAP_DIR)

# vim: syntax=make

