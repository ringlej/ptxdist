# -*-makefile-*-
#
# Copyright (C) 2002-2007 by Pengutronix e.K., Hildesheim, Germany
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
PACKAGES-$(PTXCONF_ZLIB) += zlib

#
# Paths and names
#
ZLIB_VERSION	:= 1.2.5
ZLIB		:= zlib-$(ZLIB_VERSION)
ZLIB_SUFFIX	:= tar.bz2
ZLIB_URL	:= http://zlib.net/$(ZLIB).$(ZLIB_SUFFIX)
ZLIB_SOURCE	:= $(SRCDIR)/$(ZLIB).$(ZLIB_SUFFIX)
ZLIB_DIR	:= $(BUILDDIR)/$(ZLIB)
ZLIB_LICENSE	:= zlib

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(ZLIB_SOURCE):
	@$(call targetinfo)
	@$(call get, ZLIB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ZLIB_CONF_ENV := \
	$(CROSS_ENV) \
	CROSS_PREFIX=$(PTXCONF_COMPILER_PREFIX) \
	CFLAGS="$(CROSS_CPPFLAGS) -O2 -g"

#
# autoconf
#
ZLIB_AUTOCONF := \
	--prefix=/usr

ifdef PTXCONF_ZLIB_STATIC
ZLIB_AUTOCONF += --static
endif


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/zlib.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_ZLIB_STATIC
	@$(call install_init, zlib)
	@$(call install_fixup, zlib,PACKAGE,zlib)
	@$(call install_fixup, zlib,PRIORITY,optional)
	@$(call install_fixup, zlib,VERSION,$(ZLIB_VERSION))
	@$(call install_fixup, zlib,SECTION,base)
	@$(call install_fixup, zlib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, zlib,DEPENDS,)
	@$(call install_fixup, zlib,DESCRIPTION,missing)

	@$(call install_copy, zlib, 0, 0, 0644, -, \
		/usr/lib/libz.so.1.2.5)
	@$(call install_link, zlib, libz.so.1.2.5, /usr/lib/libz.so.1)
	@$(call install_link, zlib, libz.so.1.2.5, /usr/lib/libz.so)

	@$(call install_finish, zlib)
endif
	@$(call touch)

# vim: syntax=make
