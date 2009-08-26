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
PACKAGES-$(PTXCONF_XORG_PROTO_RECORD) += xorg-proto-record

#
# Paths and names
#
XORG_PROTO_RECORD_VERSION	:= 1.14
XORG_PROTO_RECORD		:= recordproto-$(XORG_PROTO_RECORD_VERSION)
XORG_PROTO_RECORD_SUFFIX	:= tar.bz2
XORG_PROTO_RECORD_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/proto/$(XORG_PROTO_RECORD).$(XORG_PROTO_RECORD_SUFFIX)
XORG_PROTO_RECORD_SOURCE	:= $(SRCDIR)/$(XORG_PROTO_RECORD).$(XORG_PROTO_RECORD_SUFFIX)
XORG_PROTO_RECORD_DIR		:= $(BUILDDIR)/$(XORG_PROTO_RECORD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-proto-record_get: $(STATEDIR)/xorg-proto-record.get

$(STATEDIR)/xorg-proto-record.get: $(xorg-proto-record_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_PROTO_RECORD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_PROTO_RECORD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-proto-record_extract: $(STATEDIR)/xorg-proto-record.extract

$(STATEDIR)/xorg-proto-record.extract: $(xorg-proto-record_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_RECORD_DIR))
	@$(call extract, XORG_PROTO_RECORD)
	@$(call patchin, XORG_PROTO_RECORD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-proto-record_prepare: $(STATEDIR)/xorg-proto-record.prepare

XORG_PROTO_RECORD_PATH	:=  PATH=$(CROSS_PATH)
XORG_PROTO_RECORD_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_PROTO_RECORD_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-proto-record.prepare: $(xorg-proto-record_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_PROTO_RECORD_DIR)/config.cache)
	cd $(XORG_PROTO_RECORD_DIR) && \
		$(XORG_PROTO_RECORD_PATH) $(XORG_PROTO_RECORD_ENV) \
		./configure $(XORG_PROTO_RECORD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-proto-record_compile: $(STATEDIR)/xorg-proto-record.compile

$(STATEDIR)/xorg-proto-record.compile: $(xorg-proto-record_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_PROTO_RECORD_DIR) && $(XORG_PROTO_RECORD_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-proto-record_install: $(STATEDIR)/xorg-proto-record.install

$(STATEDIR)/xorg-proto-record.install: $(xorg-proto-record_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_PROTO_RECORD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-proto-record_targetinstall: $(STATEDIR)/xorg-proto-record.targetinstall

$(STATEDIR)/xorg-proto-record.targetinstall: $(xorg-proto-record_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-proto-record_clean:
	rm -rf $(STATEDIR)/xorg-proto-record.*
	rm -rf $(PKGDIR)/xorg-proto-record_*
	rm -rf $(XORG_PROTO_RECORD_DIR)

# vim: syntax=make

