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
PACKAGES-$(PTXCONF_XORG_LIB_XFONT) += xorg-lib-Xfont

#
# Paths and names
#
XORG_LIB_XFONT_VERSION	:= 1.1.0
XORG_LIB_XFONT		:= libXfont-X11R7.1-$(XORG_LIB_XFONT_VERSION)
XORG_LIB_XFONT_SUFFIX	:= tar.bz2
XORG_LIB_XFONT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/lib/$(XORG_LIB_XFONT).$(XORG_LIB_XFONT_SUFFIX)
XORG_LIB_XFONT_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XFONT).$(XORG_LIB_XFONT_SUFFIX)
XORG_LIB_XFONT_DIR	:= $(BUILDDIR)/$(XORG_LIB_XFONT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xfont_get: $(STATEDIR)/xorg-lib-Xfont.get

$(STATEDIR)/xorg-lib-Xfont.get: $(xorg-lib-Xfont_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XFONT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XFONT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xfont_extract: $(STATEDIR)/xorg-lib-Xfont.extract

$(STATEDIR)/xorg-lib-Xfont.extract: $(xorg-lib-Xfont_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFONT_DIR))
	@$(call extract, XORG_LIB_XFONT)
	@$(call patchin, XORG_LIB_XFONT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xfont_prepare: $(STATEDIR)/xorg-lib-Xfont.prepare

XORG_LIB_XFONT_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XFONT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XFONT_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_XORG_OPTIONS_TRANS_UNIX
XORG_LIB_XFONT_AUTOCONF	+= --enable-unix-transport
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-unix-transport
endif

ifdef PTXCONF_XORG_OPTIONS_TRANS_TCP
XORG_LIB_XFONT_AUTOCONF	+= --enable-tcp-transport
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-tcp-transport
endif

#
# don't trust "./configure --help" for correct switches
# Here its says "--disable-IPv6" would disable IPv6
# But the configure script itself tests on --disable-ipv6!
#
ifdef PTXCONF_XORG_OPTIONS_TRANS_IPV6
XORG_LIB_XFONT_AUTOCONF	+= --enable-ipv6
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-ipv6
endif
#
# Use the global switch here to support freetype when
# its present in the system
#
ifdef PTXCONF_FREETYPE
XORG_LIB_XFONT_AUTOCONF	+= --enable-freetype
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-freetype
endif

ifdef PTXCONF_XORG_LIB_XFONT_FONTCACHE
XORG_LIB_XFONT_AUTOCONF	+= --enable-fontcache
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-fontcache
endif

ifdef PTXCONF_XORG_LIB_XFONT_FONTSERVER
XORG_LIB_XFONT_AUTOCONF	+= --enable-fc
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-fc
endif

ifdef PTXCONF_XORG_LIB_XFONT_TYPE1_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-type1
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-type1
endif

ifdef PTXCONF_XORG_LIB_XFONT_CID_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-cid
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-cid
endif

ifdef PTXCONF_XORG_LIB_XFONT_SPEEDO_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-speedo
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-speedo
endif

ifdef PTXCONF_XORG_LIB_XFONT_PCF_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-pcfformat
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-pcfformat
endif

ifdef PTXCONF_XORG_LIB_XFONT_BDF_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-bdfformat
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-bdfformat
endif

ifdef PTXCONF_XORG_LIB_XFONT_SNF_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-snfformat
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-snfformat
endif

ifdef PTXCONF_XORG_LIB_XFONT_BUILTIN_FONTS
XORG_LIB_XFONT_AUTOCONF	+= --enable-builtins
else
XORG_LIB_XFONT_AUTOCONF	+= --disable-builtins
endif

$(STATEDIR)/xorg-lib-Xfont.prepare: $(xorg-lib-Xfont_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XFONT_DIR)/config.cache)
	cd $(XORG_LIB_XFONT_DIR) && \
		$(XORG_LIB_XFONT_PATH) $(XORG_LIB_XFONT_ENV) \
		./configure $(XORG_LIB_XFONT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xfont_compile: $(STATEDIR)/xorg-lib-Xfont.compile

$(STATEDIR)/xorg-lib-Xfont.compile: $(xorg-lib-Xfont_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XFONT_DIR) && $(XORG_LIB_XFONT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xfont_install: $(STATEDIR)/xorg-lib-Xfont.install

$(STATEDIR)/xorg-lib-Xfont.install: $(xorg-lib-Xfont_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XFONT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xfont_targetinstall: $(STATEDIR)/xorg-lib-Xfont.targetinstall

$(STATEDIR)/xorg-lib-Xfont.targetinstall: $(xorg-lib-Xfont_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xfont)
	@$(call install_fixup, xorg-lib-Xfont,PACKAGE,xorg-lib-xfont)
	@$(call install_fixup, xorg-lib-Xfont,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xfont,VERSION,$(XORG_LIB_XFONT_VERSION))
	@$(call install_fixup, xorg-lib-Xfont,SECTION,base)
	@$(call install_fixup, xorg-lib-Xfont,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xfont,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xfont,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xfont, 0, 0, 0644, \
		$(XORG_LIB_XFONT_DIR)/src/.libs/libXfont.so.1.4.1, \
		$(XORG_LIBDIR)/libXfont.so.1.4.1)

	@$(call install_link, xorg-lib-Xfont, \
		libXfont.so.1.4.1, \
		$(XORG_LIBDIR)/libXfont.so.1)

	@$(call install_link, xorg-lib-Xfont, \
		libXfont.so.1.4.1, \
		$(XORG_LIBDIR)/libXfont.so)

	@$(call install_finish, xorg-lib-Xfont)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xfont_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xfont.*
	rm -rf $(IMAGEDIR)/xorg-lib-Xfont_*
	rm -rf $(XORG_LIB_XFONT_DIR)

# vim: syntax=make
