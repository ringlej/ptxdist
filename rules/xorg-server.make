# -*-makefile-*-
#
# Copyright (C) 2006, 2009 by Robert Schwebel
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
XORG_SERVER_VERSION	:= 1.7.3
XORG_SERVER		:= xorg-server-$(XORG_SERVER_VERSION)
XORG_SERVER_SUFFIX	:= tar.bz2
XORG_SERVER_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/xserver/$(XORG_SERVER).$(XORG_SERVER_SUFFIX)
XORG_SERVER_SOURCE	:= $(SRCDIR)/$(XORG_SERVER).$(XORG_SERVER_SUFFIX)
XORG_SERVER_DIR		:= $(BUILDDIR)/$(XORG_SERVER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_SERVER_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_SERVER)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_SERVER_PATH	:= PATH=$(CROSS_PATH)
XORG_SERVER_ENV 	:= $(CROSS_ENV) \
	ac_cv_sys_linker_h=yes \
	ac_cv_file__usr_share_sgml_X11_defs_ent=no

#
# FIXME: not all processors upports MTRR. Geode GX1 not for
# example. But it is a 586 clone. configure decides always to support
# mtrr!
#
# XORG_SERVER_ENV		+= ac_cv_asm_mtrr_h=no

#
# autoconf
#
# use "=" here
XORG_SERVER_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--enable-option-checking \
	--disable-maintainer-mode \
	--enable-dependency-tracking \
	--enable-large-file \
	--disable-werror \
	--disable-debug \
	--disable-builddocs \
	--disable-config-dbus \
	--disable-config-hal \
	--disable-xfree86-utils \
	--disable-xquartz \
	--disable-standalone-xpbproxy \
	--localstatedir=/var \
	--with-xkb-output=/tmp

# FIXME
# - what is XORG_OPTIONS_TRANS?
# --enable-shared
# --enable-static
# --enable-install-libxf86config

# FIXME new options

ifdef PTXCONF_XORG_SERVER_NULL_ROOT_CURSOR
XORG_SERVER_AUTOCONF += --enable-null-root-cursor
else
XORG_SERVER_AUTOCONF += --disable-null-root-cursor
endif

ifdef PTXCONF_XORG_SERVER_AIGLX
XORG_SERVER_AUTOCONF += --enable-aiglx
else
XORG_SERVER_AUTOCONF += --disable-aiglx
endif

ifdef PTXCONF_XORG_SERVER_OPT_GLX_TLS
XORG_SERVER_AUTOCONF += --enable-glx-tls
else
XORG_SERVER_AUTOCONF += --disable-glx-tls
endif

ifdef PTXCONF_XORG_SERVER_STRING_REGISTRY
XORG_SERVER_AUTOCONF += --enable-registry
else
XORG_SERVER_AUTOCONF += --disable-registry
endif

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
# if DRI is disabled we do not have AGP
XORG_SERVER_ENV		+= ac_cv_header_linux_agpgart_h=no
endif

ifdef PTXCONF_XORG_SERVER_EXT_DRI2
XORG_SERVER_AUTOCONF += --enable-dri2
else
XORG_SERVER_AUTOCONF += --disable-dri2
# if DRI is disabled we do not have AGP
XORG_SERVER_ENV		+= ac_cv_header_linux_agpgart_h=no
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

ifdef PTXCONF_XORG_SERVER_EXT_XACE
XORG_SERVER_AUTOCONF += --enable-xace
else
XORG_SERVER_AUTOCONF += --disable-xace
endif

ifdef PTXCONF_XORG_SERVER_EXT_XSELINUX
XORG_SERVER_AUTOCONF += --enable-xselinux
else
XORG_SERVER_AUTOCONF += --disable-xselinux
endif

ifdef PTXCONF_XORG_SERVER_EXT_XCSECURITY
XORG_SERVER_AUTOCONF += --enable-xcsecurity
else
XORG_SERVER_AUTOCONF += --disable-xcsecurity
endif

ifdef PTXCONF_XORG_SERVER_EXT_CALIBRATE
XORG_SERVER_AUTOCONF += --enable-xcalibrate
else
XORG_SERVER_AUTOCONF += --disable-xcalibrate
endif

ifdef PTXCONF_XORG_SERVER_TSLIB
XORG_SERVER_AUTOCONF += --enable-tslib
else
XORG_SERVER_AUTOCONF += --disable-tslib
endif

ifdef PTXCONF_XORG_SERVER_EXT_MULTIBUFFER
XORG_SERVER_AUTOCONF += --enable-multibuffer
else
XORG_SERVER_AUTOCONF += --disable-multibuffer
endif

ifdef PTXCONF_XORG_SERVER_EXT_DBE
XORG_SERVER_AUTOCONF += --enable-dbe
else
XORG_SERVER_AUTOCONF += --disable-dbe
endif

ifdef PTXCONF_XORG_LIB_X11_XF86BIGFONT
XORG_SERVER_AUTOCONF += --enable-xf86bigfont
else
XORG_SERVER_AUTOCONF += --disable-xf86bigfont
endif

ifdef PTXCONF_XORG_SERVER_EXT_DPMS
XORG_SERVER_AUTOCONF += --enable-dpms
else
XORG_SERVER_AUTOCONF += --disable-dpms
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

ifdef PTXCONF_XORG_SERVER_KDRIVE
XORG_SERVER_AUTOCONF += --enable-kdrive
else
XORG_SERVER_AUTOCONF += --disable-kdrive
endif

ifdef PTXCONF_XORG_SERVER_XEPHYR
XORG_SERVER_AUTOCONF += --enable-xephyr
else
XORG_SERVER_AUTOCONF += --disable-xephyr
endif

ifdef PTXCONF_XORG_SERVER_XSDL
XORG_SERVER_AUTOCONF += --enable-xsdl
else
XORG_SERVER_AUTOCONF += --disable-xsdl
endif

ifdef PTXCONF_XORG_SERVER_FAKE
XORG_SERVER_AUTOCONF += --enable-fake
else
XORG_SERVER_AUTOCONF += --disable-fake
endif

ifdef PTXCONF_XORG_SERVER_XFBDEV
XORG_SERVER_AUTOCONF += --enable-xfbdev
else
XORG_SERVER_AUTOCONF += --disable-xfbdev
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

#
# FIXME rsc: what's the reason for this hack?
#

# if no value is given ignore the "--datadir" switch
ifneq ($(call remove_quotes,$(PTXCONF_XORG_DEFAULT_DATA_DIR)),)
	XORG_SERVER_AUTOCONF += --datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)
endif

#
# FIXME rsc: old options from older xorg-server versions. Still needed/possible?
#
#
#
#ifdef PTXCONF_XORG_SERVER_EXT_XF86MISC
#XORG_SERVER_AUTOCONF += --enable-xf86misc
#else
#XORG_SERVER_AUTOCONF += --disable-xf86misc
#endif
#
#ifdef PTXCONF_XORG_SERVER_EXT_XEVIE
#XORG_SERVER_AUTOCONF += --enable-xevie
#else
#XORG_SERVER_AUTOCONF += --disable-xevie
#endif
#
#ifdef PTXCONF_XORG_SERVER_EXT_APPGROUP
#XORG_SERVER_AUTOCONF += --enable-appgroup
#else
#XORG_SERVER_AUTOCONF += --disable-appgroup
#endif
#
#ifdef PTXCONF_XORG_SERVER_EXT_CUP
#XORG_SERVER_AUTOCONF += --enable-cup
#else
#XORG_SERVER_AUTOCONF += --disable-cup
#endif
#
#ifdef PTXCONF_XORG_SERVER_EXT_EVI
#XORG_SERVER_AUTOCONF += --enable-evi
#else
#XORG_SERVER_AUTOCONF += --disable-evi
#endif
#
#ifdef PTXCONF_FREETYPE
#XORG_SERVER_AUTOCONF += --enable-freetype
#else
#XORG_SERVER_AUTOCONF += --disable-freetype
#endif
#
#ifdef PTXCONF_XORG_SERVER_OPT_XORGCFG
#XORG_SERVER_AUTOCONF += --enable-xorgcfg
#else
#XORG_SERVER_AUTOCONF += --disable-xorgcfg
#endif
#
#ifdef PTXCONF_XORG_SERVER_OPT_KBD_MODE
#XORG_SERVER_AUTOCONF += --enable-kbd_mode
#else
#XORG_SERVER_AUTOCONF += --disable-kbd_mode
#endif
#
#ifdef PTXCONF_MESALIB
#XORG_SERVER_AUTOCONF += --with-mesa-source=$(MESALIB_DIR)
#endif
#
#ifdef PTXCONF_XORG_SERVER_INT10_VM86
#XORG_SERVER_AUTOCONF += --with-int10=vm86
#endif
#
#ifdef PTXCONF_XORG_SERVER_INT10_X86EMU
#XORG_SERVER_AUTOCONF += --with-int10=x86emu
#endif
#
#ifdef PTXCONF_XORG_SERVER_INT10_VM86
#XORG_SERVER_AUTOCONF += --with-int10=stub
#endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-server.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-server)
	@$(call install_fixup, xorg-server,PACKAGE,xorg-server)
	@$(call install_fixup, xorg-server,PRIORITY,optional)
	@$(call install_fixup, xorg-server,VERSION,$(XORG_SERVER_VERSION))
	@$(call install_fixup, xorg-server,SECTION,base)
	@$(call install_fixup, xorg-server,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-server,DEPENDS,)
	@$(call install_fixup, xorg-server,DESCRIPTION,missing)

ifdef PTXCONF_XORG_SERVER_XVFB
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xvfb)
endif
ifdef PTXCONF_XORG_SERVER_DMX
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xdmx)
endif
ifdef PTXCONF_XORG_SERVER_XNEST
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xnest)
endif
ifdef PTXCONF_XORG_SERVER_XWIN
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xwin)
endif

ifdef PTXCONF_XORG_SERVER_XORG
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xorg)
	@$(call install_link, xorg-server, Xorg, /usr/bin/X)

ifdef PTXCONF_XORG_DRIVER_VIDEO
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/linux/libfbdevhw.so)
#	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
#		$(XORG_PREFIX)/lib/xorg/modules/libcfb16.so)
#	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
#		$(XORG_PREFIX)/lib/xorg/modules/libcfb24.so)
#	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
#		$(XORG_PREFIX)/lib/xorg/modules/libddc.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libexa.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libfb.so)
#	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
#		$(XORG_PREFIX)/lib/xorg/modules/libi2c.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libint10.so)
#	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
#		$(XORG_PREFIX)/lib/xorg/modules/liblayer.so)
#	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
#		$(XORG_PREFIX)/lib/xorg/modules/librac.so)
#	@$(call install_copy, xorg-server, 0, 0, 0644, -,
#		$(XORG_PREFIX)/lib/xorg/modules/libramdac.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libshadowfb.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libshadow.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libvbe.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libvgahw.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libxaa.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libxf8_16bpp.so)
#	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
#		$(XORG_PREFIX)/lib/xorg/modules/libxf8_32wid.so)
endif
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/libextmod.so)
ifdef PTXCONF_XORG_SERVER_EXT_DBE
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/libdbe.so)
endif

#	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
#		/usr/lib/xorg/modules/fonts/libbitmap.so)

# FIXME: Should be included on demand only
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/multimedia/bt829_drv.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/multimedia/tda8425_drv.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/multimedia/tda9850_drv.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, - ,\
		/usr/lib/xorg/modules/multimedia/uda1380_drv.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/multimedia/fi1236_drv.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, - ,\
		/usr/lib/xorg/modules/multimedia/msp3430_drv.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/multimedia/tda9885_drv.so)

ifdef PTXCONF_XORG_SERVER_EXT_COMPOSITE
endif

ifdef PTXCONF_XORG_SERVER_EXT_SHM
endif

ifdef PTXCONF_XORG_SERVER_EXT_XRES
endif

ifdef PTXCONF_XORG_SERVER_EXT_RECORD
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/librecord.so)
endif

ifdef PTXCONF_XORG_SERVER_EXT_XV
endif

ifdef PTXCONF_XORG_SERVER_EXT_XVMC
endif

ifdef PTXCONF_XORG_SERVER_EXT_DGA
endif

ifdef PTXCONF_XORG_SERVER_EXT_SCREENSAVER
endif

ifdef PTXCONF_XORG_SERVER_EXT_XDMCP
endif

ifdef PTXCONF_XORG_SERVER_EXT_XDMCP_AUTH_1
endif

ifdef PTXCONF_XORG_SERVER_EXT_GLX
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/libglx.so)
endif

ifdef PTXCONF_XORG_SERVER_EXT_DRI
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/libdri.so)
endif

ifdef PTXCONF_XORG_SERVER_EXT_DRI2
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/libdri2.so)
endif

ifdef PTXCONF_XORG_SERVER_EXT_XINERAMA

endif

ifdef PTXCONF_XORG_SERVER_EXT_XF86VIDMODE
endif

ifdef PTXCONF_XORG_SERVER_EXT_XF86MISC
endif

ifdef PTXCONF_XORG_SERVER_EXT_XCSECURITY
endif

ifdef PTXCONF_XORG_SERVER_EXT_XEVIE
endif

ifdef PTXCONF_XORG_SERVER_EXT_LBX
endif

ifdef PTXCONF_XORG_SERVER_EXT_APPGROUP
endif

ifdef PTXCONF_XORG_SERVER_EXT_CUP
endif

ifdef PTXCONF_XORG_SERVER_EXT_EVI
endif

ifdef PTXCONF_XORG_SERVER_EXT_MULTIBUFFER
endif

ifdef PTXCONF_XORG_SERVER_OPT_SECURE_RPC
endif

ifdef PTXCONF_XORG_SERVER_OPT_XORGCFG
endif

ifdef PTXCONF_XORG_SERVER_OPT_KBD_MODE
endif
endif # PTXCONF_XORG_SERVER_XORG
	@$(call install_finish, xorg-server)

	@$(call touch)

# vim: syntax=make

