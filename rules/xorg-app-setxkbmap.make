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
PACKAGES-$(PTXCONF_XORG_APP_SETXKBMAP) += xorg-app-setxkbmap

#
# Paths and names
#
XORG_APP_SETXKBMAP_VERSION	:= 1.0.2
XORG_APP_SETXKBMAP		:= setxkbmap-X11R7.1-$(XORG_APP_SETXKBMAP_VERSION)
XORG_APP_SETXKBMAP_SUFFIX	:= tar.bz2
XORG_APP_SETXKBMAP_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.1/src/app//$(XORG_APP_SETXKBMAP).$(XORG_APP_SETXKBMAP_SUFFIX)
XORG_APP_SETXKBMAP_SOURCE	:= $(SRCDIR)/$(XORG_APP_SETXKBMAP).$(XORG_APP_SETXKBMAP_SUFFIX)
XORG_APP_SETXKBMAP_DIR	:= $(BUILDDIR)/$(XORG_APP_SETXKBMAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-setxkbmap_get: $(STATEDIR)/xorg-app-setxkbmap.get

$(STATEDIR)/xorg-app-setxkbmap.get: $(xorg-app-setxkbmap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_SETXKBMAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_SETXKBMAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-setxkbmap_extract: $(STATEDIR)/xorg-app-setxkbmap.extract

$(STATEDIR)/xorg-app-setxkbmap.extract: $(xorg-app-setxkbmap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_SETXKBMAP_DIR))
	@$(call extract, XORG_APP_SETXKBMAP)
	@$(call patchin, XORG_APP_SETXKBMAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-setxkbmap_prepare: $(STATEDIR)/xorg-app-setxkbmap.prepare

XORG_APP_SETXKBMAP_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_SETXKBMAP_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#

XORG_APP_SETXKBMAP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-setxkbmap.prepare: $(xorg-app-setxkbmap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_SETXKBMAP_DIR)/config.cache)
	@echo "selecting the correct search path in X-Server and setxkbmap is still missing"
	cd $(XORG_APP_SETXKBMAP_DIR) && \
		$(XORG_APP_SETXKBMAP_PATH) $(XORG_APP_SETXKBMAP_ENV) \
		./configure $(XORG_APP_SETXKBMAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-setxkbmap_compile: $(STATEDIR)/xorg-app-setxkbmap.compile

$(STATEDIR)/xorg-app-setxkbmap.compile: $(xorg-app-setxkbmap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_SETXKBMAP_DIR) && $(XORG_APP_SETXKBMAP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-setxkbmap_install: $(STATEDIR)/xorg-app-setxkbmap.install

$(STATEDIR)/xorg-app-setxkbmap.install: $(xorg-app-setxkbmap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_SETXKBMAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-setxkbmap_targetinstall: $(STATEDIR)/xorg-app-setxkbmap.targetinstall

$(STATEDIR)/xorg-app-setxkbmap.targetinstall: $(xorg-app-setxkbmap_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-setxkbmap)
	@$(call install_fixup, xorg-app-setxkbmap,PACKAGE,xorg-app-setxkbmap)
	@$(call install_fixup, xorg-app-setxkbmap,PRIORITY,optional)
	@$(call install_fixup, xorg-app-setxkbmap,VERSION,$(XORG_APP_SETXKBMAP_VERSION))
	@$(call install_fixup, xorg-app-setxkbmap,SECTION,base)
	@$(call install_fixup, xorg-app-setxkbmap,AUTHOR,"Juergen Beisert")
	@$(call install_fixup, xorg-app-setxkbmap,DEPENDS,)
	@$(call install_fixup, xorg-app-setxkbmap,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-setxkbmap,  0, 0, 0755, \
		$(XORG_APP_SETXKBMAP_DIR)/setxkbmap, /usr/bin/setxkbmap)

	@$(call install_finish, xorg-app-setxkbmap)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-setxkbmap_clean:
	rm -rf $(STATEDIR)/xorg-app-setxkbmap.*
	rm -rf $(IMAGEDIR)/xorg-app-setxkbmap_*
	rm -rf $(XORG_APP_SETXKBMAP_DIR)

# vim: syntax=make
