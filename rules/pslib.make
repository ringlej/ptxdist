# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PSLIB) += pslib

#
# Paths and names
#
PSLIB_VERSION	:= 0.4.5
PSLIB_MD5	:= 03f39393628a6d758799b9f845047e27
PSLIB		:= pslib-$(PSLIB_VERSION)
PSLIB_SUFFIX	:= tar.gz
PSLIB_URL	:= $(call ptx/mirror, SF, pslib/$(PSLIB).$(PSLIB_SUFFIX))
PSLIB_SOURCE	:= $(SRCDIR)/$(PSLIB).$(PSLIB_SUFFIX)
PSLIB_DIR	:= $(BUILDDIR)/$(PSLIB)
PSLIB_LICENSE	:= LGPL-2.0-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PSLIB_CONF_ENV	:= \
	$(CROSS_ENV) \
	ac_cv_prog_DOC_TO_MAN= \
	ac_cv_path_INTLTOOL_UPDATE=: \
	ac_cv_path_INTLTOOL_MERGE=: \
	ac_cv_path_INTLTOOL_EXTRACT=:

#
# autoconf
#
PSLIB_CONF_TOOL	:= autoconf
PSLIB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-bmp \
	--with-png=$(call ptx/ifdef, PTXCONF_PSLIB_LIBPNG,$(SYSROOT)/usr,no) \
	--with-jpeg=$(call ptx/ifdef, PTXCONF_PSLIB_LIBJPEG,$(SYSROOT)/usr,no) \
	--without-gif \
	--without-tiff \
	--without-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pslib.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pslib)
	@$(call install_fixup, pslib,PRIORITY,optional)
	@$(call install_fixup, pslib,SECTION,base)
	@$(call install_fixup, pslib,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, pslib,DESCRIPTION,missing)

	@$(call install_lib, pslib, 0, 0, 0644, libps)

	@$(call install_finish, pslib)

	@$(call touch)

# vim: syntax=make
