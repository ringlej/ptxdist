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
XORG_APP_XINIT_VERSION	:= 1.2.0
XORG_APP_XINIT		:= xinit-$(XORG_APP_XINIT_VERSION)
XORG_APP_XINIT_SUFFIX	:= tar.bz2
XORG_APP_XINIT_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/app/$(XORG_APP_XINIT).$(XORG_APP_XINIT_SUFFIX)
XORG_APP_XINIT_SOURCE	:= $(SRCDIR)/$(XORG_APP_XINIT).$(XORG_APP_XINIT_SUFFIX)
XORG_APP_XINIT_DIR	:= $(BUILDDIR)/$(XORG_APP_XINIT)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_APP_XINIT_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_APP_XINIT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XINIT_PATH	:=  PATH=$(CROSS_PATH)
XORG_APP_XINIT_ENV 	:=  $(CROSS_ENV)
XORG_APP_XINIT_MAKEVARS :=  XINITDIR=/etc/X11/xinit \
			RAWCPP=$(COMPILER_PREFIX)cpp
	#FIXME: damm ugly hack, should fix cpp check in configure instead

#
# autoconf
#
XORG_APP_XINIT_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

#
# if no value is given ignore the "--datadir" switch
#
ifneq ($(call remove_quotes,$(PTXCONF_XORG_DEFAULT_DATA_DIR)),)
	XORG_APP_XINIT_AUTOCONF += --datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)
endif
# startx and xinitrc shall use configfiles out of /etc/X11/xinit
XORG_APP_XINIT_AUTOCONF += --libdir=/etc

# what else is required?
#
# --with-xrdb=XRDB        Path to xrdb
# --with-xmodmap=XMODMAP  Path to xmodmap
# --with-twm=TWM          Path to twm
# --with-xclock=XCLOCK    Path to xclock
# --with-xterm=XTERM      Path to xterm
# --with-xserver=XSERVER  Path to default X server
# --with-xauth=XAUTH      Path to xauth
# --with-xinit=XINIT      Path to xinit
#

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xinit.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xinit)
	@$(call install_fixup,xorg-app-xinit,PACKAGE,xorg-app-xinit)
	@$(call install_fixup,xorg-app-xinit,PRIORITY,optional)
	@$(call install_fixup,xorg-app-xinit,VERSION,$(XORG_APP_XINIT_VERSION))
	@$(call install_fixup,xorg-app-xinit,SECTION,base)
	@$(call install_fixup,xorg-app-xinit,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,xorg-app-xinit,DEPENDS,)
	@$(call install_fixup,xorg-app-xinit,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xinit, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/xinit)
	@$(call install_copy, xorg-app-xinit, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/startx, n)

	@$(call install_finish,xorg-app-xinit)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-app-xinit_clean:
	rm -rf $(STATEDIR)/xorg-app-xinit.*
	rm -rf $(PKGDIR)/xorg-app-xinit_*
	rm -rf $(XORG_APP_XINIT_DIR)

# vim: syntax=make
