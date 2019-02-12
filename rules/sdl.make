# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDL) += sdl

#
# Paths and names
#
SDL_VERSION	:= 1.2.15
SDL_MD5		:= 9d96df8417572a2afb781a7c4c811a85
SDL		:= SDL-$(SDL_VERSION)
SDL_SUFFIX	:= tar.gz
SDL_URL		:= http://www.libsdl.org/release/$(SDL).$(SDL_SUFFIX)
SDL_SOURCE	:= $(SRCDIR)/$(SDL).$(SDL_SUFFIX)
SDL_DIR		:= $(BUILDDIR)/$(SDL)
SDL_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SDL_CONF_TOOL	:= autoconf
SDL_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--disable-static \
	--enable-libc \
	--$(call ptx/endis,PTXCONF_SDL_AUDIO)-audio \
	--$(call ptx/endis,PTXCONF_SDL_VIDEO)-video \
	--$(call ptx/endis,PTXCONF_SDL_EVENT)-events \
	--$(call ptx/endis,PTXCONF_SDL_JOYSTICK)-joystick \
	--$(call ptx/endis,PTXCONF_SDL_CDROM)-cdrom \
	--$(call ptx/endis,PTXCONF_SDL_THREADS)-threads \
	--$(call ptx/endis,PTXCONF_SDL_TIMERS)-timers \
	--$(call ptx/endis,PTXCONF_SDL_FILE)-file \
	--enable-loadso \
	--$(call ptx/endis,PTXCONF_SDL_CPUINFO)-cpuinfo \
	--enable-assembly \
	--$(call ptx/endis,PTXCONF_SDL_OSS)-oss \
	--$(call ptx/endis,PTXCONF_SDL_ALSA)-alsa \
	--disable-alsatest \
	--disable-alsa-shared \
	--disable-esd \
	--disable-esdtest \
	--disable-esd-shared \
	--disable-pulseaudio \
	--disable-pulseaudio-shared \
	--disable-arts \
	--disable-arts-shared \
	--disable-nas \
	--disable-nas-shared \
	--disable-diskaudio \
	--disable-dummyaudio \
	--disable-mintaudio \
	--enable-nasm \
	--disable-altivec \
	--disable-ipod \
	--disable-video-nanox \
	--disable-nanox-debug \
	--disable-nanox-share-memory \
	--disable-nanox-direct-fb \
	--$(call ptx/endis,PTXCONF_SDL_XORG)-video-x11 \
	--disable-x11-shared \
	--$(call ptx/endis,PTXCONF_SDL_XORG)-dga \
	--$(call ptx/endis,PTXCONF_SDL_XORG)-video-dga \
	--$(call ptx/endis,PTXCONF_SDL_XORG)-video-x11-dgamouse \
	--$(call ptx/endis,PTXCONF_SDL_XORG)-video-x11-vm \
	--$(call ptx/endis,PTXCONF_SDL_VIDEO)-video-x11-xv \
	--disable-video-x11-xinerama \
	--$(call ptx/endis,PTXCONF_SDL_XORG)-video-x11-xme \
	--disable-video-x11-xrandr \
	--disable-video-photon \
	--disable-video-carbon \
	--disable-video-cocoa \
	--$(call ptx/endis,PTXCONF_SDL_FBCON)-video-fbcon \
	--disable-video-directfb \
	--disable-video-ps2gs \
	--disable-video-ps3 \
	--disable-video-ggi \
	--disable-video-svga \
	--disable-video-vgl \
	--disable-video-wscons \
	--disable-video-aalib \
	--disable-video-caca \
	--disable-video-qtopia \
	--disable-video-picogui \
	--disable-xbios \
	--disable-gem \
	--enable-video-dummy \
	--$(call ptx/endis,PTXCONF_SDL_OPENGL)-video-opengl \
	--disable-osmesa-shared \
	--enable-screensaver \
	--enable-input-events \
	--$(call ptx/endis,PTXCONF_SDL_TSLIB)-input-tslib \
	--disable-pth \
	--enable-pthreads \
	--enable-pthread-sem \
	--disable-stdio-redirect \
	--disable-directx \
	--enable-sdl-dlopen \
	--disable-atari-ldg \
	--enable-clock_gettime \
	--disable-rpath \
	--$(call ptx/wwo,PTXCONF_SDL_XORG)-x

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdl)
	@$(call install_fixup, sdl,PRIORITY,optional)
	@$(call install_fixup, sdl,SECTION,base)
	@$(call install_fixup, sdl,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, sdl,DESCRIPTION,missing)

	@$(call install_lib, sdl, 0, 0, 0644, libSDL-1.2)

	@$(call install_finish, sdl)

	@$(call touch)

# vim: syntax=make
