# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSSTAT) += sysstat

#
# Paths and names
#
SYSSTAT_VERSION	:= 9.0.3
SYSSTAT		:= sysstat-$(SYSSTAT_VERSION)
SYSSTAT_SUFFIX	:= tar.gz
SYSSTAT_URL	:= http://pagesperso-orange.fr/sebastien.godard/$(SYSSTAT).$(SYSSTAT_SUFFIX)
SYSSTAT_SOURCE	:= $(SRCDIR)/$(SYSSTAT).$(SYSSTAT_SUFFIX)
SYSSTAT_DIR	:= $(BUILDDIR)/$(SYSSTAT)
SYSSTAT_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SYSSTAT_SOURCE):
	@$(call targetinfo)
	@$(call get, SYSSTAT)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

SYSSTAT_PATH	:= PATH=$(CROSS_PATH)
SYSSTAT_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SYSSTAT_AUTOCONF := $(CROSS_AUTOCONF_USR)
SYSSTAT_MAKE_PAR := NO

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/sysstat.targetinstall:
	@$(call targetinfo)

	@$(call install_init, sysstat)
	@$(call install_fixup, sysstat,PACKAGE,sysstat)
	@$(call install_fixup, sysstat,PRIORITY,optional)
	@$(call install_fixup, sysstat,VERSION,$(SYSSTAT_VERSION))
	@$(call install_fixup, sysstat,SECTION,base)
	@$(call install_fixup, sysstat,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, sysstat,DEPENDS,)
	@$(call install_fixup, sysstat,DESCRIPTION,missing)

	@$(call install_copy, sysstat, 0, 0, 0755, /var/log/sa)

	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/iostat)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/mpstat)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/pidstat)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/sadf)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/bin/sar)

	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/lib/sa/sa1)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/lib/sa/sa2)
	@$(call install_copy, sysstat, 0, 0, 0755, -, /usr/lib/sa/sadc)

	@$(call install_finish, sysstat)

	@$(call touch)

# vim: syntax=make
