# -*-makefile-*-
#
# Copyright (C) 2005 by Shahar Livne <shahar@livnex.com>
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
PACKAGES-$(PTXCONF_CPPUNIT) += cppunit

#
# Paths and names
#
CPPUNIT_VERSION	:= 1.12.1
CPPUNIT_MD5	:= bd30e9cf5523cdfc019b94f5e1d7fd19
CPPUNIT		:= cppunit-$(CPPUNIT_VERSION)
CPPUNIT_SUFFIX	:= tar.gz
CPPUNIT_URL	:= $(PTXCONF_SETUP_SFMIRROR)/cppunit/$(CPPUNIT).$(CPPUNIT_SUFFIX)
CPPUNIT_SOURCE	:= $(SRCDIR)/$(CPPUNIT).$(CPPUNIT_SUFFIX)
CPPUNIT_DIR	:= $(BUILDDIR)/$(CPPUNIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(CPPUNIT_SOURCE):
	@$(call targetinfo)
	@$(call get, CPPUNIT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CPPUNIT_PATH	:= PATH=$(CROSS_PATH)
CPPUNIT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CPPUNIT_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-doxygen

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cppunit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cppunit)
	@$(call install_fixup, cppunit,PRIORITY,optional)
	@$(call install_fixup, cppunit,SECTION,base)
	@$(call install_fixup, cppunit,AUTHOR,"Shahar Livne <shahar@livnex.com>")
	@$(call install_fixup, cppunit,DESCRIPTION,missing)

	@$(call install_lib, cppunit, 0, 0, 0644, libcppunit-1.12)

	@$(call install_finish, cppunit)

	@$(call touch)

# vim: syntax=make
