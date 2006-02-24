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
SDL_LIB_AUTOCONF := $(CROSS_AUTOCONF_USR)
SDL_LIB_AUTOCONF += --disable-debug 
SDL_LIB_AUTOCONF += --disable-strict-ansi 
SDL_LIB_AUTOCONF += --enable-audio     
SDL_LIB_AUTOCONF += --enable-video    
SDL_LIB_AUTOCONF += --enable-events   
SDL_LIB_AUTOCONF += --enable-joystick 
SDL_LIB_AUTOCONF += --enable-cdrom   
SDL_LIB_AUTOCONF += --enable-threads 
SDL_LIB_AUTOCONF += --enable-timers 
SDL_LIB_AUTOCONF += --enable-endian 
SDL_LIB_AUTOCONF += --enable-file   
SDL_LIB_AUTOCONF += --enable-cpuinfo 
SDL_LIB_AUTOCONF += --enable-oss    
SDL_LIB_AUTOCONF += --enable-alsa   
SDL_LIB_AUTOCONF += --disable-alsatest 
SDL_LIB_AUTOCONF += --enable-alsa-shared 
SDL_LIB_AUTOCONF += --enable-esd        
SDL_LIB_AUTOCONF += --disable-esdtest   
SDL_LIB_AUTOCONF += --enable-esd-shared 
SDL_LIB_AUTOCONF += --enable-arts       
SDL_LIB_AUTOCONF += --enable-arts-shared  
SDL_LIB_AUTOCONF += --enable-nas         
SDL_LIB_AUTOCONF += --enable-diskaudio   
SDL_LIB_AUTOCONF += --enable-mintaudio   
SDL_LIB_AUTOCONF += --enable-nasm       
SDL_LIB_AUTOCONF += --disable-video-nanox 
SDL_LIB_AUTOCONF += --disable-nanox-debug 
SDL_LIB_AUTOCONF += --disable-nanox-share-memory 
SDL_LIB_AUTOCONF += --disable-nanox-direct-fb
SDL_LIB_AUTOCONF += --enable-video-x11     
SDL_LIB_AUTOCONF += --enable-video-x11-vm 
SDL_LIB_AUTOCONF += --enable-dga         
SDL_LIB_AUTOCONF += --enable-video-x11-dgamouse 
SDL_LIB_AUTOCONF += --enable-video-x11-xv 
SDL_LIB_AUTOCONF += --enable-video-x11-xinerama 
SDL_LIB_AUTOCONF += --enable-video-x11-xme 
SDL_LIB_AUTOCONF += --enable-video-dga    
SDL_LIB_AUTOCONF += --disable-video-photon 
SDL_LIB_AUTOCONF += --disable-video-fbcon   
SDL_LIB_AUTOCONF += --disable-video-directfb
SDL_LIB_AUTOCONF += --disable-video-ps2gs 
SDL_LIB_AUTOCONF += --disable-video-ggi  
SDL_LIB_AUTOCONF += --disable-video-svga 
SDL_LIB_AUTOCONF += --disable-video-vgl  
SDL_LIB_AUTOCONF += --disable-video-aalib
SDL_LIB_AUTOCONF += --disable-video-xbios 
SDL_LIB_AUTOCONF += --disable-video-gem 
SDL_LIB_AUTOCONF += --enable-video-dummy 
SDL_LIB_AUTOCONF += --enable-video-opengl 
SDL_LIB_AUTOCONF += --enable-osmesa-shared 
SDL_LIB_AUTOCONF += --enable-input-events 
SDL_LIB_AUTOCONF += --disable-pth      
SDL_LIB_AUTOCONF += --enable-pthreads   
SDL_LIB_AUTOCONF += --enable-pthread-sem 
SDL_LIB_AUTOCONF += --enable-sigaction    
SDL_LIB_AUTOCONF += --disable-stdio-redirect
SDL_LIB_AUTOCONF += --disable-directx     
SDL_LIB_AUTOCONF += --disable-video-qtopia 
SDL_LIB_AUTOCONF += --disable-video-picogui 
SDL_LIB_AUTOCONF += --enable-sdl-dlopen 
SDL_LIB_AUTOCONF += --disable-atari-ldg 
SDL_LIB_AUTOCONF += --enable-rpath       

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

#FIXME

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
