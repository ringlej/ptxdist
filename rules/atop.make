# -*-makefile-*-
#
# Copyright (C) 2008 by Remy Bohmer, Netherlands
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ATOP) += atop

#
# Paths and names
#
ATOP_VERSION	:= 1.24
ATOP		:= atop-$(ATOP_VERSION)
ATOP_URL	:= http://www.atoptool.nl/download/$(ATOP).tar.gz
ATOP_SOURCE	:= $(SRCDIR)/$(ATOP).tar.gz
ATOP_DIR	:= $(BUILDDIR)/$(ATOP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ATOP_SOURCE):
	@$(call targetinfo)
	@$(call get, ATOP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ATOP_COMPILE_ENV := $(CROSS_ENV)

$(STATEDIR)/atop.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/atop.targetinstall:
	@$(call targetinfo)

	@$(call install_init, atop)
	@$(call install_fixup, atop,PRIORITY,optional)
	@$(call install_fixup, atop,SECTION,base)
	@$(call install_fixup, atop,AUTHOR,"Remy Bohmer <linux@bohmer.net>")
	@$(call install_fixup, atop,DESCRIPTION,missing)

	@$(call install_copy, atop, 0, 0, 0755, -, /usr/bin/atop)

	@$(call install_finish, atop)

	@$(call touch)

# vim: syntax=make
