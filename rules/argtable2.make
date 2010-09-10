# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARGTABLE2) += argtable2

#
# Paths and names
#
ARGTABLE2_VERSION	:= 12
ARGTABLE2		:= argtable2-$(ARGTABLE2_VERSION)
ARGTABLE2_SUFFIX	:= tar.gz
ARGTABLE2_URL		:= $(PTXCONF_SETUP_SFMIRROR)/argtable/$(ARGTABLE2).$(ARGTABLE2_SUFFIX)
ARGTABLE2_SOURCE	:= $(SRCDIR)/$(ARGTABLE2).$(ARGTABLE2_SUFFIX)
ARGTABLE2_DIR		:= $(BUILDDIR)/$(ARGTABLE2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ARGTABLE2_SOURCE):
	@$(call targetinfo)
	@$(call get, ARGTABLE2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ARGTABLE2_PATH	:= PATH=$(CROSS_PATH)
ARGTABLE2_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
ARGTABLE2_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/argtable2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, argtable2)
	@$(call install_fixup, argtable2,PRIORITY,optional)
	@$(call install_fixup, argtable2,SECTION,base)
	@$(call install_fixup, argtable2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, argtable2,DESCRIPTION,missing)

	@$(call install_lib, argtable2, 0, 0, 0644, libargtable2)

	@$(call install_finish, argtable2)

	@$(call touch)

# vim: syntax=make
