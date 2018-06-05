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
PACKAGES-$(PTXCONF_LIBCGROUP) += libcgroup

#
# Paths and names
#
LIBCGROUP_VERSION	:= 0.38
LIBCGROUP_MD5		:= f0f7d4060bf36ccc19d75dbf4f1695db
LIBCGROUP		:= libcgroup-$(LIBCGROUP_VERSION)
LIBCGROUP_SUFFIX	:= tar.bz2
LIBCGROUP_URL		:= $(call ptx/mirror, SF, libcg/$(LIBCGROUP).$(LIBCGROUP_SUFFIX))
LIBCGROUP_SOURCE	:= $(SRCDIR)/$(LIBCGROUP).$(LIBCGROUP_SUFFIX)
LIBCGROUP_DIR		:= $(BUILDDIR)/$(LIBCGROUP)
LIBCGROUP_LICENSE	:= LGPL-2.1-only

#
# autoconf
#
LIBCGROUP_CONF_TOOL := autoconf
LIBCGROUP_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-bindings \
	--disable-tools \
	--disable-pam \
	--enable-daemon

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libcgroup.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libcgroup)
	@$(call install_fixup, libcgroup,PRIORITY,optional)
	@$(call install_fixup, libcgroup,SECTION,base)
	@$(call install_fixup, libcgroup,AUTHOR,"Wolfram Sang <w.sang@pengutronix.de>")
	@$(call install_fixup, libcgroup,DESCRIPTION,missing)

	@$(call install_lib, libcgroup, 0, 0, 0644, libcgroup)

	@$(call install_finish, libcgroup)

	@$(call touch)

# vim: syntax=make
