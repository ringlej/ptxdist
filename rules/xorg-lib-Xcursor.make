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
PACKAGES-$(PTXCONF_XORG_LIB_XCURSOR) += xorg-lib-xcursor

#
# Paths and names
#
XORG_LIB_XCURSOR_VERSION	:= 1.1.10
XORG_LIB_XCURSOR		:= libXcursor-$(XORG_LIB_XCURSOR_VERSION)
XORG_LIB_XCURSOR_SUFFIX		:= tar.bz2
XORG_LIB_XCURSOR_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XCURSOR).$(XORG_LIB_XCURSOR_SUFFIX)
XORG_LIB_XCURSOR_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XCURSOR).$(XORG_LIB_XCURSOR_SUFFIX)
XORG_LIB_XCURSOR_DIR		:= $(BUILDDIR)/$(XORG_LIB_XCURSOR)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xcursor_get: $(STATEDIR)/xorg-lib-xcursor.get

$(STATEDIR)/xorg-lib-xcursor.get: $(xorg-lib-xcursor_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XCURSOR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XCURSOR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xcursor_extract: $(STATEDIR)/xorg-lib-xcursor.extract

$(STATEDIR)/xorg-lib-xcursor.extract: $(xorg-lib-xcursor_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCURSOR_DIR))
	@$(call extract, XORG_LIB_XCURSOR)
	@$(call patchin, XORG_LIB_XCURSOR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xcursor_prepare: $(STATEDIR)/xorg-lib-xcursor.prepare

XORG_LIB_XCURSOR_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XCURSOR_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XCURSOR_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-xcursor.prepare: $(xorg-lib-xcursor_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCURSOR_DIR)/config.cache)
	cd $(XORG_LIB_XCURSOR_DIR) && \
		$(XORG_LIB_XCURSOR_PATH) $(XORG_LIB_XCURSOR_ENV) \
		./configure $(XORG_LIB_XCURSOR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xcursor_compile: $(STATEDIR)/xorg-lib-xcursor.compile

$(STATEDIR)/xorg-lib-xcursor.compile: $(xorg-lib-xcursor_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XCURSOR_DIR) && $(XORG_LIB_XCURSOR_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xcursor_install: $(STATEDIR)/xorg-lib-xcursor.install

$(STATEDIR)/xorg-lib-xcursor.install: $(xorg-lib-xcursor_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XCURSOR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xcursor_targetinstall: $(STATEDIR)/xorg-lib-xcursor.targetinstall

$(STATEDIR)/xorg-lib-xcursor.targetinstall: $(xorg-lib-xcursor_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xcursor)
	@$(call install_fixup, xorg-lib-xcursor,PACKAGE,xorg-lib-xcursor)
	@$(call install_fixup, xorg-lib-xcursor,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xcursor,VERSION,$(XORG_LIB_XCURSOR_VERSION))
	@$(call install_fixup, xorg-lib-xcursor,SECTION,base)
	@$(call install_fixup, xorg-lib-xcursor,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xcursor,DEPENDS,)
	@$(call install_fixup, xorg-lib-xcursor,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xcursor, 0, 0, 0644, \
		$(XORG_LIB_XCURSOR_DIR)/src/.libs/libXcursor.so.1.0.2, \
		$(XORG_LIBDIR)/libXcursor.so.1.0.2)

	@$(call install_link, xorg-lib-xcursor, \
		libXcursor.so.1.0.2, \
		$(XORG_LIBDIR)/libXcursor.so.1)

	@$(call install_link, xorg-lib-xcursor, \
		libXcursor.so.1.0.2, \
		$(XORG_LIBDIR)/libXcursor.so)

	@$(call install_finish, xorg-lib-xcursor)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xcursor_clean:
	rm -rf $(STATEDIR)/xorg-lib-xcursor.*
	rm -rf $(PKGDIR)/xorg-lib-xcursor_*
	rm -rf $(XORG_LIB_XCURSOR_DIR)

# vim: syntax=make
