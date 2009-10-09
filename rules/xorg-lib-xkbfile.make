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
PACKAGES-$(PTXCONF_XORG_LIB_XKBFILE) += xorg-lib-xkbfile

#
# Paths and names
#
XORG_LIB_XKBFILE_VERSION	:= 1.0.6
XORG_LIB_XKBFILE		:= libxkbfile-$(XORG_LIB_XKBFILE_VERSION)
XORG_LIB_XKBFILE_SUFFIX		:= tar.bz2
XORG_LIB_XKBFILE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XKBFILE).$(XORG_LIB_XKBFILE_SUFFIX)
XORG_LIB_XKBFILE_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XKBFILE).$(XORG_LIB_XKBFILE_SUFFIX)
XORG_LIB_XKBFILE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XKBFILE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xkbfile_get: $(STATEDIR)/xorg-lib-xkbfile.get

$(STATEDIR)/xorg-lib-xkbfile.get: $(xorg-lib-xkbfile_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XKBFILE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XKBFILE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xkbfile_extract: $(STATEDIR)/xorg-lib-xkbfile.extract

$(STATEDIR)/xorg-lib-xkbfile.extract: $(xorg-lib-xkbfile_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XKBFILE_DIR))
	@$(call extract, XORG_LIB_XKBFILE)
	@$(call patchin, XORG_LIB_XKBFILE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xkbfile_prepare: $(STATEDIR)/xorg-lib-xkbfile.prepare

XORG_LIB_XKBFILE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XKBFILE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XKBFILE_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/xorg-lib-xkbfile.prepare: $(xorg-lib-xkbfile_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XKBFILE_DIR)/config.cache)
	cd $(XORG_LIB_XKBFILE_DIR) && \
		$(XORG_LIB_XKBFILE_PATH) $(XORG_LIB_XKBFILE_ENV) \
		./configure $(XORG_LIB_XKBFILE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xkbfile_compile: $(STATEDIR)/xorg-lib-xkbfile.compile

$(STATEDIR)/xorg-lib-xkbfile.compile: $(xorg-lib-xkbfile_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XKBFILE_DIR) && $(XORG_LIB_XKBFILE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xkbfile_install: $(STATEDIR)/xorg-lib-xkbfile.install

$(STATEDIR)/xorg-lib-xkbfile.install: $(xorg-lib-xkbfile_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XKBFILE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xkbfile_targetinstall: $(STATEDIR)/xorg-lib-xkbfile.targetinstall

$(STATEDIR)/xorg-lib-xkbfile.targetinstall: $(xorg-lib-xkbfile_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xkbfile)
	@$(call install_fixup, xorg-lib-xkbfile,PACKAGE,xorg-lib-xkbfile)
	@$(call install_fixup, xorg-lib-xkbfile,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xkbfile,VERSION,$(XORG_LIB_XKBFILE_VERSION))
	@$(call install_fixup, xorg-lib-xkbfile,SECTION,base)
	@$(call install_fixup, xorg-lib-xkbfile,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xkbfile,DEPENDS,)
	@$(call install_fixup, xorg-lib-xkbfile,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xkbfile, 0, 0, 0644, \
		$(XORG_LIB_XKBFILE_DIR)/src/.libs/libxkbfile.so.1.0.2, \
		$(XORG_LIBDIR)/libxkbfile.so.1.0.2)

	@$(call install_link, xorg-lib-xkbfile, \
		libxkbfile.so.1.0.2, \
		$(XORG_LIBDIR)/libxkbfile.so.1)

	@$(call install_link, xorg-lib-xkbfile, \
		libxkbfile.so.1.0.2, \
		$(XORG_LIBDIR)/libxkbfile.so)

	@$(call install_finish, xorg-lib-xkbfile)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xkbfile_clean:
	rm -rf $(STATEDIR)/xorg-lib-xkbfile.*
	rm -rf $(PKGDIR)/xorg-lib-xkbfile_*
	rm -rf $(XORG_LIB_XKBFILE_DIR)

# vim: syntax=make
