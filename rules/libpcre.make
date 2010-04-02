# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2008, 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPCRE) += libpcre

#
# Paths and names
#
LIBPCRE_VERSION	:= 8.00
LIBPCRE		:= pcre-$(LIBPCRE_VERSION)
LIBPCRE_SUFFIX	:= tar.bz2
LIBPCRE_URL	:= $(PTXCONF_SETUP_SFMIRROR)/pcre/$(LIBPCRE).$(LIBPCRE_SUFFIX)
LIBPCRE_SOURCE	:= $(SRCDIR)/$(LIBPCRE).$(LIBPCRE_SUFFIX)
LIBPCRE_DIR	:= $(BUILDDIR)/$(LIBPCRE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBPCRE_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBPCRE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBPCRE_PATH	:= PATH=$(CROSS_PATH)
LIBPCRE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBPCRE_AUTOCONF := $(CROSS_AUTOCONF_USR)

ifdef PTXCONF_LIBPCRE_ENABLE_NEWLINE_IS_ANYCRLF
LIBPCRE_AUTOCONF += --enable-newline-is-anycrlf
endif

ifdef PTXCONF_LIBPCRE_ENABLE_PCREGREP_LIBZ
LIBPCRE_AUTOCONF += --enable-pcregrep-libz
else
LIBPCRE_AUTOCONF += --disable-pcregrep-libz
endif

ifdef PTXCONF_LIBPCRE_ENABLE_UTF8
LIBPCRE_AUTOCONF += --enable-utf8
else
LIBPCRE_AUTOCONF += --disable-utf8
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libpcre.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libpcre)
	@$(call install_fixup, libpcre,PACKAGE,libpcre)
	@$(call install_fixup, libpcre,PRIORITY,optional)
	@$(call install_fixup, libpcre,VERSION,$(LIBPCRE_VERSION))
	@$(call install_fixup, libpcre,SECTION,base)
	@$(call install_fixup, libpcre,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libpcre,DEPENDS,)
	@$(call install_fixup, libpcre,DESCRIPTION,missing)

	@$(call install_copy, libpcre, 0, 0, 0644, -, /usr/lib/libpcre.so.0.0.1)
	@$(call install_link, libpcre, libpcre.so.0.0.1, /usr/lib/libpcre.so.0)
	@$(call install_link, libpcre, libpcre.so.0.0.1, /usr/lib/libpcre.so)

ifdef PTXCONF_LIBPCRE_LIBPCREPOSIX
	@$(call install_copy, libpcre, 0, 0, 0644, -, /usr/lib/libpcreposix.so.0.0.0)
	@$(call install_link, libpcre, libpcreposix.so.0.0.0, /usr/lib/libpcreposix.so.0)
	@$(call install_link, libpcre, libpcreposix.so.0.0.0, /usr/lib/libpcreposix.so)
endif

ifdef PTXCONF_LIBPCRE_LIBPCRECPP
	@$(call install_copy, libpcre, 0, 0, 0644, -, /usr/lib/libpcrecpp.so.0.0.0)
	@$(call install_link, libpcre, libpcrecpp.so.0.0.0, /usr/lib/libpcrecpp.so.0)
	@$(call install_link, libpcre, libpcrecpp.so.0.0.0, /usr/lib/libpcrecpp.so)
endif

	@$(call install_finish, libpcre)

	@$(call touch)

# vim: syntax=make
