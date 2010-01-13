# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
LIBTHEORA_VERSION	:= 1.1.1
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
	--disable-spec \
	--disable-valgrind-testing \
	--disable-telemetry \
	--disable-examples


ifndef PTXCONF_LIBTHEORA__DOC
LIBTHEORA_AUTOCONF += \
	ac_cv_prog_HAVE_DOXYGEN=false \
	ac_cv_prog_HAVE_PDFLATEX=no \
	ac_cv_prog_HAVE_BIBTEX=no \
	ac_cv_prog_HAVE_TRANSFIG=no
endif

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
LIBTHEORA_AUTOCONF += --enable-encode
else
LIBTHEORA_AUTOCONF += --disable-encode
endif

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
	@$(call install_fixup, libtheora,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libtheora,DEPENDS,)
	@$(call install_fixup, libtheora,DESCRIPTION,missing)

	@$(call install_copy, libtheora, 0, 0, 0644, -, /usr/lib/libtheora.so.0.3.10)
	@$(call install_link, libtheora, libtheora.so.0.3.10, /usr/lib/libtheora.so.0)
	@$(call install_link, libtheora, libtheora.so.0.3.10, /usr/lib/libtheora.so)

	@$(call install_copy, libtheora, 0, 0, 0644, -,	/usr/lib/libtheoradec.so.1.1.4)
	@$(call install_link, libtheora, libtheoradec.so.1.1.4, /usr/lib/libtheoradec.so.1)
	@$(call install_link, libtheora, libtheoradec.so.1.1.4, /usr/lib/libtheoradec.so)

	@$(call install_copy, libtheora, 0, 0, 0644, -, /usr/lib/libtheoraenc.so.1.1.2)
	@$(call install_link, libtheora, libtheoraenc.so.1.1.2, /usr/lib/libtheoraenc.so.1)
	@$(call install_link, libtheora, libtheoraenc.so.1.1.2, /usr/lib/libtheoraenc.so)

	@$(call install_finish, libtheora)

	@$(call touch)

# vim: syntax=make
