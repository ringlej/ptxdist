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
PACKAGES-$(PTXCONF_XORG_LIB_XINERAMA) += xorg-lib-xinerama

#
# Paths and names
#
XORG_LIB_XINERAMA_VERSION	:= 1.1
XORG_LIB_XINERAMA		:= libXinerama-$(XORG_LIB_XINERAMA_VERSION)
XORG_LIB_XINERAMA_SUFFIX	:= tar.bz2
XORG_LIB_XINERAMA_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XINERAMA).$(XORG_LIB_XINERAMA_SUFFIX)
XORG_LIB_XINERAMA_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XINERAMA).$(XORG_LIB_XINERAMA_SUFFIX)
XORG_LIB_XINERAMA_DIR		:= $(BUILDDIR)/$(XORG_LIB_XINERAMA)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xinerama_get: $(STATEDIR)/xorg-lib-xinerama.get

$(STATEDIR)/xorg-lib-xinerama.get: $(xorg-lib-xinerama_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XINERAMA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XINERAMA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xinerama_extract: $(STATEDIR)/xorg-lib-xinerama.extract

$(STATEDIR)/xorg-lib-xinerama.extract: $(xorg-lib-xinerama_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XINERAMA_DIR))
	@$(call extract, XORG_LIB_XINERAMA)
	@$(call patchin, XORG_LIB_XINERAMA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xinerama_prepare: $(STATEDIR)/xorg-lib-xinerama.prepare

XORG_LIB_XINERAMA_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XINERAMA_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XINERAMA_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xinerama.prepare: $(xorg-lib-xinerama_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XINERAMA_DIR)/config.cache)
	cd $(XORG_LIB_XINERAMA_DIR) && \
		$(XORG_LIB_XINERAMA_PATH) $(XORG_LIB_XINERAMA_ENV) \
		./configure $(XORG_LIB_XINERAMA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xinerama_compile: $(STATEDIR)/xorg-lib-xinerama.compile

$(STATEDIR)/xorg-lib-xinerama.compile: $(xorg-lib-xinerama_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XINERAMA_DIR) && $(XORG_LIB_XINERAMA_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xinerama_install: $(STATEDIR)/xorg-lib-xinerama.install

$(STATEDIR)/xorg-lib-xinerama.install: $(xorg-lib-xinerama_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XINERAMA)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xinerama_targetinstall: $(STATEDIR)/xorg-lib-xinerama.targetinstall

$(STATEDIR)/xorg-lib-xinerama.targetinstall: $(xorg-lib-xinerama_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xinerama)
	@$(call install_fixup, xorg-lib-xinerama,PACKAGE,xorg-lib-xinerama)
	@$(call install_fixup, xorg-lib-xinerama,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xinerama,VERSION,$(XORG_LIB_XINERAMA_VERSION))
	@$(call install_fixup, xorg-lib-xinerama,SECTION,base)
	@$(call install_fixup, xorg-lib-xinerama,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xinerama,DEPENDS,)
	@$(call install_fixup, xorg-lib-xinerama,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xinerama, 0, 0, 0644, \
		$(XORG_LIB_XINERAMA_DIR)/src/.libs/libXinerama.so.1.0.0, \
		$(XORG_LIBDIR)/libXinerama.so.1.0.0)

	@$(call install_link, xorg-lib-xinerama, \
		libXinerama.so.1.0.0, \
		$(XORG_LIBDIR)/libXinerama.so.1)

	@$(call install_link, xorg-lib-xinerama, \
		libXinerama.so.1.0.0, \
		$(XORG_LIBDIR)/libXinerama.so)

	@$(call install_finish, xorg-lib-xinerama)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xinerama_clean:
	rm -rf $(STATEDIR)/xorg-lib-xinerama.*
	rm -rf $(PKGDIR)/xorg-lib-xinerama_*
	rm -rf $(XORG_LIB_XINERAMA_DIR)

# vim: syntax=make
