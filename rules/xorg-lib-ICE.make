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
PACKAGES-$(PTXCONF_XORG_LIB_ICE) += xorg-lib-ice

#
# Paths and names
#
XORG_LIB_ICE_VERSION	:= 1.0.6
XORG_LIB_ICE		:= libICE-$(XORG_LIB_ICE_VERSION)
XORG_LIB_ICE_SUFFIX	:= tar.bz2
XORG_LIB_ICE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_ICE).$(XORG_LIB_ICE_SUFFIX)
XORG_LIB_ICE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_ICE).$(XORG_LIB_ICE_SUFFIX)
XORG_LIB_ICE_DIR	:= $(BUILDDIR)/$(XORG_LIB_ICE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-ice_get: $(STATEDIR)/xorg-lib-ice.get

$(STATEDIR)/xorg-lib-ice.get: $(xorg-lib-ice_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_ICE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_ICE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-ice_extract: $(STATEDIR)/xorg-lib-ice.extract

$(STATEDIR)/xorg-lib-ice.extract: $(xorg-lib-ice_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_ICE_DIR))
	@$(call extract, XORG_LIB_ICE)
	@$(call patchin, XORG_LIB_ICE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-ice_prepare: $(STATEDIR)/xorg-lib-ice.prepare

XORG_LIB_ICE_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_ICE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_ICE_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--disable-dependency-tracking

$(STATEDIR)/xorg-lib-ice.prepare: $(xorg-lib-ice_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_ICE_DIR)/config.cache)
	cd $(XORG_LIB_ICE_DIR) && \
		$(XORG_LIB_ICE_PATH) $(XORG_LIB_ICE_ENV) \
		./configure $(XORG_LIB_ICE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-ice_compile: $(STATEDIR)/xorg-lib-ice.compile

$(STATEDIR)/xorg-lib-ice.compile: $(xorg-lib-ice_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_ICE_DIR) && $(XORG_LIB_ICE_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-ice_install: $(STATEDIR)/xorg-lib-ice.install

$(STATEDIR)/xorg-lib-ice.install: $(xorg-lib-ice_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_ICE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-ice_targetinstall: $(STATEDIR)/xorg-lib-ice.targetinstall

$(STATEDIR)/xorg-lib-ice.targetinstall: $(xorg-lib-ice_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-ice)
	@$(call install_fixup, xorg-lib-ice,PACKAGE,xorg-lib-ice)
	@$(call install_fixup, xorg-lib-ice,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-ice,VERSION,$(XORG_LIB_ICE_VERSION))
	@$(call install_fixup, xorg-lib-ice,SECTION,base)
	@$(call install_fixup, xorg-lib-ice,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-ice,DEPENDS,)
	@$(call install_fixup, xorg-lib-ice,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-ice, 0, 0, 0644, \
		$(XORG_LIB_ICE_DIR)/src/.libs/libICE.so.6.3.0, \
		$(XORG_LIBDIR)/libICE.so.6.3.0)

	@$(call install_link, xorg-lib-ice, \
		libICE.so.6.3.0, \
		$(XORG_LIBDIR)/libICE.so.6)

	@$(call install_link, xorg-lib-ice, \
		libICE.so.6.3.0, \
		$(XORG_LIBDIR)/libICE.so)

	@$(call install_finish, xorg-lib-ice)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-ice_clean:
	rm -rf $(STATEDIR)/xorg-lib-ice.*
	rm -rf $(PKGDIR)/xorg-lib-ice_*
	rm -rf $(XORG_LIB_ICE_DIR)

# vim: syntax=make
