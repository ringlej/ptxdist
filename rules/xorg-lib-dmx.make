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
PACKAGES-$(PTXCONF_XORG_LIB_DMX) += xorg-lib-dmx

#
# Paths and names
#
XORG_LIB_DMX_VERSION	:= 1.1.0
XORG_LIB_DMX		:= libdmx-$(XORG_LIB_DMX_VERSION)
XORG_LIB_DMX_SUFFIX	:= tar.bz2
XORG_LIB_DMX_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(XORG_LIB_DMX).$(XORG_LIB_DMX_SUFFIX)
XORG_LIB_DMX_SOURCE	:= $(SRCDIR)/$(XORG_LIB_DMX).$(XORG_LIB_DMX_SUFFIX)
XORG_LIB_DMX_DIR	:= $(BUILDDIR)/$(XORG_LIB_DMX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-dmx_get: $(STATEDIR)/xorg-lib-dmx.get

$(STATEDIR)/xorg-lib-dmx.get: $(xorg-lib-dmx_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_DMX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_DMX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-dmx_extract: $(STATEDIR)/xorg-lib-dmx.extract

$(STATEDIR)/xorg-lib-dmx.extract: $(xorg-lib-dmx_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_DMX_DIR))
	@$(call extract, XORG_LIB_DMX)
	@$(call patchin, XORG_LIB_DMX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-dmx_prepare: $(STATEDIR)/xorg-lib-dmx.prepare

XORG_LIB_DMX_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_DMX_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_DMX_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull \
	--disable-dependency-tracking

$(STATEDIR)/xorg-lib-dmx.prepare: $(xorg-lib-dmx_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_DMX_DIR)/config.cache)
	cd $(XORG_LIB_DMX_DIR) && \
		$(XORG_LIB_DMX_PATH) $(XORG_LIB_DMX_ENV) \
		./configure $(XORG_LIB_DMX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-dmx_compile: $(STATEDIR)/xorg-lib-dmx.compile

$(STATEDIR)/xorg-lib-dmx.compile: $(xorg-lib-dmx_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_DMX_DIR) && $(XORG_LIB_DMX_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-dmx_install: $(STATEDIR)/xorg-lib-dmx.install

$(STATEDIR)/xorg-lib-dmx.install: $(xorg-lib-dmx_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_DMX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-dmx_targetinstall: $(STATEDIR)/xorg-lib-dmx.targetinstall

$(STATEDIR)/xorg-lib-dmx.targetinstall: $(xorg-lib-dmx_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-dmx)
	@$(call install_fixup, xorg-lib-dmx,PACKAGE,xorg-lib-dmx)
	@$(call install_fixup, xorg-lib-dmx,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-dmx,VERSION,$(XORG_LIB_DMX_VERSION))
	@$(call install_fixup, xorg-lib-dmx,SECTION,base)
	@$(call install_fixup, xorg-lib-dmx,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-dmx,DEPENDS,)
	@$(call install_fixup, xorg-lib-dmx,DESCRIPTION,missing)

# FIXME

	@$(call install_finish, xorg-lib-dmx)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-dmx_clean:
	rm -rf $(STATEDIR)/xorg-lib-dmx.*
	rm -rf $(PKGDIR)/xorg-lib-dmx_*
	rm -rf $(XORG_LIB_DMX_DIR)

# vim: syntax=make
