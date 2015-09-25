# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PYTHON_ROUTING) += python-routing

#
# Paths and names
#
PYTHON_ROUTING_VERSION	:= 1.0
PYTHON_ROUTING_MD5	:= 2ef6adf2ab6a2f303600999546198a69
PYTHON_ROUTING		:= python_routing-$(PYTHON_ROUTING_VERSION)
PYTHON_ROUTING_SUFFIX	:= tar.gz
PYTHON_ROUTING_URL	:= http://cakelab.org/~eintopf/RPL/$(PYTHON_ROUTING).$(PYTHON_ROUTING_SUFFIX)
PYTHON_ROUTING_SOURCE	:= $(SRCDIR)/$(PYTHON_ROUTING).$(PYTHON_ROUTING_SUFFIX)
PYTHON_ROUTING_DIR	:= $(BUILDDIR)/$(PYTHON_ROUTING)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PYTHON_ROUTING_CONF_TOOL	:= python

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/python-routing.targetinstall:
	@$(call targetinfo)

	@$(call install_init, python-routing)
	@$(call install_fixup, python-routing,PRIORITY,optional)
	@$(call install_fixup, python-routing,SECTION,base)
	@$(call install_fixup, python-routing,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, python-routing,DESCRIPTION,missing)

	@$(call install_copy, python-routing, 0, 0, 0644, -, $(PYTHON_SITEPACKAGES)/Routing.so)

	@$(call install_finish, python-routing)

	@$(call touch)

# vim: syntax=make
