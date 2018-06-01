# -*-makefile-*-
#
# Copyright (C) 2017 by Andreas Pretzsch <apr@cn-eng.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_LIBFAKETIME) += libfaketime

LIBFAKETIME_VERSION	:= 0.9.7
LIBFAKETIME_MD5		:= 8617e2c6caf0977b3ce9a271f867302c
LIBFAKETIME		:= libfaketime-$(LIBFAKETIME_VERSION)
LIBFAKETIME_SUFFIX	:= tar.gz
LIBFAKETIME_URL		:= https://github.com/wolfcw/libfaketime/archive/v$(LIBFAKETIME_VERSION).$(LIBFAKETIME_SUFFIX)
LIBFAKETIME_SOURCE	:= $(SRCDIR)/$(LIBFAKETIME).$(LIBFAKETIME_SUFFIX)
LIBFAKETIME_DIR		:= $(BUILDDIR)/$(LIBFAKETIME)
LIBFAKETIME_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBFAKETIME_CONF_TOOL	:= NO

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

LIBFAKETIME_MAKE_ENV	:= $(CROSS_ENV)
LIBFAKETIME_MAKE_OPT	:= PREFIX=/usr

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

LIBFAKETIME_INSTALL_OPT	:= PREFIX=/usr install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libfaketime.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libfaketime)
	@$(call install_fixup, libfaketime,PRIORITY,optional)
	@$(call install_fixup, libfaketime,SECTION,base)
	@$(call install_fixup, libfaketime,AUTHOR,"Andreas Pretzsch <apr@cn-eng.de>")
	@$(call install_fixup, libfaketime,DESCRIPTION,missing)

	@$(call install_lib, libfaketime, 0, 0, 0644, faketime/libfaketime)
	@$(call install_lib, libfaketime, 0, 0, 0644, faketime/libfaketimeMT)
	@$(call install_copy, libfaketime, 0, 0, 0755, -, /usr/bin/faketime)

	@$(call install_finish, libfaketime)

	@$(call touch)

# vim: syntax=make
