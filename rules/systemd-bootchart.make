# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSTEMD_BOOTCHART) += systemd-bootchart

#
# Paths and names
#
SYSTEMD_BOOTCHART_VERSION	:= 233
SYSTEMD_BOOTCHART_MD5		:= fbe3fa306d4d0066301b9deadafbd157
SYSTEMD_BOOTCHART		:= systemd-bootchart-$(SYSTEMD_BOOTCHART_VERSION)
SYSTEMD_BOOTCHART_SUFFIX	:= tar.xz
SYSTEMD_BOOTCHART_URL		:= https://github.com/systemd/systemd-bootchart/releases/download/v$(SYSTEMD_BOOTCHART_VERSION)/$(SYSTEMD_BOOTCHART).$(SYSTEMD_BOOTCHART_SUFFIX)
SYSTEMD_BOOTCHART_SOURCE	:= $(SRCDIR)/$(SYSTEMD_BOOTCHART).$(SYSTEMD_BOOTCHART_SUFFIX)
SYSTEMD_BOOTCHART_DIR		:= $(BUILDDIR)/$(SYSTEMD_BOOTCHART)
SYSTEMD_BOOTCHART_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-only
SYSTEMD_BOOTCHART_LICENSE_FILES := \
	file://LICENSE.GPL2;md5=751419260aa954499f7abaabaa882bbe \
	file://LICENSE.LGPL2.1;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SYSTEMD_BOOTCHART_CONF_TOOL	:= autoconf
SYSTEMD_BOOTCHART_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-man

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/systemd-bootchart.targetinstall:
	@$(call targetinfo)

	@$(call install_init, systemd-bootchart)
	@$(call install_fixup, systemd-bootchart,PRIORITY,optional)
	@$(call install_fixup, systemd-bootchart,SECTION,base)
	@$(call install_fixup, systemd-bootchart,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, systemd-bootchart,DESCRIPTION,missing)

	@$(call install_copy, systemd-bootchart, 0, 0, 0755, -, \
		/usr/lib/systemd/systemd-bootchart)
	@$(call install_alternative, systemd-bootchart, 0, 0, 0644, \
		/etc/systemd/bootchart.conf)

	@$(call install_copy, systemd-bootchart, 0, 0, 0644, -, \
		/usr/lib/systemd/system/systemd-bootchart.service)

	@$(call install_finish, systemd-bootchart)

	@$(call touch)

# vim: syntax=make
