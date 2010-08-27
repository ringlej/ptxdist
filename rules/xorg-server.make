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
XORG_SERVER_VERSION	:= 1.8.2
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
# XORG_OPTIONS_TRANS adds:
# --{en,dis}able-{unix,tcp}-transport
# --{en,dis}able-ipv6
#
# use "=" here
XORG_SERVER_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-option-checking \
	--disable-maintainer-mode \
	--enable-dependency-tracking \
	--disable-strict-compilation \
	--disable-debug \
	--disable-unit-tests \
	--disable-builddocs \
	--disable-config-dbus \
	--disable-config-hal \
	--disable-xfree86-utils \
	--disable-xquartz \
	--disable-standalone-xpbproxy \
	--disable-local-transport \
	--without-doxygen \
	--with-xkb-output=/tmp \
	--with-fontrootdir=$(XORG_FONTDIR)

# FIXME
# --enable-shared
# --enable-static
# --enable-install-libxf86config

# FIXME new options

ifdef PTXCONF_XORG_SERVER_UDEV
XORG_SERVER_AUTOCONF += --enable-config-udev
else
XORG_SERVER_AUTOCONF += --disable-config-udev
endif

ifdef PTXCONF_XORG_SERVER_OPT_AIGLX
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
XORG_SERVER_AUTOCONF += --enable-mitshm
else
XORG_SERVER_AUTOCONF += --disable-mitshm
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

ifdef PTXCONF_XORG_SERVER_EXT_XDM_AUTH_1
XORG_SERVER_AUTOCONF += --enable-xdm-auth-1
else
XORG_SERVER_AUTOCONF += --disable-xdm-auth-1
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

ifdef PTXCONF_XORG_SERVER_EXT_DRI2
XORG_SERVER_AUTOCONF += --enable-dri2
else
XORG_SERVER_AUTOCONF += --disable-dri2
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

ifdef PTXCONF_XORG_SERVER_XFAKE
XORG_SERVER_AUTOCONF += --enable-xfake
else
XORG_SERVER_AUTOCONF += --disable-xfake
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
# FIXME mol: what is this int10 stuff for?
#
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
	@$(call install_fixup, xorg-server,PRIORITY,optional)
	@$(call install_fixup, xorg-server,SECTION,base)
	@$(call install_fixup, xorg-server,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-server,DESCRIPTION,missing)

ifdef PTXCONF_XORG_SERVER_CONFIG_FILES_XORG_CONF
	@$(call install_alternative, xorg-server, 0, 0, 0644, \
		/etc/X11/xorg.conf)
endif

ifdef PTXCONF_PRELINK
	@$(call install_alternative, xorg-server, 0, 0, 0644, \
		/etc/prelink.conf.d/xorg)
endif

ifdef PTXCONF_XORG_SERVER_UDEV
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/X11/xorg.conf.d/10-evdev.conf)
endif

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
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libexa.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libfb.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libint10.so)
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
endif
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/libextmod.so)
ifdef PTXCONF_XORG_SERVER_EXT_DBE
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/libdbe.so)
endif

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

ifdef PTXCONF_XORG_SERVER_EXT_XDM_AUTH_1
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

ifdef PTXCONF_XORG_SERVER_EXT_XCSECURITY
endif

ifdef PTXCONF_XORG_SERVER_EXT_MULTIBUFFER
endif

ifdef PTXCONF_XORG_SERVER_OPT_SECURE_RPC
endif

endif # PTXCONF_XORG_SERVER_XORG
	@$(call install_finish, xorg-server)

	@$(call touch)

# vim: syntax=make

