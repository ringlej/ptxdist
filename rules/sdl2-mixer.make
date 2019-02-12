# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Grzeschik <mgr@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL2_MIXER) += sdl2-mixer

#
# Paths and names
#
SDL2_MIXER_VERSION	:= 2.0.4
SDL2_MIXER_MD5		:= a36e8410cac46b00a4d01752b32c3eb1
SDL2_MIXER		:= SDL2_mixer-$(SDL2_MIXER_VERSION)
SDL2_MIXER_SUFFIX	:= tar.gz
SDL2_MIXER_URL		:= https://www.libsdl.org/projects/SDL_mixer/release/$(SDL2_MIXER).$(SDL2_MIXER_SUFFIX)
SDL2_MIXER_SOURCE	:= $(SRCDIR)/$(SDL2_MIXER).$(SDL2_MIXER_SUFFIX)
SDL2_MIXER_DIR		:= $(BUILDDIR)/$(SDL2_MIXER)
SDL2_MIXER_LICENSE	:= zlib

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL2_MIXER_CONF_TOOL	:= autoconf
SDL2_MIXER_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-sdltest \
	--enable-music-cmd \
	--enable-music-wave \
	--disable-music-mod \
	--disable-music-mod-modplug \
	--disable-music-mod-mikmod \
	--disable-music-midi \
	--disable-music-midi-timidity \
	--disable-music-midi-native \
	--disable-music-midi-fluidsynth \
	--disable-music-ogg \
	--disable-music-opus \
	--disable-music-ogg-tremor \
	--disable-music-flac \
	--disable-music-mp3 \
	--disable-music-mp3-mad-gpl \
	--disable-music-mp3-mad-gpl-dithering \
	--disable-music-mp3-mpg123

ifdef PTXCONF_SDL2_PULSEAUDIO
SDL2_MIXER_LDFLAGS	:= \
	-Wl,-rpath-link,$(SYSROOT)/usr/lib/pulseaudio
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl2-mixer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl2-mixer)
	@$(call install_fixup, sdl2-mixer,PRIORITY,optional)
	@$(call install_fixup, sdl2-mixer,SECTION,base)
	@$(call install_fixup, sdl2-mixer,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, sdl2-mixer,DESCRIPTION,missing)

	@$(call install_lib, sdl2-mixer, 0, 0, 0644, libSDL2_mixer-2.0)

	@$(call install_finish, sdl2-mixer)

	@$(call touch)

# vim: syntax=make
