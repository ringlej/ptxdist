# -*-makefile-*-
#
# Copyright (C) 2016 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBSECCOMP) += libseccomp

#
# Paths and names
#
LIBSECCOMP_VERSION	:= 2.3.2
LIBSECCOMP_MD5		:= e74a626bea0cd607c23229b10b5f93da
LIBSECCOMP		:= libseccomp-$(LIBSECCOMP_VERSION)
LIBSECCOMP_SUFFIX	:= tar.gz
LIBSECCOMP_URL		:= https://github.com/seccomp/libseccomp/releases/download/v$(LIBSECCOMP_VERSION)/$(LIBSECCOMP).$(LIBSECCOMP_SUFFIX)
LIBSECCOMP_SOURCE	:= $(SRCDIR)/$(LIBSECCOMP).$(LIBSECCOMP_SUFFIX)
LIBSECCOMP_DIR		:= $(BUILDDIR)/$(LIBSECCOMP)
LIBSECCOMP_LICENSE	:= LGPL-2.1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBSECCOMP_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libseccomp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libseccomp)
	@$(call install_fixup, libseccomp, PRIORITY, optional)
	@$(call install_fixup, libseccomp, SECTION, base)
	@$(call install_fixup, libseccomp, AUTHOR, "Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, libseccomp, DESCRIPTION, missing)

	@$(call install_lib, libseccomp, 0, 0, 0644, libseccomp)

	@$(call install_finish, libseccomp)

	@$(call touch)

# vim: syntax=make
