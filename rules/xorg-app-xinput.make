# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XINPUT) += xorg-app-xinput

#
# Paths and names
#
XORG_APP_XINPUT_VERSION	:= 1.5.3
XORG_APP_XINPUT_MD5	:= 1e2f0ad4f3fa833b65c568907f171d28
XORG_APP_XINPUT		:= xinput-$(XORG_APP_XINPUT_VERSION)
XORG_APP_XINPUT_SUFFIX	:= tar.bz2
XORG_APP_XINPUT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XINPUT).$(XORG_APP_XINPUT_SUFFIX)
XORG_APP_XINPUT_SOURCE	:= $(SRCDIR)/$(XORG_APP_XINPUT).$(XORG_APP_XINPUT_SUFFIX)
XORG_APP_XINPUT_DIR	:= $(BUILDDIR)/$(XORG_APP_XINPUT)
XORG_APP_XINPUT_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XINPUT_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xinput.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  xorg-app-xinput)
	@$(call install_fixup, xorg-app-xinput,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xinput,SECTION,base)
	@$(call install_fixup, xorg-app-xinput,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, xorg-app-xinput,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xinput, 0, 0, 0755, -, /usr/bin/xinput)

	@$(call install_finish, xorg-app-xinput)

	@$(call touch)
