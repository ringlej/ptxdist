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
PACKAGES-$(PTXCONF_XORG_LIB_XCURSOR) += xorg-lib-Xcursor

#
# Paths and names
#
XORG_LIB_XCURSOR_VERSION	:= 1.1.9
XORG_LIB_XCURSOR		:= libXcursor-$(XORG_LIB_XCURSOR_VERSION)
XORG_LIB_XCURSOR_SUFFIX		:= tar.bz2
XORG_LIB_XCURSOR_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XCURSOR).$(XORG_LIB_XCURSOR_SUFFIX)
XORG_LIB_XCURSOR_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XCURSOR).$(XORG_LIB_XCURSOR_SUFFIX)
XORG_LIB_XCURSOR_DIR		:= $(BUILDDIR)/$(XORG_LIB_XCURSOR)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xcursor_get: $(STATEDIR)/xorg-lib-Xcursor.get

$(STATEDIR)/xorg-lib-Xcursor.get: $(xorg-lib-Xcursor_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XCURSOR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XCURSOR)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xcursor_extract: $(STATEDIR)/xorg-lib-Xcursor.extract

$(STATEDIR)/xorg-lib-Xcursor.extract: $(xorg-lib-Xcursor_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCURSOR_DIR))
	@$(call extract, XORG_LIB_XCURSOR)
	@$(call patchin, XORG_LIB_XCURSOR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xcursor_prepare: $(STATEDIR)/xorg-lib-Xcursor.prepare

XORG_LIB_XCURSOR_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XCURSOR_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XCURSOR_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-Xcursor.prepare: $(xorg-lib-Xcursor_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCURSOR_DIR)/config.cache)
	cd $(XORG_LIB_XCURSOR_DIR) && \
		$(XORG_LIB_XCURSOR_PATH) $(XORG_LIB_XCURSOR_ENV) \
		./configure $(XORG_LIB_XCURSOR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xcursor_compile: $(STATEDIR)/xorg-lib-Xcursor.compile

$(STATEDIR)/xorg-lib-Xcursor.compile: $(xorg-lib-Xcursor_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XCURSOR_DIR) && $(XORG_LIB_XCURSOR_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xcursor_install: $(STATEDIR)/xorg-lib-Xcursor.install

$(STATEDIR)/xorg-lib-Xcursor.install: $(xorg-lib-Xcursor_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XCURSOR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xcursor_targetinstall: $(STATEDIR)/xorg-lib-Xcursor.targetinstall

$(STATEDIR)/xorg-lib-Xcursor.targetinstall: $(xorg-lib-Xcursor_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xcursor)
	@$(call install_fixup, xorg-lib-Xcursor,PACKAGE,xorg-lib-xcursor)
	@$(call install_fixup, xorg-lib-Xcursor,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xcursor,VERSION,$(XORG_LIB_XCURSOR_VERSION))
	@$(call install_fixup, xorg-lib-Xcursor,SECTION,base)
	@$(call install_fixup, xorg-lib-Xcursor,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xcursor,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xcursor,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xcursor, 0, 0, 0644, \
		$(XORG_LIB_XCURSOR_DIR)/src/.libs/libXcursor.so.1.0.2, \
		$(XORG_LIBDIR)/libXcursor.so.1.0.2)

	@$(call install_link, xorg-lib-Xcursor, \
		libXcursor.so.1.0.2, \
		$(XORG_LIBDIR)/libXcursor.so.1)

	@$(call install_link, xorg-lib-Xcursor, \
		libXcursor.so.1.0.2, \
		$(XORG_LIBDIR)/libXcursor.so)

	@$(call install_finish, xorg-lib-Xcursor)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xcursor_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xcursor.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xcursor_*
	rm -rf $(XORG_LIB_XCURSOR_DIR)

# vim: syntax=make
