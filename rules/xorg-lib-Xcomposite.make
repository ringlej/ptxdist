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
PACKAGES-$(PTXCONF_XORG_LIB_XCOMPOSITE) += xorg-lib-Xcomposite

#
# Paths and names
#
XORG_LIB_XCOMPOSITE_VERSION	:= 0.2.2.2
XORG_LIB_XCOMPOSITE		:= libXcomposite-X11R7.0-$(XORG_LIB_XCOMPOSITE_VERSION)
XORG_LIB_XCOMPOSITE_SUFFIX	:= tar.bz2
XORG_LIB_XCOMPOSITE_URL		:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/lib//$(XORG_LIB_XCOMPOSITE).$(XORG_LIB_XCOMPOSITE_SUFFIX)
XORG_LIB_XCOMPOSITE_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XCOMPOSITE).$(XORG_LIB_XCOMPOSITE_SUFFIX)
XORG_LIB_XCOMPOSITE_DIR		:= $(BUILDDIR)/$(XORG_LIB_XCOMPOSITE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_get: $(STATEDIR)/xorg-lib-Xcomposite.get

$(STATEDIR)/xorg-lib-Xcomposite.get: $(xorg-lib-Xcomposite_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XCOMPOSITE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_LIB_XCOMPOSITE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_extract: $(STATEDIR)/xorg-lib-Xcomposite.extract

$(STATEDIR)/xorg-lib-Xcomposite.extract: $(xorg-lib-Xcomposite_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCOMPOSITE_DIR))
	@$(call extract, $(XORG_LIB_XCOMPOSITE_SOURCE))
	@$(call patchin, $(XORG_LIB_XCOMPOSITE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_prepare: $(STATEDIR)/xorg-lib-Xcomposite.prepare

XORG_LIB_XCOMPOSITE_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XCOMPOSITE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XCOMPOSITE_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-Xcomposite.prepare: $(xorg-lib-Xcomposite_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XCOMPOSITE_DIR)/config.cache)
	cd $(XORG_LIB_XCOMPOSITE_DIR) && \
		$(XORG_LIB_XCOMPOSITE_PATH) $(XORG_LIB_XCOMPOSITE_ENV) \
		./configure $(XORG_LIB_XCOMPOSITE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_compile: $(STATEDIR)/xorg-lib-Xcomposite.compile

$(STATEDIR)/xorg-lib-Xcomposite.compile: $(xorg-lib-Xcomposite_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XCOMPOSITE_DIR) && $(XORG_LIB_XCOMPOSITE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_install: $(STATEDIR)/xorg-lib-Xcomposite.install

$(STATEDIR)/xorg-lib-Xcomposite.install: $(xorg-lib-Xcomposite_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XCOMPOSITE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xcomposite_targetinstall: $(STATEDIR)/xorg-lib-Xcomposite.targetinstall

$(STATEDIR)/xorg-lib-Xcomposite.targetinstall: $(xorg-lib-Xcomposite_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-lib-xcomposite)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_LIB_XCOMPOSITE_VERSION))
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

xorg-lib-Xcomposite_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xcomposite.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xcomposite_*
	rm -rf $(XORG_LIB_XCOMPOSITE_DIR)

# vim: syntax=make
