# -*-makefile-*-
# $Id: net-snmp.make$
#
# Copyright (C) 2006 by Randall Loomis <rloomis@solectek.com>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NET_SNMP) += net-snmp

#
# Paths and names
#
NET_SNMP_VERSION	= 5.3.1
NET_SNMP		= net-snmp-$(NET_SNMP_VERSION)
NET_SNMP_SUFFIX		= tar.gz
NET_SNMP_URL		= $(PTXCONF_SETUP_SFMIRROR)/net-snmp/$(NET_SNMP).$(NET_SNMP_SUFFIX)
NET_SNMP_SOURCE		= $(SRCDIR)/$(NET_SNMP).$(NET_SNMP_SUFFIX)
NET_SNMP_DIR		= $(BUILDDIR)/$(NET_SNMP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

net-snmp_get: $(STATEDIR)/net-snmp.get

$(STATEDIR)/net-snmp.get: $(net-snmp_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NET_SNMP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, NET_SNMP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

net-snmp_extract: $(STATEDIR)/net-snmp.extract

$(STATEDIR)/net-snmp.extract: $(net-snmp_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NET_SNMP_DIR))
	@$(call extract, NET_SNMP)
	@$(call patchin, NET_SNMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

net-snmp_prepare: $(STATEDIR)/net-snmp.prepare

NET_SNMP_PATH	=  PATH=$(CROSS_PATH)
NET_SNMP_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
NET_SNMP_AUTOCONF	=  $(CROSS_AUTOCONF_USR)

# don't prompt for anything that's not explicitly set below
NET_SNMP_AUTOCONF	+= --with-defaults

# we don't need no stinking manuals
NET_SNMP_AUTOCONF	+= --disable-manuals

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_LITTLE_ENDIAN
NET_SNMP_AUTOCONF	+= --with-endianness=little
else
NET_SNMP_AUTOCONF	+= --with-endianness=big
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_MINI_AGENT
NET_SNMP_AUTOCONF	+= --enable-mini-agent
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_AGENT
NET_SNMP_AUTOCONF	+= --disable-agent
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_APPLICATIONS
NET_SNMP_AUTOCONF	+= --disable-applications
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_SCRIPTS
NET_SNMP_AUTOCONF	+= --disable-scripts
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_MIBS
NET_SNMP_AUTOCONF	+= --disable-mibs
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_MIB_LOADING
NET_SNMP_AUTOCONF	+= --disable-mib-loading
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_SNMPV1
NET_SNMP_AUTOCONF	+= --disable-snmpv1
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_SNMPV2C
NET_SNMP_AUTOCONF	+= --disable-snmpv2c
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_DES
NET_SNMP_AUTOCONF	+= --disable-des
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_MD5
NET_SNMP_AUTOCONF	+= --disable-md5
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_SNMPTRAPD
NET_SNMP_AUTOCONF	+= --disable-snmptrapd-subagent
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_IPV6
NET_SNMP_AUTOCONF	+= --enable-ipv6
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_LOCAL_SMUX
NET_SNMP_AUTOCONF	+= --enable-local-smux
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_DEBUGGING
NET_SNMP_AUTOCONF	+= --disable-debugging
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_DEVELOPER
NET_SNMP_AUTOCONF	+= --enable-developer
endif

ifdef PTXCONF_NET_SNMP_FEATURE_DISABLE_PRIVACY
NET_SNMP_AUTOCONF	+= --disable-privacy
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_INTERNAL_MD5
NET_SNMP_AUTOCONF	+= --enable-internal-md5
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_AGENTX_DOM_SOCK_ONLY
NET_SNMP_AUTOCONF	+= --enable-agentx-dom-sock-only
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_MIB_CONFIG_CHECKING
NET_SNMP_AUTOCONF	+= --enable-mib-config-checking
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_MFD_REWRITES
NET_SNMP_AUTOCONF	+= --enable-mfd-rewrites
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_TESTING_CODE
NET_SNMP_AUTOCONF	+= --enable-testing-code
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_REENTRANT
NET_SNMP_AUTOCONF	+= --enable-reentrant
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_EMBEDDED_PERL
NET_SNMP_AUTOCONF	+= --enable-embedded-perl
endif

ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_UCD_COMPAT
NET_SNMP_AUTOCONF	+= --enable-ucd-snmp-compatibility
endif

NET_SNMP_AUTOCONF	+= --with-mib-modules=$(PTXCONF_NET_SNMP_FEATURE_WITH_MIB_MODULES)
NET_SNMP_AUTOCONF	+= --with-mibs=$(PTXCONF_NET_SNMP_FEATURE_WITH_MIBS)

NET_SNMP_AUTOCONF	+= --with-logfile=$(call remove_quotes,$(PTXCONF_NET_SNMP_FEATURE_LOGFILE))
NET_SNMP_AUTOCONF	+= --with-persistent-directory=$(call remove_quotes,$(PTXCONF_NET_SNMP_FEATURE_PERSISTENT_DIR))

NET_SNMP_AUTOCONF	+= --with-default-snmp-version=$(call remove_quotes,$(PTXCONF_NET_SNMP_FEATURE_DEFAULT_SNMP_VERSION))
NET_SNMP_AUTOCONF	+= --enable-shared
NET_SNMP_AUTOCONF	+= --disable-static

##NET_SNMP_AUTOCONF	+= --with-mib-modules=mibII
##NET_SNMP_AUTOCONF	+= --with-sys-contact=root@localhost
##NET_SNMP_AUTOCONF	+= --with-sys-location=unknown

$(STATEDIR)/net-snmp.prepare: $(net-snmp_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(NET_SNMP_DIR)/config.cache)
	cd $(NET_SNMP_DIR) && \
		$(NET_SNMP_PATH) $(NET_SNMP_ENV) \
		./configure $(NET_SNMP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

net-snmp_compile: $(STATEDIR)/net-snmp.compile

$(STATEDIR)/net-snmp.compile: $(net-snmp_compile_deps_default)
	@$(call targetinfo, $@)
	$(NET_SNMP_PATH) make -C $(NET_SNMP_DIR) $(NET_SNMP_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

net-snmp_install: $(STATEDIR)/net-snmp.install

$(STATEDIR)/net-snmp.install: $(net-snmp_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, NET_SNMP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

net-snmp_targetinstall:	$(STATEDIR)/net-snmp.targetinstall

NET_SNMP_LIBMAJOR = 10
NET_SNMP_LIBMINOR = 0.1
NET_SNMP_LIBVER=$(NET_SNMP_LIBMAJOR).$(NET_SNMP_LIBMINOR)

NET_SNMP_V1MIBS = RFC1155-SMI.txt RFC1213-MIB.txt RFC-1215.txt

NET_SNMP_V2MIBS = SNMPv2-CONF.txt SNMPv2-SMI.txt SNMPv2-TC.txt SNMPv2-TM.txt SNMPv2-MIB.txt

NET_SNMP_V3MIBS = SNMP-FRAMEWORK-MIB.txt SNMP-MPD-MIB.txt SNMP-TARGET-MIB.txt \
			SNMP-NOTIFICATION-MIB.txt SNMP-PROXY-MIB.txt \
			SNMP-USER-BASED-SM-MIB.txt SNMP-VIEW-BASED-ACM-MIB.txt \
			SNMP-COMMUNITY-MIB.txt TRANSPORT-ADDRESS-MIB.txt

NET_SNMP_AGENTMIBS = AGENTX-MIB.txt SMUX-MIB.txt

NET_SNMP_IANAMIBS = IANAifType-MIB.txt IANA-LANGUAGE-MIB.txt \
			IANA-ADDRESS-FAMILY-NUMBERS-MIB.txt

NET_SNMP_RFCMIBS = IF-MIB.txt IF-INVERTED-STACK-MIB.txt \
			EtherLike-MIB.txt \
			IP-MIB.txt IP-FORWARD-MIB.txt IANA-RTPROTO-MIB.txt \
			TCP-MIB.txt UDP-MIB.txt \
			INET-ADDRESS-MIB.txt HCNUM-TC.txt \
			HOST-RESOURCES-MIB.txt HOST-RESOURCES-TYPES.txt \
			RMON-MIB.txt \
			IPV6-TC.txt IPV6-MIB.txt IPV6-ICMP-MIB.txt IPV6-TCP-MIB.txt \
			IPV6-UDP-MIB.txt \
			DISMAN-EVENT-MIB.txt DISMAN-SCRIPT-MIB.txt DISMAN-SCHEDULE-MIB.txt \
			NOTIFICATION-LOG-MIB.txt SNMP-USM-AES-MIB.txt \
			SNMP-USM-DH-OBJECTS-MIB.txt

NET_SNMP_NETSNMPMIBS = NET-SNMP-TC.txt NET-SNMP-MIB.txt NET-SNMP-AGENT-MIB.txt \
			NET-SNMP-EXAMPLES-MIB.txt NET-SNMP-EXTEND-MIB.txt

NET_SNMP_UCDMIBS = UCD-SNMP-MIB.txt UCD-DEMO-MIB.txt UCD-IPFWACC-MIB.txt \
			UCD-DLMOD-MIB.txt UCD-DISKIO-MIB.txt

## FIXME:  for now, you need to manually edit this list to represent what mibs to install on target.
NET_SNMP_MIBS = $(NET_SNMP_V1MIBS) $(NET_SNMP_V2MIBS) $(NET_SNMP_V3MIBS) \
	$(NET_SNMP_AGENTMIBS) $(NET_SNMP_IANAMIBS) $(NET_SNMP_RFCMIBS) $(NET_SNMP_NETSNMPMIBS) $(NET_SNNP_UCDMIBS)

$(STATEDIR)/net-snmp.targetinstall:	$(net-snmp_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, net-snmp)
	@$(call install_fixup, net-snmp,PACKAGE,net-snmp)
	@$(call install_fixup, net-snmp,PRIORITY,optional)
	@$(call install_fixup, net-snmp,VERSION,$(NET_SNMP_VERSION))
	@$(call install_fixup, net-snmp,SECTION,base)
	@$(call install_fixup, net-snmp,AUTHOR,"Randall Loomis <rloomis\@solectek.com>")
	@$(call install_fixup, net-snmp,DEPENDS,)
	@$(call install_fixup, net-snmp,DESCRIPTION,missing)

ifndef PTXCONF_NET_SNMP_FEATURE_DISABLE_AGENT
	@$(call install_copy, net-snmp, 0, 0, 0644, \
		$(NET_SNMP_DIR)/agent/.libs/libnetsnmpagent.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmpagent.so.$(NET_SNMP_LIBVER))
	@$(call install_link, net-snmp, libnetsnmpagent.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmpagent.so.$(NET_SNMP_LIBMAJOR))
	@$(call install_link, net-snmp, libnetsnmpagent.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmpagent.so)

# agent mib libs
	@$(call install_copy, net-snmp, 0, 0, 0644, \
		$(NET_SNMP_DIR)/agent/.libs/libnetsnmpmibs.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmpmibs.so.$(NET_SNMP_LIBVER))
	@$(call install_link, net-snmp, libnetsnmpmibs.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmpmibs.so.$(NET_SNMP_LIBMAJOR))
	@$(call install_link, net-snmp, libnetsnmpmibs.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmpmibs.so)

# agent binary
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/agent/.libs/snmpd, \
		/usr/sbin/snmpd)

# agent helper libs
	@$(call install_copy, net-snmp, 0, 0, 0644, \
		$(NET_SNMP_DIR)/agent/helpers/.libs/libnetsnmphelpers.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmphelpers.so.$(NET_SNMP_LIBVER))
	@$(call install_link, net-snmp, libnetsnmphelpers.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmphelpers.so.$(NET_SNMP_LIBMAJOR))
	@$(call install_link, net-snmp, libnetsnmphelpers.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmphelpers.so)
endif # PTXCONF_NET_SNMP_FEATURE_DISABLE_AGENT

ifndef PTXCONF_NET_SNMP_FEATURE_DISABLE_APPLICATIONS
# apps libs
	@$(call install_copy, net-snmp, 0, 0, 0644, \
		$(NET_SNMP_DIR)/apps/.libs/libnetsnmptrapd.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmptrapd.so.$(NET_SNMP_LIBVER))
	@$(call install_link, net-snmp, libnetsnmptrapd.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmptrapd.so.$(NET_SNMP_LIBMAJOR))
	@$(call install_link, net-snmp, libnetsnmptrapd.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmptrapd.so)

# apps binaries
##ifdef PTXCONF_NET_SNMP_FEATURE_ENABLE_MINI_AGENT
##	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/lt-snmpget, /usr/bin/lt-snmpget)
##	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/lt-snmpwalk, /usr/bin/lt-snmpwalk)
##endif
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpbulkget, /usr/bin/snmpbulkget)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpbulkwalk, /usr/bin/snmpbulkwalk)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpdelta, /usr/bin/snmpdelta)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpdf, /usr/bin/snmpdf)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpget, /usr/bin/snmpget)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpgetnext, /usr/bin/snmpgetnext)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpset, /usr/bin/snmpset)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpstatus, /usr/bin/snmpstatus)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmptable, /usr/bin/snmptable)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmptest, /usr/bin/snmptest)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmptranslate, /usr/bin/snmptranslate)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmptrap, /usr/bin/snmptrap)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmptrapd, /usr/bin/snmptrapd)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpusm, /usr/bin/snmpusm)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpvacm, /usr/bin/snmpvacm)
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/.libs/snmpwalk, /usr/bin/snmpwalk)

# apps snmpstat
	@$(call install_copy, net-snmp, 0, 0, 0755, $(NET_SNMP_DIR)/apps/snmpnetstat/.libs/snmpnetstat, /usr/bin/snmpnetstat)

endif # PTXCONF_NET_SNMP_FEATURE_DISABLE_APPLICATIONS

# snmplib
	@$(call install_copy, net-snmp, 0, 0, 0644, \
		$(NET_SNMP_DIR)/snmplib/.libs/libnetsnmp.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmp.so.$(NET_SNMP_LIBVER))
	@$(call install_link, net-snmp, libnetsnmp.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmp.so.$(NET_SNMP_LIBMAJOR))
	@$(call install_link, net-snmp, libnetsnmp.so.$(NET_SNMP_LIBVER), \
		/usr/lib/libnetsnmp.so)

# MIB files <TODO: install specified set of mib files>
ifndef PTXCONF_NET_SNMP_FEATURE_DISABLE_MIBS

	@for i in $(NET_SNMP_MIBS) ; do \
		$(call install_copy, net-snmp, 0, 0, 0644, \
		$(NET_SNMP_DIR)/mibs/$$i, \
		$(call remove_quotes,$(PTXCONF_NET_SNMP_MIB_INSTALL_DIR))/$$i, n) ; \
	done
endif

	@$(call install_finish, net-snmp)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

net-snmp_clean:
	rm -rf $(STATEDIR)/net-snmp.*
	rm -rf $(NET_SNMP_DIR)

# vim: syntax=make
