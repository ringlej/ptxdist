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
IPTABLES_VERSION	:= 1.4.12.2
IPTABLES_MD5		:= 212112389c7f10c72efb31a4ed193a4c
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

IPTABLES_PATH	:= PATH=$(CROSS_PATH)
IPTABLES_ENV	:= $(CROSS_ENV)

#
# autoconf
#
IPTABLES_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--with-kernel=$(KERNEL_HEADERS_DIR) \
	--with-xtlibdir=/usr/lib \
	--enable-devel \
	--$(call ptx/endis, PTXCONF_IPTABLES_IPV4)-ipv4 \
	--$(call ptx/endis, PTXCONF_IPTABLES_IPV6)-ipv6 \
	--disable-libipq

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iptables.install:
	@$(call targetinfo)
	@$(call install, IPTABLES)
	install $(IPTABLES_DIR)/iptables/iptables-apply $(IPTABLES_PKGDIR)/usr/sbin
	@$(touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/iptables.targetinstall:
	@$(call targetinfo)

	@$(call install_init, iptables)
	@$(call install_fixup, iptables,PRIORITY,optional)
	@$(call install_fixup, iptables,SECTION,base)
	@$(call install_fixup, iptables,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, iptables,DESCRIPTION,missing)

# 	# install the basic libraries
	@$(call install_lib, iptables, 0, 0, 0644, libiptc)
	@$(call install_lib, iptables, 0, 0, 0644, libxtables)

	@cd $(IPTABLES_PKGDIR)/usr/lib && \
		for file in libxt_*.so; do \
			$(call install_copy, iptables, 0, 0, 0644, -,\
				/usr/lib/$$file); \
		done

ifdef PTXCONF_IPTABLES_IPV6
#	# install the IPv6 relevant shared libraries
	@cd $(IPTABLES_PKGDIR)/usr/lib && \
		for file in libip6t_*.so; do \
			$(call install_copy, iptables, 0, 0, 0644, -, \
				/usr/lib/$$file); \
		done
	$(call install_lib, iptables, 0, 0, 0644, libip6tc)

endif

ifdef PTXCONF_IPTABLES_IPV4
#	# install the IPv4 relevant shared libraries
	@cd $(IPTABLES_PKGDIR)/usr/lib && \
		for file in libipt_*.so; do \
			$(call install_copy, iptables, 0, 0, 0644, -,\
				/usr/lib/$$file); \
		done
	$(call install_lib, iptables, 0, 0, 0644, libip4tc)
endif

ifdef PTXCONF_IPTABLES_INSTALL_TOOLS
	@$(call install_copy, iptables, 0, 0, 0755, -, /usr/sbin/xtables-multi)

	@$(call install_link, iptables, ../sbin/xtables-multi, /usr/bin/iptables-xml)

ifdef PTXCONF_IPTABLES_IPV6
# 	# IPv6 part
	@$(call install_link, iptables, xtables-multi, /usr/sbin/ip6tables)
	@$(call install_link, iptables, xtables-multi, /usr/sbin/ip6tables-restore)
	@$(call install_link, iptables, xtables-multi, /usr/sbin/ip6tables-save)
endif

ifdef PTXCONF_IPTABLES_IPV4
# 	# IPv4 part
	@$(call install_link, iptables, xtables-multi, /usr/sbin/iptables)
	@$(call install_link, iptables, xtables-multi, /usr/sbin/iptables-restore)
	@$(call install_link, iptables, xtables-multi, /usr/sbin/iptables-save)
endif
endif

ifdef PTXCONF_IPTABLES_INSTALL_IPTABLES_APPLY
	@$(call install_copy, iptables, 0, 0, 0755, -, /usr/sbin/iptables-apply)
endif

	@$(call install_finish, iptables)

	@$(call touch)

# vim: syntax=make
