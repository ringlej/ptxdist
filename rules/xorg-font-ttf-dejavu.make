# -*-makefile-*-
#
# Copyright (C) 2015 by Philipp Zabel <p.zabel@pengutronix.de>
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

ifdef PTXCONF_XORG_FONT_TTF_DEJAVU
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-ttf-dejavu.targetinstall
endif

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

	@rm -rf $(XORG_FONT_TTF_DEJAVU_PKGDIR)
	@mkdir -p $(XORG_FONT_TTF_DEJAVU_PKGDIR)/etc/fonts/conf.avail
	@mkdir -p $(XORG_FONT_TTF_DEJAVU_PKGDIR)/etc/fonts/conf.d

	@for file in $(XORG_FONT_TTF_DEJAVU_DIR)/fontconfig/*.conf; do \
		install -m 644 $${file} $(XORG_FONT_TTF_DEJAVU_PKGDIR)/etc/fonts/conf.avail; \
		ln -s ../conf.avail/$$(basename $${file}) $(XORG_FONT_TTF_DEJAVU_PKGDIR)/etc/fonts/conf.d/$$(basename $${file}); \
	done

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-ttf-dejavu.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/truetype

	@find $(XORG_FONT_TTF_DEJAVU_DIR) \
		-name "*.ttf" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/truetype; \
	done

	@$(call install_init,  xorg-font-ttf-dejavu)
	@$(call install_fixup, xorg-font-ttf-dejavu,PRIORITY,optional)
	@$(call install_fixup, xorg-font-ttf-dejavu,SECTION,base)
	@$(call install_fixup, xorg-font-ttf-dejavu,AUTHOR,"Philipp Zabel <p.zabel@pengutronix.de>")
	@$(call install_fixup, xorg-font-ttf-dejavu,DESCRIPTION,missing)

	@$(call install_tree, xorg-font-ttf-dejavu, 0, 0, -, /etc/fonts/conf.d)
	@$(call install_tree, xorg-font-ttf-dejavu, 0, 0, -, /etc/fonts/conf.avail)

	@$(call install_finish, xorg-font-ttf-dejavu)

	@$(call touch)

# vim: syntax=make
