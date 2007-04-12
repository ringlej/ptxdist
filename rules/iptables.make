# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
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
IPTABLES_VERSION	= 1.3.7
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

$(STATEDIR)/iptables.prepare: $(iptables_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(IPTABLES_DIR)/config.cache)
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
	@$(call install, IPTABLES)
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

# --- iptables stuff

ifdef PTXCONF_IPTABLES_INSTALL_libipt_addrtype
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_addrtype.so, /usr/lib/iptables/libipt_addrtype.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ah
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ah.so, /usr/lib/iptables/libipt_ah.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_CLASSIFY
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_CLASSIFY.so, /usr/lib/iptables/libipt_CLASSIFY.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_CLUSTERIP
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_CLUSTERIP.so, /usr/lib/iptables/libipt_CLUSTERIP.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_connlimit
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_connlimit.so, /usr/lib/iptables/libipt_connlimit.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_connmark
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_connmark.so, /usr/lib/iptables/libipt_connmark.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_CONNMARK
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_CONNMARK.so, /usr/lib/iptables/libipt_CONNMARK.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_conntrack
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_conntrack.so, /usr/lib/iptables/libipt_conntrack.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_DNAT
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_DNAT.so, /usr/lib/iptables/libipt_DNAT.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_dscp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_dscp.so, /usr/lib/iptables/libipt_dscp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_DSCP
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_DSCP.so, /usr/lib/iptables/libipt_DSCP.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ecn
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ecn.so, /usr/lib/iptables/libipt_ecn.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ECN
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ECN.so, /usr/lib/iptables/libipt_ECN.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_esp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_esp.so, /usr/lib/iptables/libipt_esp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_helper
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_helper.so, /usr/lib/iptables/libipt_helper.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_icmp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_icmp.so, /usr/lib/iptables/libipt_icmp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_iprange
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_iprange.so, /usr/lib/iptables/libipt_iprange.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_length
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_length.so, /usr/lib/iptables/libipt_length.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_limit
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_limit.so, /usr/lib/iptables/libipt_limit.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_LOG
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_LOG.so, /usr/lib/iptables/libipt_LOG.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_mac
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_mac.so, /usr/lib/iptables/libipt_mac.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_mark
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_mark.so, /usr/lib/iptables/libipt_mark.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_MARK
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_MARK.so, /usr/lib/iptables/libipt_MARK.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_MASQUERADE
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_MASQUERADE.so, /usr/lib/iptables/libipt_MASQUERADE.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_MIRROR
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_MIRROR.so, /usr/lib/iptables/libipt_MIRROR.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_multiport
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_multiport.so, /usr/lib/iptables/libipt_multiport.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_NETMAP
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_NETMAP.so, /usr/lib/iptables/libipt_NETMAP.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_NOTRACK
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_NOTRACK.so, /usr/lib/iptables/libipt_NOTRACK.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_owner
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_owner.so, /usr/lib/iptables/libipt_owner.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_physdev
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_physdev.so, /usr/lib/iptables/libipt_physdev.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_pkttype
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_pkttype.so, /usr/lib/iptables/libipt_pkttype.so, n)
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

ifdef PTXCONF_IPTABLES_INSTALL_libipt_rpc
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_rpc.so, /usr/lib/iptables/libipt_rpc.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_SAME
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_SAME.so, /usr/lib/iptables/libipt_SAME.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_sctp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_sctp.so, /usr/lib/iptables/libipt_sctp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_SNAT
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_SNAT.so, /usr/lib/iptables/libipt_SNAT.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_standard
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_standard.so, /usr/lib/iptables/libipt_standard.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_state
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_state.so, /usr/lib/iptables/libipt_state.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_TARPIT
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_TARPIT.so, /usr/lib/iptables/libipt_TARPIT.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_tcpmss
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_tcpmss.so, /usr/lib/iptables/libipt_tcpmss.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_TCPMSS
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_TCPMSS.so, /usr/lib/iptables/libipt_TCPMSS.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_tcp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_tcp.so, /usr/lib/iptables/libipt_tcp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_tos
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_tos.so, /usr/lib/iptables/libipt_tos.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_TOS
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_TOS.so, /usr/lib/iptables/libipt_TOS.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_TRACE
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_TRACE.so, /usr/lib/iptables/libipt_TRACE.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_ttl
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_ttl.so, /usr/lib/iptables/libipt_ttl.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_TTL
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_TTL.so, /usr/lib/iptables/libipt_TTL.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libipt_udp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libipt_udp.so, /usr/lib/iptables/libipt_udp.so, n)
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

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_dst
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_dst.so, /usr/lib/iptables/libip6t_dst.so, n)
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

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_hbh
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_hbh.so, /usr/lib/iptables/libip6t_hbh.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_hl
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_hl.so, /usr/lib/iptables/libip6t_hl.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_HL
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_HL.so, /usr/lib/iptables/libip6t_HL.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_icmpv6
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_icmpv6.so, /usr/lib/iptables/libip6t_icmpv6.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_ipv6header
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_ipv6header.so, /usr/lib/iptables/libip6t_ipv6header.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_length
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_length.so, /usr/lib/iptables/libip6t_length.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_limit
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_limit.so, /usr/lib/iptables/libip6t_limit.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_LOG
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_LOG.so, /usr/lib/iptables/libip6t_LOG.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_mac
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_mac.so, /usr/lib/iptables/libip6t_mac.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_mark
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_mark.so, /usr/lib/iptables/libip6t_mark.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_MARK
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_MARK.so, /usr/lib/iptables/libip6t_MARK.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_multiport
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_multiport.so, /usr/lib/iptables/libip6t_multiport.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_owner
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_owner.so, /usr/lib/iptables/libip6t_owner.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_rt
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_rt.so, /usr/lib/iptables/libip6t_rt.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_standard
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_standard.so, /usr/lib/iptables/libip6t_standard.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_tcp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_tcp.so, /usr/lib/iptables/libip6t_tcp.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_TRACE
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_TRACE.so, /usr/lib/iptables/libip6t_TRACE.so, n)
endif

ifdef PTXCONF_IPTABLES_INSTALL_libip6t_udp
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/extensions/libip6t_udp.so, /usr/lib/iptables/libip6t_udp.so, n)
endif

	@$(call install_finish, iptables)	


	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

iptables_clean:
	rm -rf $(STATEDIR)/iptables.*
	rm -rf $(IMAGEDIR)/iptables_*
	rm -rf $(IPTABLES_DIR)

# vim: syntax=make
