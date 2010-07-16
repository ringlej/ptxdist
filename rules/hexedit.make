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
PACKAGES-$(PTXCONF_HEXEDIT) += hexedit

#
# Paths and names
#
HEXEDIT_VERSION	:= 1.2.12
HEXEDIT		:= hexedit-$(HEXEDIT_VERSION)
HEXEDIT_SUFFIX	:= src.tgz
HEXEDIT_URL	:= http://rigaux.org/$(HEXEDIT).$(HEXEDIT_SUFFIX)
HEXEDIT_SOURCE	:= $(SRCDIR)/$(HEXEDIT).$(HEXEDIT_SUFFIX)
HEXEDIT_DIR	:= $(BUILDDIR)/$(HEXEDIT)
HEXEDIT_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HEXEDIT_SOURCE):
	@$(call targetinfo)
	@$(call get, HEXEDIT)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/hexedit.extract:
	@$(call targetinfo)
	@$(call clean, $(HEXEDIT_DIR))
	@$(call extract, HEXEDIT)
	mv $(BUILDDIR)/hexedit $(HEXEDIT_DIR)
	@$(call patchin, HEXEDIT)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HEXEDIT_PATH	:= PATH=$(CROSS_PATH)
HEXEDIT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
HEXEDIT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hexedit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hexedit)
	@$(call install_fixup, hexedit,PRIORITY,optional)
	@$(call install_fixup, hexedit,SECTION,base)
	@$(call install_fixup, hexedit,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, hexedit,DESCRIPTION,missing)

	@$(call install_copy, hexedit, 0, 0, 0755, -, \
		/usr/bin/hexedit)

	@$(call install_finish, hexedit)

	@$(call touch)

# vim: syntax=make
