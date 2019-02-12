# -*-makefile-*-
#
# Copyright (C) 2018 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBX11_LOCALE) += libx11-locale

#
# Paths and names
#
LIBX11_LOCALE_VERSION	= $(XORG_LIB_X11_VERSION)
LIBX11_LOCALE_MD5	= $(XORG_LIB_X11_MD5)
LIBX11_LOCALE		= libx11-locale-$(LIBX11_LOCALE_VERSION)
LIBX11_LOCALE_SUFFIX	= $(XORG_LIB_X11_SUFFIX)
LIBX11_LOCALE_URL	= $(XORG_LIB_X11_URL)
LIBX11_LOCALE_SOURCE	= $(XORG_LIB_X11_SOURCE)
LIBX11_LOCALE_DIR	= $(BUILDDIR)/$(LIBX11_LOCALE)
LIBX11_LOCALE_LICENSE	= $(XORG_LIB_X11_LICENSE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBX11_LOCALE_CONF_TOOL	:= autoconf
LIBX11_LOCALE_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-selective-werror \
	--disable-strict-compilation \
	--disable-specs \
	$(XORG_OPTIONS_TRANS) \
	--disable-loadable-i18n \
	--disable-loadable-xcursor \
	--enable-xthreads \
	--enable-xcms \
	--enable-xlocale \
	--enable-xlocaledir \
	--disable-xf86bigfont \
	--disable-xkb \
	--enable-composecache \
	--disable-lint-library \
	--disable-malloc0returnsnull \
	$(XORG_OPTIONS_DOCS) \
	--without-perl \
	--without-launchd \
	--without-lint \
	--with-locale-lib-dir=$(XORG_DATADIR)/X11/locale

LIBX11_LOCALE_MAKE_OPT		:= -C nls
LIBX11_LOCALE_INSTALL_OPT	:= -C nls install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libx11-locale.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libx11-locale)
	@$(call install_fixup, libx11-locale,PRIORITY,optional)
	@$(call install_fixup, libx11-locale,SECTION,base)
	@$(call install_fixup, libx11-locale,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libx11-locale,DESCRIPTION,missing)

	@$(call install_tree, libx11-locale, 0, 0, -, $(XORG_DATADIR)/X11/locale,n)

	@$(call install_finish, libx11-locale)

	@$(call touch)

# vim: syntax=make
