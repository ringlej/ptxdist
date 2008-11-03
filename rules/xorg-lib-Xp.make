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
PACKAGES-$(PTXCONF_XORG_LIB_XP) += xorg-lib-xp

#
# Paths and names
#
XORG_LIB_XP_VERSION	:= 1.0.0
XORG_LIB_XP		:= libXp-$(XORG_LIB_XP_VERSION)
XORG_LIB_XP_SUFFIX	:= tar.bz2
XORG_LIB_XP_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/lib//$(XORG_LIB_XP).$(XORG_LIB_XP_SUFFIX)
XORG_LIB_XP_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XP).$(XORG_LIB_XP_SUFFIX)
XORG_LIB_XP_DIR		:= $(BUILDDIR)/$(XORG_LIB_XP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-xp_get: $(STATEDIR)/xorg-lib-xp.get

$(STATEDIR)/xorg-lib-xp.get: $(xorg-lib-xp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_XP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_XP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-xp_extract: $(STATEDIR)/xorg-lib-xp.extract

$(STATEDIR)/xorg-lib-xp.extract: $(xorg-lib-xp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XP_DIR))
	@$(call extract, XORG_LIB_XP)
	@$(call patchin, XORG_LIB_XP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-xp_prepare: $(STATEDIR)/xorg-lib-xp.prepare

XORG_LIB_XP_PATH	:=  PATH=$(CROSS_PATH)
XORG_LIB_XP_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-malloc0returnsnull

$(STATEDIR)/xorg-lib-xp.prepare: $(xorg-lib-xp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_XP_DIR)/config.cache)
	cd $(XORG_LIB_XP_DIR) && \
		$(XORG_LIB_XP_PATH) $(XORG_LIB_XP_ENV) \
		./configure $(XORG_LIB_XP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-xp_compile: $(STATEDIR)/xorg-lib-xp.compile

$(STATEDIR)/xorg-lib-xp.compile: $(xorg-lib-xp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_XP_DIR) && $(XORG_LIB_XP_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-xp_install: $(STATEDIR)/xorg-lib-xp.install

$(STATEDIR)/xorg-lib-xp.install: $(xorg-lib-xp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_XP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-xp_targetinstall: $(STATEDIR)/xorg-lib-xp.targetinstall

$(STATEDIR)/xorg-lib-xp.targetinstall: $(xorg-lib-xp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-xp)
	@$(call install_fixup, xorg-lib-xp,PACKAGE,xorg-lib-xp)
	@$(call install_fixup, xorg-lib-xp,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xp,VERSION,$(XORG_LIB_XP_VERSION))
	@$(call install_fixup, xorg-lib-xp,SECTION,base)
	@$(call install_fixup, xorg-lib-xp,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xp,DEPENDS,)
	@$(call install_fixup, xorg-lib-xp,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xp, 0, 0, 0644, \
		$(XORG_LIB_XP_DIR)/src/.libs/libXp.so.6.2.0, \
		$(XORG_LIBDIR)/libXp.so.6.2.0)

	@$(call install_link, xorg-lib-xp, \
		libXp.so.6.2.0, \
		$(XORG_LIBDIR)/libXp.so.6)

	@$(call install_link, xorg-lib-xp, \
		libXp.so.6.2.0, \
		$(XORG_LIBDIR)/libXp.so)

	@$(call install_finish, xorg-lib-xp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-xp_clean:
	rm -rf $(STATEDIR)/xorg-lib-xp.*
	rm -rf $(PKGDIR)/xorg-lib-xp_*
	rm -rf $(XORG_LIB_XP_DIR)

# vim: syntax=make
