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
PACKAGES-$(PTXCONF_XORG_LIB_XMU) += xorg-lib-xmu

#
# Paths and names
#
XORG_LIB_XMU_VERSION	:= 1.0.5
XORG_LIB_XMU		:= libXmu-$(XORG_LIB_XMU_VERSION)
XORG_LIB_XMU_SUFFIX	:= tar.bz2
XORG_LIB_XMU_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/lib/$(XORG_LIB_XMU).$(XORG_LIB_XMU_SUFFIX)
XORG_LIB_XMU_SOURCE	:= $(SRCDIR)/$(XORG_LIB_XMU).$(XORG_LIB_XMU_SUFFIX)
XORG_LIB_XMU_DIR	:= $(BUILDDIR)/$(XORG_LIB_XMU)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_LIB_XMU_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_LIB_XMU)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_XMU_PATH	:= PATH=$(CROSS_PATH)
XORG_LIB_XMU_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_LIB_XMU_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-xmu.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-xmu)
	@$(call install_fixup, xorg-lib-xmu,PACKAGE,xorg-lib-xmu)
	@$(call install_fixup, xorg-lib-xmu,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-xmu,VERSION,$(XORG_LIB_XMU_VERSION))
	@$(call install_fixup, xorg-lib-xmu,SECTION,base)
	@$(call install_fixup, xorg-lib-xmu,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-xmu,DEPENDS,)
	@$(call install_fixup, xorg-lib-xmu,DESCRIPTION,missing)

	@$(call install_copy, xorg-lib-xmu, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXmu.so.6.2.0)

	@$(call install_link, xorg-lib-xmu, \
		libXmu.so.6.2.0, \
		$(XORG_LIBDIR)/libXmu.so.6)

	@$(call install_link, xorg-lib-xmu, \
		libXmu.so.6.2.0, \
		$(XORG_LIBDIR)/libXmu.so)

	@$(call install_copy, xorg-lib-xmu, 0, 0, 0644, -, \
		$(XORG_LIBDIR)/libXmuu.so.1.0.0)

	@$(call install_link, xorg-lib-xmu, \
		libXmuu.so.1.0.0, \
		$(XORG_LIBDIR)/libXmuu.so.1)

	@$(call install_link, xorg-lib-xmu, \
		libXmuu.so.1.0.0, \
		$(XORG_LIBDIR)/libXmuu.so)

	@$(call install_finish, xorg-lib-xmu)

	@$(call touch)

# vim: syntax=make
