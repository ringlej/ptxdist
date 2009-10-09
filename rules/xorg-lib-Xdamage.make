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
PACKAGES-$(PTXCONF_XORG_LIB_XDAMAGE) += xorg-lib-xdamage

#
# Paths and names
#
XORG_LIB_XDAMAGE_VERSION	:= 1.1.2
XORG_LIB_XDAMAGE		:= libXdamage-$(XORG_LIB_XDAMAGE_VERSION)
XORG_LIB_XDAMAGE_SUFFIX		:= tar.bz2
XORG_LIB_XDAMAGE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX)
XORG_LIB_XDAMAGE_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX)
XORG_LIB_XDAMAGE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XDAMAGE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xdamage_get: $(STATEDIR)/xorg-lib-xdamage.get

$(STATEDIR)/xorg-lib-xdamage.get: $(xorg-lib-xdamage_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XDAMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XDAMAGE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xdamage_extract: $(STATEDIR)/xorg-lib-xdamage.extract

$(STATEDIR)/xorg-lib-xdamage.extract: $(xorg-lib-xdamage_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XDAMAGE_DIR))
	@$(call extract, XORG_LIB_XDAMAGE)
	@$(call patchin, XORG_LIB_XDAMAGE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xdamage_prepare: $(STATEDIR)/xorg-lib-xdamage.prepare

XORG_LIB_XDAMAGE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XDAMAGE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XDAMAGE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-xdamage.prepare: $(xorg-lib-xdamage_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XDAMAGE_DIR)/config.cache)
	cd $(XORG_LIB_XDAMAGE_DIR) && \
		$(XORG_LIB_XDAMAGE_PATH) $(XORG_LIB_XDAMAGE_ENV) \
		./configure $(XORG_LIB_XDAMAGE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xdamage_compile: $(STATEDIR)/xorg-lib-xdamage.compile

$(STATEDIR)/xorg-lib-xdamage.compile: $(xorg-lib-xdamage_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XDAMAGE_DIR) && $(XORG_LIB_XDAMAGE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xdamage_install: $(STATEDIR)/xorg-lib-xdamage.install

$(STATEDIR)/xorg-lib-xdamage.install: $(xorg-lib-xdamage_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XDAMAGE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xdamage_targetinstall: $(STATEDIR)/xorg-lib-xdamage.targetinstall

$(STATEDIR)/xorg-lib-xdamage.targetinstall: $(xorg-lib-xdamage_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xdamage)
	@$(call install_fixup, xorg-lib-xdamage,PACKAGE,xorg-lib-xdamage)
	@$(call install_fixup, xorg-lib-xdamage,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xdamage,VERSION,$(XORG_LIB_XDAMAGE_VERSION))
	@$(call install_fixup, xorg-lib-xdamage,SECTION,base)
	@$(call install_fixup, xorg-lib-xdamage,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xdamage,DEPENDS,)
	@$(call install_fixup, xorg-lib-xdamage,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xdamage, 0, 0, 0644, \
		$(XORG_LIB_XDAMAGE_DIR)/src/.libs/libXdamage.so.1.1.0, \
		$(XORG_LIBDIR)/libXdamage.so.1.1.0)

	@$(call install_link, xorg-lib-xdamage, \
		libXdamage.so.1.1.0, \
		$(XORG_LIBDIR)/libXdamage.so.1)

	@$(call install_link, xorg-lib-xdamage, \
		libXdamage.so.1.1.0, \
		$(XORG_LIBDIR)/libXdamage.so)

	@$(call install_finish, xorg-lib-xdamage)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xdamage_clean:
	rm -rf $(STATEDIR)/xorg-lib-xdamage.*
	rm -rf $(PKGDIR)/xorg-lib-xdamage_*
	rm -rf $(XORG_LIB_XDAMAGE_DIR)

# vim: syntax=make
