# -*-makefile-*-
# $Id: template 3502 2005-12-11 12:46:17Z rsc $
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
COMMONCPP2_VERSION	:= 1.7.3
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
COMMONCPP2_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifndef PTXCONF_COMMONCPP2_LIBZ
COMMONCPP2_AUTOCONF += --without-compression
endif

ifndef PTXCONF_COMMONCPP2_LIBXML2
COMMONCPP2_AUTOCONF += --without-libxml2
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/commoncpp2.install:
	@$(call targetinfo)
	@$(call install, COMMONCPP2)
	install -m755 -D $(COMMONCPP2_DIR)/src/ccgnu2-config $(PTXCONF_SYSROOT_CROSS)/bin/ccgnu2-config
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/commoncpp2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, commoncpp2)
	@$(call install_fixup, commoncpp2,PACKAGE,commoncpp2)
	@$(call install_fixup, commoncpp2,PRIORITY,optional)
	@$(call install_fixup, commoncpp2,VERSION,$(COMMONCPP2_VERSION))
	@$(call install_fixup, commoncpp2,SECTION,base)
	@$(call install_fixup, commoncpp2,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, commoncpp2,DEPENDS,)
	@$(call install_fixup, commoncpp2,DESCRIPTION,missing)

	@$(call install_copy, commoncpp2, 0, 0, 0644, -, /usr/lib/libccgnu2-1.7.so.0.0.3)
	@$(call install_link, commoncpp2, libccgnu2-1.7.so.0.0.3, /usr/lib/libccgnu2-1.7.so.0)
	@$(call install_link, commoncpp2, libccgnu2-1.7.so.0.0.3, /usr/lib/libccgnu2.so)

	@$(call install_copy, commoncpp2, 0, 0, 0644, -, /usr/lib/libccext2-1.7.so.0.0.3)
	@$(call install_link, commoncpp2, libccext2-1.7.so.0.0.3, /usr/lib/libccext2-1.7.so.1)
	@$(call install_link, commoncpp2, libccext2-1.7.so.0.0.3, /usr/lib/libccext2.so)

	@$(call install_finish, commoncpp2)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

commoncpp2_clean:
	rm -rf $(STATEDIR)/commoncpp2.*
	rm -rf $(PKGDIR)/commoncpp2_*
	rm -rf $(COMMONCPP2_DIR)

# vim: syntax=make
