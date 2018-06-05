# -*-makefile-*-
#
# Copyright (C) 2014 by Bernhard Walle <bernhard@bwalle.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBCONFIG) += libconfig

#
# Paths and names
#
LIBCONFIG_VERSION	:= 1.4.9
LIBCONFIG_MD5		:= b6ee0ce2b3ef844bad7cac2803a90634
LIBCONFIG		:= libconfig-$(LIBCONFIG_VERSION)
LIBCONFIG_SUFFIX	:= tar.gz
LIBCONFIG_URL		:= http://www.hyperrealm.com/libconfig/$(LIBCONFIG).$(LIBCONFIG_SUFFIX)
LIBCONFIG_SOURCE	:= $(SRCDIR)/$(LIBCONFIG).$(LIBCONFIG_SUFFIX)
LIBCONFIG_DIR		:= $(BUILDDIR)/$(LIBCONFIG)
LIBCONFIG_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBCONFIG_CONF_TOOL	:= autoconf
LIBCONFIG_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_LIBCONFIG_CXX)-cxx \
	--disable-examples

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libconfig.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libconfig)
	@$(call install_fixup, libconfig,PRIORITY,optional)
	@$(call install_fixup, libconfig,SECTION,base)
	@$(call install_fixup, libconfig,AUTHOR,"Bernhard Walle <bernhard@bwalle.de>")
	@$(call install_fixup, libconfig,DESCRIPTION,missing)

	@$(call install_lib, libconfig, 0, 0, 0644, libconfig)
ifdef PTXCONF_LIBCONFIG_CXX
	@$(call install_lib, libconfig, 0, 0, 0644, libconfig++)
endif

	@$(call install_finish, libconfig)

	@$(call touch)

# vim: syntax=make
