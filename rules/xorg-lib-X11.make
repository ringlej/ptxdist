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
PACKAGES-$(PTXCONF_XORG_LIB_X11) += xorg-lib-X11

#
# Paths and names
#
XORG_LIB_X11_VERSION	:= 1.0.0
XORG_LIB_X11		:= libX11-X11R7.0-$(XORG_LIB_X11_VERSION)
XORG_LIB_X11_SUFFIX	:= tar.bz2
XORG_LIB_X11_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/lib//$(XORG_LIB_X11).$(XORG_LIB_X11_SUFFIX)
XORG_LIB_X11_SOURCE	:= $(SRCDIR)/$(XORG_LIB_X11).$(XORG_LIB_X11_SUFFIX)
XORG_LIB_X11_DIR	:= $(BUILDDIR)/$(XORG_LIB_X11)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-X11_get: $(STATEDIR)/xorg-lib-X11.get

$(STATEDIR)/xorg-lib-X11.get: $(xorg-lib-X11_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_X11_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_LIB_X11_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-X11_extract: $(STATEDIR)/xorg-lib-X11.extract

$(STATEDIR)/xorg-lib-X11.extract: $(xorg-lib-X11_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_X11_DIR))
	@$(call extract, $(XORG_LIB_X11_SOURCE))
	@$(call patchin, $(XORG_LIB_X11))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-X11_prepare: $(STATEDIR)/xorg-lib-X11.prepare

XORG_LIB_X11_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_X11_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_X11_AUTOCONF := $(CROSS_AUTOCONF_USR)

XORG_LIB_X11_AUTOCONF += --disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-X11.prepare: $(xorg-lib-X11_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_X11_DIR)/config.cache)
	cd $(XORG_LIB_X11_DIR) && \
		$(XORG_LIB_X11_PATH) $(XORG_LIB_X11_ENV) \
		./configure $(XORG_LIB_X11_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-X11_compile: $(STATEDIR)/xorg-lib-X11.compile

$(STATEDIR)/xorg-lib-X11.compile: $(xorg-lib-X11_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_X11_DIR) && $(XORG_LIB_X11_PATH) $(XORG_LIB_X11_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-X11_install: $(STATEDIR)/xorg-lib-X11.install

$(STATEDIR)/xorg-lib-X11.install: $(xorg-lib-X11_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_X11)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-X11_targetinstall: $(STATEDIR)/xorg-lib-X11.targetinstall

$(STATEDIR)/xorg-lib-X11.targetinstall: $(xorg-lib-X11_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-lib-X11)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_LIB_X11_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, \
		$(XORG_LIB_X11_DIR)/src/.libs/libX11.so.6.2.0, \
		$(XORG_LIBDIR)/libX11.so.6.2.0)

	@$(call install_link, \
		libX11.so.6.2.0, \
		$(XORG_LIBDIR)/libX11.so.6)

	@$(call install_link, \
		libX11.so.6.2.0, \
		$(XORG_LIBDIR)/libX11.so)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-X11_clean:
	rm -rf $(STATEDIR)/xorg-lib-X11.*
	rm -rf $(IMAGEDIR)/xorg-lib-X11_*
	rm -rf $(XORG_LIB_X11_DIR)

# vim: syntax=make
