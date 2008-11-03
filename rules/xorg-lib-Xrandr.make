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
PACKAGES-$(PTXCONF_XORG_LIB_XRANDR) += xorg-lib-xrandr

#
# Paths and names
#
XORG_LIB_XRANDR_VERSION	:= 1.2.2
XORG_LIB_XRANDR		:= libXrandr-$(XORG_LIB_XRANDR_VERSION)
XORG_LIB_XRANDR_SUFFIX	:= tar.bz2
XORG_LIB_XRANDR_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XRANDR).$(XORG_LIB_XRANDR_SUFFIX)
XORG_LIB_XRANDR_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRANDR).$(XORG_LIB_XRANDR_SUFFIX)
XORG_LIB_XRANDR_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRANDR)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xrandr_get: $(STATEDIR)/xorg-lib-xrandr.get

$(STATEDIR)/xorg-lib-xrandr.get: $(xorg-lib-xrandr_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XRANDR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XRANDR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xrandr_extract: $(STATEDIR)/xorg-lib-xrandr.extract

$(STATEDIR)/xorg-lib-xrandr.extract: $(xorg-lib-xrandr_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRANDR_DIR))
	@$(call extract, XORG_LIB_XRANDR)
	@$(call patchin, XORG_LIB_XRANDR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xrandr_prepare: $(STATEDIR)/xorg-lib-xrandr.prepare

XORG_LIB_XRANDR_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XRANDR_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRANDR_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xrandr.prepare: $(xorg-lib-xrandr_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRANDR_DIR)/config.cache)
	cd $(XORG_LIB_XRANDR_DIR) && \
		$(XORG_LIB_XRANDR_PATH) $(XORG_LIB_XRANDR_ENV) \
		./configure $(XORG_LIB_XRANDR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xrandr_compile: $(STATEDIR)/xorg-lib-xrandr.compile

$(STATEDIR)/xorg-lib-xrandr.compile: $(xorg-lib-xrandr_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XRANDR_DIR) && $(XORG_LIB_XRANDR_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xrandr_install: $(STATEDIR)/xorg-lib-xrandr.install

$(STATEDIR)/xorg-lib-xrandr.install: $(xorg-lib-xrandr_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XRANDR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xrandr_targetinstall: $(STATEDIR)/xorg-lib-xrandr.targetinstall

$(STATEDIR)/xorg-lib-xrandr.targetinstall: $(xorg-lib-xrandr_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xrandr)
	@$(call install_fixup, xorg-lib-xrandr,PACKAGE,xorg-lib-xrandr)
	@$(call install_fixup, xorg-lib-xrandr,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xrandr,VERSION,$(XORG_LIB_XRANDR_VERSION))
	@$(call install_fixup, xorg-lib-xrandr,SECTION,base)
	@$(call install_fixup, xorg-lib-xrandr,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xrandr,DEPENDS,)
	@$(call install_fixup, xorg-lib-xrandr,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xrandr, 0, 0, 0644, \
		$(XORG_LIB_XRANDR_DIR)/src/.libs/libXrandr.so.2.1.0, \
		$(XORG_LIBDIR)/libXrandr.so.2.1.0)

	@$(call install_link, xorg-lib-xrandr, \
		libXrandr.so.2.1.0, \
		$(XORG_LIBDIR)/libXrandr.so.2)

	@$(call install_link, xorg-lib-xrandr, \
		libXrandr.so.2.1.0, \
		$(XORG_LIBDIR)/libXrandr.so)

	@$(call install_finish, xorg-lib-xrandr)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xrandr_clean:
	rm -rf $(STATEDIR)/xorg-lib-xrandr.*
	rm -rf $(PKGDIR)/xorg-lib-xrandr_*
	rm -rf $(XORG_LIB_XRANDR_DIR)

# vim: syntax=make
