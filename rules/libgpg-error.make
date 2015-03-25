# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010, 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBGPG_ERROR) += libgpg-error

#
# Paths and names
#
LIBGPG_ERROR_VERSION	:= 1.12
LIBGPG_ERROR_MD5	:= 8f0eb41a344d19ac2aa9bd101dfb9ce6
LIBGPG_ERROR		:= libgpg-error-$(LIBGPG_ERROR_VERSION)
LIBGPG_ERROR_SUFFIX	:= tar.bz2
LIBGPG_ERROR_URL	:= http://artfiles.org/gnupg.org/libgpg-error/$(LIBGPG_ERROR).$(LIBGPG_ERROR_SUFFIX) ftp://ftp.gnupg.org/gcrypt/libgpg-error/$(LIBGPG_ERROR).$(LIBGPG_ERROR_SUFFIX)
LIBGPG_ERROR_SOURCE	:= $(SRCDIR)/$(LIBGPG_ERROR).$(LIBGPG_ERROR_SUFFIX)
LIBGPG_ERROR_DIR	:= $(BUILDDIR)/$(LIBGPG_ERROR)
LIBGPG_ERROR_LICENSE	:= GPLv2, LGPLv2
LIBGPG_ERROR_LICENSE_FILES := \
	file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552 \
	file://COPYING.LIB;md5=2d5025d4aa3495befef8f17206a5b0a1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBGPG_ERROR_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libgpg-error.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libgpg-error)
	@$(call install_fixup, libgpg-error,PRIORITY,optional)
	@$(call install_fixup, libgpg-error,SECTION,base)
	@$(call install_fixup, libgpg-error,AUTHOR,"Erwin Rol")
	@$(call install_fixup, libgpg-error,DESCRIPTION,missing)

	@$(call install_lib, libgpg-error, 0, 0, 0644, libgpg-error)

	@$(call install_finish, libgpg-error)

	@$(call touch)

# vim: syntax=make
