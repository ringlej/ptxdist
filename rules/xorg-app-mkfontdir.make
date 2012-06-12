# -*-makefile-*-
#
# Copyright (C) 2006 by Sascha Hauer
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
PACKAGES-$(PTXCONF_XORG_APP_MKFONTDIR) += xorg-app-mkfontdir

#
# Paths and names
#
XORG_APP_MKFONTDIR_VERSION	:= 1.0.7
XORG_APP_MKFONTDIR_MD5		:= 18c429148c96c2079edda922a2b67632
XORG_APP_MKFONTDIR		:= mkfontdir-$(XORG_APP_MKFONTDIR_VERSION)
XORG_APP_MKFONTDIR_SUFFIX	:= tar.bz2
XORG_APP_MKFONTDIR_URL		:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_MKFONTDIR).$(XORG_APP_MKFONTDIR_SUFFIX))
XORG_APP_MKFONTDIR_SOURCE	:= $(SRCDIR)/$(XORG_APP_MKFONTDIR).$(XORG_APP_MKFONTDIR_SUFFIX)
XORG_APP_MKFONTDIR_DIR		:= $(BUILDDIR)/$(XORG_APP_MKFONTDIR)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_MKFONTDIR_CONF_TOOL	:= autoconf
XORG_APP_MKFONTDIR_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--datadir=$(PTXCONF_XORG_DEFAULT_DATA_DIR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-mkfontdir.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-mkfontdir)
	@$(call install_fixup, xorg-app-mkfontdir,PRIORITY,optional)
	@$(call install_fixup, xorg-app-mkfontdir,SECTION,base)
	@$(call install_fixup, xorg-app-mkfontdir,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-mkfontdir,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-mkfontdir, 0, 0, 0755, -, \
		/usr/bin/mkfontdir, n)

	@$(call install_finish, xorg-app-mkfontdir)

	@$(call touch)

# vim: syntax=make
