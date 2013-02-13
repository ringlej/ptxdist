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
LIBGPG_ERROR_VERSION	:= 1.10
LIBGPG_ERROR_MD5	:= 736a03daa9dc5873047d4eb4a9c22a16
LIBGPG_ERROR		:= libgpg-error-$(LIBGPG_ERROR_VERSION)
LIBGPG_ERROR_SUFFIX	:= tar.bz2
LIBGPG_ERROR_URL	:= ftp://ftp.gnupg.org/gcrypt/libgpg-error/$(LIBGPG_ERROR).$(LIBGPG_ERROR_SUFFIX)
LIBGPG_ERROR_SOURCE	:= $(SRCDIR)/$(LIBGPG_ERROR).$(LIBGPG_ERROR_SUFFIX)
LIBGPG_ERROR_DIR	:= $(BUILDDIR)/$(LIBGPG_ERROR)

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
