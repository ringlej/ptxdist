# -*-makefile-*-
#
# Copyright (C) 2018 by Sergey Zhuravlevich <zhurxx@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL2_IMAGE) += sdl2-image

#
# Paths and names
#
SDL2_IMAGE_VERSION	:= 2.0.3
SDL2_IMAGE_MD5		:= c6baf6dfa80fa8a66853661a36a6034e
SDL2_IMAGE		:= SDL2_image-$(SDL2_IMAGE_VERSION)
SDL2_IMAGE_SUFFIX	:= tar.gz
SDL2_IMAGE_URL		:= https://www.libsdl.org/projects/SDL_image/release/$(SDL2_IMAGE).$(SDL2_IMAGE_SUFFIX)
SDL2_IMAGE_SOURCE	:= $(SRCDIR)/$(SDL2_IMAGE).$(SDL2_IMAGE_SUFFIX)
SDL2_IMAGE_DIR		:= $(BUILDDIR)/$(SDL2_IMAGE)
SDL2_IMAGE_LICENSE	:= zlib

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDL2_IMAGE_CONF_TOOL	:= autoconf
SDL2_IMAGE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--disable-sdltest \
	--disable-jpg-shared \
	--disable-png-shared \
	--disable-tif-shared \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_BMP)-bmp \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_GIF)-gif \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_JPG)-jpg \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_LBM)-lbm \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_PCX)-pcx \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_PNG)-png \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_PNM)-pnm \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_TGA)-tga \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_TIF)-tif \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_XCF)-xcf \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_XPM)-xpm \
	--$(call ptx/endis, PTXCONF_SDL2_IMAGE_XV)-xv

ifdef PTXCONF_SDL2_PULSEAUDIO
SDL2_IMAGE_LDFLAGS	:= \
	-Wl,-rpath-link,$(SYSROOT)/usr/lib/pulseaudio
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl2-image.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl2-image)
	@$(call install_fixup, sdl2-image,PRIORITY,optional)
	@$(call install_fixup, sdl2-image,SECTION,base)
	@$(call install_fixup, sdl2-image,AUTHOR,"Sergey Zhuravlevich <zhurxx@gmail.com>")
	@$(call install_fixup, sdl2-image,DESCRIPTION,missing)

	@$(call install_lib, sdl2-image, 0, 0, 0644, libSDL2_image-2.0)

	@$(call install_finish, sdl2-image)

	@$(call touch)

# vim: syntax=make
