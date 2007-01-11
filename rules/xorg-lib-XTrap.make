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
PACKAGES-$(PTXCONF_XORG_LIB_XTRAP) += xorg-lib-XTrap

#
# Paths and names
#
XORG_LIB_XTRAP_VERSION	:= 1.0.0
XORG_LIB_XTRAP		:= libXTrap-X11R7.0-$(XORG_LIB_XTRAP_VERSION)
XORG_LIB_XTRAP_SUFFIX	:= tar.bz2
XORG_LIB_XTRAP_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.0/src/lib/$(XORG_LIB_XTRAP).$(XORG_LIB_XTRAP_SUFFIX)
XORG_LIB_XTRAP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XTRAP).$(XORG_LIB_XTRAP_SUFFIX)
XORG_LIB_XTRAP_DIR	:= $(BUILDDIR)/$(XORG_LIB_XTRAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-XTrap_get: $(STATEDIR)/xorg-lib-XTrap.get

$(STATEDIR)/xorg-lib-XTrap.get: $(xorg-lib-XTrap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XTRAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XTRAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-XTrap_extract: $(STATEDIR)/xorg-lib-XTrap.extract

$(STATEDIR)/xorg-lib-XTrap.extract: $(xorg-lib-XTrap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTRAP_DIR))
	@$(call extract, XORG_LIB_XTRAP)
	@$(call patchin, XORG_LIB_XTRAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-XTrap_prepare: $(STATEDIR)/xorg-lib-XTrap.prepare

XORG_LIB_XTRAP_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XTRAP_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XTRAP_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-lib-XTrap.prepare: $(xorg-lib-XTrap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XTRAP_DIR)/config.cache)
	cd $(XORG_LIB_XTRAP_DIR) && \
		$(XORG_LIB_XTRAP_PATH) $(XORG_LIB_XTRAP_ENV) \
		./configure $(XORG_LIB_XTRAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-XTrap_compile: $(STATEDIR)/xorg-lib-XTrap.compile

$(STATEDIR)/xorg-lib-XTrap.compile: $(xorg-lib-XTrap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XTRAP_DIR) && $(XORG_LIB_XTRAP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-XTrap_install: $(STATEDIR)/xorg-lib-XTrap.install

$(STATEDIR)/xorg-lib-XTrap.install: $(xorg-lib-XTrap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XTRAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-XTrap_targetinstall: $(STATEDIR)/xorg-lib-XTrap.targetinstall

$(STATEDIR)/xorg-lib-XTrap.targetinstall: $(xorg-lib-XTrap_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-XTrap)
	@$(call install_fixup, xorg-lib-XTrap,PACKAGE,xorg-lib-xtrap)
	@$(call install_fixup, xorg-lib-XTrap,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-XTrap,VERSION,$(XORG_LIB_XTRAP_VERSION))
	@$(call install_fixup, xorg-lib-XTrap,SECTION,base)
	@$(call install_fixup, xorg-lib-XTrap,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-XTrap,DEPENDS,)
	@$(call install_fixup, xorg-lib-XTrap,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-XTrap, 0, 0, 0644, \
		$(XORG_LIB_XTRAP_DIR)/src/.libs/libXTrap.so.6.4.0, \
		$(XORG_LIBDIR)/libXTrap.so.6.4.0)

	@$(call install_link, xorg-lib-XTrap, \
		libXTrap.so.6.4.0, \
		$(XORG_LIBDIR)/libXTrap.so.6)

	@$(call install_link, xorg-lib-XTrap, \
		libXTrap.so.6.4.0, \
		$(XORG_LIBDIR)/libXTrap.so)

	@$(call install_finish, xorg-lib-XTrap)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-XTrap_clean:
	rm -rf $(STATEDIR)/xorg-lib-XTrap.*
	rm -rf $(IMAGEDIR)/xorg-lib-XTrap_*
	rm -rf $(XORG_LIB_XTRAP_DIR)

# vim: syntax=make
