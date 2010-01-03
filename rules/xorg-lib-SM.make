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

$(XORG_LIB_SM_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_SM)

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

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-sm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-sm)
	@$(call install_fixup, xorg-lib-sm,PACKAGE,xorg-lib-sm)
	@$(call install_fixup, xorg-lib-sm,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-sm,VERSION,$(XORG_LIB_SM_VERSION))
	@$(call install_fixup, xorg-lib-sm,SECTION,base)
	@$(call install_fixup, xorg-lib-sm,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-lib-sm,DEPENDS,)
	@$(call install_fixup, xorg-lib-sm,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-sm, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libSM.so.6.0.1)

	@$(call install_link, xorg-lib-sm, \
		libSM.so.6.0.1, \
		$(XORG_LIBDIR)/libSM.so.6)

	@$(call install_link, xorg-lib-sm, \
		libSM.so.6.0.1, \
		$(XORG_LIBDIR)/libSM.so)

	@$(call install_finish, xorg-lib-sm)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-lib-sm_clean:
	rm -rf $(STATEDIR)/xorg-lib-sm.*
	rm -rf $(PKGDIR)/xorg-lib-sm_*
	rm -rf $(XORG_LIB_SM_DIR)

# vim: syntax=make
