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
PACKAGES-$(PTXCONF_XORG_LIB_XPRINTAPPUTIL) += xorg-lib-XprintAppUtil

#
# Paths and names
#
XORG_LIB_XPRINTAPPUTIL_VERSION	:= 1.0.1
XORG_LIB_XPRINTAPPUTIL		:= libXprintAppUtil-$(XORG_LIB_XPRINTAPPUTIL_VERSION)
XORG_LIB_XPRINTAPPUTIL_SUFFIX	:= tar.bz2
XORG_LIB_XPRINTAPPUTIL_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib//$(XORG_LIB_XPRINTAPPUTIL).$(XORG_LIB_XPRINTAPPUTIL_SUFFIX)
XORG_LIB_XPRINTAPPUTIL_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XPRINTAPPUTIL).$(XORG_LIB_XPRINTAPPUTIL_SUFFIX)
XORG_LIB_XPRINTAPPUTIL_DIR	:= $(BUILDDIR)/$(XORG_LIB_XPRINTAPPUTIL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-XprintAppUtil_get: $(STATEDIR)/xorg-lib-XprintAppUtil.get

$(STATEDIR)/xorg-lib-XprintAppUtil.get: $(xorg-lib-XprintAppUtil_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XPRINTAPPUTIL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XPRINTAPPUTIL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-XprintAppUtil_extract: $(STATEDIR)/xorg-lib-XprintAppUtil.extract

$(STATEDIR)/xorg-lib-XprintAppUtil.extract: $(xorg-lib-XprintAppUtil_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XPRINTAPPUTIL_DIR))
	@$(call extract, XORG_LIB_XPRINTAPPUTIL)
	@$(call patchin, XORG_LIB_XPRINTAPPUTIL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-XprintAppUtil_prepare: $(STATEDIR)/xorg-lib-XprintAppUtil.prepare

XORG_LIB_XPRINTAPPUTIL_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XPRINTAPPUTIL_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XPRINTAPPUTIL_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-XprintAppUtil.prepare: $(xorg-lib-XprintAppUtil_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XPRINTAPPUTIL_DIR)/config.cache)
	cd $(XORG_LIB_XPRINTAPPUTIL_DIR) && \
		$(XORG_LIB_XPRINTAPPUTIL_PATH) $(XORG_LIB_XPRINTAPPUTIL_ENV) \
		./configure $(XORG_LIB_XPRINTAPPUTIL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-XprintAppUtil_compile: $(STATEDIR)/xorg-lib-XprintAppUtil.compile

$(STATEDIR)/xorg-lib-XprintAppUtil.compile: $(xorg-lib-XprintAppUtil_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XPRINTAPPUTIL_DIR) && $(XORG_LIB_XPRINTAPPUTIL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-XprintAppUtil_install: $(STATEDIR)/xorg-lib-XprintAppUtil.install

$(STATEDIR)/xorg-lib-XprintAppUtil.install: $(xorg-lib-XprintAppUtil_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XPRINTAPPUTIL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-XprintAppUtil_targetinstall: $(STATEDIR)/xorg-lib-XprintAppUtil.targetinstall

$(STATEDIR)/xorg-lib-XprintAppUtil.targetinstall: $(xorg-lib-XprintAppUtil_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-XprintAppUtil)
	@$(call install_fixup, xorg-lib-XprintAppUtil,PACKAGE,xorg-lib-xprintapputil)
	@$(call install_fixup, xorg-lib-XprintAppUtil,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-XprintAppUtil,VERSION,$(XORG_LIB_XPRINTAPPUTIL_VERSION))
	@$(call install_fixup, xorg-lib-XprintAppUtil,SECTION,base)
	@$(call install_fixup, xorg-lib-XprintAppUtil,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-XprintAppUtil,DEPENDS,)
	@$(call install_fixup, xorg-lib-XprintAppUtil,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-XprintAppUtil, 0, 0, 0644, \
		$(XORG_LIB_XPRINTAPPUTIL_DIR)/src/.libs/libXprintAppUtil.so.1.0.0, \
		$(XORG_LIBDIR)/libXprintAppUtil.so.1.0.0)

	@$(call install_link, xorg-lib-XprintAppUtil, \
		libXprintAppUtil.so.1.0.0, \
		$(XORG_LIBDIR)/libXprintAppUtil.so.1)

	@$(call install_link, xorg-lib-XprintAppUtil, \
		libXprintAppUtil.so.1.0.0, \
		$(XORG_LIBDIR)/libXprintAppUtil.so)
	@$(call install_finish, xorg-lib-XprintAppUtil)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-XprintAppUtil_clean:
	rm -rf $(STATEDIR)/xorg-lib-XprintAppUtil.*
	rm -rf $(IMAGEDIR)/xorg-lib-XprintAppUtil_*
	rm -rf $(XORG_LIB_XPRINTAPPUTIL_DIR)

# vim: syntax=make
