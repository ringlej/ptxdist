# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
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
PACKAGES-$(PTXCONF_LIBPV) += libpv

#
# Paths and names
#
LIBPV_VERSION	= 1.4.0
LIBPV		= libpv-$(LIBPV_VERSION)
LIBPV_SUFFIX	= tar.bz2
LIBPV_URL	= http://www.pengutronix.de/software/libpv/download/$(LIBPV).$(LIBPV_SUFFIX)
LIBPV_SOURCE	= $(SRCDIR)/$(LIBPV).$(LIBPV_SUFFIX)
LIBPV_DIR	= $(BUILDDIR)/$(LIBPV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBPV_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBPV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPV_PATH	:= PATH=$(CROSS_PATH)
LIBPV_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPV_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--disable-debug

ifdef PTXCONF_LIBPV_EVENT
LIBPV_AUTOCONF += --enable-event
else
LIBPV_AUTOCONF += --disable-event
endif

ifdef PTXCONF_LIBPV_PYTHON
LIBPV_AUTOCONF += --enable-python
else
LIBPV_AUTOCONF += --disable-python
endif

ifdef PTXCONF_LIBPV_XML_EXPAT
LIBPV_AUTOCONF += --with-expat
else
LIBPV_AUTOCONF += --without-expat
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpv.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpv)
	@$(call install_fixup, libpv,PACKAGE,libpv)
	@$(call install_fixup, libpv,PRIORITY,optional)
	@$(call install_fixup, libpv,VERSION,$(LIBPV_VERSION))
	@$(call install_fixup, libpv,SECTION,base)
	@$(call install_fixup, libpv,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libpv,DEPENDS,)
	@$(call install_fixup, libpv,DESCRIPTION,missing)

ifdef PTXCONF_LIBPV_PVTOOL
	@$(call install_copy, libpv, 0, 0, 0755, -, \
		/usr/bin/pvtool)
endif

	@$(call install_copy, libpv, 0, 0, 0644, - , \
		/usr/lib/libpv.so.12.0.0)
	@$(call install_link, libpv, libpv.so.12.0.0, /usr/lib/libpv.so.12)
	@$(call install_link, libpv, libpv.so.12.0.0, /usr/lib/libpv.so)

ifdef PTXCONF_LIBPV_PYTHON
	@$(call install_copy, libpv, 0, 0, 0644, -, \
		/usr/lib/python$(PYTHON_MAJORMINOR)/site-packages/libpv.so)
endif

	@$(call install_finish, libpv)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpv_clean:
	rm -rf $(STATEDIR)/libpv.*
	rm -rf $(PKGDIR)/libpv_*
	rm -rf $(LIBPV_DIR)

# vim: syntax=make
