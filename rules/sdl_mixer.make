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
SDL_MIXER_VERSION	:= 1.2.8
SDL_MIXER		:= SDL_mixer-$(SDL_MIXER_VERSION)
SDL_MIXER_SUFFIX	:= tar.gz
SDL_MIXER_URL		:= http://www.libsdl.org/projects/SDL_mixer/release/$(SDL_MIXER).$(SDL_MIXER_SUFFIX)
SDL_MIXER_SOURCE	:= $(SRCDIR)/$(SDL_MIXER).$(SDL_MIXER_SUFFIX)
SDL_MIXER_DIR		:= $(BUILDDIR)/$(SDL_MIXER)

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

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl_mixer.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl_mixer)
	@$(call install_fixup, sdl_mixer,PACKAGE,sdl-mixer)
	@$(call install_fixup, sdl_mixer,PRIORITY,optional)
	@$(call install_fixup, sdl_mixer,VERSION,$(SDL_MIXER_VERSION))
	@$(call install_fixup, sdl_mixer,SECTION,base)
	@$(call install_fixup, sdl_mixer,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, sdl_mixer,DEPENDS,)
	@$(call install_fixup, sdl_mixer,DESCRIPTION,missing)

	@$(call install_copy, sdl_mixer, 0, 0, 0644, -, \
		/usr/lib/libSDL_mixer-1.2.so.0.2.6)

	@$(call install_link, sdl_mixer, libSDL_mixer-1.2.so.0.2.6, /usr/lib/libSDL_mixer-1.2.so.0)
	@$(call install_link, sdl_mixer, libSDL_mixer-1.2.so.0, /usr/lib/libSDL_mixer.so)

	@$(call install_finish, sdl_mixer)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sdl_mixer_clean:
	rm -rf $(STATEDIR)/sdl_mixer.*
	rm -rf $(PKGDIR)/sdl_mixer_*
	rm -rf $(SDL_MIXER_DIR)

# vim: syntax=make
