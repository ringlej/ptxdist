# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
#
# Copyright (C) 2007 by cls@elaxys.com.br
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XAUTH) += xorg-app-xauth

#
# Paths and names
#
XORG_APP_XAUTH_VERSION	:= 1.0.4
XORG_APP_XAUTH		:= xauth-$(XORG_APP_XAUTH_VERSION)
XORG_APP_XAUTH_SUFFIX	:= tar.bz2
XORG_APP_XAUTH_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XAUTH).$(XORG_APP_XAUTH_SUFFIX)
XORG_APP_XAUTH_SOURCE	:= $(SRCDIR)/$(XORG_APP_XAUTH).$(XORG_APP_XAUTH_SUFFIX)
XORG_APP_XAUTH_DIR	:= $(BUILDDIR)/$(XORG_APP_XAUTH)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xauth_get: $(STATEDIR)/xorg-app-xauth.get

$(STATEDIR)/xorg-app-xauth.get: $(xorg-app-xauth_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XAUTH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XAUTH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xauth_extract: $(STATEDIR)/xorg-app-xauth.extract

$(STATEDIR)/xorg-app-xauth.extract: $(xorg-app-xauth_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XAUTH_DIR))
	@$(call extract, XORG_APP_XAUTH)
	@$(call patchin, XORG_APP_XAUTH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xauth_prepare: $(STATEDIR)/xorg-app-xauth.prepare

XORG_APP_XAUTH_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XAUTH_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XAUTH_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-xauth.prepare: $(xorg-app-xauth_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XAUTH_DIR)/config.cache)
	cd $(XORG_APP_XAUTH_DIR) && \
		$(XORG_APP_XAUTH_PATH) $(XORG_APP_XAUTH_ENV) \
		./configure $(XORG_APP_XAUTH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xauth_compile: $(STATEDIR)/xorg-app-xauth.compile

$(STATEDIR)/xorg-app-xauth.compile: $(xorg-app-xauth_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XAUTH_DIR) && $(XORG_APP_XAUTH_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xauth_install: $(STATEDIR)/xorg-app-xauth.install

$(STATEDIR)/xorg-app-xauth.install: $(xorg-app-xauth_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XAUTH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xauth_targetinstall: $(STATEDIR)/xorg-app-xauth.targetinstall

$(STATEDIR)/xorg-app-xauth.targetinstall: $(xorg-app-xauth_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xauth)
	@$(call install_fixup,xorg-app-xauth,PACKAGE,xorg-app-xauth)
	@$(call install_fixup,xorg-app-xauth,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xauth,VERSION,$(XORG_APP_XAUTH_VERSION))
	@$(call install_fixup,xorg-app-xauth,SECTION,base)
	@$(call install_fixup,xorg-app-xauth,AUTHOR,"Claudio Leonel <cls\@elaxys.com.br>")
	@$(call install_fixup,xorg-app-xauth,DEPENDS,)
	@$(call install_fixup,xorg-app-xauth,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xauth, 0, 0, 0755, $(XORG_APP_XAUTH_DIR)/xauth, /usr/bin/xauth)

	@$(call install_finish,xorg-app-xauth)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xauth_clean:
	rm -rf $(STATEDIR)/xorg-app-xauth.*
	rm -rf $(PKGDIR)/xorg-app-xauth_*
	rm -rf $(XORG_APP_XAUTH_DIR)

# vim: syntax=make
