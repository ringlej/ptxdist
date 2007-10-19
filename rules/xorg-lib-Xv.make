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
PACKAGES-$(PTXCONF_XORG_LIB_XV) += xorg-lib-Xv

#
# Paths and names
#
XORG_LIB_XV_VERSION	:= 1.0.3
XORG_LIB_XV		:= libXv-$(XORG_LIB_XV_VERSION)
XORG_LIB_XV_SUFFIX	:= tar.bz2
XORG_LIB_XV_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib//$(XORG_LIB_XV).$(XORG_LIB_XV_SUFFIX)
XORG_LIB_XV_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XV).$(XORG_LIB_XV_SUFFIX)
XORG_LIB_XV_DIR		:= $(BUILDDIR)/$(XORG_LIB_XV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xv_get: $(STATEDIR)/xorg-lib-Xv.get

$(STATEDIR)/xorg-lib-Xv.get: $(xorg-lib-Xv_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xv_extract: $(STATEDIR)/xorg-lib-Xv.extract

$(STATEDIR)/xorg-lib-Xv.extract: $(xorg-lib-Xv_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XV_DIR))
	@$(call extract, XORG_LIB_XV)
	@$(call patchin, XORG_LIB_XV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xv_prepare: $(STATEDIR)/xorg-lib-Xv.prepare

XORG_LIB_XV_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XV_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XV_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-Xv.prepare: $(xorg-lib-Xv_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XV_DIR)/config.cache)
	cd $(XORG_LIB_XV_DIR) && \
		$(XORG_LIB_XV_PATH) $(XORG_LIB_XV_ENV) \
		./configure $(XORG_LIB_XV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xv_compile: $(STATEDIR)/xorg-lib-Xv.compile

$(STATEDIR)/xorg-lib-Xv.compile: $(xorg-lib-Xv_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XV_DIR) && $(XORG_LIB_XV_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xv_install: $(STATEDIR)/xorg-lib-Xv.install

$(STATEDIR)/xorg-lib-Xv.install: $(xorg-lib-Xv_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xv_targetinstall: $(STATEDIR)/xorg-lib-Xv.targetinstall

$(STATEDIR)/xorg-lib-Xv.targetinstall: $(xorg-lib-Xv_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xv)
	@$(call install_fixup, xorg-lib-Xv,PACKAGE,xorg-lib-xv)
	@$(call install_fixup, xorg-lib-Xv,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xv,VERSION,$(XORG_LIB_XV_VERSION))
	@$(call install_fixup, xorg-lib-Xv,SECTION,base)
	@$(call install_fixup, xorg-lib-Xv,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xv,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xv,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xv, 0, 0, 0644, \
		$(XORG_LIB_XV_DIR)/src/.libs/libXv.so.1.0.0, \
		$(XORG_LIBDIR)/libXv.so.1.0.0)

	@$(call install_link, xorg-lib-Xv, \
		libXv.so.1.0.0, \
		$(XORG_LIBDIR)/libXv.so.1)

	@$(call install_link, xorg-lib-Xv, \
		libXv.so.1.0.0, \
		$(XORG_LIBDIR)/libXv.so)

	@$(call install_finish, xorg-lib-Xv)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xv_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xv.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xv_*
	rm -rf $(XORG_LIB_XV_DIR)

# vim: syntax=make
