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
PACKAGES-$(PTXCONF_LIBTHEORA) += libtheora

#
# Paths and names
#
LIBTHEORA_VERSION	:= 1.0beta3
LIBTHEORA		:= libtheora-$(LIBTHEORA_VERSION)
LIBTHEORA_SUFFIX	:= tar.gz
LIBTHEORA_URL		:= http://downloads.xiph.org/releases/theora/$(LIBTHEORA).$(LIBTHEORA_SUFFIX)
LIBTHEORA_SOURCE	:= $(SRCDIR)/$(LIBTHEORA).$(LIBTHEORA_SUFFIX)
LIBTHEORA_DIR		:= $(BUILDDIR)/$(LIBTHEORA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBTHEORA_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBTHEORA)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/libtheora.extract:
	@$(call targetinfo)
	@$(call clean, $(LIBTHEORA_DIR))
	@$(call extract, LIBTHEORA)
	@$(call patchin, LIBTHEORA)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBTHEORA_PATH	:= PATH=$(CROSS_PATH)
LIBTHEORA_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBTHEORA_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-asm \
	--disable-examples \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-sdltest

ifdef PTXCONF_LIBTHEORA__OGG
LIBTHEORA_AUTOCONF += --enable-ogg
else
LIBTHEORA_AUTOCONF += --disable-ogg
endif
ifdef PTXCONF_LIBTHEORA__VORBIS
LIBTHEORA_AUTOCONF += --enable-vorbis
else
LIBTHEORA_AUTOCONF += --disable-vorbis
endif
ifdef PTXCONF_LIBTHEORA__SDL
LIBTHEORA_AUTOCONF += --enable-sdl
else
LIBTHEORA_AUTOCONF += --disable-sdl
endif
ifdef PTXCONF_LIBTHEORA__FLOAT
LIBTHEORA_AUTOCONF += --enable-float
else
LIBTHEORA_AUTOCONF += --disable-float
endif
ifdef PTXCONF_LIBTHEORA__ENCODING
LIBTHEORA_AUTOCONF += --enable-encoding
else
LIBTHEORA_AUTOCONF += --disable-encoding
endif

$(STATEDIR)/libtheora.prepare:
	@$(call targetinfo)
	@$(call clean, $(LIBTHEORA_DIR)/config.cache)
	cd $(LIBTHEORA_DIR) && \
		$(LIBTHEORA_PATH) $(LIBTHEORA_ENV) \
		./configure $(LIBTHEORA_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/libtheora.compile:
	@$(call targetinfo)
	cd $(LIBTHEORA_DIR) && $(LIBTHEORA_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtheora.install:
	@$(call targetinfo)
	@$(call install, LIBTHEORA)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libtheora.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libtheora)
	@$(call install_fixup, libtheora,PACKAGE,libtheora)
	@$(call install_fixup, libtheora,PRIORITY,optional)
	@$(call install_fixup, libtheora,VERSION,$(LIBTHEORA_VERSION))
	@$(call install_fixup, libtheora,SECTION,base)
	@$(call install_fixup, libtheora,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, libtheora,DEPENDS,)
	@$(call install_fixup, libtheora,DESCRIPTION,missing)

	@$(call install_copy, libtheora, 0, 0, 0644, \
		$(LIBTHEORA_DIR)/lib/.libs/libtheora.so.0.3.3, \
		/usr/lib/libtheora.so.0.3.3)
	@$(call install_link, libtheora, libtheora.so.0.3.3, /usr/lib/libtheora.so.0)
	@$(call install_link, libtheora, libtheora.so.0.3.3, /usr/lib/libtheora.so)

	@$(call install_copy, libtheora, 0, 0, 0644, \
		$(LIBTHEORA_DIR)/lib/.libs/libtheoradec.so.1.0.0, \
		/usr/lib/libtheoradec.so.1.0.0)
	@$(call install_link, libtheora, libtheoradec.so.1.0.0, /usr/lib/libtheoradec.so.0)
	@$(call install_link, libtheora, libtheoradec.so.1.0.0, /usr/lib/libtheoradec.so)

	@$(call install_copy, libtheora, 0, 0, 0644, \
		$(LIBTHEORA_DIR)/lib/.libs/libtheoraenc.so.1.0.0, \
		/usr/lib/libtheoraenc.so.1.0.0)
	@$(call install_link, libtheora, libtheoraenc.so.1.0.0, /usr/lib/libtheoraenc.so.0)
	@$(call install_link, libtheora, libtheoraenc.so.1.0.0, /usr/lib/libtheoraenc.so)

	@$(call install_finish, libtheora)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libtheora_clean:
	rm -rf $(STATEDIR)/libtheora.*
	rm -rf $(PKGDIR)/libtheora_*
	rm -rf $(LIBTHEORA_DIR)

# vim: syntax=make
