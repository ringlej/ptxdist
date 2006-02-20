# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_LIB_OLDX) += xorg-lib-oldX

#
# Paths and names
#
XORG_LIB_OLDX_VERSION	:= 1.0.1
XORG_LIB_OLDX		:= liboldX-X11R7.0-$(XORG_LIB_OLDX_VERSION)
XORG_LIB_OLDX_SUFFIX	:= tar.bz2
XORG_LIB_OLDX_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/lib//$(XORG_LIB_OLDX).$(XORG_LIB_OLDX_SUFFIX)
XORG_LIB_OLDX_SOURCE	:= $(SRCDIR)/$(XORG_LIB_OLDX).$(XORG_LIB_OLDX_SUFFIX)
XORG_LIB_OLDX_DIR	:= $(BUILDDIR)/$(XORG_LIB_OLDX)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-oldX_get: $(STATEDIR)/xorg-lib-oldX.get

$(STATEDIR)/xorg-lib-oldX.get: $(xorg-lib-oldX_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_OLDX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_LIB_OLDX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-oldX_extract: $(STATEDIR)/xorg-lib-oldX.extract

$(STATEDIR)/xorg-lib-oldX.extract: $(xorg-lib-oldX_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_OLDX_DIR))
	@$(call extract, $(XORG_LIB_OLDX_SOURCE))
	@$(call patchin, $(XORG_LIB_OLDX))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-oldX_prepare: $(STATEDIR)/xorg-lib-oldX.prepare

XORG_LIB_OLDX_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_OLDX_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_OLDX_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-oldX.prepare: $(xorg-lib-oldX_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_OLDX_DIR)/config.cache)
	cd $(XORG_LIB_OLDX_DIR) && \
		$(XORG_LIB_OLDX_PATH) $(XORG_LIB_OLDX_ENV) \
		./configure $(XORG_LIB_OLDX_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-oldX_compile: $(STATEDIR)/xorg-lib-oldX.compile

$(STATEDIR)/xorg-lib-oldX.compile: $(xorg-lib-oldX_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_OLDX_DIR) && $(XORG_LIB_OLDX_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-oldX_install: $(STATEDIR)/xorg-lib-oldX.install

$(STATEDIR)/xorg-lib-oldX.install: $(xorg-lib-oldX_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_OLDX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-oldX_targetinstall: $(STATEDIR)/xorg-lib-oldX.targetinstall

$(STATEDIR)/xorg-lib-oldX.targetinstall: $(xorg-lib-oldX_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-lib-oldX)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_LIB_OLDX_VERSION))
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

xorg-lib-oldX_clean:
	rm -rf $(STATEDIR)/xorg-lib-oldX.*
	rm -rf $(IMAGEDIR)/xorg-lib-oldX_*
	rm -rf $(XORG_LIB_OLDX_DIR)

# vim: syntax=make
