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

#
# We provide this package
#
PACKAGES-$(PTXCONF_HRTIMERS_SUPPORT) += hrtimers-support

#
# Paths and names
#
HRTIMERS_SUPPORT_VERSION	:= 3.1.1
HRTIMERS_SUPPORT		:= hrtimers-support-$(HRTIMERS_SUPPORT_VERSION)
HRTIMERS_SUPPORT_SUFFIX		:= tar.bz2
HRTIMERS_SUPPORT_URL		:= $(PTXCONF_SETUP_SFMIRROR)/high-res-timers/$(HRTIMERS_SUPPORT).$(HRTIMERS_SUPPORT_SUFFIX)
HRTIMERS_SUPPORT_SOURCE		:= $(SRCDIR)/$(HRTIMERS_SUPPORT).$(HRTIMERS_SUPPORT_SUFFIX)
HRTIMERS_SUPPORT_DIR		:= $(BUILDDIR)/$(HRTIMERS_SUPPORT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HRTIMERS_SUPPORT_SOURCE):
	@$(call targetinfo)
	@$(call get, HRTIMERS_SUPPORT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HRTIMERS_SUPPORT_PATH	:= PATH=$(CROSS_PATH)
HRTIMERS_SUPPORT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
HRTIMERS_SUPPORT_AUTOCONF :=  $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hrtimers-support.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hrtimers-support)
	@$(call install_fixup, hrtimers-support,PACKAGE,hrtimers-support)
	@$(call install_fixup, hrtimers-support,PRIORITY,optional)
	@$(call install_fixup, hrtimers-support,VERSION,$(HRTIMERS_SUPPORT_VERSION))
	@$(call install_fixup, hrtimers-support,SECTION,base)
	@$(call install_fixup, hrtimers-support,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, hrtimers-support,DEPENDS,)
	@$(call install_fixup, hrtimers-support,DESCRIPTION,missing)

	@$(call install_copy, hrtimers-support, 0, 0, 0644, -, \
		/usr/lib/libposix-time.so.1.0.0)

	@$(call install_link, hrtimers-support, \
		libposix-time.so.1.0.0, \
		/usr/lib/libposix-time.so.1)

	@$(call install_link, hrtimers-support, \
		libposix-time.so.1.0.0, \
		/usr/lib/libposix-time.so)

	@$(call install_finish, hrtimers-support)

	@$(call touch)

# vim: syntax=make
