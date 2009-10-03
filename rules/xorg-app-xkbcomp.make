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
PACKAGES-$(PTXCONF_XORG_APP_XKBCOMP) += xorg-app-xkbcomp

#
# Paths and names
#
XORG_APP_XKBCOMP_VERSION	:= 1.1.1
XORG_APP_XKBCOMP		:= xkbcomp-$(XORG_APP_XKBCOMP_VERSION)
XORG_APP_XKBCOMP_SUFFIX		:= tar.bz2
XORG_APP_XKBCOMP_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app//$(XORG_APP_XKBCOMP).$(XORG_APP_XKBCOMP_SUFFIX)
XORG_APP_XKBCOMP_SOURCE		:= $(SRCDIR)/$(XORG_APP_XKBCOMP).$(XORG_APP_XKBCOMP_SUFFIX)
XORG_APP_XKBCOMP_DIR		:= $(BUILDDIR)/$(XORG_APP_XKBCOMP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-app-xkbcomp_get: $(STATEDIR)/xorg-app-xkbcomp.get

$(STATEDIR)/xorg-app-xkbcomp.get: $(xorg-app-xkbcomp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_APP_XKBCOMP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_APP_XKBCOMP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-app-xkbcomp_extract: $(STATEDIR)/xorg-app-xkbcomp.extract

$(STATEDIR)/xorg-app-xkbcomp.extract: $(xorg-app-xkbcomp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XKBCOMP_DIR))
	@$(call extract, XORG_APP_XKBCOMP)
	@$(call patchin, XORG_APP_XKBCOMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-app-xkbcomp_prepare: $(STATEDIR)/xorg-app-xkbcomp.prepare

XORG_APP_XKBCOMP_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XKBCOMP_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#

XORG_APP_XKBCOMP_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

$(STATEDIR)/xorg-app-xkbcomp.prepare: $(xorg-app-xkbcomp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_APP_XKBCOMP_DIR)/config.cache)
	@echo "selecting the correct search path in X-Server and xkbcomp is still missing"
	cd $(XORG_APP_XKBCOMP_DIR) && \
		$(XORG_APP_XKBCOMP_PATH) $(XORG_APP_XKBCOMP_ENV) \
		./configure $(XORG_APP_XKBCOMP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-app-xkbcomp_compile: $(STATEDIR)/xorg-app-xkbcomp.compile

$(STATEDIR)/xorg-app-xkbcomp.compile: $(xorg-app-xkbcomp_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_APP_XKBCOMP_DIR) && $(XORG_APP_XKBCOMP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-app-xkbcomp_install: $(STATEDIR)/xorg-app-xkbcomp.install

$(STATEDIR)/xorg-app-xkbcomp.install: $(xorg-app-xkbcomp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_APP_XKBCOMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-app-xkbcomp_targetinstall: $(STATEDIR)/xorg-app-xkbcomp.targetinstall

$(STATEDIR)/xorg-app-xkbcomp.targetinstall: $(xorg-app-xkbcomp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-app-xkbcomp)
	@$(call install_fixup, xorg-app-xkbcomp,PACKAGE,xorg-app-xkbcomp)
	@$(call install_fixup, xorg-app-xkbcomp,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xkbcomp,VERSION,$(XORG_APP_XKBCOMP_VERSION))
	@$(call install_fixup, xorg-app-xkbcomp,SECTION,base)
	@$(call install_fixup, xorg-app-xkbcomp,AUTHOR,"Juergen Beisert")
	@$(call install_fixup, xorg-app-xkbcomp,DEPENDS,)
	@$(call install_fixup, xorg-app-xkbcomp,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xkbcomp,  0, 0, 0755, \
		$(XORG_APP_XKBCOMP_DIR)/xkbcomp, /usr/bin/xkbcomp)

	@$(call install_finish, xorg-app-xkbcomp)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xkbcomp_clean:
	rm -rf $(STATEDIR)/xorg-app-xkbcomp.*
	rm -rf $(PKGDIR)/xorg-app-xkbcomp_*
	rm -rf $(XORG_APP_XKBCOMP_DIR)

# vim: syntax=make
