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
PACKAGES-$(PTXCONF_SDL2_TTF) += sdl2-ttf

#
# Paths and names
#
SDL2_TTF_VERSION	:= 2.0.14
SDL2_TTF_MD5		:= e53c05e1e7f1382c316afd6c763388b1
SDL2_TTF		:= SDL2_ttf-$(SDL2_TTF_VERSION)
SDL2_TTF_SUFFIX	:= tar.gz
SDL2_TTF_URL		:= https://www.libsdl.org/projects/SDL_ttf/release/$(SDL2_TTF).$(SDL2_TTF_SUFFIX)
SDL2_TTF_SOURCE	:= $(SRCDIR)/$(SDL2_TTF).$(SDL2_TTF_SUFFIX)
SDL2_TTF_DIR		:= $(BUILDDIR)/$(SDL2_TTF)
SDL2_TTF_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL2_TTF_CONF_TOOL	:= autoconf
SDL2_TTF_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis,PTXCONF_SDL2_OPENGL)-opengl

ifdef PTXCONF_SDL2_PULSEAUDIO
SDL2_TTF_LDFLAGS	:= \
	-Wl,-rpath-link,$(SYSROOT)/usr/lib/pulseaudio
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl2-ttf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl2-ttf)
	@$(call install_fixup, sdl2-ttf,PRIORITY,optional)
	@$(call install_fixup, sdl2-ttf,SECTION,base)
	@$(call install_fixup, sdl2-ttf,AUTHOR,"Michael Grzeschik <mgr@pengutronix.de>")
	@$(call install_fixup, sdl2-ttf,DESCRIPTION,missing)

	@$(call install_lib, sdl2-ttf, 0, 0, 0644, libSDL2_ttf-2.0)

	@$(call install_finish, sdl2-ttf)

	@$(call touch)

# vim: syntax=make
