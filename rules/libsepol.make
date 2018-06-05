# -*-makefile-*-
#
# Copyright (C) 2012 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSEPOL) += libsepol

#
# Paths and names
#
LIBSEPOL_VERSION	:= 2.1.8
LIBSEPOL_MD5		:= 56fa100ed85d7f06bd92f2892d92b3b0
LIBSEPOL		:= libsepol-$(LIBSEPOL_VERSION)
LIBSEPOL_SUFFIX		:= tar.gz
LIBSEPOL_URL		:= https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/files/releases/20120924/$(LIBSEPOL).$(LIBSEPOL_SUFFIX)
LIBSEPOL_SOURCE		:= $(SRCDIR)/$(LIBSEPOL).$(LIBSEPOL_SUFFIX)
LIBSEPOL_DIR		:= $(BUILDDIR)/$(LIBSEPOL)
LIBSEPOL_LICENSE	:= LGPL-2.1-or-later

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBSEPOL_CONF_TOOL := NO
LIBSEPOL_MAKE_ENV := \
	$(CROSS_ENV) \
	CFLAGS="-O2 -Wall -g"

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libsepol.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libsepol)
	@$(call install_fixup, libsepol,PRIORITY,optional)
	@$(call install_fixup, libsepol,SECTION,base)
	@$(call install_fixup, libsepol,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libsepol,DESCRIPTION,missing)

	@$(call install_lib, libsepol, 0, 0, 0644, libsepol)

	@$(call install_finish, libsepol)

	@$(call touch)

# vim: syntax=make
