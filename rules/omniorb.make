# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: ipkgize

#
# We provide this package
#
PACKAGES-$(PTXCONF_OMNIORB) += omniorb

#
# Paths and names
#
OMNIORB_VERSION		:= 4.0.5
OMNIORB			:= omniORB-$(OMNIORB_VERSION)
OMNIORB_SUFFIX		:= tar.gz
OMNIORB_URL		:= $(PTXCONF_SETUP_SFMIRROR)/omniorb/$(OMNIORB).$(OMNIORB_SUFFIX)
OMNIORB_SOURCE		:= $(SRCDIR)/$(OMNIORB).$(OMNIORB_SUFFIX)
OMNIORB_DIR		:= $(BUILDDIR)/$(OMNIORB)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(OMNIORB_SOURCE):
	@$(call targetinfo)
	@$(call get, OMNIORB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OMNIORB_PATH	:= PATH=$(CROSS_PATH)
OMNIORB_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
OMNIORB_AUTOCONF := $(CROSS_AUTOCONF_USR)
ifdef PTXCONF_OMNIORB_SSL
OMNIORB_AUTOCONF += --with-ssl
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/omniorb.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
