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
	--disable-examples \
	--$(call ptx/endis, PTXCONF_LIBTHEORA__OGG)-ogg \
	--$(call ptx/endis, PTXCONF_LIBTHEORA__VORBIS)-vorbis \
	--$(call ptx/endis, PTXCONF_LIBTHEORA__SDL)-sdl \
	--$(call ptx/endis, PTXCONF_LIBTHEORA__FLOAT)-float \
	--$(call ptx/endis, PTXCONF_LIBTHEORA__ENCODING)-encode

ifndef PTXCONF_LIBTHEORA__DOC
LIBTHEORA_AUTOCONF += \
	ac_cv_prog_HAVE_DOXYGEN=false \
	ac_cv_prog_HAVE_PDFLATEX=no \
	ac_cv_prog_HAVE_BIBTEX=no \
	ac_cv_prog_HAVE_TRANSFIG=no
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
