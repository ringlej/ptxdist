# -*-makefile-*-
#
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: RSC: do something on targetinstall

#
# We provide this package
#
ifdef PTXCONF_XSERVER
PACKAGES += xserver
endif

#
# Paths and names
#
XSERVER_VERSION		= 0.99.1
XSERVER			= xorg-server-$(XSERVER_VERSION)
XSERVER_SUFFIX		= tar.bz2
XSERVER_URL		= http://xorg.freedesktop.org/X11R7.0-RC0/xserver/$(XSERVER).$(XSERVER_SUFFIX)
XSERVER_SOURCE		= $(SRCDIR)/$(XSERVER).$(XSERVER_SUFFIX)
XSERVER_DIR		= $(BUILDDIR)/$(XSERVER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xserver_get: $(STATEDIR)/xserver.get

xserver_get_deps = $(XSERVER_SOURCE)

$(STATEDIR)/xserver.get: $(xserver_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XSERVER))
	$(call touch, $@)

$(XSERVER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(XSERVER_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xserver_extract: $(STATEDIR)/xserver.extract

xserver_extract_deps = $(STATEDIR)/xserver.get

$(STATEDIR)/xserver.extract: $(xserver_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XSERVER_DIR))
	@$(call extract, $(XSERVER_SOURCE))
	@$(call patchin, $(XSERVER))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xserver_prepare: $(STATEDIR)/xserver.prepare

#
# dependencies
#
xserver_prepare_deps =  $(STATEDIR)/xserver.extract
xserver_prepare_deps += $(STATEDIR)/virtual-xchain.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xfont.install
xserver_prepare_deps += $(STATEDIR)/xlibs-randrproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-renderproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-fixesproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-damageproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xextproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xfont.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xtrans.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xau.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xf86dgaproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xf86miscproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xf86rushproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xf86vidmodeproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xf86bigfontproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xkbfile.install
xserver_prepare_deps += $(STATEDIR)/xlibs-recordproto.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xscrnsaver.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xv.install

XSERVER_PATH	=  PATH=$(CROSS_PATH)
XSERVER_ENV 	=  $(CROSS_ENV)
XSERVER_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
XSERVER_ENV	+= ac_cv_sysv_ipc=yes

#
# autoconf
#
# FIXME
#XSERVER_AUTOCONF =  --build=$(GNU_HOST)
#XSERVER_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
#XSERVER_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

XSERVER_AUTOCONF  =  $(CROSS_AUTOCONF)

ifdef PTXCONF_XSERVER_XF86MISC
XSERVER_AUTOCONF += --enable-xf86misc
else
XSERVER_AUTOCONF += --disable-xf86misc
endif

ifdef PTXCONF_XSERVER_XF86VIDMODE
XSERVER_AUTOCONF += --enable-xf86vidmode
else
XSERVER_AUTOCONF += --disable-xf86vidmode
endif

ifdef PTXCONF_XSERVER_XTRAP
XSERVER_AUTOCONF += --enable-xtrap
else
XSERVER_AUTOCONF += --disable-xtrap
endif

ifdef PTXCONF_XSERVER_XCSECURITY
XSERVER_AUTOCONF += --enable-xcsecurity
else
XSERVER_AUTOCONF += --disable-xcsecurity
endif

ifdef PTXCONF_XSERVER_XEVIE
XSERVER_AUTOCONF += --enable-xevie
else
XSERVER_AUTOCONF += --disable-xevie
endif

ifdef PTXCONF_XSERVER_WERROR
XSERVER_AUTOCONF += --enable-werror
else
XSERVER_AUTOCONF += --disable-werror
endif

ifdef PTXCONF_XSERVER_XV
XSERVER_AUTOCONF += --enable-xv
else
XSERVER_AUTOCONF += --disable-xv
endif

ifdef PTXCONF_XSERVER_COMPOSITE
XSERVER_AUTOCONF += --enable-composite
else
XSERVER_AUTOCONF += --disable-composite
endif

ifdef PTXCONF_XSERVER_SHM
XSERVER_AUTOCONF += --enable-shm
else
XSERVER_AUTOCONF += --disable-shm
endif

ifdef PTXCONF_XSERVER_XRES
XSERVER_AUTOCONF += --enable-xres
else
XSERVER_AUTOCONF += --disable-xres
endif

ifdef PTXCONF_XSERVER_XRECORD
XSERVER_AUTOCONF += --enable-xrecord
else
XSERVER_AUTOCONF += --disable-xrecord
endif

ifdef PTXCONF_XSERVER_XNEST
XSERVER_AUTOCONF += --enable-xnest
else
XSERVER_AUTOCONF += --disable-xnest
endif

ifdef PTXCONF_XSERVER_XORG
XSERVER_AUTOCONF += --enable-xorg
else
XSERVER_AUTOCONF += --disable-xorg
endif

ifdef PTXCONF_XSERVER_DMX
XSERVER_AUTOCONF += --enable-dmx
else
XSERVER_AUTOCONF += --disable-dmx
endif

ifdef PTXCONF_XSERVER_XVFB
XSERVER_AUTOCONF += --enable-xvfb
else
XSERVER_AUTOCONF += --disable-xvfb
endif

ifdef PTXCONF_XSERVER_XWIN
XSERVER_AUTOCONF += --enable-xwin
else
XSERVER_AUTOCONF += --disable-xwin
endif

ifdef PTXCONF_XSERVER_XDMCP
XSERVER_AUTOCONF += --enable-xdmcp
else
XSERVER_AUTOCONF += --disable-xdmcp
endif

ifdef PTXCONF_XSERVER_XDM_AUTH
XSERVER_AUTOCONF += --enable-xdm-auth-1
else
XSERVER_AUTOCONF += --disable-xdm-auth-1
endif

ifdef PTXCONF_XSERVER_GLX
XSERVER_AUTOCONF += --enable-glx
else
XSERVER_AUTOCONF += --disable-glx
endif

ifdef PTXCONF_XSERVER_DRI
XSERVER_AUTOCONF += --enable-dri
else
XSERVER_AUTOCONF += --disable-dri
endif

ifdef PTXCONF_XSERVER_XINERAMA
XSERVER_AUTOCONF += --enable-xinerama
else
XSERVER_AUTOCONF += --disable-xinerama
endif

ifdef PTXCONF_XSERVER_UNIX_TRANSPORT
XSERVER_AUTOCONF += --enable-unix-transport
else
XSERVER_AUTOCONF += --disable-unix-transport
endif

ifdef PTXCONF_XSERVER_TCP_TRANSPORT
XSERVER_AUTOCONF += --enable-tcp-transport
else
XSERVER_AUTOCONF += --disable-tcp-transport
endif

ifdef PTXCONF_XSERVER_IPV6_TRANSPORT
XSERVER_AUTOCONF += --enable-ipv6
else
XSERVER_AUTOCONF += --disable-ipv6
endif

$(STATEDIR)/xserver.prepare: $(xserver_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XSERVER_DIR)/config.cache)
	chmod a+x $(XSERVER_DIR)/configure
	cd $(XSERVER_DIR) && \
		$(XSERVER_PATH) $(XSERVER_ENV) \
		./configure $(XSERVER_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xserver_compile: $(STATEDIR)/xserver.compile

xserver_compile_deps = $(STATEDIR)/xserver.prepare

$(STATEDIR)/xserver.compile: $(xserver_compile_deps)
	@$(call targetinfo, $@)
	cd $(XSERVER_DIR) && $(XSERVER_ENV) $(XSERVER_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xserver_install: $(STATEDIR)/xserver.install

$(STATEDIR)/xserver.install: $(STATEDIR)/xserver.compile
	@$(call targetinfo, $@)
	cd $(XSERVER_DIR) && $(XSERVER_ENV) $(XSERVER_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xserver_targetinstall: $(STATEDIR)/xserver.targetinstall

xserver_targetinstall_deps = $(STATEDIR)/xserver.compile
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xfont.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-randrproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-renderproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-fixesproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-damageproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xextproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xfont.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xtrans.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xau.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xf86dgaproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xf86miscproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xf86rushproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xf86vidmodeproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xf86bigfontproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xkbfile.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-recordproto.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xscrnsaver.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xv.targetinstall

$(STATEDIR)/xserver.targetinstall: $(xserver_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xserver_clean:
	rm -rf $(STATEDIR)/xserver.*
	rm -rf $(XSERVER_DIR)

# vim: syntax=make
