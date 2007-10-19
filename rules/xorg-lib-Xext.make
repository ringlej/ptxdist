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
PACKAGES-$(PTXCONF_XORG_LIB_XEXT) += xorg-lib-Xext

#
# Paths and names
#
XORG_LIB_XEXT_VERSION	:= 1.0.2
XORG_LIB_XEXT		:= libXext-$(XORG_LIB_XEXT_VERSION)
XORG_LIB_XEXT_SUFFIX	:= tar.bz2
XORG_LIB_XEXT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XEXT).$(XORG_LIB_XEXT_SUFFIX)
XORG_LIB_XEXT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XEXT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xext_get: $(STATEDIR)/xorg-lib-Xext.get

$(STATEDIR)/xorg-lib-Xext.get: $(xorg-lib-Xext_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XEXT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XEXT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xext_extract: $(STATEDIR)/xorg-lib-Xext.extract

$(STATEDIR)/xorg-lib-Xext.extract: $(xorg-lib-Xext_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XEXT_DIR))
	@$(call extract, XORG_LIB_XEXT)
	@$(call patchin, XORG_LIB_XEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xext_prepare: $(STATEDIR)/xorg-lib-Xext.prepare

XORG_LIB_XEXT_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XEXT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XEXT_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_XEXT_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-Xext.prepare: $(xorg-lib-Xext_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XEXT_DIR)/config.cache)
	cd $(XORG_LIB_XEXT_DIR) && \
		$(XORG_LIB_XEXT_PATH) $(XORG_LIB_XEXT_ENV) \
		./configure $(XORG_LIB_XEXT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xext_compile: $(STATEDIR)/xorg-lib-Xext.compile

$(STATEDIR)/xorg-lib-Xext.compile: $(xorg-lib-Xext_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XEXT_DIR) && $(XORG_LIB_XEXT_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xext_install: $(STATEDIR)/xorg-lib-Xext.install

$(STATEDIR)/xorg-lib-Xext.install: $(xorg-lib-Xext_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XEXT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xext_targetinstall: $(STATEDIR)/xorg-lib-Xext.targetinstall

$(STATEDIR)/xorg-lib-Xext.targetinstall: $(xorg-lib-Xext_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xext)
	@$(call install_fixup, xorg-lib-Xext,PACKAGE,xorg-lib-xext)
	@$(call install_fixup, xorg-lib-Xext,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xext,VERSION,$(XORG_LIB_XEXT_VERSION))
	@$(call install_fixup, xorg-lib-Xext,SECTION,base)
	@$(call install_fixup, xorg-lib-Xext,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xext,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xext,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xext, 0, 0, 0644, \
		$(XORG_LIB_XEXT_DIR)/src/.libs/libXext.so.6.4.0, \
		$(XORG_LIBDIR)/libXext.so.6.4.0)

	@$(call install_link, xorg-lib-Xext, \
		libXext.so.6.4.0, \
		$(XORG_LIBDIR)/libXext.so.6)

	@$(call install_link, xorg-lib-Xext, \
		libXext.so.6.4.0, \
		$(XORG_LIBDIR)/libXext.so)

	@$(call install_finish, xorg-lib-Xext)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xext_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xext.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xext_*
	rm -rf $(XORG_LIB_XEXT_DIR)

# vim: syntax=make
