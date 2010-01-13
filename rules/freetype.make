# -*-makefile-*-
#
# Copyright (C) 2003-2006 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FREETYPE) += freetype

#
# Paths and names
#
FREETYPE_VERSION	:= 2.3.11
FREETYPE		:= freetype-$(FREETYPE_VERSION)
FREETYPE_SUFFIX		:= tar.bz2
FREETYPE_URL		:= http://download.savannah.gnu.org/releases/freetype/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_SOURCE		:= $(SRCDIR)/$(FREETYPE).$(FREETYPE_SUFFIX)
FREETYPE_DIR		:= $(BUILDDIR)/$(FREETYPE)
FREETYPE_LICENSE	:= BSD,GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(FREETYPE_SOURCE):
	@$(call targetinfo)
	@$(call get, FREETYPE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

FREETYPE_PATH	:= PATH=$(CROSS_PATH)
FREETYPE_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FREETYPE_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/freetype.targetinstall:
	@$(call targetinfo)

	@$(call install_init, freetype)
	@$(call install_fixup, freetype,PACKAGE,freetype)
	@$(call install_fixup, freetype,PRIORITY,optional)
	@$(call install_fixup, freetype,VERSION,$(FREETYPE_VERSION))
	@$(call install_fixup, freetype,SECTION,base)
	@$(call install_fixup, freetype,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, freetype,DEPENDS,)
	@$(call install_fixup, freetype,DESCRIPTION,missing)

	@$(call install_copy, freetype, 0, 0, 0644, -, /usr/lib/libfreetype.so.6.3.22)
	@$(call install_link, freetype, libfreetype.so.6.3.22, /usr/lib/libfreetype.so.6)
	@$(call install_link, freetype, libfreetype.so.6.3.22, /usr/lib/libfreetype.so)

	@$(call install_finish, freetype)

	@$(call touch)

# vim: syntax=make
