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
PACKAGES-$(PTXCONF_XORG_LIB_SM) += xorg-lib-sm

#
# Paths and names
#
XORG_LIB_SM_VERSION	:= 1.1.1
XORG_LIB_SM		:= libSM-$(XORG_LIB_SM_VERSION)
XORG_LIB_SM_SUFFIX	:= tar.bz2
XORG_LIB_SM_URL		:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_SM).$(XORG_LIB_SM_SUFFIX)
XORG_LIB_SM_SOURCE	:= $(SRCDIR)/$(XORG_LIB_SM).$(XORG_LIB_SM_SUFFIX)
XORG_LIB_SM_DIR		:= $(BUILDDIR)/$(XORG_LIB_SM)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-lib-sm_get: $(STATEDIR)/xorg-lib-sm.get

$(STATEDIR)/xorg-lib-sm.get: $(xorg-lib-sm_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_LIB_SM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_LIB_SM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-lib-sm_extract: $(STATEDIR)/xorg-lib-sm.extract

$(STATEDIR)/xorg-lib-sm.extract: $(xorg-lib-sm_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_SM_DIR))
	@$(call extract, XORG_LIB_SM)
	@$(call patchin, XORG_LIB_SM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-lib-sm_prepare: $(STATEDIR)/xorg-lib-sm.prepare

XORG_LIB_SM_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_SM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_SM_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--disable-dependency-tracking \
	--with-libuuid=no

$(STATEDIR)/xorg-lib-sm.prepare: $(xorg-lib-sm_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_LIB_SM_DIR)/config.cache)
	cd $(XORG_LIB_SM_DIR) && \
		$(XORG_LIB_SM_PATH) $(XORG_LIB_SM_ENV) \
		./configure $(XORG_LIB_SM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-lib-sm_compile: $(STATEDIR)/xorg-lib-sm.compile

$(STATEDIR)/xorg-lib-sm.compile: $(xorg-lib-sm_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_LIB_SM_DIR) && $(XORG_LIB_SM_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-lib-sm_install: $(STATEDIR)/xorg-lib-sm.install

$(STATEDIR)/xorg-lib-sm.install: $(xorg-lib-sm_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, XORG_LIB_SM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-lib-sm_targetinstall: $(STATEDIR)/xorg-lib-sm.targetinstall

$(STATEDIR)/xorg-lib-sm.targetinstall: $(xorg-lib-sm_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-lib-sm)
	@$(call install_fixup, xorg-lib-sm,PACKAGE,xorg-lib-sm)
	@$(call install_fixup, xorg-lib-sm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-sm,VERSION,$(XORG_LIB_SM_VERSION))
	@$(call install_fixup, xorg-lib-sm,SECTION,base)
	@$(call install_fixup, xorg-lib-sm,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-sm,DEPENDS,)
	@$(call install_fixup, xorg-lib-sm,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-sm, 0, 0, 0644, \
		$(XORG_LIB_SM_DIR)/src/.libs/libSM.so.6.0.1, \
		$(XORG_LIBDIR)/libSM.so.6.0.1)

	@$(call install_link, xorg-lib-sm, \
		libSM.so.6.0.1, \
		$(XORG_LIBDIR)/libSM.so.6)

	@$(call install_link, xorg-lib-sm, \
		libSM.so.6.0.1, \
		$(XORG_LIBDIR)/libSM.so)

	@$(call install_finish, xorg-lib-sm)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-sm_clean:
	rm -rf $(STATEDIR)/xorg-lib-sm.*
	rm -rf $(PKGDIR)/xorg-lib-sm_*
	rm -rf $(XORG_LIB_SM_DIR)

# vim: syntax=make
