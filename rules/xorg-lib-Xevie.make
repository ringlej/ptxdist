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
PACKAGES-$(PTXCONF_XORG_LIB_XEVIE) += xorg-lib-xevie

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

xorg-lib-xevie_get: $(STATEDIR)/xorg-lib-xevie.get

$(STATEDIR)/xorg-lib-xevie.get: $(xorg-lib-xevie_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XEVIE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XEVIE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xevie_extract: $(STATEDIR)/xorg-lib-xevie.extract

$(STATEDIR)/xorg-lib-xevie.extract: $(xorg-lib-xevie_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XEVIE_DIR))
	@$(call extract, XORG_LIB_XEVIE)
	@$(call patchin, XORG_LIB_XEVIE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xevie_prepare: $(STATEDIR)/xorg-lib-xevie.prepare

XORG_LIB_XEVIE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XEVIE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XEVIE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xevie.prepare: $(xorg-lib-xevie_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XEVIE_DIR)/config.cache)
	cd $(XORG_LIB_XEVIE_DIR) && \
		$(XORG_LIB_XEVIE_PATH) $(XORG_LIB_XEVIE_ENV) \
		./configure $(XORG_LIB_XEVIE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xevie_compile: $(STATEDIR)/xorg-lib-xevie.compile

$(STATEDIR)/xorg-lib-xevie.compile: $(xorg-lib-xevie_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XEVIE_DIR) && $(XORG_LIB_XEVIE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xevie_install: $(STATEDIR)/xorg-lib-xevie.install

$(STATEDIR)/xorg-lib-xevie.install: $(xorg-lib-xevie_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XEVIE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xevie_targetinstall: $(STATEDIR)/xorg-lib-xevie.targetinstall

$(STATEDIR)/xorg-lib-xevie.targetinstall: $(xorg-lib-xevie_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xevie)
	@$(call install_fixup, xorg-lib-xevie,PACKAGE,xorg-lib-xevie)
	@$(call install_fixup, xorg-lib-xevie,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xevie,VERSION,$(XORG_LIB_XEVIE_VERSION))
	@$(call install_fixup, xorg-lib-xevie,SECTION,base)
	@$(call install_fixup, xorg-lib-xevie,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xevie,DEPENDS,)
	@$(call install_fixup, xorg-lib-xevie,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xevie, 0, 0, 0644, \
		$(XORG_LIB_XEVIE_DIR)/src/.libs/libXevie.so.1.0.0, \
		$(XORG_LIBDIR)/libXevie.so.1.0.0)

	@$(call install_link, xorg-lib-xevie, \
		libXevie.so.1.0.0, \
		$(XORG_LIBDIR)/libXevie.so.1)

	@$(call install_link, xorg-lib-xevie, \
		libXevie.so.1.0.0, \
		$(XORG_LIBDIR)/libXevie.so)

	@$(call install_finish, xorg-lib-xevie)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xevie_clean:
	rm -rf $(STATEDIR)/xorg-lib-xevie.*
	rm -rf $(PKGDIR)/xorg-lib-xevie_*
	rm -rf $(XORG_LIB_XEVIE_DIR)

# vim: syntax=make
