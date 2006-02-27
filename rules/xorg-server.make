# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_SERVER) += xorg-server

#
# Paths and names
#
XORG_SERVER_VERSION	:= 1.0.1
XORG_SERVER		:= xorg-server-X11R7.0-$(XORG_SERVER_VERSION)
XORG_SERVER_SUFFIX	:= tar.bz2
XORG_SERVER_URL		:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/xserver/$(XORG_SERVER).$(XORG_SERVER_SUFFIX)
XORG_SERVER_SOURCE	:= $(SRCDIR)/$(XORG_SERVER).$(XORG_SERVER_SUFFIX)
XORG_SERVER_DIR		:= $(BUILDDIR)/$(XORG_SERVER)

-include $(call package_depfile)

# these are the defaults taken from the xorg server ./configure script
# FIXME: perhaps make them configurable
XORG_PREFIX  = /usr
XORG_LIBDIR  = $(XORG_PREFIX)/lib
XORG_FONTDIR = $(XORG_LIBDIR)/X11/fonts
XORG_BINDIR  = /usr/bin

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-server_get: $(STATEDIR)/xorg-server.get

$(STATEDIR)/xorg-server.get: $(xorg-server_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_SERVER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XORG_SERVER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-server_extract: $(STATEDIR)/xorg-server.extract

$(STATEDIR)/xorg-server.extract: $(xorg-server_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_SERVER_DIR))
	@$(call extract, $(XORG_SERVER_SOURCE))
	@$(call patchin, $(XORG_SERVER))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-server_prepare: $(STATEDIR)/xorg-server.prepare

XORG_SERVER_PATH	:=  PATH=$(CROSS_PATH)
XORG_SERVER_ENV 	:=  $(CROSS_ENV)

# some tweaking for cross compilation

# doesn't work while cross compiling
XORG_SERVER_ENV		+=  ac_cv_sys_linker_h=yes

# isn't switched off correctly with --disable-builddocs, IMHO the test
# should disable this as well (it is sgml documentation stuff)
XORG_SERVER_ENV		+=  ac_cv_file__usr_share_X11_sgml_defs_ent=no

#
# autoconf
#
XORG_SERVER_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_XORG_SERVER_EXT_COMPOSITE
XORG_SERVER_AUTOCONF += --enable-composite
else
XORG_SERVER_AUTOCONF += --disable-composite
endif

ifdef PTXCONF_XORG_SERVER_EXT_SHM
XORG_SERVER_AUTOCONF += --enable-shm
else
XORG_SERVER_AUTOCONF += --disable-shm
endif

ifdef PTXCONF_XORG_SERVER_EXT_XRES
XORG_SERVER_AUTOCONF += --enable-xres
else
XORG_SERVER_AUTOCONF += --disable-xres
endif

ifdef PTXCONF_XORG_SERVER_EXT_XTRAP
XORG_SERVER_AUTOCONF += --enable-xtrap
else
XORG_SERVER_AUTOCONF += --disable-xtrap
endif

ifdef PTXCONF_XORG_SERVER_EXT_RECORD
XORG_SERVER_AUTOCONF += --enable-record
else
XORG_SERVER_AUTOCONF += --disable-record
endif

ifdef PTXCONF_XORG_SERVER_EXT_XV
XORG_SERVER_AUTOCONF += --enable-xv
else
XORG_SERVER_AUTOCONF += --disable-xv
endif

ifdef PTXCONF_XORG_SERVER_EXT_XVMC
XORG_SERVER_AUTOCONF += --enable-xvmc
else
XORG_SERVER_AUTOCONF += --disable-xvmc
endif

ifdef PTXCONF_XORG_SERVER_EXT_DGA
XORG_SERVER_AUTOCONF += --enable-dga
else
XORG_SERVER_AUTOCONF += --disable-dga
endif

ifdef PTXCONF_XORG_SERVER_EXT_SCREENSAVER
XORG_SERVER_AUTOCONF += --enable-screensaver
else
XORG_SERVER_AUTOCONF += --disable-screensaver
endif

ifdef PTXCONF_XORG_SERVER_EXT_XDMCP
XORG_SERVER_AUTOCONF += --enable-xdmcp
else
XORG_SERVER_AUTOCONF += --disable-xdmcp
endif

ifdef PTXCONF_XORG_SERVER_EXT_XDMCP_AUTH_1
XORG_SERVER_AUTOCONF += --enable-xdmcp-auth-1
else
XORG_SERVER_AUTOCONF += --disable-xdmcp-auth-1
endif

ifdef PTXCONF_XORG_SERVER_EXT_GLX
XORG_SERVER_AUTOCONF += --enable-glx
else
XORG_SERVER_AUTOCONF += --disable-glx
endif

ifdef PTXCONF_XORG_SERVER_EXT_DRI
XORG_SERVER_AUTOCONF += --enable-dri
else
XORG_SERVER_AUTOCONF += --disable-dri
endif

ifdef PTXCONF_XORG_SERVER_EXT_XINERAMA
XORG_SERVER_AUTOCONF += --enable-xinerama
else
XORG_SERVER_AUTOCONF += --disable-xinerama
endif

ifdef PTXCONF_XORG_SERVER_EXT_XF86VIDMODE
XORG_SERVER_AUTOCONF += --enable-xf86vidmode
else
XORG_SERVER_AUTOCONF += --disable-xf86vidmode
endif

ifdef PTXCONF_XORG_SERVER_EXT_XF86MISC
XORG_SERVER_AUTOCONF += --enable-xf86misc
else
XORG_SERVER_AUTOCONF += --disable-xf86misc
endif

ifdef PTXCONF_XORG_SERVER_EXT_XCSECURITY
XORG_SERVER_AUTOCONF += --enable-xcsecurity
else
XORG_SERVER_AUTOCONF += --disable-xcsecurity
endif

ifdef PTXCONF_XORG_SERVER_EXT_XEVIE
XORG_SERVER_AUTOCONF += --enable-xevie
else
XORG_SERVER_AUTOCONF += --disable-xevie
endif

ifdef PTXCONF_XORG_SERVER_EXT_LBX
XORG_SERVER_AUTOCONF += --enable-lbx
else
XORG_SERVER_AUTOCONF += --disable-lbx
endif

ifdef PTXCONF_XORG_SERVER_EXT_APPGROUP
XORG_SERVER_AUTOCONF += --enable-appgroup
else
XORG_SERVER_AUTOCONF += --disable-appgroup
endif

ifdef PTXCONF_XORG_SERVER_EXT_CUP
XORG_SERVER_AUTOCONF += --enable-cup
else
XORG_SERVER_AUTOCONF += --disable-cup
endif

ifdef PTXCONF_XORG_SERVER_EXT_EVI
XORG_SERVER_AUTOCONF += --enable-evi
else
XORG_SERVER_AUTOCONF += --disable-evi
endif

ifdef PTXCONF_XORG_SERVER_EXT_MULTIBUFFER
XORG_SERVER_AUTOCONF += --enable-multibuffer
else
XORG_SERVER_AUTOCONF += --disable-multibuffer
endif

ifdef PTXCONF_XORG_SERVER_EXT_FONTCACHE
XORG_SERVER_AUTOCONF += --enable-fontcache
else
XORG_SERVER_AUTOCONF += --disable-fontcache
endif

ifdef PTXCONF_XORG_SERVER_EXT_DBE
XORG_SERVER_AUTOCONF += --enable-dbe
else
XORG_SERVER_AUTOCONF += --disable-dbe
endif

ifdef PTXCONF_XORG_SERVER_XORG
XORG_SERVER_AUTOCONF += --enable-xorg
else
XORG_SERVER_AUTOCONF += --disable-xorg
endif

ifdef PTXCONF_XORG_SERVER_DMX
XORG_SERVER_AUTOCONF += --enable-dmx
else
XORG_SERVER_AUTOCONF += --disable-dmx
endif

ifdef PTXCONF_XORG_SERVER_XVFB
XORG_SERVER_AUTOCONF += --enable-xvfb
else
XORG_SERVER_AUTOCONF += --disable-xvfb
endif

ifdef PTXCONF_XORG_SERVER_XNEST
XORG_SERVER_AUTOCONF += --enable-xnest
else
XORG_SERVER_AUTOCONF += --disable-xnest
endif

ifdef PTXCONF_XORG_SERVER_XWIN
XORG_SERVER_AUTOCONF += --enable-xwin
else
XORG_SERVER_AUTOCONF += --disable-xwin
endif

ifdef PTXCONF_XORG_SERVER_XPRINT
XORG_SERVER_AUTOCONF += --enable-xprint
else
XORG_SERVER_AUTOCONF += --disable-xprint
endif

ifdef PTXCONF_XORG_SERVER_OPT_INSTALL_SETUID
XORG_SERVER_AUTOCONF += --enable-install-setuid
else
XORG_SERVER_AUTOCONF += --disable-install-setuid
endif

ifdef PTXCONF_XORG_SERVER_OPT_SECURE_RPC
XORG_SERVER_AUTOCONF += --enable-secure-rpc
else
XORG_SERVER_AUTOCONF += --disable-secure-rpc
endif

ifdef PTXCONF_XORG_SERVER_OPT_XORGCFG
XORG_SERVER_AUTOCONF += --enable-xorgcfg
else
XORG_SERVER_AUTOCONF += --disable-xorgcfg
endif

ifdef PTXCONF_XORG_SERVER_OPT_KBD_MODE
XORG_SERVER_AUTOCONF += --enable-kbd_mode
else
XORG_SERVER_AUTOCONF += --disable-kbd_mode
endif

XORG_SERVER_AUTOCONF += --disable-builddocs
XORG_SERVER_AUTOCONF += --with-mesa-source=$(MESALIB_DIR)/

XORG_SERVER_AUTOCONF += --localstatedir=/var

$(STATEDIR)/xorg-server.prepare: $(xorg-server_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_SERVER_DIR)/config.cache)
	cd $(XORG_SERVER_DIR) && \
		$(XORG_SERVER_PATH) $(XORG_SERVER_ENV) \
		./configure $(XORG_SERVER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-server_compile: $(STATEDIR)/xorg-server.compile

$(STATEDIR)/xorg-server.compile: $(xorg-server_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_SERVER_DIR) && $(XORG_SERVER_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-server_install: $(STATEDIR)/xorg-server.install

$(STATEDIR)/xorg-server.install: $(xorg-server_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_SERVER)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-server_targetinstall: $(STATEDIR)/xorg-server.targetinstall

$(STATEDIR)/xorg-server.targetinstall: $(xorg-server_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-server)
	@$(call install_fixup, xorg-server,PACKAGE,xorg-server)
	@$(call install_fixup, xorg-server,PRIORITY,optional)
	@$(call install_fixup, xorg-server,VERSION,$(XORG_SERVER_VERSION))
	@$(call install_fixup, xorg-server,SECTION,base)
	@$(call install_fixup, xorg-server,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xorg-server,DEPENDS,)
	@$(call install_fixup, xorg-server,DESCRIPTION,missing)

ifdef PTXCONF_XORG_SERVER_XVFB
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/vfb/Xvfb, $(XORG_PREFIX)/bin/Xvfb)
endif
ifdef PTXCONF_XORG_SERVER_XORG
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/xfree86/Xorg, $(XORG_PREFIX)/bin/Xorg)
endif
ifdef PTXCONF_XORG_SERVER_DMX
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/dmx/Xdmx, $(XORG_PREFIX)/bin/Xdmx)
endif
ifdef PTXCONF_XORG_SERVER_XNEST
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/xnest/Xnest, $(XORG_PREFIX)/bin/Xnest)
endif
ifdef PTXCONF_XORG_SERVER_XPRINT
endif
ifdef PTXCONF_XORG_SERVER_XWIN
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/xwin/Xwin, $(XORG_PREFIX)/bin/Xwin)
endif
ifdef PTXCONF_XORG_DRIVER_VIDEO_FBDEV
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/xfree86/fbdevhw/.libs/libfbdevhw.so, $(XORG_PREFIX)/lib/xorg/modules/libfbdevhw.so)
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/xfree86/dixmods/.libs/libfb.so, $(XORG_PREFIX)/lib/xorg/modules/libfb.so)
endif

	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/xfree86/dixmods/.libs/libbitmap.so, $(XORG_PREFIX)/lib/xorg/modules/libbitmap.so)
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/xfree86/scanpci/.libs/libpcidata.so, $(XORG_PREFIX)/lib/xorg/modules/libpcidata.so)
	@$(call install_copy, xorg-server, 0, 0, 0755, $(XORG_SERVER_DIR)/hw/xfree86/dixmods/.libs/libshadow.so, $(XORG_PREFIX)/lib/xorg/modules/libshadow.so)

	@$(call install_finish, xorg-server)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-server_clean:
	rm -rf $(STATEDIR)/xorg-server.*
	rm -rf $(IMAGEDIR)/xorg-server_*
	rm -rf $(XORG_SERVER_DIR)

# vim: syntax=make
