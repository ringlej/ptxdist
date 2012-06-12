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
PACKAGES-$(PTXCONF_XORG_APP_XINIT) += xorg-app-xinit

#
# Paths and names
#
XORG_APP_XINIT_VERSION	:= 1.3.2
XORG_APP_XINIT_MD5	:= 9c0943cbd83e489ad1b05221b97efd44
XORG_APP_XINIT		:= xinit-$(XORG_APP_XINIT_VERSION)
XORG_APP_XINIT_SUFFIX	:= tar.bz2
XORG_APP_XINIT_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XINIT).$(XORG_APP_XINIT_SUFFIX))
XORG_APP_XINIT_SOURCE	:= $(SRCDIR)/$(XORG_APP_XINIT).$(XORG_APP_XINIT_SUFFIX)
XORG_APP_XINIT_DIR	:= $(BUILDDIR)/$(XORG_APP_XINIT)


# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XINIT_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_RAWCPP=$(COMPILER_PREFIX)cpp \
	ac_cv_path_MCOOKIE=/usr/bin/mcookie

#
# autoconf
#
XORG_APP_XINIT_CONF_TOOL := autoconf
XORG_APP_XINIT_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-xinitdir=/etc/X11/xinit \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xinit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xinit)
	@$(call install_fixup, xorg-app-xinit,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xinit,SECTION,base)
	@$(call install_fixup, xorg-app-xinit,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-xinit,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xinit, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/xinit)

ifdef PTXCONF_XORG_APP_XINIT_STARTX
	@$(call install_copy, xorg-app-xinit, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/startx, n)
endif

	@$(call install_finish, xorg-app-xinit)

	@$(call touch)

# vim: syntax=make
