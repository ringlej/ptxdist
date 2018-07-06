# -*-makefile-*-
#
# Copyright (C) 2005 by Shahar Livne <shahar@livnex.com>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#               2014 by Bernhard Seßler <bernhard.sessler@corscience.de>
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
CPPUNIT_VERSION	:= 1.14.0
CPPUNIT_MD5	:= 7ad93022171710a541bfe4bfd8b4a381
CPPUNIT		:= cppunit-$(CPPUNIT_VERSION)
CPPUNIT_SUFFIX	:= tar.gz
CPPUNIT_URL	:= http://dev-www.libreoffice.org/src/$(CPPUNIT).$(CPPUNIT_SUFFIX)
CPPUNIT_SOURCE	:= $(SRCDIR)/$(CPPUNIT).$(CPPUNIT_SUFFIX)
CPPUNIT_DIR	:= $(BUILDDIR)/$(CPPUNIT)
CPPUNIT_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

CPPUNIT_CONF_TOOL	:= autoconf
CPPUNIT_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-doxygen \
	--disable-dot \
	--disable-html-docs \
	--enable-latex-docs \
	--disable-debug \
	--disable-werror

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

	@$(call install_lib, cppunit, 0, 0, 0644, libcppunit-$(basename $(CPPUNIT_VERSION)))

	@$(call install_finish, cppunit)

	@$(call touch)

# vim: syntax=make
