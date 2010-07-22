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
PACKAGES-$(PTXCONF_LIBASSUAN) += libassuan

#
# Paths and names
#
LIBASSUAN_VERSION	:= 2.0.0
LIBASSUAN		:= libassuan-$(LIBASSUAN_VERSION)
LIBASSUAN_SUFFIX	:= tar.bz2
LIBASSUAN_URL		:= ftp://ftp.gnupg.org/gcrypt/libassuan/$(LIBASSUAN).$(LIBASSUAN_SUFFIX)
LIBASSUAN_SOURCE	:= $(SRCDIR)/$(LIBASSUAN).$(LIBASSUAN_SUFFIX)
LIBASSUAN_DIR		:= $(BUILDDIR)/$(LIBASSUAN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBASSUAN_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libassuan.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libassuan)
	@$(call install_fixup, libassuan,PRIORITY,optional)
	@$(call install_fixup, libassuan,SECTION,base)
	@$(call install_fixup, libassuan,AUTHOR,"Alexander Stein")
	@$(call install_fixup, libassuan,DESCRIPTION,missing)

	@$(call install_copy, libassuan, 0, 0, 0644, -, \
		/usr/lib/libassuan.so.0.0.0)
	@$(call install_link, libassuan, libassuan.so.0.0.0, /usr/lib/libassuan.so.0)
	@$(call install_link, libassuan, libassuan.so.0.0.0, /usr/lib/libassuan.so)

	@$(call install_finish, libassuan)

	@$(call touch)

# vim: syntax=make
