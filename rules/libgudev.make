# -*-makefile-*-
#
# Copyright (C) 2015 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGUDEV) += libgudev

#
# Paths and names
#
LIBGUDEV_VERSION	:= 230
LIBGUDEV_MD5		:= e4dee8f3f349e9372213d33887819a4d
LIBGUDEV		:= libgudev-$(LIBGUDEV_VERSION)
LIBGUDEV_SUFFIX		:= tar.xz
LIBGUDEV_URL		:= https://download.gnome.org/sources/libgudev/$(LIBGUDEV_VERSION)/$(LIBGUDEV).$(LIBGUDEV_SUFFIX)
LIBGUDEV_SOURCE		:= $(SRCDIR)/$(LIBGUDEV).$(LIBGUDEV_SUFFIX)
LIBGUDEV_DIR		:= $(BUILDDIR)/$(LIBGUDEV)
LIBGUDEV_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ifdef PTXCONF_ARCH_PPC
PTXCONF_LIBGUDEV_INTROSPECTION :=
endif

#
# autoconf
#
LIBGUDEV_CONF_TOOL	:= autoconf
LIBGUDEV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--$(call ptx/endis, PTXCONF_LIBGUDEV_INTROSPECTION)-introspection

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgudev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgudev)
	@$(call install_fixup, libgudev,PRIORITY,optional)
	@$(call install_fixup, libgudev,SECTION,base)
	@$(call install_fixup, libgudev,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libgudev,DESCRIPTION,missing)

	@$(call install_lib, libgudev, 0, 0, 0644, libgudev-1.0)
ifdef PTXCONF_LIBGUDEV_INTROSPECTION
	@$(call install_copy, libgudev, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/GUdev-1.0.typelib)
endif

	@$(call install_finish, libgudev)

	@$(call touch)

# vim: syntax=make
