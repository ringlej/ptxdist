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
PACKAGES-$(PTXCONF_XORG_LIB_XV) += xorg-lib-xv

#
# Paths and names
#
XORG_LIB_XV_VERSION	:= 1.0.5
XORG_LIB_XV		:= libXv-$(XORG_LIB_XV_VERSION)
XORG_LIB_XV_SUFFIX	:= tar.bz2
XORG_LIB_XV_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib//$(XORG_LIB_XV).$(XORG_LIB_XV_SUFFIX)
XORG_LIB_XV_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XV).$(XORG_LIB_XV_SUFFIX)
XORG_LIB_XV_DIR		:= $(BUILDDIR)/$(XORG_LIB_XV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xv_get: $(STATEDIR)/xorg-lib-xv.get

$(STATEDIR)/xorg-lib-xv.get: $(xorg-lib-xv_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xv_extract: $(STATEDIR)/xorg-lib-xv.extract

$(STATEDIR)/xorg-lib-xv.extract: $(xorg-lib-xv_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XV_DIR))
	@$(call extract, XORG_LIB_XV)
	@$(call patchin, XORG_LIB_XV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xv_prepare: $(STATEDIR)/xorg-lib-xv.prepare

XORG_LIB_XV_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XV_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XV_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xv.prepare: $(xorg-lib-xv_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XV_DIR)/config.cache)
	cd $(XORG_LIB_XV_DIR) && \
		$(XORG_LIB_XV_PATH) $(XORG_LIB_XV_ENV) \
		./configure $(XORG_LIB_XV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xv_compile: $(STATEDIR)/xorg-lib-xv.compile

$(STATEDIR)/xorg-lib-xv.compile: $(xorg-lib-xv_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XV_DIR) && $(XORG_LIB_XV_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xv_install: $(STATEDIR)/xorg-lib-xv.install

$(STATEDIR)/xorg-lib-xv.install: $(xorg-lib-xv_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xv_targetinstall: $(STATEDIR)/xorg-lib-xv.targetinstall

$(STATEDIR)/xorg-lib-xv.targetinstall: $(xorg-lib-xv_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xv)
	@$(call install_fixup, xorg-lib-xv,PACKAGE,xorg-lib-xv)
	@$(call install_fixup, xorg-lib-xv,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xv,VERSION,$(XORG_LIB_XV_VERSION))
	@$(call install_fixup, xorg-lib-xv,SECTION,base)
	@$(call install_fixup, xorg-lib-xv,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xv,DEPENDS,)
	@$(call install_fixup, xorg-lib-xv,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xv, 0, 0, 0644, \
		$(XORG_LIB_XV_DIR)/src/.libs/libXv.so.1.0.0, \
		$(XORG_LIBDIR)/libXv.so.1.0.0)

	@$(call install_link, xorg-lib-xv, \
		libXv.so.1.0.0, \
		$(XORG_LIBDIR)/libXv.so.1)

	@$(call install_link, xorg-lib-xv, \
		libXv.so.1.0.0, \
		$(XORG_LIBDIR)/libXv.so)

	@$(call install_finish, xorg-lib-xv)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xv_clean:
	rm -rf $(STATEDIR)/xorg-lib-xv.*
	rm -rf $(PKGDIR)/xorg-lib-xv_*
	rm -rf $(XORG_LIB_XV_DIR)

# vim: syntax=make
