# -*-makefile-*-
# $Id: template-make 9053 2008-11-03 10:58:48Z wsa $
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBNL) += libnl

#
# Paths and names
#
LIBNL_VERSION	:= 1.1
LIBNL		:= libnl-$(LIBNL_VERSION)
LIBNL_SUFFIX	:= tar.gz
LIBNL_URL	:= http://people.suug.ch/~tgr/libnl/files/$(LIBNL).$(LIBNL_SUFFIX)
LIBNL_SOURCE	:= $(SRCDIR)/$(LIBNL).$(LIBNL_SUFFIX)
LIBNL_DIR	:= $(BUILDDIR)/$(LIBNL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIBNL_SOURCE):
	@$(call targetinfo)
	@$(call get, LIBNL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBNL_PATH	:= PATH=$(CROSS_PATH)
LIBNL_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIBNL_AUTOCONF := $(CROSS_AUTOCONF_USR)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libnl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libnl)
	@$(call install_fixup, libnl,PACKAGE,libnl)
	@$(call install_fixup, libnl,PRIORITY,optional)
	@$(call install_fixup, libnl,VERSION,$(LIBNL_VERSION))
	@$(call install_fixup, libnl,SECTION,base)
	@$(call install_fixup, libnl,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, libnl,DEPENDS,)
	@$(call install_fixup, libnl,DESCRIPTION,missing)

	@$(call install_copy, libnl, 0, 0, 0644, -, /usr/lib/libnl.so.1.1)
	@$(call install_link, libnl, libnl.so.1.1, /usr/lib/libnl.so.1)
	@$(call install_link, libnl, libnl.so.1.1, /usr/lib/libnl.so)

ifdef PTXCONF_LIBNL_MONITOR
	@$(call install_copy, libnl, 0, 0, 0755, -, /usr/sbin/nl-monitor)
endif

# genl-ctrl-dump
# genl-ctrl-get
# nf-ct-dump
# nf-log
# nf-monitor
# nl-addr-add
# nl-addr-delete
# nl-addr-dump
# nl-fib-lookup
# nl-link-dump
# nl-link-ifindex2name
# nl-link-name2ifindex
# nl-link-set
# nl-link-stats
# nl-list-caches
# nl-list-sockets
# nl-monitor
# nl-neigh-add
# nl-neigh-delete
# nl-neigh-dump
# nl-neightbl-dump
# nl-qdisc-add
# nl-qdisc-delete
# nl-qdisc-dump
# nl-route-add
# nl-route-del
# nl-route-dump
# nl-route-get
# nl-rule-dump
# nl-tctree-dump
# nl-util-addr

	@$(call install_finish, libnl)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libnl_clean:
	rm -rf $(STATEDIR)/libnl.*
	rm -rf $(PKGDIR)/libnl_*
	rm -rf $(LIBNL_DIR)

# vim: syntax=make
