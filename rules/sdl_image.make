# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL_IMAGE) += sdl_image

#
# Paths and names
#
SDL_IMAGE_VERSION	:= 1.2.4
SDL_IMAGE		:= SDL_image-$(SDL_IMAGE_VERSION)
SDL_IMAGE_SUFFIX	:= tar.gz
SDL_IMAGE_URL		:= http://www.libsdl.org/projects/SDL_image/release/$(SDL_IMAGE).$(SDL_IMAGE_SUFFIX)
SDL_IMAGE_SOURCE	:= $(SRCDIR)/$(SDL_IMAGE).$(SDL_IMAGE_SUFFIX)
SDL_IMAGE_DIR		:= $(BUILDDIR)/$(SDL_IMAGE)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sdl_image_get: $(STATEDIR)/sdl_image.get

$(STATEDIR)/sdl_image.get: $(sdl_image_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SDL_IMAGE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SDL_IMAGE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sdl_image_extract: $(STATEDIR)/sdl_image.extract

$(STATEDIR)/sdl_image.extract: $(sdl_image_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SDL_IMAGE_DIR))
	@$(call extract, $(SDL_IMAGE_SOURCE))
	@$(call patchin, $(SDL_IMAGE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sdl_image_prepare: $(STATEDIR)/sdl_image.prepare

SDL_IMAGE_PATH	:=  PATH=$(CROSS_PATH)
SDL_IMAGE_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
SDL_IMAGE_AUTOCONF := $(CROSS_AUTOCONF_USR)
SDL_IMAGE_AUTOCONF += --with-sdl-prefix=$(CROSS_LIB_DIR)
SDL_IMAGE_AUTOCONF += --disable-sdltest
SDL_IMAGE_AUTOCONF += --enable-bmp
SDL_IMAGE_AUTOCONF += --enable-gif
SDL_IMAGE_AUTOCONF += --disable-jpg
SDL_IMAGE_AUTOCONF += --enable-lbm
SDL_IMAGE_AUTOCONF += --enable-pcx
SDL_IMAGE_AUTOCONF += --enable-png
SDL_IMAGE_AUTOCONF += --enable-pnm
SDL_IMAGE_AUTOCONF += --enable-tga
SDL_IMAGE_AUTOCONF += --disable-tif
SDL_IMAGE_AUTOCONF += --disable-xcf
SDL_IMAGE_AUTOCONF += --enable-xpm


$(STATEDIR)/sdl_image.prepare: $(sdl_image_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SDL_IMAGE_DIR)/config.cache)
	cd $(SDL_IMAGE_DIR) && \
		$(SDL_IMAGE_PATH) $(SDL_IMAGE_ENV) \
		./configure $(SDL_IMAGE_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sdl_image_compile: $(STATEDIR)/sdl_image.compile

$(STATEDIR)/sdl_image.compile: $(sdl_image_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SDL_IMAGE_DIR) && $(SDL_IMAGE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sdl_image_install: $(STATEDIR)/sdl_image.install

$(STATEDIR)/sdl_image.install: $(sdl_image_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SDL_IMAGE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sdl_image_targetinstall: $(STATEDIR)/sdl_image.targetinstall

$(STATEDIR)/sdl_image.targetinstall: $(sdl_image_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,sdl_image)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SDL_IMAGE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(SDL_IMAGE_DIR)/foobar, /dev/null)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sdl_image_clean:
	rm -rf $(STATEDIR)/sdl_image.*
	rm -rf $(IMAGEDIR)/sdl_image_*
	rm -rf $(SDL_IMAGE_DIR)

# vim: syntax=make
