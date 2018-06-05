# -*-makefile-*-
#
# Copyright (C) 2004 by Sascha Hauer
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
PACKAGES-$(PTXCONF_FBTEST) += fbtest

#
# Paths and names
#
FBTEST_VERSION	:= 2014-08-11-g29ab066
FBTEST_MD5	:= 48d1f4e6450ded48c44733539c1c9614
FBTEST		:= fbtest-$(FBTEST_VERSION)
FBTEST_SUFFIX	:= tar.gz
FBTEST_URL	:= https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git;tag=$(FBTEST_VERSION)
FBTEST_SOURCE	:= $(SRCDIR)/$(FBTEST).$(FBTEST_SUFFIX)
FBTEST_DIR	:= $(BUILDDIR)/$(FBTEST)
FBTEST_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

FBTEST_PATH	:= PATH=$(CROSS_PATH)
FBTEST_MAKE_ENV	:= $(CROSS_ENV) CROSS_COMPILE=$(COMPILER_PREFIX)
FBTEST_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbtest.targetinstall:
	@$(call targetinfo)

	@$(call install_init, fbtest)
	@$(call install_fixup, fbtest,PRIORITY,optional)
	@$(call install_fixup, fbtest,SECTION,base)
	@$(call install_fixup, fbtest,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fbtest,DESCRIPTION,missing)

	@$(call install_copy, fbtest, 0, 0, 0755, -, /usr/sbin/fbtest)

	@$(call install_finish, fbtest)

	@$(call touch)

# vim: syntax=make
