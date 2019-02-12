# -*-makefile-*-
#
# Copyright (C) 2015 by Philipp Zabel <p.zabel@pengutronix.de>
#           (C) 2018 by Florian Bäuerle <florian.baeuerle@allegion.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_TTF_DEJAVU) += xorg-font-ttf-dejavu

#
# Paths and names
#
XORG_FONT_TTF_DEJAVU_VERSION	:= 2.35
XORG_FONT_TTF_DEJAVU_MD5	:= 59eaca5acf5c7c8212e92778e3e01f32
XORG_FONT_TTF_DEJAVU		:= dejavu-fonts-ttf-$(XORG_FONT_TTF_DEJAVU_VERSION)
XORG_FONT_TTF_DEJAVU_SUFFIX	:= tar.bz2
XORG_FONT_TTF_DEJAVU_URL	:= http://sourceforge.net/projects/dejavu/files/dejavu/$(XORG_FONT_TTF_DEJAVU_VERSION)/$(XORG_FONT_TTF_DEJAVU).$(XORG_FONT_TTF_DEJAVU_SUFFIX)
XORG_FONT_TTF_DEJAVU_SOURCE	:= $(SRCDIR)/$(XORG_FONT_TTF_DEJAVU).$(XORG_FONT_TTF_DEJAVU_SUFFIX)
XORG_FONT_TTF_DEJAVU_DIR	:= $(BUILDDIR)/$(XORG_FONT_TTF_DEJAVU)
XORG_FONT_TTF_DEJAVU_LICENSE	:= Bitstream-Vera AND public_domain

XORG_FONT_TTF_DEJAVU_CONF_TOOL	:= NO
XORG_FONT_TTF_DEJAVU_FONTDIR	:= $(XORG_FONTDIR)/truetype/dejavu

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-dejavu.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-dejavu.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-dejavu.install:
	@$(call targetinfo)

	@$(call world/install-fonts,XORG_FONT_TTF_DEJAVU,*.ttf)
	@mkdir -p $(XORG_FONT_TTF_DEJAVU_PKGDIR)/etc/fonts/conf.avail
	@mkdir -p $(XORG_FONT_TTF_DEJAVU_PKGDIR)/etc/fonts/conf.d

	@for file in $(XORG_FONT_TTF_DEJAVU_DIR)/fontconfig/*.conf; do \
		name=$$(basename $${file}); \
		install -m 644 $${file} $(XORG_FONT_TTF_DEJAVU_PKGDIR)/etc/fonts/conf.avail; \
		ln -s ../conf.avail/$${name} $(XORG_FONT_TTF_DEJAVU_PKGDIR)/etc/fonts/conf.d/$${name}; \
	done

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-dejavu.targetinstall:
	@$(call targetinfo)
	@$(call install_init,  xorg-font-ttf-dejavu)
	@$(call install_fixup, xorg-font-ttf-dejavu,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-dejavu,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-dejavu,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-dejavu,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-dejavu, 0, 0, -, /etc)
	@$(call install_tree, xorg-font-ttf-dejavu, 0, 0, -, /usr)

	@$(call install_finish, xorg-font-ttf-dejavu)
	@$(call touch)

# vim: syntax=make
