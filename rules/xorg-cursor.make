# -*-makefile-*-
# $Id: template 6655 2007-01-02 12:55:21Z rsc $
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_CURSOR) += xorg-cursor

#
# Paths and names
#
XORG_CURSOR_VERSION	:= 0.0.1
XORG_CURSOR		:= xorg-cursor-$(XORG_CURSOR_VERSION)
XORG_CURSOR_DIR		:= $(BUILDDIR)/$(XORG_CURSOR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-cursor_get: $(STATEDIR)/xorg-cursor.get

$(STATEDIR)/xorg-cursor.get: $(xorg-cursor_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-cursor_extract: $(STATEDIR)/xorg-cursor.extract

$(STATEDIR)/xorg-cursor.extract: $(xorg-cursor_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_CURSOR_DIR))
	@mkdir -p $(XORG_CURSOR_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-cursor_prepare: $(STATEDIR)/xorg-cursor.prepare

$(STATEDIR)/xorg-cursor.prepare: $(xorg-cursor_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-cursor_compile: $(STATEDIR)/xorg-cursor.compile

$(STATEDIR)/xorg-cursor.compile: $(xorg-cursor_compile_deps_default)
	@$(call targetinfo, $@)
	echo "[Icon Theme]"                          >  $(XORG_CURSOR_DIR)/index.theme
	echo "Inherits=$(PTXCONF_XORG_CURSOR_THEME)" >> $(XORG_CURSOR_DIR)/index.theme
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-cursor_install: $(STATEDIR)/xorg-cursor.install

$(STATEDIR)/xorg-cursor.install: $(xorg-cursor_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-cursor_targetinstall: $(STATEDIR)/xorg-cursor.targetinstall

$(STATEDIR)/xorg-cursor.targetinstall: $(xorg-cursor_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-cursor)
	@$(call install_fixup, xorg-cursor,PACKAGE,xorg-cursor)
	@$(call install_fixup, xorg-cursor,PRIORITY,optional)
	@$(call install_fixup, xorg-cursor,VERSION,$(XORG_CURSOR_VERSION))
	@$(call install_fixup, xorg-cursor,SECTION,base)
	@$(call install_fixup, xorg-cursor,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xorg-cursor,DEPENDS,)
	@$(call install_fixup, xorg-cursor,DESCRIPTION,missing)

	@$(call install_copy, xorg-cursor, 0, 0, 0755, /usr/share/icons/default)
	@$(call install_copy, xorg-cursor, 0, 0, 0644, $(XORG_CURSOR_DIR)/index.theme, /usr/share/icons/default/index.theme, n)

	@$(call install_finish, xorg-cursor)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-cursor_clean:
	rm -rf $(STATEDIR)/xorg-cursor.*
	rm -rf $(PKGDIR)/xorg-cursor_*
	rm -rf $(XORG_CURSOR_DIR)

# vim: syntax=make
