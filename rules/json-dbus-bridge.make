# -*-makefile-*-
#
# Copyright (C) 2010 by Tim Sander <tim.sander@hbm.com>
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
PACKAGES-$(PTXCONF_JSON_DBUS_BRIDGE) += json-dbus-bridge

#
# Paths and names
#
JSON_DBUS_BRIDGE_VERSION	:= 1.0.0
JSON_DBUS_BRIDGE_MD5		:= ac1d4a909e148cbf6fb5c7829bd5332d
JSON_DBUS_BRIDGE		:= json-dbus-bridge-$(JSON_DBUS_BRIDGE_VERSION)
JSON_DBUS_BRIDGE_SUFFIX		:= tar.bz2
JSON_DBUS_BRIDGE_URL		:= http://www.pengutronix.de/software/json-dbus-bridge/download/$(JSON_DBUS_BRIDGE).$(JSON_DBUS_BRIDGE_SUFFIX)
JSON_DBUS_BRIDGE_SOURCE		:= $(SRCDIR)/$(JSON_DBUS_BRIDGE).$(JSON_DBUS_BRIDGE_SUFFIX)
JSON_DBUS_BRIDGE_DIR		:= $(BUILDDIR)/$(JSON_DBUS_BRIDGE)
JSON_DBUS_BRIDGE_LICENSE	:= LGPLv2.1+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(JSON_DBUS_BRIDGE_SOURCE):
	@$(call targetinfo)
	@$(call get, JSON_DBUS_BRIDGE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
JSON_DBUS_BRIDGE_CONF_TOOL	:= autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/json-dbus-bridge.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  json-dbus-bridge)
	@$(call install_fixup, json-dbus-bridge,PRIORITY,optional)
	@$(call install_fixup, json-dbus-bridge,SECTION,base)
	@$(call install_fixup, json-dbus-bridge,AUTHOR,"Tim Sander <tim.sander@hbm.com>")
	@$(call install_fixup, json-dbus-bridge,DESCRIPTION,missing)

	@$(call install_copy, json-dbus-bridge, 0, 0, 0755, -, /usr/bin/json-dbus-bridge)

	@$(call install_finish, json-dbus-bridge)

	@$(call touch)

# vim: syntax=make
