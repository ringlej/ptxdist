# -*-makefile-*-
#
# Copyright (C) 2003-2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FREETYPE) += freetype

#
# Paths and names
#
FREETYPE_VERSION	:= 2.5.2
FREETYPE_MD5		:= 10e8f4d6a019b124088d18bc26123a25
FREETYPE		:= freetype-$(FREETYPE_VERSION)
FREETYPE_SUFFIX		:= tar.bz2
FREETYPE_SOURCE		:= $(SRCDIR)/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_DIR		:= $(BUILDDIR)/$(FREETYPE)
FREETYPE_LICENSE	:= BSD-2-Clause, FTL, GPL-2.0+
FREETYPE_LICENSE_FILES	:= \
	file://docs/LICENSE.TXT;md5=c017ff17fc6f0794adf93db5559ccd56 \
	file://docs/GPLv2.TXT;md5=8ef380476f642c20ebf40fecb0add2ec \
	file://docs/FTL.TXT;md5=d479e83797f699fe873b38dadd0fcd4c \
	file://src/bdf/README;startline=98;endline=140;md5=d0c2c2e2e102c393a12869bc34515be2 \
	file://src/pcf/README;startline=69;endline=88;md5=e0f11f550450e58753f2d54ddaf17d34

FREETYPE_URL := \
	http://download.savannah.gnu.org/releases/freetype/$(FREETYPE).$(FREETYPE_SUFFIX) \
	http://download.savannah.gnu.org/releases/freetype/freetype-old/$(FREETYPE).$(FREETYPE_SUFFIX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
FREETYPE_CONF_TOOL	:= autoconf
FREETYPE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	--with-zlib \
	--without-bzip2 \
	--without-png


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/freetype.targetinstall:
	@$(call targetinfo)

	@$(call install_init, freetype)
	@$(call install_fixup, freetype,PRIORITY,optional)
	@$(call install_fixup, freetype,SECTION,base)
	@$(call install_fixup, freetype,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, freetype,DESCRIPTION,missing)

	@$(call install_lib, freetype, 0, 0, 0644, libfreetype)

	@$(call install_finish, freetype)

	@$(call touch)

# vim: syntax=make
