# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
# Copyright (C) 2007 by Carsten Schlote, konzeptpark
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IPTABLES) += iptables

#
# Paths and names
#
IPTABLES_VERSION	= 1.4.1.1
IPTABLES		= iptables-$(IPTABLES_VERSION)
IPTABLES_SUFFIX		= tar.bz2
IPTABLES_URL		= http://ftp.netfilter.org/pub/iptables/$(IPTABLES).$(IPTABLES_SUFFIX)
IPTABLES_SOURCE		= $(SRCDIR)/$(IPTABLES).$(IPTABLES_SUFFIX)
IPTABLES_DIR		= $(BUILDDIR)/$(IPTABLES)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

iptables_get: $(STATEDIR)/iptables.get

$(STATEDIR)/iptables.get: $(iptables_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(IPTABLES_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, IPTABLES)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

iptables_extract: $(STATEDIR)/iptables.extract

$(STATEDIR)/iptables.extract: $(iptables_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IPTABLES_DIR))
	@$(call extract, IPTABLES)
	@$(call patchin, IPTABLES)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

iptables_prepare: $(STATEDIR)/iptables.prepare

IPTABLES_PATH	=  PATH=$(CROSS_PATH)
IPTABLES_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
IPTABLES_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/iptables.prepare: $(iptables_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IPTABLES_DIR)/config.cache)
	cd $(IPTABLES_DIR) && \
		$(IPTABLES_PATH) $(IPTABLES_ENV) \
		./configure $(IPTABLES_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

iptables_compile: $(STATEDIR)/iptables.compile

$(STATEDIR)/iptables.compile: $(iptables_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(IPTABLES_DIR) && $(IPTABLES_ENV) $(IPTABLES_PATH) \
		make KERNEL_DIR=$(KERNEL_DIR) PREFIX=/usr
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

iptables_install: $(STATEDIR)/iptables.install

$(STATEDIR)/iptables.install: $(iptables_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, IPTABLES,,, KERNEL_DIR=$(KERNEL_DIR) PREFIX=/usr)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

iptables_targetinstall: $(STATEDIR)/iptables.targetinstall

$(STATEDIR)/iptables.targetinstall: $(iptables_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, iptables)
	@$(call install_fixup, iptables,PACKAGE,iptables)
	@$(call install_fixup, iptables,PRIORITY,optional)
	@$(call install_fixup, iptables,VERSION,$(IPTABLES_VERSION))
	@$(call install_fixup, iptables,SECTION,base)
	@$(call install_fixup, iptables,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, iptables,DEPENDS,)
	@$(call install_fixup, iptables,DESCRIPTION,missing)

ifdef PTXCONF_IPTABLES_INSTALL_IP6TABLES
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/ip6tables, /sbin/ip6tables)
endif
ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/iptables, /sbin/iptables)
endif
ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_RESTORE
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/iptables-restore, /sbin/iptables-restore)
endif
ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_SAVE
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/iptables-save, /sbin/iptables-save)
endif

# --- iptables stuff - commented entries no longer available

ifdef PTXCONF_IPTABLES_INSTALL_libipt_addrtype
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_addrtype.so, /usr/lib/iptables/libipt_addrtype.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ah
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ah.so, /usr/lib/iptables/libipt_ah.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_CLUSTERIP
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_CLUSTERIP.so, /usr/lib/iptables/libipt_CLUSTERIP.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_connbytes
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_connbytes.so, /usr/lib/iptables/libipt_connbytes.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_dccp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_dccp.so, /usr/lib/iptables/libipt_dccp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_DF
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_DF.so, /usr/lib/iptables/libipt_DF.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_DNAT
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_DNAT.so, /usr/lib/iptables/libipt_DNAT.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ecn
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ecn.so, /usr/lib/iptables/libipt_ecn.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ECN
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ECN.so, /usr/lib/iptables/libipt_ECN.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_icmp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_icmp.so, /usr/lib/iptables/libipt_icmp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_LOG
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_LOG.so, /usr/lib/iptables/libipt_LOG.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_MASQUERADE
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_MASQUERADE.so, /usr/lib/iptables/libipt_MASQUERADE.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_MIRROR
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_MIRROR.so, /usr/lib/iptables/libipt_MIRROR.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_NETMAP
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_NETMAP.so, /usr/lib/iptables/libipt_NETMAP.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_NFLOG
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_NFLOG.so, /usr/lib/iptables/libipt_NFLOG.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_policy
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_policy.so, /usr/lib/iptables/libipt_policy.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_quota
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_quota.so, /usr/lib/iptables/libipt_quota.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_realm
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_realm.so, /usr/lib/iptables/libipt_realm.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_recent
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_recent.so, /usr/lib/iptables/libipt_recent.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_REDIRECT
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_REDIRECT.so, /usr/lib/iptables/libipt_REDIRECT.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_REJECT
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_REJECT.so, /usr/lib/iptables/libipt_REJECT.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_SAME
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_SAME.so, /usr/lib/iptables/libipt_SAME.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_SNAT
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_SNAT.so, /usr/lib/iptables/libipt_SNAT.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_statistic
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_statistic.so, /usr/lib/iptables/libipt_statistic.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_string
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_string.so, /usr/lib/iptables/libipt_string.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ttl
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ttl.so, /usr/lib/iptables/libipt_ttl.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_TTL
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_TTL.so, /usr/lib/iptables/libipt_TTL.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ULOG
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ULOG.so, /usr/lib/iptables/libipt_ULOG.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_unclean
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_unclean.so, /usr/lib/iptables/libipt_unclean.so, n)
endif

# --- ip6tables stuff

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_ah
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_ah.so, /usr/lib/iptables/libip6t_ah.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_esp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_esp.so, /usr/lib/iptables/libip6t_esp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_eui64
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_eui64.so, /usr/lib/iptables/libip6t_eui64.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_frag
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_frag.so, /usr/lib/iptables/libip6t_frag.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_hashlimit
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_hashlimit.so, /usr/lib/iptables/libip6t_hashlimit.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_hl
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_hl.so, /usr/lib/iptables/libip6t_hl.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_HL
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_HL.so, /usr/lib/iptables/libip6t_HL.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_icmp6
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_icmp6.so, /usr/lib/iptables/libip6t_icmp6.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_ipv6header
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_ipv6header.so, /usr/lib/iptables/libip6t_ipv6header.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_LOG
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_LOG.so, /usr/lib/iptables/libip6t_LOG.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_mh
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_mh.so, /usr/lib/iptables/libip6t_mh.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_NFLOG
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_NFLOG.so, /usr/lib/iptables/libip6t_NFLOG.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_policy
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_policy.so, /usr/lib/iptables/libip6t_policy.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_REJECT
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_REJECT.so, /usr/lib/iptables/libip6t_REJECT.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_rt
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_rt.so, /usr/lib/iptables/libip6t_rt.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_sctp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_sctp.so, /usr/lib/iptables/libip6t_sctp.so, n)
endif

	@$(call install_finish, iptables)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

iptables_clean:
	rm -rf $(STATEDIR)/iptables.*
	rm -rf $(PKGDIR)/iptables_*
	rm -rf $(IPTABLES_DIR)

# vim: syntax=make
