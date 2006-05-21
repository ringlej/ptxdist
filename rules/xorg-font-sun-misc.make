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
PACKAGES-$(PTXCONF_XORG_FONT_SUN_MISC) += xorg-font-sun-misc

#
# Paths and names
#
XORG_FONT_SUN_MISC_VERSION	:= 1.0.0
XORG_FONT_SUN_MISC		:= font-sun-misc-X11R7.0-$(XORG_FONT_SUN_MISC_VERSION)
XORG_FONT_SUN_MISC_SUFFIX	:= tar.bz2
XORG_FONT_SUN_MISC_URL		:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/font//$(XORG_FONT_SUN_MISC).$(XORG_FONT_SUN_MISC_SUFFIX)
XORG_FONT_SUN_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_SUN_MISC).$(XORG_FONT_SUN_MISC_SUFFIX)
XORG_FONT_SUN_MISC_DIR		:= $(BUILDDIR)/$(XORG_FONT_SUN_MISC)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-sun-misc_get: $(STATEDIR)/xorg-font-sun-misc.get

$(STATEDIR)/xorg-font-sun-misc.get: $(xorg-font-sun-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_SUN_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_SUN_MISC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-sun-misc_extract: $(STATEDIR)/xorg-font-sun-misc.extract

$(STATEDIR)/xorg-font-sun-misc.extract: $(xorg-font-sun-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_SUN_MISC_DIR))
	@$(call extract, XORG_FONT_SUN_MISC)
	@$(call patchin, XORG_FONT_SUN_MISC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-sun-misc_prepare: $(STATEDIR)/xorg-font-sun-misc.prepare

XORG_FONT_SUN_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_SUN_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_SUN_MISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-font-sun-misc.prepare: $(xorg-font-sun-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_SUN_MISC_DIR)/config.cache)
	cd $(XORG_FONT_SUN_MISC_DIR) && \
		$(XORG_FONT_SUN_MISC_PATH) $(XORG_FONT_SUN_MISC_ENV) \
		./configure $(XORG_FONT_SUN_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-sun-misc_compile: $(STATEDIR)/xorg-font-sun-misc.compile

$(STATEDIR)/xorg-font-sun-misc.compile: $(xorg-font-sun-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_SUN_MISC_DIR) && $(XORG_FONT_SUN_MISC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-sun-misc_install: $(STATEDIR)/xorg-font-sun-misc.install

$(STATEDIR)/xorg-font-sun-misc.install: $(xorg-font-sun-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-sun-misc_targetinstall: $(STATEDIR)/xorg-font-sun-misc.targetinstall

$(STATEDIR)/xorg-font-sun-misc.targetinstall: $(xorg-font-sun-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-font-sun-misc)
	@$(call install_fixup, xorg-font-sun-misc,PACKAGE,xorg-font-sun-misc)
	@$(call install_fixup, xorg-font-sun-misc,PRIORITY,optional)
	@$(call install_fixup, xorg-font-sun-misc,VERSION,$(XORG_FONT_SUN_MISC_VERSION))
	@$(call install_fixup, xorg-font-sun-misc,SECTION,base)
	@$(call install_fixup, xorg-font-sun-misc,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-font-sun-misc,DEPENDS,)
	@$(call install_fixup, xorg-font-sun-misc,DESCRIPTION,missing)

	@cd $(XORG_FONT_SUN_MISC_DIR); \
	for file in *.pcf.gz; do	\
		$(call install_copy, xorg-font-sun-misc, 0, 0, 0644, $$file, $(XORG_FONTDIR)/misc/$$file, n); \
	done

	@$(call install_finish, xorg-font-sun-misc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-sun-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-sun-misc.*
	rm -rf $(IMAGEDIR)/xorg-font-sun-misc_*
	rm -rf $(XORG_FONT_SUN_MISC_DIR)

# vim: syntax=make
