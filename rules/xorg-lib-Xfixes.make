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
PACKAGES-$(PTXCONF_XORG_LIB_XFIXES) += xorg-lib-Xfixes

#
# Paths and names
#
XORG_LIB_XFIXES_VERSION	:= 4.0.3
XORG_LIB_XFIXES		:= libXfixes-$(XORG_LIB_XFIXES_VERSION)
XORG_LIB_XFIXES_SUFFIX	:= tar.bz2
XORG_LIB_XFIXES_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XFIXES).$(XORG_LIB_XFIXES_SUFFIX)
XORG_LIB_XFIXES_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFIXES).$(XORG_LIB_XFIXES_SUFFIX)
XORG_LIB_XFIXES_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFIXES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xfixes_get: $(STATEDIR)/xorg-lib-Xfixes.get

$(STATEDIR)/xorg-lib-Xfixes.get: $(xorg-lib-Xfixes_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XFIXES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XFIXES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xfixes_extract: $(STATEDIR)/xorg-lib-Xfixes.extract

$(STATEDIR)/xorg-lib-Xfixes.extract: $(xorg-lib-Xfixes_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFIXES_DIR))
	@$(call extract, XORG_LIB_XFIXES)
	@$(call patchin, XORG_LIB_XFIXES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xfixes_prepare: $(STATEDIR)/xorg-lib-Xfixes.prepare

XORG_LIB_XFIXES_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XFIXES_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFIXES_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-Xfixes.prepare: $(xorg-lib-Xfixes_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFIXES_DIR)/config.cache)
	cd $(XORG_LIB_XFIXES_DIR) && \
		$(XORG_LIB_XFIXES_PATH) $(XORG_LIB_XFIXES_ENV) \
		./configure $(XORG_LIB_XFIXES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xfixes_compile: $(STATEDIR)/xorg-lib-Xfixes.compile

$(STATEDIR)/xorg-lib-Xfixes.compile: $(xorg-lib-Xfixes_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XFIXES_DIR) && $(XORG_LIB_XFIXES_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xfixes_install: $(STATEDIR)/xorg-lib-Xfixes.install

$(STATEDIR)/xorg-lib-Xfixes.install: $(xorg-lib-Xfixes_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XFIXES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xfixes_targetinstall: $(STATEDIR)/xorg-lib-Xfixes.targetinstall

$(STATEDIR)/xorg-lib-Xfixes.targetinstall: $(xorg-lib-Xfixes_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xfixes)
	@$(call install_fixup, xorg-lib-Xfixes,PACKAGE,xorg-lib-xfixes)
	@$(call install_fixup, xorg-lib-Xfixes,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xfixes,VERSION,$(XORG_LIB_XFIXES_VERSION))
	@$(call install_fixup, xorg-lib-Xfixes,SECTION,base)
	@$(call install_fixup, xorg-lib-Xfixes,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xfixes,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xfixes,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xfixes, 0, 0, 0644, \
		$(XORG_LIB_XFIXES_DIR)/src/.libs/libXfixes.so.3.1.0, \
		$(XORG_LIBDIR)/libXfixes.so.3.1.0)

	@$(call install_link, xorg-lib-Xfixes, \
		libXfixes.so.3.1.0, \
		$(XORG_LIBDIR)/libXfixes.so.3)

	@$(call install_link, xorg-lib-Xfixes, \
		libXfixes.so.3.1.0, \
		$(XORG_LIBDIR)/libXfixes.so)

	@$(call install_finish, xorg-lib-Xfixes)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xfixes_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xfixes.*
	rm -rf $(PKGDIR)/xorg-lib-Xfixes_*
	rm -rf $(XORG_LIB_XFIXES_DIR)

# vim: syntax=make
