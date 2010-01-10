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
PACKAGES-$(PTXCONF_XORG_APP_XDM) += xorg-app-xdm

#
# Paths and names
#
XORG_APP_XDM_VERSION	:= 1.1.9
XORG_APP_XDM		:= xdm-$(XORG_APP_XDM_VERSION)
XORG_APP_XDM_SUFFIX	:= tar.bz2
XORG_APP_XDM_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XDM).$(XORG_APP_XDM_SUFFIX)
XORG_APP_XDM_SOURCE	:= $(SRCDIR)/$(XORG_APP_XDM).$(XORG_APP_XDM_SUFFIX)
XORG_APP_XDM_DIR	:= $(BUILDDIR)/$(XORG_APP_XDM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xdm_get: $(STATEDIR)/xorg-app-xdm.get

$(STATEDIR)/xorg-app-xdm.get: $(xorg-app-xdm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XDM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XDM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xdm_extract: $(STATEDIR)/xorg-app-xdm.extract

$(STATEDIR)/xorg-app-xdm.extract: $(xorg-app-xdm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XDM_DIR))
	@$(call extract, XORG_APP_XDM)
	@$(call patchin, XORG_APP_XDM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xdm_prepare: $(STATEDIR)/xorg-app-xdm.prepare

XORG_APP_XDM_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XDM_ENV 	:=  $(CROSS_ENV)
XORG_APP_XDM_BINCONFIG_GLOB := ""

#
# autoconf
#
XORG_APP_XDM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR) \
	--disable-dependency-tracking \
	--with-random-device=$(XORG_APP_XDM_DEV_RANDOM) \
	--with-utmp-file=/var/run/utmp \
	--with-wtmp-file=/var/log/wtmp

ifdef PTXCONF_XORG_SERVER_OPT_SECURE_RPC
XORG_APP_XDM_AUTOCONF += --enable-secure-rpc
else
XORG_APP_XDM_AUTOCONF += --disable-secure-rpc
endif

XORG_APP_XDM_AUTOCONF += --enable-xpm-logos	# Display xpm logos in greeter
XORG_APP_XDM_AUTOCONF += --disable-xprint	# FIXME XPrint support
XORG_APP_XDM_AUTOCONF += --enable-dynamic-greeter # Build greeter as dynamically loaded shared object
XORG_APP_XDM_AUTOCONF += --without-pam		# FXIME


$(STATEDIR)/xorg-app-xdm.prepare: $(xorg-app-xdm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XDM_DIR)/config.cache)
	cd $(XORG_APP_XDM_DIR) && \
		$(XORG_APP_XDM_PATH) $(XORG_APP_XDM_ENV) \
		./configure $(XORG_APP_XDM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xdm_compile: $(STATEDIR)/xorg-app-xdm.compile

$(STATEDIR)/xorg-app-xdm.compile: $(xorg-app-xdm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XDM_DIR) && $(XORG_APP_XDM_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xdm_install: $(STATEDIR)/xorg-app-xdm.install

$(STATEDIR)/xorg-app-xdm.install: $(xorg-app-xdm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XDM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xdm_targetinstall: $(STATEDIR)/xorg-app-xdm.targetinstall

$(STATEDIR)/xorg-app-xdm.targetinstall: $(xorg-app-xdm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xdm)
	@$(call install_fixup, xorg-app-xdm,PACKAGE,xorg-app-xdm)
	@$(call install_fixup, xorg-app-xdm,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xdm,VERSION,$(XORG_APP_XDM_VERSION))
	@$(call install_fixup, xorg-app-xdm,SECTION,base)
	@$(call install_fixup, xorg-app-xdm,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-app-xdm,DEPENDS,)
	@$(call install_fixup, xorg-app-xdm,DESCRIPTION,missing)

	@$(call install_finish, xorg-app-xdm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xdm_clean:
	rm -rf $(STATEDIR)/xorg-app-xdm.*
	rm -rf $(PKGDIR)/xorg-app-xdm_*
	rm -rf $(XORG_APP_XDM_DIR)

# vim: syntax=make
