# -*-makefile-*-
#
# Copyright (C) 2017 Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HARFBUZZ) += harfbuzz

#
# Paths and names
#
HARFBUZZ_VERSION	:= 1.8.0
HARFBUZZ_MD5		:= 1023806c6a25a3fb11af0bcee8d0dc7c
HARFBUZZ		:= harfbuzz-$(HARFBUZZ_VERSION)
HARFBUZZ_SUFFIX		:= tar.bz2
HARFBUZZ_URL		:= https://www.freedesktop.org/software/harfbuzz/release/$(HARFBUZZ).$(HARFBUZZ_SUFFIX)
HARFBUZZ_SOURCE		:= $(SRCDIR)/$(HARFBUZZ).$(HARFBUZZ_SUFFIX)
HARFBUZZ_DIR		:= $(BUILDDIR)/$(HARFBUZZ)
HARFBUZZ_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HARFBUZZ_CONF_TOOL	:= autoconf
HARFBUZZ_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-static \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-introspection \
	--with-glib \
	--without-gobject \
	--without-cairo \
	--with-fontconfig \
	--without-icu \
	--without-ucdn \
	--without-graphite2 \
	--with-freetype \
	--without-uniscribe \
	--without-directwrite \
	--without-coretext

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/harfbuzz.targetinstall:
	@$(call targetinfo)

	@$(call install_init, harfbuzz)
	@$(call install_fixup, harfbuzz,PRIORITY,optional)
	@$(call install_fixup, harfbuzz,SECTION,base)
	@$(call install_fixup, harfbuzz,AUTHOR,"Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, harfbuzz,DESCRIPTION, "OpenType text shaping engine")

	@$(call install_lib, harfbuzz, 0, 0, 0644, libharfbuzz)

	@$(call install_finish, harfbuzz)

	@$(call touch)

# vim: syntax=make
