# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SCREEN) += screen

#
# Paths and names
#
SCREEN_VERSION	:= 4.0.2
SCREEN		:= screen-$(SCREEN_VERSION)
SCREEN_SUFFIX	:= tar.gz
SCREEN_URL	:= $(PTXCONF_SETUP_GNUMIRROR)/screen/$(SCREEN).$(SCREEN_SUFFIX)
SCREEN_SOURCE	:= $(SRCDIR)/$(SCREEN).$(SCREEN_SUFFIX)
SCREEN_DIR	:= $(BUILDDIR)/$(SCREEN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SCREEN_SOURCE):
	@$(call targetinfo)
	@$(call get, SCREEN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SCREEN_PATH	:= PATH=$(CROSS_PATH)
SCREEN_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SCREEN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-sys-screenrc=/etc/screenrc

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/screen.targetinstall:
	@$(call targetinfo)

	@$(call install_init, screen)
	@$(call install_fixup, screen,PRIORITY,optional)
	@$(call install_fixup, screen,SECTION,base)
	@$(call install_fixup, screen,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, screen,DESCRIPTION,missing)

	@$(call install_copy, screen, 0, 0, 0755, -, /usr/bin/screen)

ifdef PTXCONF_SCREEN_ETC_SCREENRC
	@$(call install_alternative, screen, 0, 0, 0644, /etc/screenrc, n)
endif

	@$(call install_finish, screen)

	@$(call touch)

# vim: syntax=make
