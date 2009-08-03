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
PACKAGES-$(PTXCONF_XORG_LIB_XTRANS) += xorg-lib-xtrans

#
# Paths and names
#
XORG_LIB_XTRANS_VERSION	:= 1.2.5
XORG_LIB_XTRANS		:= xtrans-$(XORG_LIB_XTRANS_VERSION)
XORG_LIB_XTRANS_SUFFIX	:= tar.bz2
XORG_LIB_XTRANS_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XTRANS).$(XORG_LIB_XTRANS_SUFFIX)
XORG_LIB_XTRANS_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XTRANS).$(XORG_LIB_XTRANS_SUFFIX)
XORG_LIB_XTRANS_DIR	:= $(BUILDDIR)/$(XORG_LIB_XTRANS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xtrans_get: $(STATEDIR)/xorg-lib-xtrans.get

$(STATEDIR)/xorg-lib-xtrans.get: $(xorg-lib-xtrans_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XTRANS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XTRANS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xtrans_extract: $(STATEDIR)/xorg-lib-xtrans.extract

$(STATEDIR)/xorg-lib-xtrans.extract: $(xorg-lib-xtrans_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTRANS_DIR))
	@$(call extract, XORG_LIB_XTRANS)
	@$(call patchin, XORG_LIB_XTRANS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xtrans_prepare: $(STATEDIR)/xorg-lib-xtrans.prepare

XORG_LIB_XTRANS_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XTRANS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XTRANS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/xorg-lib-xtrans.prepare: $(xorg-lib-xtrans_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTRANS_DIR)/config.cache)
	cd $(XORG_LIB_XTRANS_DIR) && \
		$(XORG_LIB_XTRANS_PATH) $(XORG_LIB_XTRANS_ENV) \
		./configure $(XORG_LIB_XTRANS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xtrans_compile: $(STATEDIR)/xorg-lib-xtrans.compile

$(STATEDIR)/xorg-lib-xtrans.compile: $(xorg-lib-xtrans_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XTRANS_DIR) && $(XORG_LIB_XTRANS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xtrans_install: $(STATEDIR)/xorg-lib-xtrans.install

$(STATEDIR)/xorg-lib-xtrans.install: $(xorg-lib-xtrans_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XTRANS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xtrans_targetinstall: $(STATEDIR)/xorg-lib-xtrans.targetinstall

$(STATEDIR)/xorg-lib-xtrans.targetinstall: $(xorg-lib-xtrans_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xtrans_clean:
	rm -rf $(STATEDIR)/xorg-lib-xtrans.*
	rm -rf $(PKGDIR)/xorg-lib-xtrans_*
	rm -rf $(XORG_LIB_XTRANS_DIR)

# vim: syntax=make
