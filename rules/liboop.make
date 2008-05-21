# -*-makefile-*-
# $Id: template-make 8008 2008-04-15 07:39:46Z mkl $
#
# Copyright (C) 2008 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBOOP) += liboop

#
# Paths and names
#
LIBOOP_VERSION	:= 1.0
LIBOOP		:= liboop-$(LIBOOP_VERSION)
LIBOOP_SUFFIX	:= tar.bz2
LIBOOP_URL	:= http://download.ofb.net/liboop/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_SOURCE	:= $(SRCDIR)/$(LIBOOP).$(LIBOOP_SUFFIX)
LIBOOP_DIR	:= $(BUILDDIR)/$(LIBOOP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBOOP_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBOOP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBOOP_PATH	:= PATH=$(CROSS_PATH)
LIBOOP_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBOOP_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/liboop.targetinstall:
	@$(call targetinfo)
# only static libs for now
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

liboop_clean:
	rm -rf $(STATEDIR)/liboop.*
	rm -rf $(IMAGEDIR)/liboop_*
	rm -rf $(LIBOOP_DIR)

# vim: syntax=make
