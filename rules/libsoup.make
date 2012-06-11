# -*-makefile-*-
#
# Copyright (C) 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSOUP) += libsoup

#
# Paths and names
#
LIBSOUP_VERSION	:= 2.38.1
LIBSOUP_MD5	:= d13fb4968acea24c26b83268a308f580
LIBSOUP		:= libsoup-$(LIBSOUP_VERSION)
LIBSOUP_SUFFIX	:= tar.xz
LIBSOUP_URL	:= http://ftp.gnome.org/pub/GNOME/sources/libsoup/2.38/$(LIBSOUP).$(LIBSOUP_SUFFIX)
LIBSOUP_SOURCE	:= $(SRCDIR)/$(LIBSOUP).$(LIBSOUP_SUFFIX)
LIBSOUP_DIR	:= $(BUILDDIR)/$(LIBSOUP)
LIBSOUP_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSOUP_CONF_TOOL := autoconf
LIBSOUP_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--without-gnome

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsoup.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsoup)
	@$(call install_fixup, libsoup,PRIORITY,optional)
	@$(call install_fixup, libsoup,SECTION,base)
	@$(call install_fixup, libsoup,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, libsoup,DESCRIPTION,missing)

	@$(call install_lib, libsoup, 0, 0, 0644, libsoup-2.4)

	@$(call install_finish, libsoup)

	@$(call touch)

# vim: syntax=make
