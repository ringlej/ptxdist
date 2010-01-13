# -*-makefile-*-
#
# Copyright (C) 2003 by Robert Schwebel
#               2008 by Wolfram Sang, Pengutronix e.K.
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
PACKAGES-$(PTXCONF_BING) += bing

#
# Paths and names
#
BING_VERSION	:= 1.1.3
BING		:= bing_src-$(BING_VERSION)
BING_SUFFIX	:= tar.gz
BING_URL	:= http://fgouget.free.fr/bing/$(BING).$(BING_SUFFIX)
BING_SOURCE	:= $(SRCDIR)/$(BING).$(BING_SUFFIX)
BING_DIR	:= $(BUILDDIR)/$(BING)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(BING_SOURCE):
	@$(call targetinfo)
	@$(call get, BING)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

BING_PATH	:= PATH=$(CROSS_PATH)
BING_ENV 	:= $(CROSS_ENV)

BING_MAKEVARS	:= $(CROSS_ENV_CC)

$(STATEDIR)/bing.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/bing.targetinstall:
	@$(call targetinfo)

	@$(call install_init, bing)
	@$(call install_fixup, bing,PACKAGE,bing)
	@$(call install_fixup, bing,PRIORITY,optional)
	@$(call install_fixup, bing,VERSION,$(BING_VERSION))
	@$(call install_fixup, bing,SECTION,base)
	@$(call install_fixup, bing,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, bing,DEPENDS,)
	@$(call install_fixup, bing,DESCRIPTION,missing)
	@$(call install_copy, bing, 0, 0, 0755, -, /usr/sbin/bing)
	@$(call install_finish, bing)

	@$(call touch)

# vim: syntax=make
