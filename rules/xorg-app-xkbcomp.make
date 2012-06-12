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
PACKAGES-$(PTXCONF_XORG_APP_XKBCOMP) += xorg-app-xkbcomp

#
# Paths and names
#
XORG_APP_XKBCOMP_VERSION	:= 1.2.4
XORG_APP_XKBCOMP_MD5		:= a0fc1ac3fc4fe479ade09674347c5aa0
XORG_APP_XKBCOMP		:= xkbcomp-$(XORG_APP_XKBCOMP_VERSION)
XORG_APP_XKBCOMP_SUFFIX		:= tar.bz2
XORG_APP_XKBCOMP_URL		:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XKBCOMP).$(XORG_APP_XKBCOMP_SUFFIX))
XORG_APP_XKBCOMP_SOURCE		:= $(SRCDIR)/$(XORG_APP_XKBCOMP).$(XORG_APP_XKBCOMP_SUFFIX)
XORG_APP_XKBCOMP_DIR		:= $(BUILDDIR)/$(XORG_APP_XKBCOMP)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_APP_XKBCOMP_CON_ENV := \
	$(CROSS_ENV) \
	ac_cv_file_$(call tr_sh,./xkbparse.c)=yes

#
# autoconf
#
XORG_APP_XKBCOMP_CONF_TOOL	:= autoconf
XORG_APP_XKBCOMP_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xkbcomp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xkbcomp)
	@$(call install_fixup, xorg-app-xkbcomp,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xkbcomp,SECTION,base)
	@$(call install_fixup, xorg-app-xkbcomp,AUTHOR,"Juergen Beisert")
	@$(call install_fixup, xorg-app-xkbcomp,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xkbcomp,  0, 0, 0755, -, \
		/usr/bin/xkbcomp)

	@$(call install_finish, xorg-app-xkbcomp)

	@$(call touch)

# vim: syntax=make
