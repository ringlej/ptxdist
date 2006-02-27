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
PACKAGES-$(PTXCONF_XORG_LIB_XAW) += xorg-lib-Xaw

#
# Paths and names
#
XORG_LIB_XAW_VERSION	:= 1.0.1
XORG_LIB_XAW		:= libXaw-X11R7.0-$(XORG_LIB_XAW_VERSION)
XORG_LIB_XAW_SUFFIX	:= tar.bz2
XORG_LIB_XAW_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/lib//$(XORG_LIB_XAW).$(XORG_LIB_XAW_SUFFIX)
XORG_LIB_XAW_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XAW).$(XORG_LIB_XAW_SUFFIX)
XORG_LIB_XAW_DIR	:= $(BUILDDIR)/$(XORG_LIB_XAW)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xaw_get: $(STATEDIR)/xorg-lib-Xaw.get

$(STATEDIR)/xorg-lib-Xaw.get: $(xorg-lib-Xaw_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XAW_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_LIB_XAW_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xaw_extract: $(STATEDIR)/xorg-lib-Xaw.extract

$(STATEDIR)/xorg-lib-Xaw.extract: $(xorg-lib-Xaw_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XAW_DIR))
	@$(call extract, $(XORG_LIB_XAW_SOURCE))
	@$(call patchin, $(XORG_LIB_XAW))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xaw_prepare: $(STATEDIR)/xorg-lib-Xaw.prepare

XORG_LIB_XAW_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XAW_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XAW_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-Xaw.prepare: $(xorg-lib-Xaw_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XAW_DIR)/config.cache)
	cd $(XORG_LIB_XAW_DIR) && \
		$(XORG_LIB_XAW_PATH) $(XORG_LIB_XAW_ENV) \
		./configure $(XORG_LIB_XAW_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xaw_compile: $(STATEDIR)/xorg-lib-Xaw.compile

$(STATEDIR)/xorg-lib-Xaw.compile: $(xorg-lib-Xaw_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XAW_DIR) && $(XORG_LIB_XAW_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xaw_install: $(STATEDIR)/xorg-lib-Xaw.install

$(STATEDIR)/xorg-lib-Xaw.install: $(xorg-lib-Xaw_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XAW)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xaw_targetinstall: $(STATEDIR)/xorg-lib-Xaw.targetinstall

$(STATEDIR)/xorg-lib-Xaw.targetinstall: $(xorg-lib-Xaw_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xaw)
	@$(call install_fixup, xorg-lib-Xaw,PACKAGE,xorg-lib-xaw)
	@$(call install_fixup, xorg-lib-Xaw,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xaw,VERSION,$(XORG_LIB_XAW_VERSION))
	@$(call install_fixup, xorg-lib-Xaw,SECTION,base)
	@$(call install_fixup, xorg-lib-Xaw,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xaw,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xaw,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xaw, 0, 0, 0644, \
		$(XORG_LIB_XAW_DIR)/src/.libs/libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw6.so.6.0.1)

	@$(call install_link, xorg-lib-Xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw6.so.6)

	@$(call install_link, xorg-lib-Xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw6.so)

	@$(call install_link, xorg-lib-Xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw.so.6)

	@$(call install_copy, xorg-lib-Xaw, 0, 0, 0644, \
		$(XORG_LIB_XAW_DIR)/src/.libs/libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw7.so.7.0.0)

	@$(call install_link, xorg-lib-Xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw7.so.7)

	@$(call install_link, xorg-lib-Xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw7.so)

	@$(call install_link, xorg-lib-Xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw.so.7)

	@$(call install_finish, xorg-lib-Xaw)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xaw_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xaw.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xaw_*
	rm -rf $(XORG_LIB_XAW_DIR)

# vim: syntax=make
