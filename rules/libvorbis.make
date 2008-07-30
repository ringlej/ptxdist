# -*-makefile-*-
# $Id: template-make 8509 2008-06-12 12:45:40Z mkl $
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
LIBVORBIS_VERSION	:= 1.2.0
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
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libvorbis.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBVORBIS_DIR))
	@$(call extract, LIBVORBIS)
	@$(call patchin, LIBVORBIS)
	@$(call touch)

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

$(STATEDIR)/libvorbis.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBVORBIS_DIR)/config.cache)
	cd $(LIBVORBIS_DIR) && \
		$(LIBVORBIS_PATH) $(LIBVORBIS_ENV) \
		./configure $(LIBVORBIS_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libvorbis.compile:
	@$(call targetinfo)
	cd $(LIBVORBIS_DIR) && $(LIBVORBIS_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libvorbis.install:
	@$(call targetinfo)
	@$(call install, LIBVORBIS)
	@$(call touch)

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
	@$(call install_fixup, libvorbis,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libvorbis,DEPENDS,)
	@$(call install_fixup, libvorbis,DESCRIPTION,missing)

	@$(call install_copy, libvorbis, 0, 0, 0644, \
		$(LIBVORBIS_DIR)/lib/.libs/libvorbis.so.0.4.0, \
		/usr/lib/libvorbis.so.0.4.0)
	@$(call install_link, libvorbis, libvorbis.so.0.4.0, libvorbis.so.0)
	@$(call install_link, libvorbis, libvorbis.so.0.4.0, libvorbis.so)

	@$(call install_copy, libvorbisenc, 0, 0, 0644, \
		$(LIBVORBIS_DIR)/lib/.libs/libvorbisenc.so.2.0.3, \
		/usr/lib/libvorbisenc.so.2.0.3)
	@$(call install_link, libvorbisenc, libvorbisenc.so.2.0.3, libvorbis.so.0)
	@$(call install_link, libvorbisenc, libvorbisenc.so.2.0.3, libvorbis.so)

	@$(call install_copy, libvorbisfile, 0, 0, 0644, \
		$(LIBVORBIS_DIR)/lib/.libs/libvorbisfile.so.3.2.0, \
		/usr/lib/libvorbisfile.so.3.2.0)
	@$(call install_link, libvorbisfile, libvorbisfile.so.3.2.0, libvorbis.so.0)
	@$(call install_link, libvorbisfile, libvorbisfile.so.3.2.0, libvorbis.so)

	@$(call install_finish, libvorbis)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libvorbis_clean:
	rm -rf $(STATEDIR)/libvorbis.*
	rm -rf $(PKGDIR)/libvorbis_*
	rm -rf $(LIBVORBIS_DIR)

# vim: syntax=make
