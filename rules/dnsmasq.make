# -*-makefile-*-
#
# Copyright (C) 2003 by Benedikt Spranger
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
PACKAGES-$(PTXCONF_DNSMASQ) += dnsmasq

#
# Paths and names
#
DNSMASQ_VERSION		:= 2.47
DNSMASQ			:= dnsmasq-$(DNSMASQ_VERSION)
DNSMASQ_SUFFIX		:= tar.gz
DNSMASQ_URL		:= http://www.thekelleys.org.uk/dnsmasq/$(DNSMASQ).$(DNSMASQ_SUFFIX)
DNSMASQ_SOURCE		:= $(SRCDIR)/$(DNSMASQ).$(DNSMASQ_SUFFIX)
DNSMASQ_DIR		:= $(BUILDDIR)/$(DNSMASQ)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(DNSMASQ_SOURCE):
	@$(call targetinfo)
	@$(call get, DNSMASQ)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DNSMASQ_PATH := PATH=$(CROSS_PATH)
DNSMASQ_COMPILE_ENV := $(CROSS_ENV)

DNSMASQ_COPT :=

ifndef PTXCONF_DNSMASQ_TFTP
DNSMASQ_COPT += -DNO_TFTP
endif
ifndef PTXCONF_DNSMASQ_IPV6
DNSMASQ_COPT += -DNO_IPV6
endif

DNSMASQ_MAKEVARS := PREFIX=/usr AWK=awk COPTS='$(DNSMASQ_COPT)'

$(STATEDIR)/dnsmasq.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dnsmasq.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dnsmasq)
	@$(call install_fixup, dnsmasq,PACKAGE,dnsmasq)
	@$(call install_fixup, dnsmasq,PRIORITY,optional)
	@$(call install_fixup, dnsmasq,VERSION,$(DNSMASQ_VERSION))
	@$(call install_fixup, dnsmasq,SECTION,base)
	@$(call install_fixup, dnsmasq,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dnsmasq,DEPENDS,)
	@$(call install_fixup, dnsmasq,DESCRIPTION,missing)

	@$(call install_copy, dnsmasq, 0, 0, 0755, -, \
		/usr/sbin/dnsmasq)

ifdef PTXCONF_DNSMASQ_INETD
	@$(call install_alternative, dnsmasq, 0, 0, 0644, /etc/inetd.conf.d/dnsmasq, n)
endif

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_DNSMASQ_STARTSCRIPT
	@$(call install_alternative, dnsmasq, 0, 0, 0755, /etc/init.d/dnsmasq, n)
endif
endif

	@$(call install_alternative, dnsmasq, 0, 0, 0644, /etc/dnsmasq.conf, n)

# for the 'dnsmasq.leases' file
	@$(call install_copy, dnsmasq, 0, 0, 0755, /var/lib/misc)

	@$(call install_finish, dnsmasq)

	@$(call touch)

# vim: syntax=make
