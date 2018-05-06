# -*-makefile-*-
#
# Copyright (C) 2014 by Guillaume Gourat <guillaume.gourat@nexvision.fr>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_GFLAGS) += gflags

#
# Paths and names
#
GFLAGS_VERSION	:= 2.0
GFLAGS_MD5	:= 9084829124e02a7e6be0f0f824523423 ebad229932448ad03fc085eca26ba735
GFLAGS		:= gflags-$(GFLAGS_VERSION)
GFLAGS_SUFFIX	:= tar.gz
GFLAGS_URL	:= https://github.com/gflags/gflags/archive/v$(GFLAGS_VERSION).$(GFLAGS_SUFFIX)
GFLAGS_SOURCE	:= $(SRCDIR)/$(GFLAGS)-no-svn-files.$(GFLAGS_SUFFIX)
GFLAGS_DIR	:= $(BUILDDIR)/$(GFLAGS)
GFLAGS_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GFLAGS_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gflags.targetinstall:
	@$(call targetinfo)

	@$(call install_init, gflags)
	@$(call install_fixup, gflags,PRIORITY,optional)
	@$(call install_fixup, gflags,SECTION,base)
	@$(call install_fixup, gflags,AUTHOR,"Guillaume Gourat <guillaume.gourat@nexvision.fr>")
	@$(call install_fixup, gflags,DESCRIPTION,missing)

	@$(call install_lib, gflags, 0, 0, 0644, libgflags)

	@$(call install_finish, gflags)

	@$(call touch)

# vim: syntax=make
