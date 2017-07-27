# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger <b.spranger@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGD) += libgd

#
# Paths and names
#
LIBGD_VERSION	:= 2.2.4
LIBGD_MD5	:= 0a3c307b5075edbe1883543dd1153c02
LIBGD		:= gd-$(LIBGD_VERSION)
LIBGD_SUFFIX	:= tar.gz
LIBGD_URL	:= https://github.com/libgd/libgd/releases/download/$(LIBGD)/libgd-$(LIBGD_VERSION).$(LIBGD_SUFFIX)
LIBGD_SOURCE	:= $(SRCDIR)/$(LIBGD).$(LIBGD_SUFFIX)
LIBGD_DIR	:= $(BUILDDIR)/$(LIBGD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGD_PATH	:= PATH=$(CROSS_PATH)
LIBGD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGD_AUTOCONF  := \
	$(CROSS_AUTOCONF_USR) \
	--disable-rpath \
	--disable-werror \
	--$(call ptx/wwo, PTXCONF_LIBGD_X)-x \
	--with-zlib \
	--$(call ptx/wwo, PTXCONF_LIBGD_PNG)-png \
	--$(call ptx/wwo, PTXCONF_LIBGD_FREETYPE)-freetype \
	--$(call ptx/wwo, PTXCONF_LIBGD_FONTCONFIG)-fontconfig \
	--$(call ptx/wwo, PTXCONF_LIBGD_JPEG)-jpeg \
	--without-liq \
	--$(call ptx/wwo, PTXCONF_LIBGD_XPM)-xpm \
	--without-tiff \
	--without-webp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgd)
	@$(call install_fixup, libgd,PRIORITY,optional)
	@$(call install_fixup, libgd,SECTION,base)
	@$(call install_fixup, libgd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libgd,DESCRIPTION,missing)

	@$(call install_lib, libgd, 0, 0, 0644, libgd)

	@$(call install_finish, libgd)

	@$(call touch)

# vim: syntax=make
