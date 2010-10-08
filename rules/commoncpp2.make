# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#               2008, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_COMMONCPP2) += commoncpp2

#
# Paths and names
#
COMMONCPP2_VERSION	:= 1.8.1
COMMONCPP2_MD5		:= 4804b184e609154ba2bc0aa9f61dc6ef
COMMONCPP2		:= commoncpp2-$(COMMONCPP2_VERSION)
COMMONCPP2_SUFFIX	:= tar.gz
COMMONCPP2_SOURCE	:= $(SRCDIR)/$(COMMONCPP2).$(COMMONCPP2_SUFFIX)
COMMONCPP2_DIR		:= $(BUILDDIR)/$(COMMONCPP2)

COMMONCPP2_URL		:= \
	http://www.gnutelephony.org/dist/tarballs/$(COMMONCPP2).$(COMMONCPP2_SUFFIX) \
	http://www.gnutelephony.org/dist/archive/$(COMMONCPP2).$(COMMONCPP2_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(COMMONCPP2_SOURCE):
	@$(call targetinfo)
	@$(call get, COMMONCPP2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

COMMONCPP2_PATH	:= PATH=$(CROSS_PATH)
COMMONCPP2_ENV 	:= $(CROSS_ENV)
COMMONCPP2_MAKE_PAR := NO

#
# autoconf
#
COMMONCPP2_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-debug \
	--disable-profiling \
	--without-ipv6 \
	--without-nat \
	--without-gnutls \
	--without-openssl \
	--without-memaudit \
	--without-cppunit

# the logic for these switches is broken in 1.8.0:
#	--with-exceptions
#	--with-monotonic
#	--with-extras

ifndef PTXCONF_COMMONCPP2_LIBZ
COMMONCPP2_AUTOCONF += --without-compression
endif

ifndef PTXCONF_COMMONCPP2_LIBXML2
COMMONCPP2_AUTOCONF += --without-libxml2
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/commoncpp2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, commoncpp2)
	@$(call install_fixup, commoncpp2,PRIORITY,optional)
	@$(call install_fixup, commoncpp2,SECTION,base)
	@$(call install_fixup, commoncpp2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, commoncpp2,DESCRIPTION,missing)

	@$(call install_lib, commoncpp2, 0, 0, 0644, libccgnu2-1.8)
	@$(call install_lib, commoncpp2, 0, 0, 0644, libccext2-1.8)

	@$(call install_finish, commoncpp2)

	@$(call touch)

# vim: syntax=make
