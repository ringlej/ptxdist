# -*-makefile-*-
#
# Copyright (C) 2008 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SDPARM) += sdparm

#
# Paths and names
#
SDPARM_VERSION	:= 1.04
SDPARM		:= sdparm-$(SDPARM_VERSION)
SDPARM_SUFFIX	:= tgz
SDPARM_URL	:= http://sg.danny.cz/sg/p/$(SDPARM).$(SDPARM_SUFFIX)
SDPARM_SOURCE	:= $(SRCDIR)/$(SDPARM).$(SDPARM_SUFFIX)
SDPARM_DIR	:= $(BUILDDIR)/$(SDPARM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SDPARM_SOURCE):
	@$(call targetinfo)
	@$(call get, SDPARM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SDPARM_PATH	:= PATH=$(CROSS_PATH)
SDPARM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SDPARM_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sdparm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sdparm)
	@$(call install_fixup, sdparm,PRIORITY,optional)
	@$(call install_fixup, sdparm,SECTION,base)
	@$(call install_fixup, sdparm,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, sdparm,DESCRIPTION,missing)

	@$(call install_copy, sdparm, 0, 0, 0755, -, /usr/bin/sdparm)

	@$(call install_finish, sdparm)

	@$(call touch)

# vim: syntax=make
