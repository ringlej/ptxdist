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
PACKAGES-$(PTXCONF_XORG_FONT_DAEWOO_MISC) += xorg-font-daewoo-misc

#
# Paths and names
#
XORG_FONT_DAEWOO_MISC_VERSION	:= 1.0.0
XORG_FONT_DAEWOO_MISC		:= font-daewoo-misc-X11R7.0-$(XORG_FONT_DAEWOO_MISC_VERSION)
XORG_FONT_DAEWOO_MISC_SUFFIX	:= tar.bz2
XORG_FONT_DAEWOO_MISC_URL	:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/font//$(XORG_FONT_DAEWOO_MISC).$(XORG_FONT_DAEWOO_MISC_SUFFIX)
XORG_FONT_DAEWOO_MISC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_DAEWOO_MISC).$(XORG_FONT_DAEWOO_MISC_SUFFIX)
XORG_FONT_DAEWOO_MISC_DIR	:= $(BUILDDIR)/$(XORG_FONT_DAEWOO_MISC)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-daewoo-misc_get: $(STATEDIR)/xorg-font-daewoo-misc.get

$(STATEDIR)/xorg-font-daewoo-misc.get: $(xorg-font-daewoo-misc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_DAEWOO_MISC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_FONT_DAEWOO_MISC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-daewoo-misc_extract: $(STATEDIR)/xorg-font-daewoo-misc.extract

$(STATEDIR)/xorg-font-daewoo-misc.extract: $(xorg-font-daewoo-misc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_DAEWOO_MISC_DIR))
	@$(call extract, $(XORG_FONT_DAEWOO_MISC_SOURCE))
	@$(call patchin, $(XORG_FONT_DAEWOO_MISC))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-daewoo-misc_prepare: $(STATEDIR)/xorg-font-daewoo-misc.prepare

XORG_FONT_DAEWOO_MISC_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_DAEWOO_MISC_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_DAEWOO_MISC_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-font-daewoo-misc.prepare: $(xorg-font-daewoo-misc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_DAEWOO_MISC_DIR)/config.cache)
	cd $(XORG_FONT_DAEWOO_MISC_DIR) && \
		$(XORG_FONT_DAEWOO_MISC_PATH) $(XORG_FONT_DAEWOO_MISC_ENV) \
		./configure $(XORG_FONT_DAEWOO_MISC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-daewoo-misc_compile: $(STATEDIR)/xorg-font-daewoo-misc.compile

$(STATEDIR)/xorg-font-daewoo-misc.compile: $(xorg-font-daewoo-misc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_DAEWOO_MISC_DIR) && $(XORG_FONT_DAEWOO_MISC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-daewoo-misc_install: $(STATEDIR)/xorg-font-daewoo-misc.install

$(STATEDIR)/xorg-font-daewoo-misc.install: $(xorg-font-daewoo-misc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-daewoo-misc_targetinstall: $(STATEDIR)/xorg-font-daewoo-misc.targetinstall

$(STATEDIR)/xorg-font-daewoo-misc.targetinstall: $(xorg-font-daewoo-misc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-font-daewoo-misc)
	@$(call install_fixup, xorg-font-daewoo-misc,PACKAGE,xorg-font-daewoo-misc)
	@$(call install_fixup, xorg-font-daewoo-misc,PRIORITY,optional)
	@$(call install_fixup, xorg-font-daewoo-misc,VERSION,$(XORG_FONT_DAEWOO_MISC_VERSION))
	@$(call install_fixup, xorg-font-daewoo-misc,SECTION,base)
	@$(call install_fixup, xorg-font-daewoo-misc,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-font-daewoo-misc,DEPENDS,)
	@$(call install_fixup, xorg-font-daewoo-misc,DESCRIPTION,missing)

	@cd $(XORG_FONT_DAEWOO_MISC_DIR); \
	for file in *.pcf.gz; do	\
		$(call install_copy, xorg-font-daewoo-misc, 0, 0, 0644, $$file, $(XORG_FONTDIR)/misc/$$file, n); \
	done

	@$(call install_finish, xorg-font-daewoo-misc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-daewoo-misc_clean:
	rm -rf $(STATEDIR)/xorg-font-daewoo-misc.*
	rm -rf $(IMAGEDIR)/xorg-font-daewoo-misc_*
	rm -rf $(XORG_FONT_DAEWOO_MISC_DIR)

# vim: syntax=make
