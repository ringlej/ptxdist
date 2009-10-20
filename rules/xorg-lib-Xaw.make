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
PACKAGES-$(PTXCONF_XORG_LIB_XAW) += xorg-lib-xaw

#
# Paths and names
#
XORG_LIB_XAW_VERSION	:= 1.0.7
XORG_LIB_XAW		:= libXaw-$(XORG_LIB_XAW_VERSION)
XORG_LIB_XAW_SUFFIX	:= tar.bz2
XORG_LIB_XAW_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XAW).$(XORG_LIB_XAW_SUFFIX)
XORG_LIB_XAW_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XAW).$(XORG_LIB_XAW_SUFFIX)
XORG_LIB_XAW_DIR	:= $(BUILDDIR)/$(XORG_LIB_XAW)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xaw_get: $(STATEDIR)/xorg-lib-xaw.get

$(STATEDIR)/xorg-lib-xaw.get: $(xorg-lib-xaw_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XAW_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XAW)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xaw_extract: $(STATEDIR)/xorg-lib-xaw.extract

$(STATEDIR)/xorg-lib-xaw.extract: $(xorg-lib-xaw_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XAW_DIR))
	@$(call extract, XORG_LIB_XAW)
	@$(call patchin, XORG_LIB_XAW)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xaw_prepare: $(STATEDIR)/xorg-lib-xaw.prepare

XORG_LIB_XAW_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XAW_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XAW_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--disable-docs

ifdef PTXCONF_XORG_LIB_XAW_V6
XORG_LIB_XAW_AUTOCONF += --enable-xaw6
else
XORG_LIB_XAW_AUTOCONF += --disable-xaw6
endif

ifdef PTXCONF_XORG_LIB_XAW_V7
XORG_LIB_XAW_AUTOCONF += --enable-xaw7
else
XORG_LIB_XAW_AUTOCONF += --disable-xaw7
endif

$(STATEDIR)/xorg-lib-xaw.prepare: $(xorg-lib-xaw_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XAW_DIR)/config.cache)
	cd $(XORG_LIB_XAW_DIR) && \
		$(XORG_LIB_XAW_PATH) $(XORG_LIB_XAW_ENV) \
		./configure $(XORG_LIB_XAW_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xaw_compile: $(STATEDIR)/xorg-lib-xaw.compile

$(STATEDIR)/xorg-lib-xaw.compile: $(xorg-lib-xaw_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XAW_DIR) && $(XORG_LIB_XAW_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xaw_install: $(STATEDIR)/xorg-lib-xaw.install

$(STATEDIR)/xorg-lib-xaw.install: $(xorg-lib-xaw_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XAW)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xaw_targetinstall: $(STATEDIR)/xorg-lib-xaw.targetinstall

$(STATEDIR)/xorg-lib-xaw.targetinstall: $(xorg-lib-xaw_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xaw)
	@$(call install_fixup, xorg-lib-xaw,PACKAGE,xorg-lib-xaw)
	@$(call install_fixup, xorg-lib-xaw,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xaw,VERSION,$(XORG_LIB_XAW_VERSION))
	@$(call install_fixup, xorg-lib-xaw,SECTION,base)
	@$(call install_fixup, xorg-lib-xaw,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xaw,DEPENDS,)
	@$(call install_fixup, xorg-lib-xaw,DESCRIPTION,missing)

ifdef PTXCONF_XORG_LIB_XAW_V6
	@$(call install_copy, xorg-lib-xaw, 0, 0, 0644, \
		$(XORG_LIB_XAW_DIR)/src/.libs/libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw6.so.6.0.1)

	@$(call install_link, xorg-lib-xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw6.so.6)

	@$(call install_link, xorg-lib-xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw6.so)

	@$(call install_link, xorg-lib-xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw.so.6)
endif

ifdef PTXCONF_XORG_LIB_XAW_V7
	@$(call install_copy, xorg-lib-xaw, 0, 0, 0644, \
		$(XORG_LIB_XAW_DIR)/src/.libs/libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw7.so.7.0.0)

	@$(call install_link, xorg-lib-xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw7.so.7)

	@$(call install_link, xorg-lib-xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw7.so)

	@$(call install_link, xorg-lib-xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw.so.7)
endif

	@$(call install_finish, xorg-lib-xaw)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xaw_clean:
	rm -rf $(STATEDIR)/xorg-lib-xaw.*
	rm -rf $(PKGDIR)/xorg-lib-xaw_*
	rm -rf $(XORG_LIB_XAW_DIR)

# vim: syntax=make
