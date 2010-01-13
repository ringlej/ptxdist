# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBVORBIS) += libvorbis

#
# Paths and names
#
LIBVORBIS_VERSION	:= 1.2.3
LIBVORBIS		:= libvorbis-$(LIBVORBIS_VERSION)
LIBVORBIS_SUFFIX	:= tar.gz
LIBVORBIS_URL		:= http://downloads.xiph.org/releases/vorbis/$(LIBVORBIS).$(LIBVORBIS_SUFFIX)
LIBVORBIS_SOURCE	:= $(SRCDIR)/$(LIBVORBIS).$(LIBVORBIS_SUFFIX)
LIBVORBIS_DIR		:= $(BUILDDIR)/$(LIBVORBIS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBVORBIS_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBVORBIS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBVORBIS_PATH	:= PATH=$(CROSS_PATH)
LIBVORBIS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBVORBIS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs \
	--disable-oggtest

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libvorbis.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libvorbis)
	@$(call install_fixup, libvorbis,PACKAGE,libvorbis)
	@$(call install_fixup, libvorbis,PRIORITY,optional)
	@$(call install_fixup, libvorbis,VERSION,$(LIBVORBIS_VERSION))
	@$(call install_fixup, libvorbis,SECTION,base)
	@$(call install_fixup, libvorbis,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libvorbis,DEPENDS,)
	@$(call install_fixup, libvorbis,DESCRIPTION,missing)

	@$(call install_copy, libvorbis, 0, 0, 0644, -,	/usr/lib/libvorbis.so.0.4.3)
	@$(call install_link, libvorbis, libvorbis.so.0.4.3, /usr/lib/libvorbis.so.0)
	@$(call install_link, libvorbis, libvorbis.so.0.4.3, /usr/lib/libvorbis.so)

	@$(call install_copy, libvorbis, 0, 0, 0644, -,	/usr/lib/libvorbisenc.so.2.0.6)
	@$(call install_link, libvorbis, libvorbisenc.so.2.0.6, /usr/lib/libvorbisenc.so.2)
	@$(call install_link, libvorbis, libvorbisenc.so.2.0.6, /usr/lib/libvorbisenc.so)

	@$(call install_copy, libvorbis, 0, 0, 0644, -, /usr/lib/libvorbisfile.so.3.3.2)
	@$(call install_link, libvorbis, libvorbisfile.so.3.3.2, /usr/lib/libvorbisfile.so.3)
	@$(call install_link, libvorbis, libvorbisfile.so.3.3.2, /usr/lib/libvorbisfile.so)

	@$(call install_finish, libvorbis)

	@$(call touch)

# vim: syntax=make
