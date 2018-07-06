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
PACKAGES-$(PTXCONF_LIBMBIM) += libmbim

#
# Paths and names
#
LIBMBIM_VERSION	:= 1.16.0
LIBMBIM_MD5	:= 76ea4d8381989919b1d9b91c818fed80
LIBMBIM		:= libmbim-$(LIBMBIM_VERSION)
LIBMBIM_SUFFIX	:= tar.xz
LIBMBIM_URL	:= http://www.freedesktop.org/software/libmbim/$(LIBMBIM).$(LIBMBIM_SUFFIX)
LIBMBIM_SOURCE	:= $(SRCDIR)/$(LIBMBIM).$(LIBMBIM_SUFFIX)
LIBMBIM_DIR	:= $(BUILDDIR)/$(LIBMBIM)
LIBMBIM_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMBIM_CONF_EVN	:= \
	$(CROSS_ENV) \
	ac_cv_path_PYTHON=$(SYSTEMPYTHON3)
#
# autoconf
#
LIBMBIM_CONF_TOOL	:= autoconf
LIBMBIM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-more-warnings \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--with-udev-base-dir=/usr/lib/udev

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmbim.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmbim)
	@$(call install_fixup, libmbim,PRIORITY,optional)
	@$(call install_fixup, libmbim,SECTION,base)
	@$(call install_fixup, libmbim,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, libmbim,DESCRIPTION,missing)

	@$(call install_copy, libmbim, 0, 0, 0755, -, /usr/bin/mbimcli)
	@$(call install_copy, libmbim, 0, 0, 0755, -, /usr/bin/mbim-network)

	@$(call install_copy, libmbim, 0, 0, 0755, -, /usr/libexec/mbim-proxy)
	@$(call install_lib, libmbim, 0, 0, 0644, libmbim-glib)

	@$(call install_finish, libmbim)

	@$(call touch)

# vim: syntax=make
