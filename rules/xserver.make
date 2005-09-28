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
XSERVER_VERSION		= 20041103-1
XSERVER			= xserver-$(XSERVER_VERSION)
XSERVER_SUFFIX		= tar.bz2
XSERVER_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XSERVER).$(XSERVER_SUFFIX)
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
xserver_prepare_deps += $(STATEDIR)/xlibs-xext.install
xserver_prepare_deps += $(STATEDIR)/xlibs-randr.install
xserver_prepare_deps += $(STATEDIR)/xlibs-fixesext.install
xserver_prepare_deps += $(STATEDIR)/xlibs-damageext.install
xserver_prepare_deps += $(STATEDIR)/xlibs-xfont.install
xserver_prepare_deps += $(STATEDIR)/xlibs-render.install

XSERVER_PATH	=  PATH=$(CROSS_PATH)
XSERVER_ENV 	=  $(CROSS_ENV)
XSERVER_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
XSERVER_AUTOCONF =  --build=$(GNU_HOST)
XSERVER_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
XSERVER_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

ifdef PTXCONF_XSERVER_SHAPE
XSERVER_AUTOCONF += --enable-shape
else
XSERVER_AUTOCONF += --disable-shape
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

ifdef PTXCONF_XSERVER_KDRIVE
XSERVER_AUTOCONF += --enable-kdriveserver
else
XSERVER_AUTOCONF += --disable-kdriveserver
endif

ifdef PTXCONF_XSERVER_XNEST
XSERVER_AUTOCONF += --enable-xnestserver
else
XSERVER_AUTOCONF += --disable-xnestserver
endif

ifdef PTXCONF_XSERVER_XWIN
XSERVER_AUTOCONF += --enable-xwinserver
else
XSERVER_AUTOCONF += --disable-xwinserver
endif

ifdef PTXCONF_XSERVER_XSDL
XSERVER_AUTOCONF += --enable-xsdlserver
else
XSERVER_AUTOCONF += --disable-xsdlserver
endif

ifdef PTXCONF_XSERVER_XGL
XSERVER_AUTOCONF += --enable-xglserver
else
XSERVER_AUTOCONF += --disable-xglserver
endif

ifdef PTXCONF_XSERVER_XTRAP
XSERVER_AUTOCONF += --enable-xtrap
else
XSERVER_AUTOCONF += --disable-xtrap
endif

ifdef PTXCONF_XSERVER_BUILTIN_RGB
XSERVER_AUTOCONF += --enable-builtinrgb
else
XSERVER_AUTOCONF += --disable-builtinrgb
endif

ifdef PTXCONF_XSERVER_SCREENSAVER
XSERVER_AUTOCONF += --enable-screensaver
else
XSERVER_AUTOCONF += --disable-screensaver
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

ifdef PTXCONF_XSERVER_XINPUT
XSERVER_AUTOCONF += --enable-xinput
else
XSERVER_AUTOCONF += --disable-xinput
endif

ifdef PTXCONF_XSERVER_XKB
XSERVER_AUTOCONF += --enable-xkb
else
XSERVER_AUTOCONF += --disable-xkb
endif

ifdef PTXCONF_XSERVER_XLOADABLE
XSERVER_AUTOCONF += --enable-xloadable
else
XSERVER_AUTOCONF += --disable-xloadable
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
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xext.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-randr.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-fixesext.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-damageext.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xfont.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-render.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-x11.targetinstall
xserver_targetinstall_deps += $(STATEDIR)/xlibs-xau.targetinstall

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
