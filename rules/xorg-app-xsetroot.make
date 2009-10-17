# -*-makefile-*-
# $Id: template 4761 2006-02-24 17:35:57Z sha $
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XSETROOT) += xorg-app-xsetroot

#
# Paths and names
#
XORG_APP_XSETROOT_VERSION	:= 1.0.3
XORG_APP_XSETROOT		:= xsetroot-$(XORG_APP_XSETROOT_VERSION)
XORG_APP_XSETROOT_SUFFIX	:= tar.bz2
XORG_APP_XSETROOT_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XSETROOT).$(XORG_APP_XSETROOT_SUFFIX)
XORG_APP_XSETROOT_SOURCE	:= $(SRCDIR)/$(XORG_APP_XSETROOT).$(XORG_APP_XSETROOT_SUFFIX)
XORG_APP_XSETROOT_DIR		:= $(BUILDDIR)/$(XORG_APP_XSETROOT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xsetroot_get: $(STATEDIR)/xorg-app-xsetroot.get

$(STATEDIR)/xorg-app-xsetroot.get: $(xorg-app-xsetroot_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XSETROOT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XSETROOT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xsetroot_extract: $(STATEDIR)/xorg-app-xsetroot.extract

$(STATEDIR)/xorg-app-xsetroot.extract: $(xorg-app-xsetroot_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XSETROOT_DIR))
	@$(call extract, XORG_APP_XSETROOT)
	@$(call patchin, XORG_APP_XSETROOT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xsetroot_prepare: $(STATEDIR)/xorg-app-xsetroot.prepare

XORG_APP_XSETROOT_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XSETROOT_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XSETROOT_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-xsetroot.prepare: $(xorg-app-xsetroot_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XSETROOT_DIR)/config.cache)
	cd $(XORG_APP_XSETROOT_DIR) && \
		$(XORG_APP_XSETROOT_PATH) $(XORG_APP_XSETROOT_ENV) \
		./configure $(XORG_APP_XSETROOT_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xsetroot_compile: $(STATEDIR)/xorg-app-xsetroot.compile

$(STATEDIR)/xorg-app-xsetroot.compile: $(xorg-app-xsetroot_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XSETROOT_DIR) && $(XORG_APP_XSETROOT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xsetroot_install: $(STATEDIR)/xorg-app-xsetroot.install

$(STATEDIR)/xorg-app-xsetroot.install: $(xorg-app-xsetroot_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XSETROOT)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xsetroot_targetinstall: $(STATEDIR)/xorg-app-xsetroot.targetinstall

$(STATEDIR)/xorg-app-xsetroot.targetinstall: $(xorg-app-xsetroot_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xsetroot)
	@$(call install_fixup,xorg-app-xsetroot,PACKAGE,xorg-app-xsetroot)
	@$(call install_fixup,xorg-app-xsetroot,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xsetroot,VERSION,$(XORG_APP_XSETROOT_VERSION))
	@$(call install_fixup,xorg-app-xsetroot,SECTION,base)
	@$(call install_fixup,xorg-app-xsetroot,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,xorg-app-xsetroot,DEPENDS,)
	@$(call install_fixup,xorg-app-xsetroot,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xsetroot, 0, 0, 0755, $(XORG_APP_XSETROOT_DIR)/xsetroot, $(XORG_BINDIR)/xsetroot)

	@$(call install_finish,xorg-app-xsetroot)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xsetroot_clean:
	rm -rf $(STATEDIR)/xorg-app-xsetroot.*
	rm -rf $(PKGDIR)/xorg-app-xsetroot_*
	rm -rf $(XORG_APP_XSETROOT_DIR)

# vim: syntax=make
