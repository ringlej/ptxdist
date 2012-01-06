# -*-makefile-*-
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
PACKAGES-$(PTXCONF_XORG_FONT_ALIAS) += xorg-font-alias

#
# Paths and names
#
XORG_FONT_ALIAS_VERSION	:= 1.0.3
XORG_FONT_ALIAS_MD5	:= 6d25f64796fef34b53b439c2e9efa562
XORG_FONT_ALIAS		:= font-alias-$(XORG_FONT_ALIAS_VERSION)
XORG_FONT_ALIAS_SUFFIX	:= tar.bz2
XORG_FONT_ALIAS_URL	:= $(call ptx/mirror, XORG, individual/font/$(XORG_FONT_ALIAS).$(XORG_FONT_ALIAS_SUFFIX))
XORG_FONT_ALIAS_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ALIAS).$(XORG_FONT_ALIAS_SUFFIX)
XORG_FONT_ALIAS_DIR	:= $(BUILDDIR)/$(XORG_FONT_ALIAS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_ALIAS_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_ALIAS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_ALIAS_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_ALIAS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ALIAS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontrootdir=$(XORG_FONTDIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-alias.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xorg-font-alias)
	@$(call install_fixup, xorg-font-alias,PRIORITY,optional)
	@$(call install_fixup, xorg-font-alias,SECTION,base)
	@$(call install_fixup, xorg-font-alias,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-font-alias,DESCRIPTION,missing)

	@$(call install_copy, xorg-font-alias, 0, 0, 0644, - ,\
		$(XORG_FONTDIR)/100dpi/fonts.alias, n)
	@$(call install_copy, xorg-font-alias, 0, 0, 0644, -, \
		$(XORG_FONTDIR)/75dpi/fonts.alias, n)
	@$(call install_copy, xorg-font-alias, 0, 0, 0644, -, \
		$(XORG_FONTDIR)/cyrillic/fonts.alias, n)
	@$(call install_copy, xorg-font-alias, 0, 0, 0644, -, \
		$(XORG_FONTDIR)/misc/fonts.alias, n)

	@$(call install_finish, xorg-font-alias)

	@$(call touch)

# vim: syntax=make
