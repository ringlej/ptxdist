# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
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
PACKAGES-$(PTXCONF_XORG_APP_XHOST) += xorg-app-xhost

#
# Paths and names
#
XORG_APP_XHOST_VERSION	:= 1.0.2
XORG_APP_XHOST		:= xhost-$(XORG_APP_XHOST_VERSION)
XORG_APP_XHOST_SUFFIX	:= tar.bz2
XORG_APP_XHOST_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.3/src/app/$(XORG_APP_XHOST).$(XORG_APP_XHOST_SUFFIX)
XORG_APP_XHOST_SOURCE	:= $(SRCDIR)/$(XORG_APP_XHOST).$(XORG_APP_XHOST_SUFFIX)
XORG_APP_XHOST_DIR	:= $(BUILDDIR)/$(XORG_APP_XHOST)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xhost_get: $(STATEDIR)/xorg-app-xhost.get

$(STATEDIR)/xorg-app-xhost.get: $(xorg-app-xhost_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XHOST_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XHOST)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xhost_extract: $(STATEDIR)/xorg-app-xhost.extract

$(STATEDIR)/xorg-app-xhost.extract: $(xorg-app-xhost_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XHOST_DIR))
	@$(call extract, XORG_APP_XHOST)
	@$(call patchin, XORG_APP_XHOST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xhost_prepare: $(STATEDIR)/xorg-app-xhost.prepare

XORG_APP_XHOST_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XHOST_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XHOST_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--disable-dependency-tracking \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

ifdef PTXCONF_XORG_SERVER_OPT_SECURE_RPC
XORG_APP_XHOST_AUTOCONF += --enable-secure-rpc
else
XORG_APP_XHOST_AUTOCONF += --disable-secure-rpc
endif

$(STATEDIR)/xorg-app-xhost.prepare: $(xorg-app-xhost_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XHOST_DIR)/config.cache)
	cd $(XORG_APP_XHOST_DIR) && \
		$(XORG_APP_XHOST_PATH) $(XORG_APP_XHOST_ENV) \
		./configure $(XORG_APP_XHOST_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xhost_compile: $(STATEDIR)/xorg-app-xhost.compile

$(STATEDIR)/xorg-app-xhost.compile: $(xorg-app-xhost_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XHOST_DIR) && $(XORG_APP_XHOST_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xhost_install: $(STATEDIR)/xorg-app-xhost.install

$(STATEDIR)/xorg-app-xhost.install: $(xorg-app-xhost_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XHOST)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xhost_targetinstall: $(STATEDIR)/xorg-app-xhost.targetinstall

$(STATEDIR)/xorg-app-xhost.targetinstall: $(xorg-app-xhost_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xhost)
	@$(call install_fixup, xorg-app-xhost,PACKAGE,xorg-app-xhost)
	@$(call install_fixup, xorg-app-xhost,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xhost,VERSION,$(XORG_APP_XHOST_VERSION))
	@$(call install_fixup, xorg-app-xhost,SECTION,base)
	@$(call install_fixup, xorg-app-xhost,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, xorg-app-xhost,DEPENDS,)
	@$(call install_fixup, xorg-app-xhost,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xhost, 0, 0, 0755, $(XORG_APP_XHOST_DIR)/xhost, $(XORG_PREFIX)/bin/xhost)

	@$(call install_finish, xorg-app-xhost)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xhost_clean:
	rm -rf $(STATEDIR)/xorg-app-xhost.*
	rm -rf $(IMAGEDIR)/xorg-app-xhost_*
	rm -rf $(XORG_APP_XHOST_DIR)

# vim: syntax=make
