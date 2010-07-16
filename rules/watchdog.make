# -*-makefile-*-
#
# Copyright (C) 2010 by Jon Ringle
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WATCHDOG) += watchdog

#
# Paths and names
#
WATCHDOG_VERSION	:= 5.7
WATCHDOG		:= watchdog-$(WATCHDOG_VERSION)
WATCHDOG_SUFFIX		:= tar.gz
WATCHDOG_URL		:= $(PTXCONF_SETUP_SFMIRROR)/watchdog/$(WATCHDOG).$(WATCHDOG_SUFFIX)
WATCHDOG_SOURCE		:= $(SRCDIR)/$(WATCHDOG).$(WATCHDOG_SUFFIX)
WATCHDOG_DIR		:= $(BUILDDIR)/$(WATCHDOG)
WATCHDOG_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(WATCHDOG_SOURCE):
	@$(call targetinfo)
	@$(call get, WATCHDOG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WATCHDOG_CONF_TOOL := autoconf

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/watchdog.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  watchdog)
	@$(call install_fixup, watchdog,PRIORITY,optional)
	@$(call install_fixup, watchdog,SECTION,base)
	@$(call install_fixup, watchdog,AUTHOR,"Jon Ringle")
	@$(call install_fixup, watchdog,DESCRIPTION,missing)

	@$(call install_alternative, watchdog, 0, 0, 0644, /etc/watchdog.conf)
	@$(call install_copy, watchdog, 0, 0, 0755, -, /usr/sbin/watchdog)

	@$(call install_finish, watchdog)

	@$(call touch)

# vim: syntax=make
