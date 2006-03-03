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
PACKAGES-$(PTXCONF_SDL_LIB) += sdl

#
# Paths and names
#
SDL_LIB_VERSION	:= 1.2.9
SDL_LIB		:= SDL-$(SDL_LIB_VERSION)
SDL_LIB_SUFFIX	:= tar.gz
SDL_LIB_URL	:= http://www.libsdl.org/release//$(SDL_LIB).$(SDL_LIB_SUFFIX)
SDL_LIB_SOURCE	:= $(SRCDIR)/$(SDL_LIB).$(SDL_LIB_SUFFIX)
SDL_LIB_DIR	:= $(BUILDDIR)/$(SDL_LIB)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sdl_get: $(STATEDIR)/sdl.get

$(STATEDIR)/sdl.get: $(sdl_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SDL_LIB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SDL_LIB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sdl_extract: $(STATEDIR)/sdl.extract

$(STATEDIR)/sdl.extract: $(sdl_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SDL_LIB_DIR))
	@$(call extract, $(SDL_LIB_SOURCE))
	@$(call patchin, $(SDL_LIB))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sdl_prepare: $(STATEDIR)/sdl.prepare

SDL_LIB_PATH	:=  PATH=$(CROSS_PATH)
SDL_LIB_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
SDL_LIB_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-strict-ansi \
	--enable-audio \
	--enable-video \
	--enable-events \
	--enable-joystick \
	--enable-cdrom \
	--enable-threads \
	--enable-timers \
	--enable-endian \
	--enable-file \
	--enable-cpuinfo \
	--enable-oss \
	--enable-alsa \
	--disable-alsatest \
	--enable-alsa-shared \
	--disable-esd \
	--disable-esdtest \
	--enable-esd-shared \
	--enable-arts \
	--enable-arts-shared \
	--enable-nas \
	--enable-diskaudio \
	--enable-mintaudio \
	--enable-nasm \
	--disable-video-nanox \
	--disable-nanox-debug \
	--disable-nanox-share-memory \
	--disable-nanox-direct-fb \
	--enable-video-dga \
	--disable-video-photon \
	--disable-video-fbcon \
	--disable-video-directfb \
	--disable-video-ps2gs \
	--disable-video-ggi \
	--disable-video-svga \
	--disable-video-vgl \
	--disable-video-aalib \
	--disable-video-xbios \
	--disable-video-gem \
	--enable-video-dummy \
	--enable-video-opengl \
	--enable-osmesa-shared \
	--enable-input-events \
	--disable-pth \
	--enable-pthreads \
	--enable-pthread-sem \
	--enable-sigaction \
	--disable-stdio-redirect \
	--disable-directx \
	--disable-video-qtopia \
	--disable-video-picogui \
	--enable-sdl-dlopen \
	--disable-atari-ldg \
	--enable-rpath

ifdef PTXCONF_SDL_VIDEO_X
SDL_LIB_AUTOCONF += \
	--enable-video-x11 \
	--enable-video-x11-vm \
	--enable-dga \
	--enable-video-x11-dgamouse \
	--enable-video-x11-xv \
	--enable-video-x11-xinerama \
	--enable-video-x11-xme
else
SDL_LIB_AUTOCONF += \
	--disable-video-x11
endif

$(STATEDIR)/sdl.prepare: $(sdl_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SDL_LIB_DIR)/config.cache)
	cd $(SDL_LIB_DIR) && \
		$(SDL_LIB_PATH) $(SDL_LIB_ENV) \
		./configure $(SDL_LIB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sdl_compile: $(STATEDIR)/sdl.compile

$(STATEDIR)/sdl.compile: $(sdl_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SDL_LIB_DIR) && $(SDL_LIB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sdl_install: $(STATEDIR)/sdl.install

$(STATEDIR)/sdl.install: $(sdl_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SDL_LIB)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sdl_targetinstall: $(STATEDIR)/sdl.targetinstall

$(STATEDIR)/sdl.targetinstall: $(sdl_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, sdl)
	@$(call install_fixup, sdl,PACKAGE,sdl)
	@$(call install_fixup, sdl,PRIORITY,optional)
	@$(call install_fixup, sdl,VERSION,$(SDL_LIB_VERSION))
	@$(call install_fixup, sdl,SECTION,base)
	@$(call install_fixup, sdl,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, sdl,DEPENDS,)
	@$(call install_fixup, sdl,DESCRIPTION,missing)

	@$(call install_copy, sdl, 0, 0, 0644, \
		$(SDL_LIB_DIR)/src/.libs/libSDL-1.2.so.0.7.2, \
		/usr/lib/libSDL-1.2.so.0.7.2)

	@$(call install_link, sdl, \
		libSDL-1.2.so.0.7.2, \
		/usr/lib/libSDL-1.2.so.0)

	@$(call install_link, sdl, \
		libSDL-1.2.so.0.7.2, \
		/usr/lib/libSDL-1.2.so)

	@$(call install_finish, sdl)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sdl_clean:
	rm -rf $(STATEDIR)/sdl.*
	rm -rf $(IMAGEDIR)/sdl_*
	rm -rf $(SDL_LIB_DIR)

# vim: syntax=make
