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
PACKAGES-$(PTXCONF_XORG_LIB_XAU) += xorg-lib-Xau

#
# Paths and names
#
XORG_LIB_XAU_VERSION	:= 1.0.3
XORG_LIB_XAU		:= libXau-$(XORG_LIB_XAU_VERSION)
XORG_LIB_XAU_SUFFIX	:= tar.bz2
XORG_LIB_XAU_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XAU).$(XORG_LIB_XAU_SUFFIX)
XORG_LIB_XAU_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XAU).$(XORG_LIB_XAU_SUFFIX)
XORG_LIB_XAU_DIR	:= $(BUILDDIR)/$(XORG_LIB_XAU)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-Xau_get: $(STATEDIR)/xorg-lib-Xau.get

$(STATEDIR)/xorg-lib-Xau.get: $(xorg-lib-Xau_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XAU_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XAU)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-Xau_extract: $(STATEDIR)/xorg-lib-Xau.extract

$(STATEDIR)/xorg-lib-Xau.extract: $(xorg-lib-Xau_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XAU_DIR))
	@$(call extract, XORG_LIB_XAU)
	@$(call patchin, XORG_LIB_XAU)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-Xau_prepare: $(STATEDIR)/xorg-lib-Xau.prepare

XORG_LIB_XAU_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XAU_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XAU_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

ifdef PTXCONF_XORG_LIB_XAU_THREAD
XORG_LIB_XAU_AUTOCONF += --enable-xthreads
else
XORG_LIB_XAU_AUTOCONF += --disable-xthreads
endif

$(STATEDIR)/xorg-lib-Xau.prepare: $(xorg-lib-Xau_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XAU_DIR)/config.cache)
	cd $(XORG_LIB_XAU_DIR) && \
		$(XORG_LIB_XAU_PATH) $(XORG_LIB_XAU_ENV) \
		./configure $(XORG_LIB_XAU_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-Xau_compile: $(STATEDIR)/xorg-lib-Xau.compile

$(STATEDIR)/xorg-lib-Xau.compile: $(xorg-lib-Xau_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XAU_DIR) && $(XORG_LIB_XAU_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-Xau_install: $(STATEDIR)/xorg-lib-Xau.install

$(STATEDIR)/xorg-lib-Xau.install: $(xorg-lib-Xau_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XAU)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-Xau_targetinstall: $(STATEDIR)/xorg-lib-Xau.targetinstall

$(STATEDIR)/xorg-lib-Xau.targetinstall: $(xorg-lib-Xau_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-Xau)
	@$(call install_fixup, xorg-lib-Xau,PACKAGE,xorg-lib-xau)
	@$(call install_fixup, xorg-lib-Xau,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-Xau,VERSION,$(XORG_LIB_XAU_VERSION))
	@$(call install_fixup, xorg-lib-Xau,SECTION,base)
	@$(call install_fixup, xorg-lib-Xau,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-Xau,DEPENDS,)
	@$(call install_fixup, xorg-lib-Xau,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-Xau, 0, 0, 0644, \
		$(XORG_LIB_XAU_DIR)/.libs/libXau.so.6.0.0, \
		$(XORG_LIBDIR)/libXau.so.6.0.0)

	@$(call install_link, xorg-lib-Xau, \
		libXau.so.6.0.0, \
		$(XORG_LIBDIR)/libXau.so.6)

	@$(call install_link, xorg-lib-Xau, \
		libXau.so.6.0.0, \
		$(XORG_LIBDIR)/libXau.so)

	@$(call install_finish, xorg-lib-Xau)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-Xau_clean:
	rm -rf $(STATEDIR)/xorg-lib-Xau.*
	rm -rf $(PKGDIR)/xorg-lib-Xau_*
	rm -rf $(XORG_LIB_XAU_DIR)

# vim: syntax=make
