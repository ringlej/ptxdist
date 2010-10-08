# -*-makefile-*-
#
# Copyright (C) 2008 by Marek Moeckel
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
PACKAGES-$(PTXCONF_SDL_MIXER) += sdl_mixer

#
# Paths and names
#
SDL_MIXER_VERSION	:= 1.2.11
SDL_MIXER_MD5		:= 65ada3d997fe85109191a5fb083f248c
SDL_MIXER		:= SDL_mixer-$(SDL_MIXER_VERSION)
SDL_MIXER_SUFFIX	:= tar.gz
SDL_MIXER_URL		:= http://www.libsdl.org/projects/SDL_mixer/release/$(SDL_MIXER).$(SDL_MIXER_SUFFIX)
SDL_MIXER_SOURCE	:= $(SRCDIR)/$(SDL_MIXER).$(SDL_MIXER_SUFFIX)
SDL_MIXER_DIR		:= $(BUILDDIR)/$(SDL_MIXER)
SDL_MIXER_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SDL_MIXER_SOURCE):
	@$(call targetinfo)
	@$(call get, SDL_MIXER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL_MIXER_PATH	:= PATH=$(CROSS_PATH)
SDL_MIXER_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SDL_MIXER_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-sdl-prefix=$(SYSROOT)/usr \
	--disable-music-mp3

ifdef PTXCONF_SDL_MIXER_WAVE
SDL_MIXER_AUTOCONF += --enable-music-wave
else
SDL_MIXER_AUTOCONF += --disable-music-wave
endif

ifdef PTXCONF_SDL_MIXER_MOD
SDL_MIXER_AUTOCONF += --enable-music-mod
else
SDL_MIXER_AUTOCONF += --disable-music-mod
endif

ifneq ($(PTXCONF_SDL_MIXER_MIDI_TIMIDITY)$(PTXCONF_SDL_MIXER_MIDI_NATIVE),)
SDL_MIXER_AUTOCONF += --enable-music-midi
else
SDL_MIXER_AUTOCONF += --disable-music-midi
endif

ifdef PTXCONF_SDL_MIXER_MIDI_TIMIDITY
SDL_MIXER_AUTOCONF += --enable-music-timidity-midi
else
SDL_MIXER_AUTOCONF += --disable-music-timidity-midi
endif

ifdef PTXCONF_SDL_MIXER_MIDI_NATIVE
SDL_MIXER_AUTOCONF += --enable-music-native-midi-gpl
else
SDL_MIXER_AUTOCONF += --disable-music-native-midi-gpl
endif

ifdef PTXCONF_SDL_MIXER_OGG
SDL_MIXER_AUTOCONF += --enable-music-ogg
else
SDL_MIXER_AUTOCONF += --disable-music-ogg
endif

ifdef PTXCONF_SDL_MIXER_FLAC
SDL_MIXER_AUTOCONF += --enable-music-flac
else
SDL_MIXER_AUTOCONF += --disable-music-flac
endif

ifdef PTXCONF_SDL_MIXER_MP3
SDL_MIXER_AUTOCONF += --enable-music-mp3-mad-gpl
else
SDL_MIXER_AUTOCONF += --disable-music-mp3-mad-gpl
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl_mixer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl_mixer)
	@$(call install_fixup, sdl_mixer,PRIORITY,optional)
	@$(call install_fixup, sdl_mixer,SECTION,base)
	@$(call install_fixup, sdl_mixer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, sdl_mixer,DESCRIPTION,missing)

	@$(call install_lib, sdl_mixer, 0, 0, 0644, libSDL_mixer-1.2)

	@$(call install_finish, sdl_mixer)

	@$(call touch)

# vim: syntax=make
