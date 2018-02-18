# -*-makefile-*-
#
# Copyright (C) 2018 by Bastian Stender <bst@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBYAML) += libyaml

#
# Paths and names
#
LIBYAML_VERSION	:= 0.1.7
LIBYAML_MD5	:= c966bdf434286e4f618d9ae8a5e8db97
LIBYAML		:= libyaml-$(LIBYAML_VERSION)
LIBYAML_SUFFIX	:= tar.gz
LIBYAML_URL	:= https://github.com/yaml/libyaml/archive/$(LIBYAML_VERSION).$(LIBYAML_SUFFIX)
LIBYAML_SOURCE	:= $(SRCDIR)/$(LIBYAML).$(LIBYAML_SUFFIX)
LIBYAML_DIR	:= $(BUILDDIR)/$(LIBYAML)
LIBYAML_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
LIBYAML_CONF_TOOL	:= autoconf
LIBYAML_CONF_OPT	:= $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libyaml.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libyaml)
	@$(call install_fixup, libyaml, PRIORITY, optional)
	@$(call install_fixup, libyaml, SECTION, base)
	@$(call install_fixup, libyaml, AUTHOR, "Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, libyaml, DESCRIPTION, missing)

	@$(call install_lib, libyaml, 0, 0, 0644, libyaml-0)

	@$(call install_finish, libyaml)

	@$(call touch)

# vim: syntax=make
