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
ZLIB_VERSION	:= 1.2.8
ZLIB_MD5	:= 28f1205d8dd2001f26fec1e8c2cebe37
ZLIB		:= zlib-$(ZLIB_VERSION)
ZLIB_SUFFIX	:= tar.xz
ZLIB_URL	:= \
	http://zlib.net/$(ZLIB).$(ZLIB_SUFFIX) \
	$(call ptx/mirror, SF, libpng/$(ZLIB).$(ZLIB_SUFFIX))
ZLIB_SOURCE	:= $(SRCDIR)/$(ZLIB).$(ZLIB_SUFFIX)
ZLIB_DIR	:= $(BUILDDIR)/$(ZLIB)
ZLIB_LICENSE	:= zlib

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ZLIB_CONF_ENV := \
	$(CROSS_ENV) \
	CROSS_PREFIX=$(PTXCONF_COMPILER_PREFIX)

#
# autoconf
#
ZLIB_CONF_TOOL := autoconf
ZLIB_CONF_OPT := \
	--prefix=/usr \
	--uname=Linux \
	$(call ptx/ifdef, PTXCONF_ZLIB_STATIC,--static) \
	--libdir=/usr/$(CROSS_LIB_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/zlib.targetinstall:
	@$(call targetinfo)

ifndef PTXCONF_ZLIB_STATIC
	@$(call install_init, zlib)
	@$(call install_fixup, zlib,PRIORITY,optional)
	@$(call install_fixup, zlib,SECTION,base)
	@$(call install_fixup, zlib,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, zlib,DESCRIPTION,missing)

	@$(call install_lib, zlib, 0, 0, 0644, libz)

	@$(call install_finish, zlib)
endif
	@$(call touch)

# vim: syntax=make
