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
LIBTHEORA_MD5		:= bb4dc37f0dc97db98333e7160bfbb52b
LIBTHEORA		:= libtheora-$(LIBTHEORA_VERSION)
LIBTHEORA_SUFFIX	:= tar.gz
LIBTHEORA_URL		:= http://downloads.xiph.org/releases/theora/$(LIBTHEORA).$(LIBTHEORA_SUFFIX)
LIBTHEORA_SOURCE	:= $(SRCDIR)/$(LIBTHEORA).$(LIBTHEORA_SUFFIX)
LIBTHEORA_DIR		:= $(BUILDDIR)/$(LIBTHEORA)

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
	@$(call install_fixup, libtheora,PRIORITY,optional)
	@$(call install_fixup, libtheora,SECTION,base)
	@$(call install_fixup, libtheora,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libtheora,DESCRIPTION,missing)

	@$(call install_lib, libtheora, 0, 0, 0644, libtheora)
	@$(call install_lib, libtheora, 0, 0, 0644, libtheoradec)
	@$(call install_lib, libtheora, 0, 0, 0644, libtheoraenc)

	@$(call install_finish, libtheora)

	@$(call touch)

# vim: syntax=make
