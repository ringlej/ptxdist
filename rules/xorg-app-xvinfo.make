# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
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
PACKAGES-$(PTXCONF_XORG_APP_XVINFO) += xorg-app-xvinfo

#
# Paths and names
#
XORG_APP_XVINFO_VERSION	:= 1.1.1
XORG_APP_XVINFO		:= xvinfo-$(XORG_APP_XVINFO_VERSION)
XORG_APP_XVINFO_SUFFIX	:= tar.bz2
XORG_APP_XVINFO_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XVINFO).$(XORG_APP_XVINFO_SUFFIX)
XORG_APP_XVINFO_SOURCE	:= $(SRCDIR)/$(XORG_APP_XVINFO).$(XORG_APP_XVINFO_SUFFIX)
XORG_APP_XVINFO_DIR	:= $(BUILDDIR)/$(XORG_APP_XVINFO)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XVINFO_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XVINFO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XVINFO_PATH	:= PATH=$(CROSS_PATH)
XORG_APP_XVINFO_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_APP_XVINFO_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xvinfo.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xvinfo)
	@$(call install_fixup, xorg-app-xvinfo,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xvinfo,SECTION,base)
	@$(call install_fixup, xorg-app-xvinfo,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-xvinfo,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xvinfo, 0, 0, 0755, -, \
		$(XORG_BINDIR)/xvinfo)

	@$(call install_finish, xorg-app-xvinfo)

	@$(call touch)

# vim: syntax=make
