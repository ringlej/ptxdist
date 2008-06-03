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
PACKAGES-$(PTXCONF_XORG_LIB_XEVIE) += xorg-lib-Xevie

#
# Paths and names
#
XORG_LIB_XEVIE_VERSION	:= 1.0.2
XORG_LIB_XEVIE		:= libXevie-$(XORG_LIB_XEVIE_VERSION)
XORG_LIB_XEVIE_SUFFIX	:= tar.bz2
XORG_LIB_XEVIE_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XEVIE).$(XORG_LIB_XEVIE_SUFFIX)
XORG_LIB_XEVIE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XEVIE).$(XORG_LIB_XEVIE_SUFFIX)
XORG_LIB_XEVIE_DIR	:= $(BUILDDIR)/$(XORG_LIB_XEVIE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xevie_get: $(STATEDIR)/xorg-lib-Xevie.get

$(STATEDIR)/xorg-lib-Xevie.get: $(xorg-lib-Xevie_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XEVIE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XEVIE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xevie_extract: $(STATEDIR)/xorg-lib-Xevie.extract

$(STATEDIR)/xorg-lib-Xevie.extract: $(xorg-lib-Xevie_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XEVIE_DIR))
	@$(call extract, XORG_LIB_XEVIE)
	@$(call patchin, XORG_LIB_XEVIE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xevie_prepare: $(STATEDIR)/xorg-lib-Xevie.prepare

XORG_LIB_XEVIE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XEVIE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XEVIE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-Xevie.prepare: $(xorg-lib-Xevie_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XEVIE_DIR)/config.cache)
	cd $(XORG_LIB_XEVIE_DIR) && \
		$(XORG_LIB_XEVIE_PATH) $(XORG_LIB_XEVIE_ENV) \
		./configure $(XORG_LIB_XEVIE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xevie_compile: $(STATEDIR)/xorg-lib-Xevie.compile

$(STATEDIR)/xorg-lib-Xevie.compile: $(xorg-lib-Xevie_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XEVIE_DIR) && $(XORG_LIB_XEVIE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xevie_install: $(STATEDIR)/xorg-lib-Xevie.install

$(STATEDIR)/xorg-lib-Xevie.install: $(xorg-lib-Xevie_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XEVIE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xevie_targetinstall: $(STATEDIR)/xorg-lib-Xevie.targetinstall

$(STATEDIR)/xorg-lib-Xevie.targetinstall: $(xorg-lib-Xevie_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xevie)
	@$(call install_fixup, xorg-lib-Xevie,PACKAGE,xorg-lib-xevie)
	@$(call install_fixup, xorg-lib-Xevie,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xevie,VERSION,$(XORG_LIB_XEVIE_VERSION))
	@$(call install_fixup, xorg-lib-Xevie,SECTION,base)
	@$(call install_fixup, xorg-lib-Xevie,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xevie,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xevie,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xevie, 0, 0, 0644, \
		$(XORG_LIB_XEVIE_DIR)/src/.libs/libXevie.so.1.0.0, \
		$(XORG_LIBDIR)/libXevie.so.1.0.0)

	@$(call install_link, xorg-lib-Xevie, \
		libXevie.so.1.0.0, \
		$(XORG_LIBDIR)/libXevie.so.1)

	@$(call install_link, xorg-lib-Xevie, \
		libXevie.so.1.0.0, \
		$(XORG_LIBDIR)/libXevie.so)

	@$(call install_finish, xorg-lib-Xevie)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xevie_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xevie.*
	rm -rf $(PKGDIR)/xorg-lib-Xevie_*
	rm -rf $(XORG_LIB_XEVIE_DIR)

# vim: syntax=make
