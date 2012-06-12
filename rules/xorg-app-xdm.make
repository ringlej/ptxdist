# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XDM) += xorg-app-xdm

#
# Paths and names
#
XORG_APP_XDM_VERSION	:= 1.1.11
XORG_APP_XDM_MD5	:= 64a1af1f7eb69feae12e75d4cc3aaf19
XORG_APP_XDM		:= xdm-$(XORG_APP_XDM_VERSION)
XORG_APP_XDM_SUFFIX	:= tar.bz2
XORG_APP_XDM_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XDM).$(XORG_APP_XDM_SUFFIX))
XORG_APP_XDM_SOURCE	:= $(SRCDIR)/$(XORG_APP_XDM).$(XORG_APP_XDM_SUFFIX)
XORG_APP_XDM_DIR	:= $(BUILDDIR)/$(XORG_APP_XDM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XDM_BINCONFIG_GLOB := ""

#
# autoconf
#
XORG_APP_XDM_CONF_TOOL	:= autoconf
XORG_APP_XDM_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(XORG_OPTIONS_TRANS) \
	--$(call ptx/endis, PTXCONF_XORG_SERVER_OPT_SECURE_RPC)-secure-rpc \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR) \
	--enable-xpm-logos \
	--disable-xdmshell \
	--disable-xdm-auth \
	--without-pam \
	--without-selinux \
	--with-systemdsystemunitdir=/lib/systemd/system \
	--with-random-device=$(XORG_APP_XDM_DEV_RANDOM) \
	--with-utmp-file=/var/run/utmp \
	--with-wtmp-file=/var/log/wtmp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xdm.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xdm)
	@$(call install_fixup, xorg-app-xdm,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xdm,SECTION,base)
	@$(call install_fixup, xorg-app-xdm,AUTHOR,"Erwin Rol <ero@pengutronix.de>")
	@$(call install_fixup, xorg-app-xdm,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xdm, 0, 0, 0755, -, /usr/bin/xdm)

ifdef PTXCONF_XORG_APP_XDM_SYSTEMD_UNIT
	@$(call install_alternative, xorg-app-xdm, 0, 0, 0644, \
		/lib/systemd/system/xdm.service)
	@$(call install_link, xorg-app-xdm, ../xmd.service, \
		/lib/systemd/system/graphical.target.wants/xdm.service)
endif

	@$(call install_finish, xorg-app-xdm)

	@$(call touch)

# vim: syntax=make
