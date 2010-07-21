# -*-makefile-*-
#
# Copyright (C) 2010 by Alexander Stein <alexander.stein@systec-electronic.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBKSBA) += libksba

#
# Paths and names
#
LIBKSBA_VERSION	:= 1.0.7
LIBKSBA		:= libksba-$(LIBKSBA_VERSION)
LIBKSBA_SUFFIX	:= tar.bz2
LIBKSBA_URL	:= ftp://ftp.gnupg.org/gcrypt/libksba/$(LIBKSBA).$(LIBKSBA_SUFFIX)
LIBKSBA_SOURCE	:= $(SRCDIR)/$(LIBKSBA).$(LIBKSBA_SUFFIX)
LIBKSBA_DIR	:= $(BUILDDIR)/$(LIBKSBA)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBKSBA_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libksba.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libksba)
	@$(call install_fixup, libksba,PRIORITY,optional)
	@$(call install_fixup, libksba,SECTION,base)
	@$(call install_fixup, libksba,AUTHOR,"Alexander Stein")
	@$(call install_fixup, libksba,DESCRIPTION,missing)

	@$(call install_copy, libksba, 0, 0, 0644, -, \
		/usr/lib/libksba.so.8.9.6)
	@$(call install_link, libksba, libksba.so.11.5.3, /usr/lib/libksba.so.8)
	@$(call install_link, libksba, libksba.so.11.5.3, /usr/lib/libksba.so)

	@$(call install_finish, libksba)

	@$(call touch)

# vim: syntax=make
