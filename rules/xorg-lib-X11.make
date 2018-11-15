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
PACKAGES-$(PTXCONF_XORG_LIB_X11) += xorg-lib-x11

#
# Paths and names
#
XORG_LIB_X11_VERSION	:= 1.6.7
XORG_LIB_X11_MD5	:= 034fdd6cc5393974d88aec6f5bc96162
XORG_LIB_X11		:= libX11-$(XORG_LIB_X11_VERSION)
XORG_LIB_X11_SUFFIX	:= tar.bz2
XORG_LIB_X11_URL	:= $(call ptx/mirror, XORG, individual/lib/$(XORG_LIB_X11).$(XORG_LIB_X11_SUFFIX))
XORG_LIB_X11_SOURCE	:= $(SRCDIR)/$(XORG_LIB_X11).$(XORG_LIB_X11_SUFFIX)
XORG_LIB_X11_DIR	:= $(BUILDDIR)/$(XORG_LIB_X11)
XORG_LIB_X11_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_LIB_X11_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_RAWCPP=$(PTXCONF_COMPILER_PREFIX)cpp

# configure states: "checking for working mmap...no"
# is this a correct fix?
XORG_LIB_X11_CONF_ENV += ac_cv_func_mmap_fixed_mapped=yes

#
# autoconf
#
XORG_LIB_X11_CONF_TOOL	:= autoconf
XORG_LIB_X11_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(XORG_DATADIR) \
	--disable-selective-werror \
	--disable-strict-compilation \
	--disable-specs \
	$(XORG_OPTIONS_TRANS) \
	--$(call ptx/endis, PTXCONF_XORG_LIB_X11_I18N)-loadable-i18n \
	--$(call ptx/endis, PTXCONF_XORG_LIB_X11_CURSOR)-loadable-xcursor \
	--enable-xthreads \
	--enable-xcms \
	--enable-xlocale \
	--enable-xlocaledir \
	--$(call ptx/endis, PTXCONF_XORG_LIB_X11_XF86BIGFONT)-xf86bigfont \
	--$(call ptx/endis, PTXCONF_XORG_LIB_X11_XKB)-xkb \
	--enable-composecache \
	--disable-lint-library \
	--disable-malloc0returnsnull \
	$(XORG_OPTIONS_DOCS) \
	--without-perl \
	--without-launchd \
	--without-lint \
	--with-locale-lib-dir=$(XORG_DATADIR)/X11/locale

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-lib-x11.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-lib-x11)
	@$(call install_fixup, xorg-lib-x11,PRIORITY,optional)
	@$(call install_fixup, xorg-lib-x11,SECTION,base)
	@$(call install_fixup, xorg-lib-x11,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-lib-x11,DESCRIPTION,missing)

	@$(call install_lib, xorg-lib-x11, 0, 0, 0644, libX11)
	@$(call install_lib, xorg-lib-x11, 0, 0, 0644, libX11-xcb)

	@$(call install_finish, xorg-lib-x11)

	@$(call touch)

# vim: syntax=make
