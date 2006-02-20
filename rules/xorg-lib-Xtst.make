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
PACKAGES-$(PTXCONF_XORG_LIB_XTST) += xorg-lib-Xtst

#
# Paths and names
#
XORG_LIB_XTST_VERSION	:= 1.0.1
XORG_LIB_XTST		:= libXtst-X11R7.0-$(XORG_LIB_XTST_VERSION)
XORG_LIB_XTST_SUFFIX	:= tar.bz2
XORG_LIB_XTST_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/lib//$(XORG_LIB_XTST).$(XORG_LIB_XTST_SUFFIX)
XORG_LIB_XTST_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XTST).$(XORG_LIB_XTST_SUFFIX)
XORG_LIB_XTST_DIR	:= $(BUILDDIR)/$(XORG_LIB_XTST)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xtst_get: $(STATEDIR)/xorg-lib-Xtst.get

$(STATEDIR)/xorg-lib-Xtst.get: $(xorg-lib-Xtst_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XTST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_LIB_XTST_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xtst_extract: $(STATEDIR)/xorg-lib-Xtst.extract

$(STATEDIR)/xorg-lib-Xtst.extract: $(xorg-lib-Xtst_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTST_DIR))
	@$(call extract, $(XORG_LIB_XTST_SOURCE))
	@$(call patchin, $(XORG_LIB_XTST))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xtst_prepare: $(STATEDIR)/xorg-lib-Xtst.prepare

XORG_LIB_XTST_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XTST_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XTST_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-Xtst.prepare: $(xorg-lib-Xtst_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTST_DIR)/config.cache)
	cd $(XORG_LIB_XTST_DIR) && \
		$(XORG_LIB_XTST_PATH) $(XORG_LIB_XTST_ENV) \
		./configure $(XORG_LIB_XTST_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xtst_compile: $(STATEDIR)/xorg-lib-Xtst.compile

$(STATEDIR)/xorg-lib-Xtst.compile: $(xorg-lib-Xtst_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XTST_DIR) && $(XORG_LIB_XTST_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xtst_install: $(STATEDIR)/xorg-lib-Xtst.install

$(STATEDIR)/xorg-lib-Xtst.install: $(xorg-lib-Xtst_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XTST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xtst_targetinstall: $(STATEDIR)/xorg-lib-Xtst.targetinstall

$(STATEDIR)/xorg-lib-Xtst.targetinstall: $(xorg-lib-Xtst_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-lib-Xtst)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_LIB_XTST_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

#FIXME

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xtst_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xtst.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xtst_*
	rm -rf $(XORG_LIB_XTST_DIR)

# vim: syntax=make
