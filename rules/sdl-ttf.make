# -*-makefile-*-
#
# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL_TTF) += sdl-ttf

#
# Paths and names
#
SDL_TTF_VERSION	:= 2.0.9
SDL_TTF		:= SDL_ttf-$(SDL_TTF_VERSION)
SDL_TTF_SUFFIX	:= tar.gz
SDL_TTF_URL	:= http://www.libsdl.org/projects/SDL_ttf/release/$(SDL_TTF).$(SDL_TTF_SUFFIX)
SDL_TTF_SOURCE	:= $(SRCDIR)/$(SDL_TTF).$(SDL_TTF_SUFFIX)
SDL_TTF_DIR	:= $(BUILDDIR)/$(SDL_TTF)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SDL_TTF_SOURCE):
	@$(call targetinfo)
	@$(call get, SDL_TTF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL_TTF_PATH	:= PATH=$(CROSS_PATH)
SDL_TTF_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SDL_TTF_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-sdl-prefix=$(SYSROOT)/usr \
	--disable-sdltest \
	--without-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl-ttf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl-ttf)
	@$(call install_fixup, sdl-ttf,PRIORITY,optional)
	@$(call install_fixup, sdl-ttf,SECTION,base)
	@$(call install_fixup, sdl-ttf,AUTHOR,"Markus Rathgeb <rathgeb.markus@googlemail.com>")
	@$(call install_fixup, sdl-ttf,DESCRIPTION,missing)

	@$(call install_lib, sdl-ttf, 0, 0, 0644, libSDL_ttf-2.0)

	@$(call install_finish, sdl-ttf)

	@$(call touch)

# vim: syntax=make
