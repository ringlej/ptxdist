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
	@$(call get, SDL_LIB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sdl_extract: $(STATEDIR)/sdl.extract

$(STATEDIR)/sdl.extract: $(sdl_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SDL_LIB_DIR))
	@$(call extract, SDL_LIB)
	@$(call patchin, SDL_LIB)
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
SDL_LIB_AUTOCONF := $(CROSS_AUTOCONF_USR)
ifdef PTXCONF_SDL_SHARED
SDL_LIB_AUTOCONF += --enable-shared
else
SDL_LIB_AUTOCONF += --disable-shared
endif
ifdef PTXCONF_SDL_STATIC
SDL_LIB_AUTOCONF += --enable-static
else
SDL_LIB_AUTOCONF += --disable-static
endif

ifdef PTXCONF_SDL_AUDIO
SDL_LIB_AUTOCONF += --enable-audio      

 ifdef PTXCONF_SDL_OSS
 SDL_LIB_AUTOCONF += --enable-oss
 else
 SDL_LIB_AUTOCONF += --disable-oss
 endif

 ifdef PTXCONF_SDL_ALSA
 SDL_LIB_AUTOCONF += --enable-alsa     
 SDL_LIB_AUTOCONF += --disable-alsatest 
 #SDL_LIB_AUTOCONF += --with-alsa-prefix=PFX 
 #SDL_LIB_AUTOCONF += --with-alsa-inc-prefix=PFX 
  ifdef PTXCONF_SDL_ALSA_SHARED
  SDL_LIB_AUTOCONF += --enable-alsa-shared  
  else
  SDL_LIB_AUTOCONF += --disable-alsa-shared
  endif
 else
 SDL_LIB_AUTOCONF += --disable-alsa
 endif

 ifdef PTXCONF_SDL_ESD
 SDL_LIB_AUTOCONF += --enable-esd   
 SDL_LIB_AUTOCONF += --disable-esdtest
 #SDL_LIB_AUTOCONF += --with-esd-prefix=PFX 
 #SDL_LIB_AUTOCONF += --with-esd-exec-prefix=PFX 
  ifdef PTXCONF_SDL_ESD_SHARED
  SDL_LIB_AUTOCONF += --enable-esd-shared   
  else
  SDL_LIB_AUTOCONF += --disable-esd-shared
  endif
 else
 SDL_LIB_AUTOCONF += --disable-esd
 endif

 ifdef PTXCONF_SDL_ARTS
 SDL_LIB_AUTOCONF += --enable-arts         
  ifdef PTXCONF_SDL_ARTS_SHARED
  SDL_LIB_AUTOCONF += --enable-arts-shared  
  else
  SDL_LIB_AUTOCONF += --disable-arts-shared
  endif
 else
 SDL_LIB_AUTOCONF += --disable-arts
 endif

 ifdef PTXCONF_SDL_NAS
 SDL_LIB_AUTOCONF += --enable-nas       
 else
 SDL_LIB_AUTOCONF += --disable-nas
 endif

 ifdef PTXCONF_SDL_DISKAUDIO
 SDL_LIB_AUTOCONF += --enable-diskaudio   
 else
 SDL_LIB_AUTOCONF += --disable-diskaudio
 endif

else
DL_LIB_AUTOCONF += --disable-audio
endif

ifdef PTXCONF_SDL_VIDEO
SDL_LIB_AUTOCONF += --enable-video  

 ifdef PTXCONF_SDL_NANOX
 SDL_LIB_AUTOCONF += --enable-video-nanox
 SDL_LIB_AUTOCONF += --enable-nanox-debug
 SDL_LIB_AUTOCONF += --enable-nanox-share-memory
 SDL_LIB_AUTOCONF += --enable-nanox-direct-fb
 else
 SDL_LIB_AUTOCONF += --disable-video-nanox
 endif

 ifdef PTXCONF_SDL_XORG
 SDL_LIB_AUTOCONF += --with-x              
 SDL_LIB_AUTOCONF += --enable-video-x11   
 SDL_LIB_AUTOCONF += --enable-video-x11-vm 
 SDL_LIB_AUTOCONF += --enable-dga         
 SDL_LIB_AUTOCONF += --enable-video-x11-dgamouse 
 SDL_LIB_AUTOCONF += --enable-video-x11-xv  
 SDL_LIB_AUTOCONF += --enable-video-x11-xinerama 
 SDL_LIB_AUTOCONF += --enable-video-x11-xme 
 SDL_LIB_AUTOCONF += --enable-video-dga    
 else
 SDL_LIB_AUTOCONF += --without-x
 endif

 ifdef PTXCONF_SDL_FBCON
 SDL_LIB_AUTOCONF += --enable-video-fbcon 
 else
 SDL_LIB_AUTOCONF += --disable-video-fbcon
 endif

 ifdef PTXCONF_SDL_DIRECTFB
 SDL_LIB_AUTOCONF += --enable-video-directfb 
 else
 SDL_LIB_AUTOCONF += --disable-video-directfb
 endif

 ifdef PTXCONF_SDL_AALIB
 SDL_LIB_AUTOCONF += --enable-video-aalib 
 else
 SDL_LIB_AUTOCONF += --disable-video-aalib
 endif

 ifdef PTXCONF_SDL_OPENGL
 SDL_LIB_AUTOCONF += --enable-video-opengl  
 SDL_LIB_AUTOCONF += --enable-osmesa-shared 
 else
 SDL_LIB_AUTOCONF += --disable-video-opengl
 endif

 ifdef PTXCONF_SDL_QTOPIA
 SDL_LIB_AUTOCONF += --enable-video-qtopia 
 else
 SDL_LIB_AUTOCONF += --disable-video-qtopia
 endif

else
SDL_LIB_AUTOCONF += --disable-video 
endif

ifdef PTXCONF_SDL_EVENT
SDL_LIB_AUTOCONF += --enable-events  
else
SDL_LIB_AUTOCONF += --disable-events
endif

ifdef PTXCONF_SDL_JOYSTICK
SDL_LIB_AUTOCONF += --enable-joystick  
else
SDL_LIB_AUTOCONF += --disable-joystick
endif

ifdef PTXCONF_SDL_CDROM
SDL_LIB_AUTOCONF += --enable-cdrom    
else
SDL_LIB_AUTOCONF += --disable-cdrom
endif

ifdef PTXCONF_SDL_THREADS
SDL_LIB_AUTOCONF += --enable-threads  
 ifdef PTXCONF_SDL_PTH
 SDL_LIB_AUTOCONF += --enable-pth         
 else
 SDL_LIB_AUTOCONF += --disable-pth
 endif
else
SDL_LIB_AUTOCONF += --disable-threads
endif

ifdef PTXCONF_SDL_TIMERS
SDL_LIB_AUTOCONF += --enable-timers  
else
SDL_LIB_AUTOCONF += --disable-timers
endif

ifdef PTXCONF_SDL_ENDIAN
SDL_LIB_AUTOCONF += --enable-endian 
else
SDL_LIB_AUTOCONF += --disable-endian
endif

ifdef PTXCONF_SDL_FILE
SDL_LIB_AUTOCONF += --enable-file   
else
SDL_LIB_AUTOCONF += --disable-file
endif

ifdef PTXCONF_SDL_CPUINFO
SDL_LIB_AUTOCONF += --enable-cpuinfo
else
SDL_LIB_AUTOCONF += --disable-cpuinfo
endif

ifdef PTXCONF_SDL_NASM
SDL_LIB_AUTOCONF += --enable-nasm    
else
SDL_LIB_AUTOCONF += --disable-nasm
endif

SDL_LIB_AUTOCONF += --disable-debug
SDL_LIB_AUTOCONF += --disable-strict-ansi
SDL_LIB_AUTOCONF += --disable-video-ps2gs  
SDL_LIB_AUTOCONF += --disable-video-ggi   
SDL_LIB_AUTOCONF += --disable-video-svga 
SDL_LIB_AUTOCONF += --disable-video-vgl 
SDL_LIB_AUTOCONF += --disable-video-xbios 
SDL_LIB_AUTOCONF += --disable-video-gem   
SDL_LIB_AUTOCONF += --enable-video-dummy  
SDL_LIB_AUTOCONF += --enable-pthreads    
SDL_LIB_AUTOCONF += --enable-pthread-sem 
SDL_LIB_AUTOCONF += --enable-sigaction   
SDL_LIB_AUTOCONF += --disable-stdio-redirect
SDL_LIB_AUTOCONF += --disable-directx      
SDL_LIB_AUTOCONF += --disable-video-picogui
SDL_LIB_AUTOCONF += --enable-sdl-dlopen   
SDL_LIB_AUTOCONF += --disable-atari-ldg  
SDL_LIB_AUTOCONF += --enable-rpath      
SDL_LIB_AUTOCONF += --disable-mintaudio
SDL_LIB_AUTOCONF += --disable-video-photon
SDL_LIB_AUTOCONF += --enable-input-events

#
# FIXME
# the dependency generator doesn't work for conditional selects yet
#
sdl_prepare_deps  = $(STATEDIR)/sdl.extract
ifdef PTXCONF_SDL_ALSA
sdl_prepare_deps += $(STATEDIR)/alsa-lib.install
endif
ifdef PTXCONF_SDL_XORG
sdl_prepare_deps += $(STATEDIR)/xorg-lib-X11.install
sdl_prepare_deps += $(STATEDIR)/xorg-lib-Xt.install
sdl_prepare_deps += $(STATEDIR)/xorg-lib-Xv.install
sdl_prepare_deps += $(STATEDIR)/xorg-lib-XvMC.install
sdl_prepare_deps += $(STATEDIR)/xorg-lib-Xinerama.install
endif

$(STATEDIR)/sdl.prepare: $(sdl_prepare_deps)
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
	# install sdl-config in bin dir
	mkdir -p $(PTXCONF_PREFIX)/bin
	cp $(SDL_LIB_DIR)/sdl-config $(PTXCONF_PREFIX)/bin/
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sdl_targetinstall: $(STATEDIR)/sdl.targetinstall

#
# FIXME
# the dependency generator doesn't work for conditional selects yet
#
sdl_targetinstall_deps  = $(STATEDIR)/sdl.install
ifdef PTXCONF_SDL_ALSA
sdl_targetinstall_deps += $(STATEDIR)/alsa-lib.targetinstall
endif
ifdef PTXCONF_SDL_XORG
sdl_targettargetinstall_deps += $(STATEDIR)/xorg-lib-X11.targetinstall
sdl_targettargetinstall_deps += $(STATEDIR)/xorg-lib-Xt.targetinstall
sdl_targettargetinstall_deps += $(STATEDIR)/xorg-lib-Xv.targetinstall
sdl_targettargetinstall_deps += $(STATEDIR)/xorg-lib-XvMC.targetinstall
sdl_targettargetinstall_deps += $(STATEDIR)/xorg-lib-Xinerama.targetinstall
endif


$(STATEDIR)/sdl.targetinstall: $(sdl_targetinstall_deps)
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
