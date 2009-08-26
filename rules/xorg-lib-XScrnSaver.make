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
PACKAGES-$(PTXCONF_XORG_LIB_XSCRNSAVER) += xorg-lib-xscrnsaver

#
# Paths and names
#
XORG_LIB_XSCRNSAVER_VERSION	:= 1.2.0
XORG_LIB_XSCRNSAVER		:= libXScrnSaver-$(XORG_LIB_XSCRNSAVER_VERSION)
XORG_LIB_XSCRNSAVER_SUFFIX	:= tar.bz2
XORG_LIB_XSCRNSAVER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XSCRNSAVER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xscrnsaver_get: $(STATEDIR)/xorg-lib-xscrnsaver.get

$(STATEDIR)/xorg-lib-xscrnsaver.get: $(xorg-lib-xscrnsaver_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XSCRNSAVER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XSCRNSAVER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xscrnsaver_extract: $(STATEDIR)/xorg-lib-xscrnsaver.extract

$(STATEDIR)/xorg-lib-xscrnsaver.extract: $(xorg-lib-xscrnsaver_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XSCRNSAVER_DIR))
	@$(call extract, XORG_LIB_XSCRNSAVER)
	@$(call patchin, XORG_LIB_XSCRNSAVER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xscrnsaver_prepare: $(STATEDIR)/xorg-lib-xscrnsaver.prepare

XORG_LIB_XSCRNSAVER_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XSCRNSAVER_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XSCRNSAVER_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xscrnsaver.prepare: $(xorg-lib-xscrnsaver_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XSCRNSAVER_DIR)/config.cache)
	cd $(XORG_LIB_XSCRNSAVER_DIR) && \
		$(XORG_LIB_XSCRNSAVER_PATH) $(XORG_LIB_XSCRNSAVER_ENV) \
		./configure $(XORG_LIB_XSCRNSAVER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xscrnsaver_compile: $(STATEDIR)/xorg-lib-xscrnsaver.compile

$(STATEDIR)/xorg-lib-xscrnsaver.compile: $(xorg-lib-xscrnsaver_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XSCRNSAVER_DIR) && $(XORG_LIB_XSCRNSAVER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xscrnsaver_install: $(STATEDIR)/xorg-lib-xscrnsaver.install

$(STATEDIR)/xorg-lib-xscrnsaver.install: $(xorg-lib-xscrnsaver_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XSCRNSAVER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xscrnsaver_targetinstall: $(STATEDIR)/xorg-lib-xscrnsaver.targetinstall

$(STATEDIR)/xorg-lib-xscrnsaver.targetinstall: $(xorg-lib-xscrnsaver_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xscrnsaver)
	@$(call install_fixup, xorg-lib-xscrnsaver,PACKAGE,xorg-lib-xscrnsaver)
	@$(call install_fixup, xorg-lib-xscrnsaver,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xscrnsaver,VERSION,$(XORG_LIB_XSCRNSAVER_VERSION))
	@$(call install_fixup, xorg-lib-xscrnsaver,SECTION,base)
	@$(call install_fixup, xorg-lib-xscrnsaver,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xscrnsaver,DEPENDS,)
	@$(call install_fixup, xorg-lib-xscrnsaver,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xscrnsaver, 0, 0, 0644, \
		$(XORG_LIB_XSCRNSAVER_DIR)/src/.libs/libXss.so.1.0.0, \
		$(XORG_LIBDIR)/libXss.so.1.0.0)

	@$(call install_link, xorg-lib-xscrnsaver, \
		libXss.so.1.0.0, \
		$(XORG_LIBDIR)/libXss.so.1)

	@$(call install_link, xorg-lib-xscrnsaver, \
		libXss.so.1.0.0, \
		$(XORG_LIBDIR)/libXss.so)

	@$(call install_finish, xorg-lib-xscrnsaver)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xscrnsaver_clean:
	rm -rf $(STATEDIR)/xorg-lib-xscrnsaver.*
	rm -rf $(PKGDIR)/xorg-lib-xscrnsaver_*
	rm -rf $(XORG_LIB_XSCRNSAVER_DIR)

# vim: syntax=make
