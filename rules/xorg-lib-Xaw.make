# -*-makefile-*-
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
PACKAGES-$(PTXCONF_XORG_LIB_XAW) += xorg-lib-xaw

#
# Paths and names
#
XORG_LIB_XAW_VERSION	:= 1.0.7
XORG_LIB_XAW		:= libXaw-$(XORG_LIB_XAW_VERSION)
XORG_LIB_XAW_SUFFIX	:= tar.bz2
XORG_LIB_XAW_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XAW).$(XORG_LIB_XAW_SUFFIX)
XORG_LIB_XAW_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XAW).$(XORG_LIB_XAW_SUFFIX)
XORG_LIB_XAW_DIR	:= $(BUILDDIR)/$(XORG_LIB_XAW)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XAW_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XAW)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XAW_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XAW_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XAW_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-docs

ifdef PTXCONF_XORG_LIB_XAW_V6
XORG_LIB_XAW_AUTOCONF += --enable-xaw6
else
XORG_LIB_XAW_AUTOCONF += --disable-xaw6
endif

ifdef PTXCONF_XORG_LIB_XAW_V7
XORG_LIB_XAW_AUTOCONF += --enable-xaw7
else
XORG_LIB_XAW_AUTOCONF += --disable-xaw7
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xaw.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xaw)
	@$(call install_fixup, xorg-lib-xaw,PACKAGE,xorg-lib-xaw)
	@$(call install_fixup, xorg-lib-xaw,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xaw,VERSION,$(XORG_LIB_XAW_VERSION))
	@$(call install_fixup, xorg-lib-xaw,SECTION,base)
	@$(call install_fixup, xorg-lib-xaw,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xaw,DEPENDS,)
	@$(call install_fixup, xorg-lib-xaw,DESCRIPTION,missing)

ifdef PTXCONF_XORG_LIB_XAW_V6
	@$(call install_copy, xorg-lib-xaw, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXaw6.so.6.0.1)

	@$(call install_link, xorg-lib-xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw6.so.6)

	@$(call install_link, xorg-lib-xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw6.so)

	@$(call install_link, xorg-lib-xaw, \
		libXaw6.so.6.0.1, \
		$(XORG_LIBDIR)/libXaw.so.6)
endif

ifdef PTXCONF_XORG_LIB_XAW_V7
	@$(call install_copy, xorg-lib-xaw, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXaw7.so.7.0.0)

	@$(call install_link, xorg-lib-xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw7.so.7)

	@$(call install_link, xorg-lib-xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw7.so)

	@$(call install_link, xorg-lib-xaw, \
		libXaw7.so.7.0.0, \
		$(XORG_LIBDIR)/libXaw.so.7)
endif

	@$(call install_finish, xorg-lib-xaw)

	@$(call touch)

# vim: syntax=make
