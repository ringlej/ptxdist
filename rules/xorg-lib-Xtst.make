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
PACKAGES-$(PTXCONF_XORG_LIB_XTST) += xorg-lib-xtst

#
# Paths and names
#
XORG_LIB_XTST_VERSION	:= 1.1.0
XORG_LIB_XTST		:= libXtst-$(XORG_LIB_XTST_VERSION)
XORG_LIB_XTST_SUFFIX	:= tar.bz2
XORG_LIB_XTST_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XTST).$(XORG_LIB_XTST_SUFFIX)
XORG_LIB_XTST_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XTST).$(XORG_LIB_XTST_SUFFIX)
XORG_LIB_XTST_DIR	:= $(BUILDDIR)/$(XORG_LIB_XTST)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xtst_get: $(STATEDIR)/xorg-lib-xtst.get

$(STATEDIR)/xorg-lib-xtst.get: $(xorg-lib-xtst_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XTST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XTST)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xtst_extract: $(STATEDIR)/xorg-lib-xtst.extract

$(STATEDIR)/xorg-lib-xtst.extract: $(xorg-lib-xtst_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTST_DIR))
	@$(call extract, XORG_LIB_XTST)
	@$(call patchin, XORG_LIB_XTST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xtst_prepare: $(STATEDIR)/xorg-lib-xtst.prepare

XORG_LIB_XTST_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XTST_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XTST_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-xtst.prepare: $(xorg-lib-xtst_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTST_DIR)/config.cache)
	cd $(XORG_LIB_XTST_DIR) && \
		$(XORG_LIB_XTST_PATH) $(XORG_LIB_XTST_ENV) \
		./configure $(XORG_LIB_XTST_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xtst_compile: $(STATEDIR)/xorg-lib-xtst.compile

$(STATEDIR)/xorg-lib-xtst.compile: $(xorg-lib-xtst_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XTST_DIR) && $(XORG_LIB_XTST_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xtst_install: $(STATEDIR)/xorg-lib-xtst.install

$(STATEDIR)/xorg-lib-xtst.install: $(xorg-lib-xtst_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XTST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xtst_targetinstall: $(STATEDIR)/xorg-lib-xtst.targetinstall

$(STATEDIR)/xorg-lib-xtst.targetinstall: $(xorg-lib-xtst_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xtst)
	@$(call install_fixup, xorg-lib-xtst,PACKAGE,xorg-lib-xtst)
	@$(call install_fixup, xorg-lib-xtst,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xtst,VERSION,$(XORG_LIB_XTST_VERSION))
	@$(call install_fixup, xorg-lib-xtst,SECTION,base)
	@$(call install_fixup, xorg-lib-xtst,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xtst,DEPENDS,)
	@$(call install_fixup, xorg-lib-xtst,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xtst, 0, 0, 0644, \
		$(XORG_LIB_XTST_DIR)/src/.libs/libXtst.so.6.1.0, \
		$(XORG_LIBDIR)/libXtst.so.6.1.0)

	@$(call install_link, xorg-lib-xtst, \
		libXtst.so.6.1.0, \
		$(XORG_LIBDIR)/libXtst.so.6)

	@$(call install_link, xorg-lib-xtst, \
		libXtst.so.6.1.0, \
		$(XORG_LIBDIR)/libXtst.so)

	@$(call install_finish, xorg-lib-xtst)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xtst_clean:
	rm -rf $(STATEDIR)/xorg-lib-xtst.*
	rm -rf $(PKGDIR)/xorg-lib-xtst_*
	rm -rf $(XORG_LIB_XTST_DIR)

# vim: syntax=make
