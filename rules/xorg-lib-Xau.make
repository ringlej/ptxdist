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
PACKAGES-$(PTXCONF_XORG_LIB_XAU) += xorg-lib-xau

#
# Paths and names
#
XORG_LIB_XAU_VERSION	:= 1.0.5
XORG_LIB_XAU		:= libXau-$(XORG_LIB_XAU_VERSION)
XORG_LIB_XAU_SUFFIX	:= tar.bz2
XORG_LIB_XAU_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XAU).$(XORG_LIB_XAU_SUFFIX)
XORG_LIB_XAU_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XAU).$(XORG_LIB_XAU_SUFFIX)
XORG_LIB_XAU_DIR	:= $(BUILDDIR)/$(XORG_LIB_XAU)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xau_get: $(STATEDIR)/xorg-lib-xau.get

$(STATEDIR)/xorg-lib-xau.get: $(xorg-lib-xau_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XAU_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XAU)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xau_extract: $(STATEDIR)/xorg-lib-xau.extract

$(STATEDIR)/xorg-lib-xau.extract: $(xorg-lib-xau_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XAU_DIR))
	@$(call extract, XORG_LIB_XAU)
	@$(call patchin, XORG_LIB_XAU)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xau_prepare: $(STATEDIR)/xorg-lib-xau.prepare

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

$(STATEDIR)/xorg-lib-xau.prepare: $(xorg-lib-xau_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XAU_DIR)/config.cache)
	cd $(XORG_LIB_XAU_DIR) && \
		$(XORG_LIB_XAU_PATH) $(XORG_LIB_XAU_ENV) \
		./configure $(XORG_LIB_XAU_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xau_compile: $(STATEDIR)/xorg-lib-xau.compile

$(STATEDIR)/xorg-lib-xau.compile: $(xorg-lib-xau_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XAU_DIR) && $(XORG_LIB_XAU_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xau_install: $(STATEDIR)/xorg-lib-xau.install

$(STATEDIR)/xorg-lib-xau.install: $(xorg-lib-xau_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XAU)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xau_targetinstall: $(STATEDIR)/xorg-lib-xau.targetinstall

$(STATEDIR)/xorg-lib-xau.targetinstall: $(xorg-lib-xau_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xau)
	@$(call install_fixup, xorg-lib-xau,PACKAGE,xorg-lib-xau)
	@$(call install_fixup, xorg-lib-xau,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xau,VERSION,$(XORG_LIB_XAU_VERSION))
	@$(call install_fixup, xorg-lib-xau,SECTION,base)
	@$(call install_fixup, xorg-lib-xau,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xau,DEPENDS,)
	@$(call install_fixup, xorg-lib-xau,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xau, 0, 0, 0644, \
		$(XORG_LIB_XAU_DIR)/.libs/libXau.so.6.0.0, \
		$(XORG_LIBDIR)/libXau.so.6.0.0)

	@$(call install_link, xorg-lib-xau, \
		libXau.so.6.0.0, \
		$(XORG_LIBDIR)/libXau.so.6)

	@$(call install_link, xorg-lib-xau, \
		libXau.so.6.0.0, \
		$(XORG_LIBDIR)/libXau.so)

	@$(call install_finish, xorg-lib-xau)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xau_clean:
	rm -rf $(STATEDIR)/xorg-lib-xau.*
	rm -rf $(PKGDIR)/xorg-lib-xau_*
	rm -rf $(XORG_LIB_XAU_DIR)

# vim: syntax=make
