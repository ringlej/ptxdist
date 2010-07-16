# -*-makefile-*-
#
# Copyright (C) 2008 by Luotao Fu <l.fu@pengutronix.de>
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BC) += bc

#
# Paths and names
#
BC_VERSION	:= 1.06
BC		:= bc-$(BC_VERSION)
BC_SUFFIX	:= tar.gz
BC_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/bc/$(BC).$(BC_SUFFIX)
BC_SOURCE	:= $(SRCDIR)/$(BC).$(BC_SUFFIX)
BC_DIR		:= $(BUILDDIR)/$(BC)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BC_SOURCE):
	@$(call targetinfo)
	@$(call get, BC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BC_PATH	:= PATH=$(CROSS_PATH)
BC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
BC_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bc)
	@$(call install_fixup, bc,PRIORITY,optional)
	@$(call install_fixup, bc,SECTION,base)
	@$(call install_fixup, bc,AUTHOR,"Luotao Fu <l.fu@pengutronix.de>")
	@$(call install_fixup, bc,DESCRIPTION,missing)

	@$(call install_copy, bc, 0, 0, 0755, -, /usr/bin/bc)

	@$(call install_finish, bc)

	@$(call touch)

# vim: syntax=make
