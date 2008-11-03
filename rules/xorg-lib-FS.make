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
PACKAGES-$(PTXCONF_XORG_LIB_FS) += xorg-lib-fs

#
# Paths and names
#
XORG_LIB_FS_VERSION	:= 1.0.0
XORG_LIB_FS		:= libFS-$(XORG_LIB_FS_VERSION)
XORG_LIB_FS_SUFFIX	:= tar.bz2
XORG_LIB_FS_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_FS).$(XORG_LIB_FS_SUFFIX)
XORG_LIB_FS_SOURCE	:= $(SRCDIR)/$(XORG_LIB_FS).$(XORG_LIB_FS_SUFFIX)
XORG_LIB_FS_DIR		:= $(BUILDDIR)/$(XORG_LIB_FS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-fs_get: $(STATEDIR)/xorg-lib-fs.get

$(STATEDIR)/xorg-lib-fs.get: $(xorg-lib-fs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_FS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_FS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-fs_extract: $(STATEDIR)/xorg-lib-fs.extract

$(STATEDIR)/xorg-lib-fs.extract: $(xorg-lib-fs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_FS_DIR))
	@$(call extract, XORG_LIB_FS)
	@$(call patchin, XORG_LIB_FS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-fs_prepare: $(STATEDIR)/xorg-lib-fs.prepare

XORG_LIB_FS_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_FS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_FS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-fs.prepare: $(xorg-lib-fs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_FS_DIR)/config.cache)
	cd $(XORG_LIB_FS_DIR) && \
		$(XORG_LIB_FS_PATH) $(XORG_LIB_FS_ENV) \
		./configure $(XORG_LIB_FS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-fs_compile: $(STATEDIR)/xorg-lib-fs.compile

$(STATEDIR)/xorg-lib-fs.compile: $(xorg-lib-fs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_FS_DIR) && $(XORG_LIB_FS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-fs_install: $(STATEDIR)/xorg-lib-fs.install

$(STATEDIR)/xorg-lib-fs.install: $(xorg-lib-fs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_FS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-fs_targetinstall: $(STATEDIR)/xorg-lib-fs.targetinstall

$(STATEDIR)/xorg-lib-fs.targetinstall: $(xorg-lib-fs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-fs)
	@$(call install_fixup, xorg-lib-fs,PACKAGE,xorg-lib-fs)
	@$(call install_fixup, xorg-lib-fs,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-fs,VERSION,$(XORG_LIB_FS_VERSION))
	@$(call install_fixup, xorg-lib-fs,SECTION,base)
	@$(call install_fixup, xorg-lib-fs,AUTHOR,"Erwin rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-fs,DEPENDS,)
	@$(call install_fixup, xorg-lib-fs,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-fs, 0, 0, 0644, \
		$(XORG_LIB_FS_DIR)/src/.libs/libFS.so.6.0.0, \
		$(XORG_LIBDIR)/libFS.so.6.0.0)

	@$(call install_link, xorg-lib-fs, \
		libFS.so.6.0.0, \
		$(XORG_LIBDIR)/libFS.so.6)

	@$(call install_link, xorg-lib-fs, \
		libFS.so.6.0.0, \
		$(XORG_LIBDIR)/libFS.so)

	@$(call install_finish, xorg-lib-fs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-fs_clean:
	rm -rf $(STATEDIR)/xorg-lib-fs.*
	rm -rf $(PKGDIR)/xorg-lib-fs_*
	rm -rf $(XORG_LIB_FS_DIR)

# vim: syntax=make
