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
PACKAGES-$(PTXCONF_XORG_LIB_LBXUTIL) += xorg-lib-lbxutil

#
# Paths and names
#
XORG_LIB_LBXUTIL_VERSION	:= 1.0.0
XORG_LIB_LBXUTIL		:= liblbxutil-X11R7.0-$(XORG_LIB_LBXUTIL_VERSION)
XORG_LIB_LBXUTIL_SUFFIX		:= tar.bz2
XORG_LIB_LBXUTIL_URL		:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/lib//$(XORG_LIB_LBXUTIL).$(XORG_LIB_LBXUTIL_SUFFIX)
XORG_LIB_LBXUTIL_SOURCE		:= $(SRCDIR)/$(XORG_LIB_LBXUTIL).$(XORG_LIB_LBXUTIL_SUFFIX)
XORG_LIB_LBXUTIL_DIR		:= $(BUILDDIR)/$(XORG_LIB_LBXUTIL)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-lbxutil_get: $(STATEDIR)/xorg-lib-lbxutil.get

$(STATEDIR)/xorg-lib-lbxutil.get: $(xorg-lib-lbxutil_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_LBXUTIL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_LIB_LBXUTIL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-lbxutil_extract: $(STATEDIR)/xorg-lib-lbxutil.extract

$(STATEDIR)/xorg-lib-lbxutil.extract: $(xorg-lib-lbxutil_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_LBXUTIL_DIR))
	@$(call extract, $(XORG_LIB_LBXUTIL_SOURCE))
	@$(call patchin, $(XORG_LIB_LBXUTIL))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-lbxutil_prepare: $(STATEDIR)/xorg-lib-lbxutil.prepare

XORG_LIB_LBXUTIL_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_LBXUTIL_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_LBXUTIL_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-lbxutil.prepare: $(xorg-lib-lbxutil_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_LBXUTIL_DIR)/config.cache)
	cd $(XORG_LIB_LBXUTIL_DIR) && \
		$(XORG_LIB_LBXUTIL_PATH) $(XORG_LIB_LBXUTIL_ENV) \
		./configure $(XORG_LIB_LBXUTIL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-lbxutil_compile: $(STATEDIR)/xorg-lib-lbxutil.compile

$(STATEDIR)/xorg-lib-lbxutil.compile: $(xorg-lib-lbxutil_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_LBXUTIL_DIR) && $(XORG_LIB_LBXUTIL_PATH) $(XORG_LIB_LBXUTIL_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-lbxutil_install: $(STATEDIR)/xorg-lib-lbxutil.install

$(STATEDIR)/xorg-lib-lbxutil.install: $(xorg-lib-lbxutil_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_LBXUTIL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-lbxutil_targetinstall: $(STATEDIR)/xorg-lib-lbxutil.targetinstall

$(STATEDIR)/xorg-lib-lbxutil.targetinstall: $(xorg-lib-lbxutil_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-lib-lbxutil)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_LIB_LBXUTIL_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

# FIXME

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-lbxutil_clean:
	rm -rf $(STATEDIR)/xorg-lib-lbxutil.*
	rm -rf $(IMAGEDIR)/xorg-lib-lbxutil_*
	rm -rf $(XORG_LIB_LBXUTIL_DIR)

# vim: syntax=make
