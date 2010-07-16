# -*-makefile-*-
#
# Copyright (C) 2009 by Erwin Rol
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
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
LIBGPG_ERROR_VERSION	:= 1.7
LIBGPG_ERROR		:= libgpg-error-$(LIBGPG_ERROR_VERSION)
LIBGPG_ERROR_SUFFIX	:= tar.bz2
LIBGPG_ERROR_URL	:= ftp://ftp.gnupg.org/gcrypt/libgpg-error/$(LIBGPG_ERROR).$(LIBGPG_ERROR_SUFFIX)
LIBGPG_ERROR_SOURCE	:= $(SRCDIR)/$(LIBGPG_ERROR).$(LIBGPG_ERROR_SUFFIX)
LIBGPG_ERROR_DIR	:= $(BUILDDIR)/$(LIBGPG_ERROR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBGPG_ERROR_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBGPG_ERROR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBGPG_ERROR_PATH	:= PATH=$(CROSS_PATH)
LIBGPG_ERROR_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBGPG_ERROR_AUTOCONF := $(CROSS_AUTOCONF_USR)

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

	@$(call install_copy, libgpg-error, 0, 0, 0644, -, \
		/usr/lib/libgpg-error.so.0.5.0)
	@$(call install_link, libgpg-error, libgpg-error.so.0.5.0, /usr/lib/libgpg-error.so.0)
	@$(call install_link, libgpg-error, libgpg-error.so.0.5.0, /usr/lib/libgpg-error.so)

	@$(call install_finish, libgpg-error)

	@$(call touch)

# vim: syntax=make
