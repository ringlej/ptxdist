# Copyright (C) 2009 by Markus Rathgeb <rathgeb.markus@googlemail.com>

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL_GFX) += sdl-gfx

#
# Paths and names
#
SDL_GFX_VERSION	:= 2.0.20
SDL_GFX		:= SDL_gfx-$(SDL_GFX_VERSION)
SDL_GFX_SUFFIX	:= tar.gz
SDL_GFX_URL	:= http://www.ferzkopp.net/Software/SDL_gfx-2.0/$(SDL_GFX).$(SDL_GFX_SUFFIX)
SDL_GFX_SOURCE	:= $(SRCDIR)/$(SDL_GFX).$(SDL_GFX_SUFFIX)
SDL_GFX_DIR	:= $(BUILDDIR)/$(SDL_GFX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SDL_GFX_SOURCE):
	@$(call targetinfo)
	@$(call get, SDL_GFX)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL_GFX_PATH	:=  PATH=$(CROSS_PATH)
SDL_GFX_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
SDL_GFX_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-sdl-prefix=$(SYSROOT)/usr \
	--disable-mmx \
	--disable-sdltest \
	--disable-dependency-tracking

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl-gfx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl-gfx)
	@$(call install_fixup, sdl-gfx,PACKAGE,sdl-gfx)
	@$(call install_fixup, sdl-gfx,PRIORITY,optional)
	@$(call install_fixup, sdl-gfx,VERSION,$(SDL_GFX_VERSION))
	@$(call install_fixup, sdl-gfx,SECTION,base)
	@$(call install_fixup, sdl-gfx,AUTHOR,"Markus Rathgeb <rathgeb.markus\@googlemail.com>")
	@$(call install_fixup, sdl-gfx,DEPENDS,)
	@$(call install_fixup, sdl-gfx,DESCRIPTION,missing)

	@$(call install_copy, sdl-gfx, 0, 0, 0644, -, \
		/usr/lib/libSDL_gfx.so.13.5.2)
	@$(call install_link, sdl-gfx, libSDL_gfx.so.13.5.2, \
		/usr/lib/libSDL_gfx.so.13)
	@$(call install_link, sdl-gfx, libSDL_gfx.so.13.5.2, \
		/usr/lib/libSDL_gfx.so)

	@$(call install_finish, sdl-gfx)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sdl-gfx_clean:
	rm -rf $(STATEDIR)/sdl-gfx.*
	rm -rf $(PKGDIR)/sdl-gfx_*
	rm -rf $(SDL_GFX_DIR)

# vim: syntax=make
