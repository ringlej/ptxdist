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
PACKAGES-$(PTXCONF_XORG_LIB_XTRAP) += xorg-lib-xtrap

#
# Paths and names
#
XORG_LIB_XTRAP_VERSION	:= 1.0.0
XORG_LIB_XTRAP		:= libXTrap-$(XORG_LIB_XTRAP_VERSION)
XORG_LIB_XTRAP_SUFFIX	:= tar.bz2
XORG_LIB_XTRAP_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib/$(XORG_LIB_XTRAP).$(XORG_LIB_XTRAP_SUFFIX)
XORG_LIB_XTRAP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XTRAP).$(XORG_LIB_XTRAP_SUFFIX)
XORG_LIB_XTRAP_DIR	:= $(BUILDDIR)/$(XORG_LIB_XTRAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xtrap_get: $(STATEDIR)/xorg-lib-xtrap.get

$(STATEDIR)/xorg-lib-xtrap.get: $(xorg-lib-xtrap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XTRAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XTRAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xtrap_extract: $(STATEDIR)/xorg-lib-xtrap.extract

$(STATEDIR)/xorg-lib-xtrap.extract: $(xorg-lib-xtrap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTRAP_DIR))
	@$(call extract, XORG_LIB_XTRAP)
	@$(call patchin, XORG_LIB_XTRAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xtrap_prepare: $(STATEDIR)/xorg-lib-xtrap.prepare

XORG_LIB_XTRAP_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XTRAP_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XTRAP_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-xtrap.prepare: $(xorg-lib-xtrap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTRAP_DIR)/config.cache)
	cd $(XORG_LIB_XTRAP_DIR) && \
		$(XORG_LIB_XTRAP_PATH) $(XORG_LIB_XTRAP_ENV) \
		./configure $(XORG_LIB_XTRAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xtrap_compile: $(STATEDIR)/xorg-lib-xtrap.compile

$(STATEDIR)/xorg-lib-xtrap.compile: $(xorg-lib-xtrap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XTRAP_DIR) && $(XORG_LIB_XTRAP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xtrap_install: $(STATEDIR)/xorg-lib-xtrap.install

$(STATEDIR)/xorg-lib-xtrap.install: $(xorg-lib-xtrap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XTRAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xtrap_targetinstall: $(STATEDIR)/xorg-lib-xtrap.targetinstall

$(STATEDIR)/xorg-lib-xtrap.targetinstall: $(xorg-lib-xtrap_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xtrap)
	@$(call install_fixup, xorg-lib-xtrap,PACKAGE,xorg-lib-xtrap)
	@$(call install_fixup, xorg-lib-xtrap,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xtrap,VERSION,$(XORG_LIB_XTRAP_VERSION))
	@$(call install_fixup, xorg-lib-xtrap,SECTION,base)
	@$(call install_fixup, xorg-lib-xtrap,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xtrap,DEPENDS,)
	@$(call install_fixup, xorg-lib-xtrap,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xtrap, 0, 0, 0644, \
		$(XORG_LIB_XTRAP_DIR)/src/.libs/libXTrap.so.6.4.0, \
		$(XORG_LIBDIR)/libXTrap.so.6.4.0)

	@$(call install_link, xorg-lib-xtrap, \
		libXTrap.so.6.4.0, \
		$(XORG_LIBDIR)/libXTrap.so.6)

	@$(call install_link, xorg-lib-xtrap, \
		libXTrap.so.6.4.0, \
		$(XORG_LIBDIR)/libXTrap.so)

	@$(call install_finish, xorg-lib-xtrap)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xtrap_clean:
	rm -rf $(STATEDIR)/xorg-lib-xtrap.*
	rm -rf $(PKGDIR)/xorg-lib-xtrap_*
	rm -rf $(XORG_LIB_XTRAP_DIR)

# vim: syntax=make
