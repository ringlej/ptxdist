# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PELTS_TESTS) += pelts-tests

#
# Paths and names
#
PELTS_TESTS_VERSION	:= 0.0.1
PELTS_TESTS		:= pelts_tests-$(PELTS_TESTS_VERSION)
PELTS_TESTS_SUFFIX	:= tar.bz2
PELTS_TESTS_URL		:= http://www.pengutronix.de/software/pelts/download/utils/$(PELTS_TESTS).$(PELTS_TESTS_SUFFIX)
PELTS_TESTS_SOURCE	:= $(SRCDIR)/$(PELTS_TESTS).$(PELTS_TESTS_SUFFIX)
PELTS_TESTS_DIR		:= $(BUILDDIR)/$(PELTS_TESTS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PELTS_TESTS_SOURCE):
	@$(call targetinfo)
	@$(call get, PELTS_TESTS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PELTS_TESTS_PATH	:= PATH=$(CROSS_PATH)
PELTS_TESTS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PELTS_TESTS_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pelts-tests.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pelts-tests)
	@$(call install_fixup,pelts-tests,PRIORITY,optional)
	@$(call install_fixup,pelts-tests,SECTION,base)
	@$(call install_fixup,pelts-tests,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,pelts-tests,DESCRIPTION,missing)

	@$(call install_copy, pelts-tests, 0, 0, 0755, -, /usr/bin/floattest)

	@$(call install_finish,pelts-tests)

	@$(call touch)

# vim: syntax=make
