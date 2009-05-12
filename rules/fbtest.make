# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
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
# Prepare
# ----------------------------------------------------------------------------

FBTEST_PATH	:=  PATH=$(CROSS_PATH)
FBTEST_ENV 	:=  $(CROSS_ENV)
FBTEST_COMPILE_ENV := CROSS_COMPILE=$(COMPILER_PREFIX)

$(STATEDIR)/fbtest.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/fbtest.compile:
	@$(call targetinfo)
	cd $(FBTEST_DIR) && $(FBTEST_COMPILE_ENV) $(FBTEST_PATH) \
		$(MAKE) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/fbtest.install:
	@$(call targetinfo)
	@$(call touch)

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

	@$(call install_copy, fbtest, 0, 0, 0755, $(FBTEST_DIR)/$(COMPILER_PREFIX)fbtest, /sbin/fbtest)

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
