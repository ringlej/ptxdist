# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XERCES) += xerces

#
# Paths and names
#
XERCES_VERSION	:= 2_7_0
XERCES		:= xerces-c-src_$(XERCES_VERSION)
XERCES_SUFFIX	:= tar.gz
XERCES_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(XERCES).$(XERCES_SUFFIX)
XERCES_SOURCE	:= $(SRCDIR)/$(XERCES).$(XERCES_SUFFIX)
XERCES_DIR	:= $(BUILDDIR)/$(XERCES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XERCES_SOURCE):
	@$(call targetinfo)
	@$(call get, XERCES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XERCES_PATH	:= PATH=$(CROSS_PATH)
XERCES_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
XERCES_AUTOCONF	:= $(CROSS_AUTOCONF_USR)

XERCES_SUBDIR	:= src/xercesc

XERCES_MAKE_ENV	:= XERCESCROOT=$(XERCES_DIR)
XERCES_MAKE_OPT	:= SYSROOT=$(SYSROOT)
XERCES_MAKE_PAR	:= NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xerces.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xerces)
	@$(call install_fixup, xerces,PRIORITY,optional)
	@$(call install_fixup, xerces,SECTION,base)
	@$(call install_fixup, xerces,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xerces,DESCRIPTION,missing)

	@$(call install_copy, xerces, 0, 0, 0644, -, \
		/usr/lib/libxerces-c.so.27.0)

	@$(call install_link, xerces, libxerces-c.so.27.0, \
		/usr/lib/libxerces-c.so.27)
	@$(call install_link, xerces, libxerces-c.so.27, \
		/usr/lib/libxerces-c.so)

	@$(call install_finish, xerces)

	@$(call touch)

# vim: syntax=make
