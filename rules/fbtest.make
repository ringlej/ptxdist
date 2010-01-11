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
FBTEST_VERSION	:= 20041102-1
FBTEST		:= fbtest-$(FBTEST_VERSION)
FBTEST_SUFFIX	:= tar.gz
FBTEST_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(FBTEST).$(FBTEST_SUFFIX)
FBTEST_SOURCE	:= $(SRCDIR)/$(FBTEST).$(FBTEST_SUFFIX)
FBTEST_DIR	:= $(BUILDDIR)/$(FBTEST)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FBTEST_SOURCE):
	@$(call targetinfo)
	@$(call get, FBTEST)

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
	@$(call install_fixup, fbtest,PACKAGE,fbtest)
	@$(call install_fixup, fbtest,PRIORITY,optional)
	@$(call install_fixup, fbtest,VERSION,$(FBTEST_VERSION))
	@$(call install_fixup, fbtest,SECTION,base)
	@$(call install_fixup, fbtest,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, fbtest,DEPENDS,)
	@$(call install_fixup, fbtest,DESCRIPTION,missing)

	@$(call install_copy, fbtest, 0, 0, 0755, -, /sbin/fbtest)

	@$(call install_finish, fbtest)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fbtest_clean:
	rm -rf $(STATEDIR)/fbtest.*
	rm -rf $(PKGDIR)/fbtest_*
	rm -rf $(FBTEST_DIR)

# vim: syntax=make
