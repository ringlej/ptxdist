# -*-makefile-*-
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#               2007, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_EXPAT) += expat

#
# Paths and names
#
EXPAT_VERSION	:= 2.0.1
EXPAT_MD5	:= e4b08e8477e1dccb56b95078c6d6ff88
EXPAT		:= expat-$(EXPAT_VERSION)
# Note: repackaged tar.bz2 as tar.gz seems broken.
EXPAT_SUFFIX	:= tar.bz2
EXPAT_URL	:= http://www.pengutronix.de/software/ptxdist/temporary-src/$(EXPAT).$(EXPAT_SUFFIX)
EXPAT_SOURCE	:= $(SRCDIR)/$(EXPAT).$(EXPAT_SUFFIX)
EXPAT_DIR	:= $(BUILDDIR)/$(EXPAT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(EXPAT_SOURCE):
	@$(call targetinfo)
	@$(call get, EXPAT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

EXPAT_PATH	:= PATH=$(CROSS_PATH)
EXPAT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
EXPAT_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/expat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, expat)
	@$(call install_fixup, expat,PRIORITY,optional)
	@$(call install_fixup, expat,SECTION,base)
	@$(call install_fixup, expat,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, expat,DESCRIPTION,missing)

	@$(call install_lib, expat, 0, 0, 0644, libexpat)

	@$(call install_finish, expat)

	@$(call touch)

# vim: syntax=make
