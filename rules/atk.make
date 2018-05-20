# -*-makefile-*-
#
# Copyright (C) 2003-2006 Robert Schwebel <r.schwebel@pengutronix.de>
#                         Pengutronix <info@pengutronix.de>, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATK) += atk

#
# Paths and names
#
ATK_VERSION	:= 2.28.1
ATK_MD5		:= dfb5e7474220afa3f4ca7e45af9f3a11
ATK		:= atk-$(ATK_VERSION)
ATK_SUFFIX	:= tar.xz
ATK_URL		:= http://ftp.gnome.org/pub/gnome/sources/atk/$(basename $(ATK_VERSION))/$(ATK).$(ATK_SUFFIX)
ATK_SOURCE	:= $(SRCDIR)/$(ATK).$(ATK_SUFFIX)
ATK_DIR		:= $(BUILDDIR)/$(ATK)
ATK_LICENSE	:= LGPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ATK_CONF_TOOL	:= autoconf
ATK_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-static \
	--disable-rebuilds \
	--disable-nls \
	--disable-rpath \
	--$(call ptx/endis, PTXCONF_ATK_INTROSPECTION)-introspection \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/atk.targetinstall:
	@$(call targetinfo)

	@$(call install_init, atk)
	@$(call install_fixup, atk,PRIORITY,optional)
	@$(call install_fixup, atk,SECTION,base)
	@$(call install_fixup, atk,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, atk,DESCRIPTION,missing)

	@$(call install_lib, atk, 0, 0, 0644, libatk-1.0)
ifdef PTXCONF_ATK_INTROSPECTION
	@$(call install_copy, atk, 0, 0, 0644, -, \
		/usr/lib/girepository-1.0/Atk-1.0.typelib)
endif

	@$(call install_finish, atk)

	@$(call touch)

# vim: syntax=make
