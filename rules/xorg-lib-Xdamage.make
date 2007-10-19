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
PACKAGES-$(PTXCONF_XORG_LIB_XDAMAGE) += xorg-lib-Xdamage

#
# Paths and names
#
XORG_LIB_XDAMAGE_VERSION	:= 1.0.4
XORG_LIB_XDAMAGE		:= libXdamage-$(XORG_LIB_XDAMAGE_VERSION)
XORG_LIB_XDAMAGE_SUFFIX		:= tar.bz2
XORG_LIB_XDAMAGE_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX)
XORG_LIB_XDAMAGE_SOURCE		:= $(SRCDIR)/$(XORG_LIB_XDAMAGE).$(XORG_LIB_XDAMAGE_SUFFIX)
XORG_LIB_XDAMAGE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XDAMAGE)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xdamage_get: $(STATEDIR)/xorg-lib-Xdamage.get

$(STATEDIR)/xorg-lib-Xdamage.get: $(xorg-lib-Xdamage_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XDAMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XDAMAGE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xdamage_extract: $(STATEDIR)/xorg-lib-Xdamage.extract

$(STATEDIR)/xorg-lib-Xdamage.extract: $(xorg-lib-Xdamage_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XDAMAGE_DIR))
	@$(call extract, XORG_LIB_XDAMAGE)
	@$(call patchin, XORG_LIB_XDAMAGE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xdamage_prepare: $(STATEDIR)/xorg-lib-Xdamage.prepare

XORG_LIB_XDAMAGE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XDAMAGE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XDAMAGE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-Xdamage.prepare: $(xorg-lib-Xdamage_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XDAMAGE_DIR)/config.cache)
	cd $(XORG_LIB_XDAMAGE_DIR) && \
		$(XORG_LIB_XDAMAGE_PATH) $(XORG_LIB_XDAMAGE_ENV) \
		./configure $(XORG_LIB_XDAMAGE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xdamage_compile: $(STATEDIR)/xorg-lib-Xdamage.compile

$(STATEDIR)/xorg-lib-Xdamage.compile: $(xorg-lib-Xdamage_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XDAMAGE_DIR) && $(XORG_LIB_XDAMAGE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xdamage_install: $(STATEDIR)/xorg-lib-Xdamage.install

$(STATEDIR)/xorg-lib-Xdamage.install: $(xorg-lib-Xdamage_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XDAMAGE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xdamage_targetinstall: $(STATEDIR)/xorg-lib-Xdamage.targetinstall

$(STATEDIR)/xorg-lib-Xdamage.targetinstall: $(xorg-lib-Xdamage_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xdamage)
	@$(call install_fixup, xorg-lib-Xdamage,PACKAGE,xorg-lib-xdamage)
	@$(call install_fixup, xorg-lib-Xdamage,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xdamage,VERSION,$(XORG_LIB_XDAMAGE_VERSION))
	@$(call install_fixup, xorg-lib-Xdamage,SECTION,base)
	@$(call install_fixup, xorg-lib-Xdamage,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xdamage,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xdamage,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xdamage, 0, 0, 0644, \
		$(XORG_LIB_XDAMAGE_DIR)/src/.libs/libXdamage.so.1.0.0, \
		$(XORG_LIBDIR)/libXdamage.so.1.0.0)

	@$(call install_link, xorg-lib-Xdamage, \
		libXdamage.so.1.0.0, \
		$(XORG_LIBDIR)/libXdamage.so.1)

	@$(call install_link, xorg-lib-Xdamage, \
		libXdamage.so.1.0.0, \
		$(XORG_LIBDIR)/libXdamage.so)

	@$(call install_finish, xorg-lib-Xdamage)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xdamage_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xdamage.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xdamage_*
	rm -rf $(XORG_LIB_XDAMAGE_DIR)

# vim: syntax=make
