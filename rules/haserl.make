# -*-makefile-*-
#
# Copyright (C) 2007 by University of Illinois
#               2010 Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_HASERL) += haserl

#
# Paths and names
#
HASERL_VERSION	:= 0.9.21
HASERL		:= haserl-$(HASERL_VERSION)
HASERL_SUFFIX	:= tar.gz
HASERL_URL	:= $(PTXCONF_SETUP_SFMIRROR)/haserl/$(HASERL).$(HASERL_SUFFIX)
HASERL_SOURCE	:= $(SRCDIR)/$(HASERL).$(HASERL_SUFFIX)
HASERL_DIR	:= $(BUILDDIR)/$(HASERL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HASERL_SOURCE):
	@$(call targetinfo)
	@$(call get, HASERL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HASERL_PATH	:= PATH=$(CROSS_PATH)
HASERL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
HASERL_AUTOCONF = $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/haserl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, haserl)
	@$(call install_fixup,haserl,PACKAGE,haserl)
	@$(call install_fixup,haserl,PRIORITY,optional)
	@$(call install_fixup,haserl,VERSION,$(HASERL_VERSION))
	@$(call install_fixup,haserl,SECTION,base)
	@$(call install_fixup,haserl,AUTHOR,"N. Angelacos; PTXDist rule: Tom St")
	@$(call install_fixup,haserl,DEPENDS,)
	@$(call install_fixup,haserl,DESCRIPTION,missing)

	@$(call install_copy, haserl, 0, 0, 0755, -, /usr/bin/haserl)

	@$(call install_finish,haserl)

	@$(call touch)

# vim: syntax=make

