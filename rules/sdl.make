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
PACKAGES-$(PTXCONF_SDL) += sdl

#
# Paths and names
#
SDL_VERSION	:= 1.2.9
SDL		:= SDL-$(SDL_VERSION)
SDL_SUFFIX	:= tar.gz
SDL_URL		:= http://www.libsdl.org/release//$(SDL).$(SDL_SUFFIX)
SDL_SOURCE	:= $(SRCDIR)/$(SDL).$(SDL_SUFFIX)
SDL_DIR		:= $(BUILDDIR)/$(SDL)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sdl_get: $(STATEDIR)/sdl.get

$(STATEDIR)/sdl.get: $(sdl_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SDL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SDL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sdl_extract: $(STATEDIR)/sdl.extract

$(STATEDIR)/sdl.extract: $(sdl_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SDL_DIR))
	@$(call extract, $(SDL_SOURCE))
	@$(call patchin, $(SDL))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sdl_prepare: $(STATEDIR)/sdl.prepare

SDL_PATH	:=  PATH=$(CROSS_PATH)
SDL_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
SDL_AUTOCONF := $(CROSS_AUTOCONF_USR)
SDL_AUTOCONF += --disable-debug 
SDL_AUTOCONF += --disable-strict-ansi 
SDL_AUTOCONF += --enable-audio     
SDL_AUTOCONF += --enable-video    
SDL_AUTOCONF += --enable-events   
SDL_AUTOCONF += --enable-joystick 
SDL_AUTOCONF += --enable-cdrom   
SDL_AUTOCONF += --enable-threads 
SDL_AUTOCONF += --enable-timers 
SDL_AUTOCONF += --enable-endian 
SDL_AUTOCONF += --enable-file   
SDL_AUTOCONF += --enable-cpuinfo 
SDL_AUTOCONF += --enable-oss    
SDL_AUTOCONF += --enable-alsa   
SDL_AUTOCONF += --disable-alsatest 
SDL_AUTOCONF += --enable-alsa-shared 
SDL_AUTOCONF += --enable-esd        
SDL_AUTOCONF += --disable-esdtest   
SDL_AUTOCONF += --enable-esd-shared 
SDL_AUTOCONF += --enable-arts       
SDL_AUTOCONF += --enable-arts-shared  
SDL_AUTOCONF += --enable-nas         
SDL_AUTOCONF += --enable-diskaudio   
SDL_AUTOCONF += --enable-mintaudio   
SDL_AUTOCONF += --enable-nasm       
SDL_AUTOCONF += --disable-video-nanox 
SDL_AUTOCONF += --disable-nanox-debug 
SDL_AUTOCONF += --disable-nanox-share-memory 
SDL_AUTOCONF += --disable-nanox-direct-fb
SDL_AUTOCONF += --enable-video-x11     
SDL_AUTOCONF += --enable-video-x11-vm 
SDL_AUTOCONF += --enable-dga         
SDL_AUTOCONF += --enable-video-x11-dgamouse 
SDL_AUTOCONF += --enable-video-x11-xv 
SDL_AUTOCONF += --enable-video-x11-xinerama 
SDL_AUTOCONF += --enable-video-x11-xme 
SDL_AUTOCONF += --enable-video-dga    
SDL_AUTOCONF += --disable-video-photon 
SDL_AUTOCONF += --disable-video-fbcon   
SDL_AUTOCONF += --disable-video-directfb
SDL_AUTOCONF += --disable-video-ps2gs 
SDL_AUTOCONF += --disable-video-ggi  
SDL_AUTOCONF += --disable-video-svga 
SDL_AUTOCONF += --disable-video-vgl  
SDL_AUTOCONF += --disable-video-aalib
SDL_AUTOCONF += --disable-video-xbios 
SDL_AUTOCONF += --disable-video-gem 
SDL_AUTOCONF += --enable-video-dummy 
SDL_AUTOCONF += --enable-video-opengl 
SDL_AUTOCONF += --enable-osmesa-shared 
SDL_AUTOCONF += --enable-input-events 
SDL_AUTOCONF += --disable-pth      
SDL_AUTOCONF += --enable-pthreads   
SDL_AUTOCONF += --enable-pthread-sem 
SDL_AUTOCONF += --enable-sigaction    
SDL_AUTOCONF += --disable-stdio-redirect
SDL_AUTOCONF += --disable-directx     
SDL_AUTOCONF += --disable-video-qtopia 
SDL_AUTOCONF += --disable-video-picogui 
SDL_AUTOCONF += --enable-sdl-dlopen 
SDL_AUTOCONF += --disable-atari-ldg 
SDL_AUTOCONF += --enable-rpath       

$(STATEDIR)/sdl.prepare: $(sdl_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SDL_DIR)/config.cache)
	cd $(SDL_DIR) && \
		$(SDL_PATH) $(SDL_ENV) \
		./configure $(SDL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sdl_compile: $(STATEDIR)/sdl.compile

$(STATEDIR)/sdl.compile: $(sdl_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SDL_DIR) && $(SDL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sdl_install: $(STATEDIR)/sdl.install

$(STATEDIR)/sdl.install: $(sdl_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SDL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sdl_targetinstall: $(STATEDIR)/sdl.targetinstall

$(STATEDIR)/sdl.targetinstall: $(sdl_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,sdl)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SDL_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

#FIXME

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sdl_clean:
	rm -rf $(STATEDIR)/sdl.*
	rm -rf $(IMAGEDIR)/sdl_*
	rm -rf $(SDL_DIR)

# vim: syntax=make
