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
PACKAGES-$(PTXCONF_XORG_LIB_XRANDR) += xorg-lib-Xrandr

#
# Paths and names
#
XORG_LIB_XRANDR_VERSION	:= 1.1.0.2
XORG_LIB_XRANDR		:= libXrandr-X11R7.0-$(XORG_LIB_XRANDR_VERSION)
XORG_LIB_XRANDR_SUFFIX	:= tar.bz2
XORG_LIB_XRANDR_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/lib//$(XORG_LIB_XRANDR).$(XORG_LIB_XRANDR_SUFFIX)
XORG_LIB_XRANDR_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XRANDR).$(XORG_LIB_XRANDR_SUFFIX)
XORG_LIB_XRANDR_DIR	:= $(BUILDDIR)/$(XORG_LIB_XRANDR)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xrandr_get: $(STATEDIR)/xorg-lib-Xrandr.get

$(STATEDIR)/xorg-lib-Xrandr.get: $(xorg-lib-Xrandr_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XRANDR_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_LIB_XRANDR_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xrandr_extract: $(STATEDIR)/xorg-lib-Xrandr.extract

$(STATEDIR)/xorg-lib-Xrandr.extract: $(xorg-lib-Xrandr_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRANDR_DIR))
	@$(call extract, $(XORG_LIB_XRANDR_SOURCE))
	@$(call patchin, $(XORG_LIB_XRANDR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xrandr_prepare: $(STATEDIR)/xorg-lib-Xrandr.prepare

XORG_LIB_XRANDR_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XRANDR_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XRANDR_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-Xrandr.prepare: $(xorg-lib-Xrandr_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XRANDR_DIR)/config.cache)
	cd $(XORG_LIB_XRANDR_DIR) && \
		$(XORG_LIB_XRANDR_PATH) $(XORG_LIB_XRANDR_ENV) \
		./configure $(XORG_LIB_XRANDR_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xrandr_compile: $(STATEDIR)/xorg-lib-Xrandr.compile

$(STATEDIR)/xorg-lib-Xrandr.compile: $(xorg-lib-Xrandr_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XRANDR_DIR) && $(XORG_LIB_XRANDR_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xrandr_install: $(STATEDIR)/xorg-lib-Xrandr.install

$(STATEDIR)/xorg-lib-Xrandr.install: $(xorg-lib-Xrandr_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XRANDR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xrandr_targetinstall: $(STATEDIR)/xorg-lib-Xrandr.targetinstall

$(STATEDIR)/xorg-lib-Xrandr.targetinstall: $(xorg-lib-Xrandr_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-lib-Xrandr)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_LIB_XRANDR_VERSION))
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

xorg-lib-Xrandr_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xrandr.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xrandr_*
	rm -rf $(XORG_LIB_XRANDR_DIR)

# vim: syntax=make
