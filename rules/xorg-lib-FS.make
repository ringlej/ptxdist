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
PACKAGES-$(PTXCONF_XORG_LIB_FS) += xorg-lib-FS

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

xorg-lib-FS_get: $(STATEDIR)/xorg-lib-FS.get

$(STATEDIR)/xorg-lib-FS.get: $(xorg-lib-FS_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_FS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_FS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-FS_extract: $(STATEDIR)/xorg-lib-FS.extract

$(STATEDIR)/xorg-lib-FS.extract: $(xorg-lib-FS_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_FS_DIR))
	@$(call extract, XORG_LIB_FS)
	@$(call patchin, XORG_LIB_FS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-FS_prepare: $(STATEDIR)/xorg-lib-FS.prepare

XORG_LIB_FS_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_FS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_FS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-FS.prepare: $(xorg-lib-FS_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_FS_DIR)/config.cache)
	cd $(XORG_LIB_FS_DIR) && \
		$(XORG_LIB_FS_PATH) $(XORG_LIB_FS_ENV) \
		./configure $(XORG_LIB_FS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-FS_compile: $(STATEDIR)/xorg-lib-FS.compile

$(STATEDIR)/xorg-lib-FS.compile: $(xorg-lib-FS_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_FS_DIR) && $(XORG_LIB_FS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-FS_install: $(STATEDIR)/xorg-lib-FS.install

$(STATEDIR)/xorg-lib-FS.install: $(xorg-lib-FS_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_FS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-FS_targetinstall: $(STATEDIR)/xorg-lib-FS.targetinstall

$(STATEDIR)/xorg-lib-FS.targetinstall: $(xorg-lib-FS_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-FS)
	@$(call install_fixup, xorg-lib-FS,PACKAGE,xorg-lib-fs)
	@$(call install_fixup, xorg-lib-FS,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-FS,VERSION,$(XORG_LIB_FS_VERSION))
	@$(call install_fixup, xorg-lib-FS,SECTION,base)
	@$(call install_fixup, xorg-lib-FS,AUTHOR,"Erwin rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-FS,DEPENDS,)
	@$(call install_fixup, xorg-lib-FS,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-FS, 0, 0, 0644, \
		$(XORG_LIB_FS_DIR)/src/.libs/libFS.so.6.0.0, \
		$(XORG_LIBDIR)/libFS.so.6.0.0)

	@$(call install_link, xorg-lib-FS, \
		libFS.so.6.0.0, \
		$(XORG_LIBDIR)/libFS.so.6)

	@$(call install_link, xorg-lib-FS, \
		libFS.so.6.0.0, \
		$(XORG_LIBDIR)/libFS.so)

	@$(call install_finish, xorg-lib-FS)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-FS_clean:
	rm -rf $(STATEDIR)/xorg-lib-FS.*
	rm -rf $(IMAGEDIR)/xorg-lib-FS_*
	rm -rf $(XORG_LIB_FS_DIR)

# vim: syntax=make
