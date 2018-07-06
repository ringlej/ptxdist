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
LIBVORBIS_VERSION	:= 1.3.3
LIBVORBIS_MD5		:= 6b1a36f0d72332fae5130688e65efe1f
LIBVORBIS		:= libvorbis-$(LIBVORBIS_VERSION)
LIBVORBIS_SUFFIX	:= tar.gz
LIBVORBIS_URL		:= http://downloads.xiph.org/releases/vorbis/$(LIBVORBIS).$(LIBVORBIS_SUFFIX)
LIBVORBIS_SOURCE	:= $(SRCDIR)/$(LIBVORBIS).$(LIBVORBIS_SUFFIX)
LIBVORBIS_DIR		:= $(BUILDDIR)/$(LIBVORBIS)
LIBVORBIS_LICENSE	:= BSD-3-Clause

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
	--disable-examples \
	--disable-oggtest

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libvorbis.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libvorbis)
	@$(call install_fixup, libvorbis,PRIORITY,optional)
	@$(call install_fixup, libvorbis,SECTION,base)
	@$(call install_fixup, libvorbis,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libvorbis,DESCRIPTION,missing)

	@$(call install_lib, libvorbis, 0, 0, 0644, libvorbis)
	@$(call install_lib, libvorbis, 0, 0, 0644, libvorbisenc)
	@$(call install_lib, libvorbis, 0, 0, 0644, libvorbisfile)

	@$(call install_finish, libvorbis)

	@$(call touch)

# vim: syntax=make
