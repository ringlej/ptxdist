# -*-makefile-*-
#
# Copyright (C) 2006 by Luotao Fu <lfu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_APP_XRDB) += xorg-app-xrdb

#
# Paths and names
#
XORG_APP_XRDB_VERSION	:= 1.0.9
XORG_APP_XRDB_MD5	:= ed2e48cf33584455d74615ad4bbe4246
XORG_APP_XRDB		:= xrdb-$(XORG_APP_XRDB_VERSION)
XORG_APP_XRDB_SUFFIX	:= tar.bz2
XORG_APP_XRDB_URL	:= $(call ptx/mirror, XORG, individual/app/$(XORG_APP_XRDB).$(XORG_APP_XRDB_SUFFIX))
XORG_APP_XRDB_SOURCE	:= $(SRCDIR)/$(XORG_APP_XRDB).$(XORG_APP_XRDB_SUFFIX)
XORG_APP_XRDB_DIR	:= $(BUILDDIR)/$(XORG_APP_XRDB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
XORG_APP_XRDB_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-app-xrdb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, xorg-app-xrdb)
	@$(call install_fixup, xorg-app-xrdb,PRIORITY,optional)
	@$(call install_fixup, xorg-app-xrdb,SECTION,base)
	@$(call install_fixup, xorg-app-xrdb,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, xorg-app-xrdb,DESCRIPTION,missing)

	@$(call install_copy, xorg-app-xrdb, 0, 0, 0755, -, \
		$(XORG_PREFIX)/bin/xrdb)

	@$(call install_finish, xorg-app-xrdb)

	@$(call touch)

# vim: syntax=make
