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
XORG_SERVER_URL		:= ftp://ftp.gwdg.de/pub/x11/x.org/pub/X11R7.0/src/xorg-server/$(XORG_SERVER).$(XORG_SERVER_SUFFIX)
XORG_SERVER_SOURCE	:= $(SRCDIR)/$(XORG_SERVER).$(XORG_SERVER_SUFFIX)
XORG_SERVER_DIR		:= $(BUILDDIR)/$(XORG_SERVER)

-include $(call package_depfile)

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

#
# autoconf
#
XORG_SERVER_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_XORG_SERVER_SHAPE
XORG_SERVER_AUTOCONF += --enable-shape
else
XORG_SERVER_AUTOCONF += --disable-shape
endif

ifdef PTXCONF_XORG_SERVER_XV
XORG_SERVER_AUTOCONF += --enable-xv
else
XORG_SERVER_AUTOCONF += --disable-xv
endif

ifdef PTXCONF_XORG_SERVER_COMPOSITE
XORG_SERVER_AUTOCONF += --enable-composite
else
XORG_SERVER_AUTOCONF += --disable-composite
endif

ifdef PTXCONF_XORG_SERVER_SHM
XORG_SERVER_AUTOCONF += --enable-shm
else
XORG_SERVER_AUTOCONF += --disable-shm
endif

ifdef PTXCONF_XORG_SERVER_XRES
XORG_SERVER_AUTOCONF += --enable-xres
else
XORG_SERVER_AUTOCONF += --disable-xres
endif

ifdef PTXCONF_XORG_SERVER_XRECORD
XORG_SERVER_AUTOCONF += --enable-xrecord
else
XORG_SERVER_AUTOCONF += --disable-xrecord
endif

ifdef PTXCONF_XORG_SERVER_KDRIVE
XORG_SERVER_AUTOCONF += --enable-kdriveserver
else
XORG_SERVER_AUTOCONF += --disable-kdriveserver
endif

ifdef PTXCONF_XORG_SERVER_XNEST
XORG_SERVER_AUTOCONF += --enable-xnestserver
else
XORG_SERVER_AUTOCONF += --disable-xnestserver
endif

ifdef PTXCONF_XORG_SERVER_XWIN
XORG_SERVER_AUTOCONF += --enable-xwinserver
else
XORG_SERVER_AUTOCONF += --disable-xwinserver
endif

ifdef PTXCONF_XORG_SERVER_XSDL
XORG_SERVER_AUTOCONF += --enable-xsdlserver
else
XORG_SERVER_AUTOCONF += --disable-xsdlserver
endif

ifdef PTXCONF_XORG_SERVER_XGL
XORG_SERVER_AUTOCONF += --enable-xglserver
else
XORG_SERVER_AUTOCONF += --disable-xglserver
endif

ifdef PTXCONF_XORG_SERVER_XTRAP
XORG_SERVER_AUTOCONF += --enable-xtrap
else
XORG_SERVER_AUTOCONF += --disable-xtrap
endif

ifdef PTXCONF_XORG_SERVER_BUILTIN_RGB
XORG_SERVER_AUTOCONF += --enable-builtinrgb
else
XORG_SERVER_AUTOCONF += --disable-builtinrgb
endif

ifdef PTXCONF_XORG_SERVER_SCREENSAVER
XORG_SERVER_AUTOCONF += --enable-screensaver
else
XORG_SERVER_AUTOCONF += --disable-screensaver
endif

ifdef PTXCONF_XORG_SERVER_XDMCP
XORG_SERVER_AUTOCONF += --enable-xdmcp
else
XORG_SERVER_AUTOCONF += --disable-xdmcp
endif

ifdef PTXCONF_XORG_SERVER_XDM_AUTH
XORG_SERVER_AUTOCONF += --enable-xdm-auth-1
else
XORG_SERVER_AUTOCONF += --disable-xdm-auth-1
endif

ifdef PTXCONF_XORG_SERVER_GLX
XORG_SERVER_AUTOCONF += --enable-glx
else
XORG_SERVER_AUTOCONF += --disable-glx
endif

ifdef PTXCONF_XORG_SERVER_DRI
XORG_SERVER_AUTOCONF += --enable-dri
else
XORG_SERVER_AUTOCONF += --disable-dri
endif

ifdef PTXCONF_XORG_SERVER_XINPUT
XORG_SERVER_AUTOCONF += --enable-xinput
else
XORG_SERVER_AUTOCONF += --disable-xinput
endif

ifdef PTXCONF_XORG_SERVER_XKB
XORG_SERVER_AUTOCONF += --enable-xkb
else
XORG_SERVER_AUTOCONF += --disable-xkb
endif

ifdef PTXCONF_XORG_SERVER_XLOADABLE
XORG_SERVER_AUTOCONF += --enable-xloadable
else
XORG_SERVER_AUTOCONF += --disable-xloadable
endif

ifdef PTXCONF_XORG_SERVER_XINERAMA
XORG_SERVER_AUTOCONF += --enable-xinerama
else
XORG_SERVER_AUTOCONF += --disable-xinerama
endif

ifdef PTXCONF_XORG_SERVER_UNIX_TRANSPORT
XORG_SERVER_AUTOCONF += --enable-unix-transport
else
XORG_SERVER_AUTOCONF += --disable-unix-transport
endif

ifdef PTXCONF_XORG_SERVER_TCP_TRANSPORT
XORG_SERVER_AUTOCONF += --enable-tcp-transport
else
XORG_SERVER_AUTOCONF += --disable-tcp-transport
endif

ifdef PTXCONF_XORG_SERVER_IPV6_TRANSPORT
XORG_SERVER_AUTOCONF += --enable-ipv6
else
XORG_SERVER_AUTOCONF += --disable-ipv6
endif

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

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,xorg-server)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(XORG_SERVER_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(XORG_SERVER_DIR)/foobar, /dev/null)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-server_clean:
	rm -rf $(STATEDIR)/xorg-server.*
	rm -rf $(IMAGEDIR)/xorg-server_*
	rm -rf $(XORG_SERVER_DIR)

# vim: syntax=make
