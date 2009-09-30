# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>

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

SDL_TTF_PATH	:=  PATH=$(CROSS_PATH)
SDL_TTF_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
SDL_TTF_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-sdl-prefix=$(SYSROOT)/usr \
	--disable-sdltest \
	--disable-dependency-tracking \
	--without-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl-ttf.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl-ttf)
	@$(call install_fixup, sdl-ttf,PACKAGE,sdl-ttf)
	@$(call install_fixup, sdl-ttf,PRIORITY,optional)
	@$(call install_fixup, sdl-ttf,VERSION,$(SDL_TTF_VERSION))
	@$(call install_fixup, sdl-ttf,SECTION,base)
	@$(call install_fixup, sdl-ttf,AUTHOR,"Markus Rathgeb <rathgeb.markus\@googlemail.com>")
	@$(call install_fixup, sdl-ttf,DEPENDS,)
	@$(call install_fixup, sdl-ttf,DESCRIPTION,missing)

	@$(call install_copy, sdl-ttf, 0, 0, 0644, -, \
		/usr/lib/libSDL_ttf-2.0.so.0.6.3)
	@$(call install_link, sdl-ttf, libSDL_ttf-2.0.so.0.6.3, \
		/usr/lib/libSDL_ttf-2.0.so.0)
	@$(call install_link, sdl-ttf, libSDL_ttf-2.0.so.0.6.3, \
		/usr/lib/libSDL_ttf.so)

	@$(call install_finish, sdl-ttf)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sdl-ttf_clean:
	rm -rf $(STATEDIR)/sdl-ttf.*
	rm -rf $(PKGDIR)/sdl-ttf_*
	rm -rf $(SDL_TTF_DIR)

# vim: syntax=make
