# -*-makefile-*-
#
# Copyright (C) 2006 by Marc Kleine-Budde <mkl@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_MODULE_INIT_TOOLS) += cross-module-init-tools

#
# Paths and names
#
CROSS_MODULE_INIT_TOOLS_DIR	= $(CROSS_BUILDDIR)/$(MODULE_INIT_TOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
CROSS_MODULE_INIT_TOOLS_CONF_TOOL := autoconf

CROSS_MODULE_INIT_TOOLS_MAKE_OPT := depmod

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cross-module-init-tools.install:
	@$(call targetinfo)
	install -D -m 755 $(CROSS_MODULE_INIT_TOOLS_DIR)/build/depmod $(CROSS_MODULE_INIT_TOOLS_PKGDIR)/sbin/$(PTXCONF_GNU_TARGET)-depmod
	@$(call touch)

# vim: syntax=make
