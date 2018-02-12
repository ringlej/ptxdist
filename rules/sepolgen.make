# -*-makefile-*-
#
# Copyright (C) 2013 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SEPOLGEN) += sepolgen

#
# Paths and names
#
SEPOLGEN_VERSION	:= 1.1.8
SEPOLGEN_MD5		:= d734ff236639cc1bd3a33901774fa98d
SEPOLGEN		:= sepolgen-$(SEPOLGEN_VERSION)
SEPOLGEN_SUFFIX		:= tar.gz
SEPOLGEN_URL		:= https://raw.githubusercontent.com/wiki/SELinuxProject/selinux/files/releases/20120924/$(SEPOLGEN).$(SEPOLGEN_SUFFIX)
SEPOLGEN_SOURCE		:= $(SRCDIR)/$(SEPOLGEN).$(SEPOLGEN_SUFFIX)
SEPOLGEN_DIR		:= $(BUILDDIR)/$(SEPOLGEN)
SEPOLGEN_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SEPOLGEN_CONF_TOOL := NO
# no ':=' because of $(PYTHON_SITEPACKAGES)
SEPOLGEN_MAKE_ENV = PYTHONLIBDIR=$(PYTHON_SITEPACKAGES)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sepolgen.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sepolgen)
	@$(call install_fixup, sepolgen,PRIORITY,optional)
	@$(call install_fixup, sepolgen,SECTION,base)
	@$(call install_fixup, sepolgen,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, sepolgen,DESCRIPTION,missing)

	@$(call install_tree, sepolgen, 0, 0, -, $(PYTHON_SITEPACKAGES))
	@$(call install_alternative, sepolgen, 0, 0, 0644, /var/lib/sepolgen/perm_map)

	@$(call install_finish, sepolgen)

	@$(call touch)

# vim: syntax=make
