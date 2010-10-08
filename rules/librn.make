# -*-makefile-*-
#
# Copyright (C) 2003 Ixia Corporation, by Milan Bobde
#		2005-2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBRN) += librn

#
# Paths and names
#
LIBRN_VERSION	:= 0.5.3
LIBRN_MD5	:= a357a6ceb4b6becae2f64d0fed9a8111
LIBRN		:= librn-$(LIBRN_VERSION)
LIBRN_SUFFIX	:= tar.bz2
LIBRN_URL	:= http://www.pengutronix.de/software/librn/download/$(LIBRN).$(LIBRN_SUFFIX)
LIBRN_SOURCE	:= $(SRCDIR)/$(LIBRN).$(LIBRN_SUFFIX)
LIBRN_DIR	:= $(BUILDDIR)/$(LIBRN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBRN_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBRN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBRN_PATH	:= PATH=$(CROSS_PATH)
LIBRN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBRN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/librn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, librn)
	@$(call install_fixup, librn,PRIORITY,optional)
	@$(call install_fixup, librn,SECTION,base)
	@$(call install_fixup, librn,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, librn,DESCRIPTION,missing)

	@$(call install_lib, librn, 0, 0, 0644, librn)

	@$(call install_finish, librn)

	@$(call touch)

# vim: syntax=make
