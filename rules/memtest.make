# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MEMTEST) += memtest

#
# Paths and names
#
MEMTEST_VERSION		:= 0.0.4
MEMTEST			:= memtest-$(MEMTEST_VERSION)
MEMTEST_SUFFIX		:= tar.bz2
MEMTEST_URL		:= http://carpanta.dc.fi.udc.es/~quintela/memtest/$(MEMTEST).$(MEMTEST_SUFFIX)
MEMTEST_SOURCE		:= $(SRCDIR)/$(MEMTEST).$(MEMTEST_SUFFIX)
MEMTEST_DIR		:= $(BUILDDIR)/$(MEMTEST)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(MEMTEST_SOURCE):
	@$(call targetinfo)
	@$(call get, MEMTEST)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

MEMTEST_MAKE_ENV	:= $(CROSS_ENV)
MEMTEST_MAKE_OPT	:= mtest

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memtest.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/memtest.targetinstall:
	@$(call targetinfo)

	@$(call install_init, memtest)
	@$(call install_fixup, memtest,PRIORITY,optional)
	@$(call install_fixup, memtest,SECTION,base)
	@$(call install_fixup, memtest,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, memtest,DESCRIPTION,missing)

	@$(call install_copy, memtest, 0, 0, 0755, $(MEMTEST_DIR)/mtest, /usr/sbin/memtest)

	@$(call install_finish, memtest)

	@$(call touch)

# vim: syntax=make
