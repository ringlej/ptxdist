# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DCONF) += dconf

#
# Paths and names
#
DCONF_VERSION	:= 0.3.1
DCONF		:= dconf-$(DCONF_VERSION)
DCONF_SUFFIX	:= tar.bz2
DCONF_URL	:= http://download.gnome.org/sources/dconf/0.3/$(DCONF).$(DCONF_SUFFIX)
DCONF_SOURCE	:= $(SRCDIR)/$(DCONF).$(DCONF_SUFFIX)
DCONF_DIR	:= $(BUILDDIR)/$(DCONF)
DCONF_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DCONF_SOURCE):
	@$(call targetinfo)
	@$(call get, DCONF)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DCONF_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dconf.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  dconf)
	@$(call install_fixup, dconf,PACKAGE,dconf)
	@$(call install_fixup, dconf,PRIORITY,optional)
	@$(call install_fixup, dconf,VERSION,$(DCONF_VERSION))
	@$(call install_fixup, dconf,SECTION,base)
	@$(call install_fixup, dconf,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dconf,DEPENDS,)
	@$(call install_fixup, dconf,DESCRIPTION,missing)

	@$(call install_copy, dconf, 0, 0, 0644, -, /usr/lib/gio/modules/libdconfsettings.so)
	@$(call install_lib,  dconf, 0, 0, 0644, libdconf)

	@$(call install_copy, dconf, 0, 0, 0755, -, /usr/libexec/dconf-service)
	@$(call install_copy, dconf, 0, 0, 0755, -, /usr/bin/dconf)

	@$(call install_copy, dconf, 0, 0, 0644, -, /usr/share/dbus-1/services/ca.desrt.dconf.service)
	@$(call install_copy, dconf, 0, 0, 0644, -, /usr/share/dbus-1/system-services/ca.desrt.dconf.service)

	@$(call install_finish, dconf)

	@$(call touch)

# vim: syntax=make
