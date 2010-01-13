# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2009 by Wolfram Sang <w.sang@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RT_TESTS) += rt-tests

#
# Paths and names
#
RT_TESTS_VERSION	:= 0.60
RT_TESTS_LICENSE	:= GPLv2, GPLv2+
RT_TESTS		:= rt-tests-$(RT_TESTS_VERSION)
RT_TESTS_SUFFIX		:= tar.bz2
RT_TESTS_URL		:= http://www.kernel.org/pub/linux/kernel/people/clrkwllms/rt-tests/$(RT_TESTS).$(RT_TESTS_SUFFIX)
RT_TESTS_SOURCE		:= $(SRCDIR)/$(RT_TESTS).$(RT_TESTS_SUFFIX)
RT_TESTS_DIR		:= $(BUILDDIR)/$(RT_TESTS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(RT_TESTS_SOURCE):
	@$(call targetinfo)
	@$(call get, RT_TESTS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/rt-tests.extract:
	@$(call targetinfo)
	@$(call clean, $(RT_TESTS_DIR))
	@$(call extract, RT_TESTS)
	rm -fr $(RT_TESTS_DIR)
	mv $(BUILDDIR)/rt-tests $(RT_TESTS_DIR)
	@$(call patchin, RT_TESTS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

RT_TESTS_PATH	:= PATH=$(CROSS_PATH)
RT_TESTS_ENV 	:= $(CROSS_ENV)

RT_TESTS_MAKEVARS := \
	$(CROSS_ENV_CC) \
	prefix=/usr

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rt-tests.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rt-tests)
	@$(call install_fixup, rt-tests,PACKAGE,rt-tests)
	@$(call install_fixup, rt-tests,PRIORITY,optional)
	@$(call install_fixup, rt-tests,VERSION,$(RT_TESTS_VERSION))
	@$(call install_fixup, rt-tests,SECTION,base)
	@$(call install_fixup, rt-tests,AUTHOR,"Robert Schwebel")
	@$(call install_fixup, rt-tests,DEPENDS,)
	@$(call install_fixup, rt-tests,DESCRIPTION,missing)

ifdef PTXCONF_RT_TESTS_CYCLICTEST
	@$(call install_copy, rt-tests, 0, 0, 0755, -, \
		/usr/bin/cyclictest)
endif
ifdef PTXCONF_RT_TESTS_PI_STRESS
	@$(call install_copy, rt-tests, 0, 0, 0755, -, \
		/usr/bin/pi_stress)
endif
ifdef PTXCONF_RT_TESTS_SIGNALTEST
	@$(call install_copy, rt-tests, 0, 0, 0755, -, \
		/usr/bin/signaltest)
endif
	@$(call install_finish, rt-tests)

	@$(call touch)

# vim: syntax=make
