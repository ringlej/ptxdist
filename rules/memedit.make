# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
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
PACKAGES-$(PTXCONF_MEMEDIT) += memedit

#
# Paths and names
#
MEMEDIT_VERSION	:= 0.8
MEMEDIT_MD5	:= 20ac6513eb99c7d1930ae45b61bc95d7
MEMEDIT_LICENSE	:= GPLv2
MEMEDIT		:= memedit-$(MEMEDIT_VERSION)
MEMEDIT_SUFFIX	:= tar.gz
MEMEDIT_URL	:= http://www.pengutronix.de/software/memedit/downloads/$(MEMEDIT).$(MEMEDIT_SUFFIX)
MEMEDIT_SOURCE	:= $(SRCDIR)/$(MEMEDIT).$(MEMEDIT_SUFFIX)
MEMEDIT_DIR	:= $(BUILDDIR)/$(MEMEDIT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MEMEDIT_SOURCE):
	@$(call targetinfo)
	@$(call get, MEMEDIT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MEMEDIT_PATH	:= PATH=$(CROSS_PATH)
MEMEDIT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
MEMEDIT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memedit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memedit)
	@$(call install_fixup, memedit,PRIORITY,optional)
	@$(call install_fixup, memedit,SECTION,base)
	@$(call install_fixup, memedit,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, memedit,DESCRIPTION,missing)

	@$(call install_copy, memedit, 0, 0, 0755, -, /usr/bin/memedit)

	@$(call install_finish, memedit)

	@$(call touch)

# vim: syntax=make
