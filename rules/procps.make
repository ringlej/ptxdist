# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation, by Milan Bobde
#		2007 by Pengutronix e.K.
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PROCPS) += procps

#
# Paths and names
#
PROCPS_VERSION	:= 3.2.8
PROCPS		:= procps-$(PROCPS_VERSION)
PROCPS_SUFFIX	:= tar.gz
PROCPS_URL	:= http://procps.sourceforge.net/$(PROCPS).$(PROCPS_SUFFIX)
PROCPS_SOURCE	:= $(SRCDIR)/$(PROCPS).$(PROCPS_SUFFIX)
PROCPS_DIR	:= $(BUILDDIR)/$(PROCPS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PROCPS_SOURCE):
	@$(call targetinfo)
	@$(call get, PROCPS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# build only the required parts
PROCPS_ALL-$(PTXCONF_PROCPS_TOP)	+= $(SYSROOT)/usr/bin/top
PROCPS_ALL-$(PTXCONF_PROCPS_SLABTOP)	+= $(SYSROOT)/usr/bin/slabtop
PROCPS_ALL-$(PTXCONF_PROCPS_SYSCTL)	+= $(SYSROOT)/sbin/sysctl
PROCPS_ALL-$(PTXCONF_PROCPS_PS)		+= $(SYSROOT)/bin/ps
PROCPS_ALL-$(PTXCONF_PROCPS_W)		+= $(SYSROOT)/usr/bin/w
PROCPS_ALL-$(PTXCONF_PROCPS_PGREP)	+= $(SYSROOT)/usr/bin/pgrep

PROCPS_PATH	:= PATH=$(CROSS_PATH)
PROCPS_MAKEVARS	:= \
	CC="$(CROSS_CC)" \
	CFLAGS=-O2 \
	CPPFLAGS='$(CROSS_CPPFLAGS)' \
	LDFLAGS='$(CROSS_LDFLAGS)' \
	lib64=lib \
	ldconfig=true \
	MANFILES="" \
	BINFILES="$(PROCPS_ALL-y)"

$(STATEDIR)/procps.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/procps.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/procps.targetinstall:
	@$(call targetinfo)

	@$(call install_init, procps)
	@$(call install_fixup, procps,PACKAGE,procps)
	@$(call install_fixup, procps,PRIORITY,optional)
	@$(call install_fixup, procps,VERSION,$(PROCPS_VERSION))
	@$(call install_fixup, procps,SECTION,base)
	@$(call install_fixup, procps,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, procps,DEPENDS,)
	@$(call install_fixup, procps,DESCRIPTION,missing)

	@$(call install_copy, procps, 0, 0, 0644, \
		$(PROCPS_DIR)/proc/libproc-3.2.8.so, /lib/libproc-3.2.8.so)

ifdef PTXCONF_PROCPS_TOP
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_DIR)/top, \
		/usr/bin/top)
endif
ifdef PTXCONF_PROCPS_SLABTOP
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_DIR)/slabtop, \
		/usr/bin/slabtop)
endif
ifdef PTXCONF_PROCPS_SYSCTL
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_DIR)/sysctl, \
		/sbin/sysctl)
endif
ifdef PTXCONF_PROCPS_PS
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_DIR)/ps/ps, \
		/bin/ps)
endif
ifdef PTXCONF_PROCPS_W
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_DIR)/w, \
		/usr/bin/w)
endif
ifdef PTXCONF_PROCPS_PGREP
	@$(call install_copy, procps, 0, 0, 0755, $(PROCPS_DIR)/pgrep, \
		/usr/bin/pgrep)
endif
	@$(call install_finish, procps)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

procps_clean:
	rm -rf $(STATEDIR)/procps.*
	rm -rf $(PKGDIR)/procps_*
	rm -rf $(PROCPS_DIR)

# vim: syntax=make
