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
XORG_SERVER_VERSION	:= 1.17.2
XORG_SERVER_MD5		:= 397e405566651150490ff493e463f1ad
XORG_SERVER		:= xorg-server-$(XORG_SERVER_VERSION)
XORG_SERVER_SUFFIX	:= tar.bz2
XORG_SERVER_URL		:= $(call ptx/mirror, XORG, individual/xserver/$(XORG_SERVER).$(XORG_SERVER_SUFFIX))
XORG_SERVER_SOURCE	:= $(SRCDIR)/$(XORG_SERVER).$(XORG_SERVER_SUFFIX)
XORG_SERVER_DIR		:= $(BUILDDIR)/$(XORG_SERVER)
XORG_SERVER_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# The xorg module loader needs lazy symbol binding
XORG_SERVER_WRAPPER_BLACKLIST := \
        TARGET_HARDEN_BINDNOW

XORG_SERVER_ENV 	:= $(CROSS_ENV) \
	ac_cv_sys_linker_h=yes \
	ac_cv_file__usr_share_sgml_X11_defs_ent=no

#
# FIXME: not all processors support MTRR. Geode GX1 not for
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
XORG_SERVER_CONF_TOOL	:= autoconf
# use "=" here
XORG_SERVER_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	--disable-strict-compilation \
	--disable-docs \
	--disable-devel-docs \
	--disable-unit-tests \
	--disable-static \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-debug \
	--disable-sparkle \
	--disable-install-libxf86config \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_OPT_AIGLX)-aiglx \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_OPT_GLX_TLS)-glx-tls \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_COMPOSITE)-composite \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_SHM)-mitshm \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XRES)-xres \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_RECORD)-record \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XV)-xv \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XVMC)-xvmc \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_DGA)-dga \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_SCREENSAVER)-screensaver \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XDMCP)-xdmcp \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XDM_AUTH_1)-xdm-auth-1 \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_GLX)-glx \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_DRI)-dri \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_DRI2)-dri2 \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_DRI3)-dri3 \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_PRESENT)-present \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XINERAMA)-xinerama \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XF86VIDMODE)-xf86vidmode \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XACE)-xace \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XSELINUX)-xselinux \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_XCSECURITY)-xcsecurity \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_TSLIB)-tslib \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_DBE)-dbe \
	--$(call ptx/endis, PTXCONF_XORG_LIB_X11_XF86BIGFONT)-xf86bigfont \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_DPMS)-dpms \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_UDEV)-config-udev \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_UDEV)-config-udev-kms \
	--disable-config-hal \
	--disable-config-wscons \
	--disable-xfree86-utils \
	--enable-vgahw \
	--enable-vbe \
	--enable-int10-module \
	--disable-windowswm \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_LIBDRM)-libdrm \
	--enable-clientids \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XORG)-pciaccess \
	--enable-linux-acpi \
	--enable-linux-apm \
	--disable-listen-tcp \
	--enable-listen-unix \
	--enable-listen-local \
	--disable-systemd-logind \
	--disable-suid-wrapper \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XORG)-xorg \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_DMX)-dmx \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XVFB)-xvfb \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XNEST)-xnest \
	--disable-xquartz \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_EXT_DRI3)-xshmfence \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XWAYLAND)-xwayland \
	--disable-standalone-xpbproxy \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XWIN)-xwin \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_GLAMOR)-glamor \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_KDRIVE)-kdrive \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XEPHYR)-xephyr \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XFAKE)-xfake \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_XFBDEV)-xfbdev \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_KDRIVE_KBD)-kdrive-kbd \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_KDRIVE_MOUSE)-kdrive-mouse \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_KDRIVE_EVDEV)-kdrive-evdev \
	--disable-libunwind \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_OPT_INSTALL_SETUID)-install-setuid \
	$(XORG_OPTIONS_TRANS) \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_OPT_SECURE_RPC)-secure-rpc \
	--enable-xtrans-send-fds \
	--without-doxygen \
	$(XORG_OPTIONS_DOCS) \
	--with-vendor-name=Ptxdist \
	--with-vendor-name-short=PTX \
	--with-vendor-web=http://www.pengutronix.de/software/ptxdist/index_en.html \
	--with-os-name=Linux-$(KERNEL_HEADER_VERSION) \
	--with-os-vendor=Ptxdist \
	--with-fontrootdir=$(XORG_FONTDIR) \
	--with-xkb-output=/tmp \
	--without-systemd-daemon \
	--with-sha1=libcrypto

#
# FIXME rsc: what's the reason for this hack?
#

# if no value is given ignore the "--datadir" switch
ifneq ($(call remove_quotes,$(XORG_DATADIR)),)
	XORG_SERVER_CONF_OPT += --datadir=$(XORG_DATADIR)
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

ifdef PTXCONF_XORG_SERVER_XORG
ifdef PTXCONF_XORG_SERVER_UDEV
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_DATADIR)/X11/xorg.conf.d/10-evdev.conf)
endif
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
ifdef PTXCONF_XORG_SERVER_XWAYLAND
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xwayland)
endif
ifdef PTXCONF_XORG_SERVER_XWIN
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xwin)
endif
ifdef PTXCONF_XORG_SERVER_XFBDEV
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xfbdev)
endif

ifdef PTXCONF_XORG_SERVER_XORG
	@$(call install_copy, xorg-server, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/Xorg)
	@$(call install_link, xorg-server, Xorg, /usr/bin/X)

ifdef PTXCONF_XORG_DRIVER_VIDEO
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libexa.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libfb.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libfbdevhw.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libint10.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libshadow.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libshadowfb.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libvbe.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libwfb.so)
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libvgahw.so)
ifdef PTXCONF_XORG_DRIVER_VIDEO_MODESETTING
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/drivers/modesetting_drv.so)
endif
endif

ifdef PTXCONF_XORG_SERVER_EXT_GLX
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		/usr/lib/xorg/modules/extensions/libglx.so)
endif
ifdef PTXCONF_XORG_SERVER_GLAMOR
	@$(call install_copy, xorg-server, 0, 0, 0644, -, \
		$(XORG_PREFIX)/lib/xorg/modules/libglamoregl.so)
endif

endif # PTXCONF_XORG_SERVER_XORG
	@$(call install_finish, xorg-server)

	@$(call touch)

# vim: syntax=make

