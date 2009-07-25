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
CPPUNIT_VERSION	= 1.12.1
CPPUNIT		= cppunit-$(CPPUNIT_VERSION)
CPPUNIT_SUFFIX	= tar.gz
CPPUNIT_URL	= $(PTXCONF_SETUP_SFMIRROR)/cppunit/$(CPPUNIT).$(CPPUNIT_SUFFIX)
CPPUNIT_SOURCE	= $(SRCDIR)/$(CPPUNIT).$(CPPUNIT_SUFFIX)
CPPUNIT_DIR	= $(BUILDDIR)/$(CPPUNIT)

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
CPPUNIT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/cppunit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, cppunit)
	@$(call install_fixup, cppunit,PACKAGE,$(CPPUNIT))
	@$(call install_fixup, cppunit,PRIORITY,optional)
	@$(call install_fixup, cppunit,VERSION,$(CPPUNIT_VERSION))
	@$(call install_fixup, cppunit,SECTION,base)
	@$(call install_fixup, cppunit,AUTHOR,"Shahar Livne <shahar@livnex.com>")
	@$(call install_fixup, cppunit,DEPENDS,)
	@$(call install_fixup, cppunit,DESCRIPTION,missing)

	@$(call install_copy, cppunit, 0, 0, 0644, -, \
		/usr/lib/libcppunit-1.12.so.1.0.0)

	@$(call install_link, cppunit, libcppunit-1.12.so.1.0.0, /usr/lib/libcppunit-1.10.so.1)
	@$(call install_link, cppunit, libcppunit-1.12.so.1.0.0, /usr/lib/libcppunit.so)

	@$(call install_finish, cppunit)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cppunit_clean:
	rm -rf $(STATEDIR)/cppunit.*
	rm -rf $(PKGDIR)/cppunit_*
	rm -rf $(CPPUNIT_DIR)

# vim: syntax=make
