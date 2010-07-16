# -*-makefile-*-
#
# Copyright (C) 2004 by Benedikt Spranger
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ETHERWAKE) += etherwake

#
# Paths and names
#
ETHERWAKE_VERSION	:= 1.09
ETHERWAKE_SUFFIX	:= tar.gz
ETHERWAKE		:= etherwake-$(ETHERWAKE_VERSION).orig
ETHERWAKE_TARBALL	:= etherwake_$(ETHERWAKE_VERSION).orig.$(ETHERWAKE_SUFFIX)
ETHERWAKE_URL		:= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/e/etherwake/$(ETHERWAKE_TARBALL)
ETHERWAKE_SOURCE	:= $(SRCDIR)/$(ETHERWAKE_TARBALL)
ETHERWAKE_DIR		:= $(BUILDDIR)/$(ETHERWAKE)
ETHERWAKE_LICENSE	:= GPL

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ETHERWAKE_SOURCE):
	@$(call targetinfo)
	@$(call get, ETHERWAKE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ETHERWAKE_PATH	:= PATH=$(CROSS_PATH)
ETHERWAKE_ENV 	:= $(CROSS_ENV)

ETHERWAKE_MAKEVARS := CC=$(CROSS_CC)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/etherwake.targetinstall:
	@$(call targetinfo)

	@$(call install_init, etherwake)
	@$(call install_fixup, etherwake,PRIORITY,optional)
	@$(call install_fixup, etherwake,SECTION,base)
	@$(call install_fixup, etherwake,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, etherwake,DESCRIPTION,missing)

	@$(call install_copy, etherwake, 0, 0, 0755, -, \
		/usr/sbin/etherwake)

	@$(call install_finish, etherwake)

	@$(call touch)

# vim: syntax=make
