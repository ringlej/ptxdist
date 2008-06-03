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
PACKAGES-$(PTXCONF_XORG_LIB_XSCRNSAVER) += xorg-lib-XScrnSaver

#
# Paths and names
#
XORG_LIB_XSCRNSAVER_VERSION	:= 1.1.2
XORG_LIB_XSCRNSAVER		:= libXScrnSaver-$(XORG_LIB_XSCRNSAVER_VERSION)
XORG_LIB_XSCRNSAVER_SUFFIX	:= tar.bz2
XORG_LIB_XSCRNSAVER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XSCRNSAVER).$(XORG_LIB_XSCRNSAVER_SUFFIX)
XORG_LIB_XSCRNSAVER_DIR		:= $(BUILDDIR)/$(XORG_LIB_XSCRNSAVER)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-XScrnSaver_get: $(STATEDIR)/xorg-lib-XScrnSaver.get

$(STATEDIR)/xorg-lib-XScrnSaver.get: $(xorg-lib-XScrnSaver_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XSCRNSAVER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XSCRNSAVER)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-XScrnSaver_extract: $(STATEDIR)/xorg-lib-XScrnSaver.extract

$(STATEDIR)/xorg-lib-XScrnSaver.extract: $(xorg-lib-XScrnSaver_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XSCRNSAVER_DIR))
	@$(call extract, XORG_LIB_XSCRNSAVER)
	@$(call patchin, XORG_LIB_XSCRNSAVER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-XScrnSaver_prepare: $(STATEDIR)/xorg-lib-XScrnSaver.prepare

XORG_LIB_XSCRNSAVER_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XSCRNSAVER_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XSCRNSAVER_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-XScrnSaver.prepare: $(xorg-lib-XScrnSaver_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XSCRNSAVER_DIR)/config.cache)
	cd $(XORG_LIB_XSCRNSAVER_DIR) && \
		$(XORG_LIB_XSCRNSAVER_PATH) $(XORG_LIB_XSCRNSAVER_ENV) \
		./configure $(XORG_LIB_XSCRNSAVER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-XScrnSaver_compile: $(STATEDIR)/xorg-lib-XScrnSaver.compile

$(STATEDIR)/xorg-lib-XScrnSaver.compile: $(xorg-lib-XScrnSaver_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XSCRNSAVER_DIR) && $(XORG_LIB_XSCRNSAVER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-XScrnSaver_install: $(STATEDIR)/xorg-lib-XScrnSaver.install

$(STATEDIR)/xorg-lib-XScrnSaver.install: $(xorg-lib-XScrnSaver_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XSCRNSAVER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-XScrnSaver_targetinstall: $(STATEDIR)/xorg-lib-XScrnSaver.targetinstall

$(STATEDIR)/xorg-lib-XScrnSaver.targetinstall: $(xorg-lib-XScrnSaver_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-XScrnSaver)
	@$(call install_fixup, xorg-lib-XScrnSaver,PACKAGE,xorg-lib-xscrnsaver)
	@$(call install_fixup, xorg-lib-XScrnSaver,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-XScrnSaver,VERSION,$(XORG_LIB_XSCRNSAVER_VERSION))
	@$(call install_fixup, xorg-lib-XScrnSaver,SECTION,base)
	@$(call install_fixup, xorg-lib-XScrnSaver,AUTHOR,"Erwin rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-XScrnSaver,DEPENDS,)
	@$(call install_fixup, xorg-lib-XScrnSaver,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-XScrnSaver, 0, 0, 0644, \
		$(XORG_LIB_XSCRNSAVER_DIR)/src/.libs/libXss.so.1.0.0, \
		$(XORG_LIBDIR)/libXss.so.1.0.0)

	@$(call install_link, xorg-lib-XScrnSaver, \
		libXss.so.1.0.0, \
		$(XORG_LIBDIR)/libXss.so.1)

	@$(call install_link, xorg-lib-XScrnSaver, \
		libXss.so.1.0.0, \
		$(XORG_LIBDIR)/libXss.so)

	@$(call install_finish, xorg-lib-XScrnSaver)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-XScrnSaver_clean:
	rm -rf $(STATEDIR)/xorg-lib-XScrnSaver.*
	rm -rf $(PKGDIR)/xorg-lib-XScrnSaver_*
	rm -rf $(XORG_LIB_XSCRNSAVER_DIR)

# vim: syntax=make
