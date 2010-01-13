# -*-makefile-*-
#
# Copyright (C) 2007, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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

$(STATEDIR)/xorg-cursor.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-cursor.extract:
	@$(call targetinfo)
	@$(call clean, $(XORG_CURSOR_DIR))
	@mkdir -p $(XORG_CURSOR_DIR)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-cursor.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-cursor.compile:
	@$(call targetinfo)
	echo "[Icon Theme]"                          >  $(XORG_CURSOR_DIR)/index.theme
	echo "Inherits=$(PTXCONF_XORG_CURSOR_THEME)" >> $(XORG_CURSOR_DIR)/index.theme
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-cursor.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-cursor.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-cursor)
	@$(call install_fixup, xorg-cursor,PACKAGE,xorg-cursor)
	@$(call install_fixup, xorg-cursor,PRIORITY,optional)
	@$(call install_fixup, xorg-cursor,VERSION,$(XORG_CURSOR_VERSION))
	@$(call install_fixup, xorg-cursor,SECTION,base)
	@$(call install_fixup, xorg-cursor,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-cursor,DEPENDS,)
	@$(call install_fixup, xorg-cursor,DESCRIPTION,missing)

	@$(call install_copy, xorg-cursor, 0, 0, 0755, /usr/share/icons/default)
	@$(call install_copy, xorg-cursor, 0, 0, 0644, $(XORG_CURSOR_DIR)/index.theme, /usr/share/icons/default/index.theme, n)

	@$(call install_finish, xorg-cursor)

	@$(call touch)

# vim: syntax=make
