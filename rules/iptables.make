# -*-makefile-*-
#
# Copyright (C) 2004 by Robert Schwebel
#               2007 by Carsten Schlote, konzeptpark
#               2008 by Juergen Beisert
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
PACKAGES-$(PTXCONF_IPTABLES) += iptables

#
# Paths and names
#
IPTABLES_VERSION	:= 1.4.5
IPTABLES		:= iptables-$(IPTABLES_VERSION)
IPTABLES_SUFFIX		:= tar.bz2
IPTABLES_URL		:= http://ftp.netfilter.org/pub/iptables/$(IPTABLES).$(IPTABLES_SUFFIX)
IPTABLES_SOURCE		:= $(SRCDIR)/$(IPTABLES).$(IPTABLES_SUFFIX)
IPTABLES_DIR		:= $(BUILDDIR)/$(IPTABLES)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(IPTABLES_SOURCE):
	@$(call targetinfo)
	@$(call get, IPTABLES)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IPTABLES_PATH	:=  PATH=$(CROSS_PATH)
IPTABLES_ENV	:=  $(CROSS_ENV)

#
# autoconf
#
IPTABLES_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--with-kernel=$(KERNEL_HEADERS_DIR) \
	--with-xtlibdir=/usr/lib

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iptables.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iptables)
	@$(call install_fixup, iptables,PACKAGE,iptables)
	@$(call install_fixup, iptables,PRIORITY,optional)
	@$(call install_fixup, iptables,VERSION,$(IPTABLES_VERSION))
	@$(call install_fixup, iptables,SECTION,base)
	@$(call install_fixup, iptables,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, iptables,DEPENDS,)
	@$(call install_fixup, iptables,DESCRIPTION,missing)

# install the basic libraries
	@$(call install_copy, iptables, 0, 0, 0644, -, \
		/usr/lib/libiptc.so.0.0.0)
	@$(call install_link, iptables, libiptc.so.0.0.0, /usr/lib/libiptc.so)
	@$(call install_link, iptables, libiptc.so.0.0.0, /usr/lib/libiptc.so.0)

	@$(call install_copy, iptables, 0, 0, 0644, -, \
		/usr/lib/libxtables.so.2.1.0)
	@$(call install_link, iptables, libxtables.so.2.1.0, /usr/lib/libxtables.so)
	@$(call install_link, iptables, libxtables.so.2.1.0, /usr/lib/libxtables.so.2)

# IPv6 part
ifdef PTXCONF_IPTABLES_INSTALL_IP6TABLES_MULTI
	@$(call install_copy, iptables, 0, 0, 0755, -, /usr/sbin/ip6tables-multi)

	@$(call install_copy, iptables, 0, 0, 0644, -, \
		/usr/lib/libip4tc.so.0.0.0)
	@$(call install_link, iptables, libip4tc.so.0.0.0, /usr/lib/libip4tc.so)
	@$(call install_link, iptables, libip4tc.so.0.0.0, /usr/lib/libip4tc.so.0)
endif

ifdef PTXCONF_IPTABLES_INSTALL_IP6TABLES
	@$(call install_link, iptables, ip6tables-multi, /usr/sbin/ip6tables)
endif
ifdef PTXCONF_IPTABLES_INSTALL_IP6TABLES_RESTORE
	@$(call install_link, iptables, ip6tables-multi, /usr/sbin/ip6tables-restore)
endif
ifdef PTXCONF_IPTABLES_INSTALL_IP6TABLES_SAVE
	@$(call install_link, iptables, ip6tables-multi, /usr/sbin/ip6tables-save)
endif

# install the IPv6 relevant shared feature libraries
ifdef PTXCONF_IPTABLES_INSTALL_IPV6_TOOLS
	@cd $(IPTABLES_DIR)/extensions && \
		for file in libip6t_*.so; do \
			$(call install_copy, iptables, 0, 0, 0644, -, \
				/usr/lib/$$file); \
		done

endif


# IPv4 part
ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_MULTI
	@$(call install_copy, iptables, 0, 0, 0755, -, /usr/sbin/iptables-multi)

	@$(call install_copy, iptables, 0, 0, 0644, -, \
		/usr/lib/libip6tc.so.0.0.0)
	@$(call install_link, iptables, libip6tc.so.0.0.0, /usr/lib/libip6tc.so)
	@$(call install_link, iptables, libip6tc.so.0.0.0, /usr/lib/libip6tc.so.0)
endif

ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES
	@$(call install_link, iptables, iptables-multi, /usr/sbin/iptables)
endif
ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_RESTORE
	@$(call install_link, iptables, iptables-multi, /usr/sbin/iptables-restore)
endif
ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_SAVE
	@$(call install_link, iptables, iptables-multi, /usr/sbin/iptables-save)
endif

# install all shared feature libraries to get full runtime support
ifdef PTXCONF_IPTABLES_INSTALL_IPV4_TOOLS
	@cd $(IPTABLES_DIR)/extensions && \
		for file in libipt_*.so libxt_*.so; do \
			$(call install_copy, iptables, 0, 0, 0644, -,\
				/usr/lib/$$file); \
		done
endif

ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_XML
	@$(call install_link, iptables, ../sbin/iptables-multi, /usr/bin/iptables-xml)
endif

ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_APPLY
	@$(call install_copy, iptables, 0, 0, 0755, $(IPTABLES_DIR)/iptables-apply, /usr/sbin/iptables-apply)
endif

	@$(call install_finish, iptables)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

iptables_clean:
	rm -rf $(STATEDIR)/iptables.*
	rm -rf $(PKGDIR)/iptables_*
	rm -rf $(IPTABLES_DIR)

# vim: syntax=make
