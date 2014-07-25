# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NET_DNS_PERL) += net-dns-perl

#
# Paths and names
#
NET_DNS_PERL_VERSION	:= 0.74
NET_DNS_PERL_MD5	:= d3d074ba95314fa9627252653a4242b7
NET_DNS_PERL		:= Net-DNS-$(NET_DNS_PERL_VERSION)
NET_DNS_PERL_SUFFIX	:= tar.gz
NET_DNS_PERL_URL	:= http://www.net-dns.org/download/$(NET_DNS_PERL).$(NET_DNS_PERL_SUFFIX)
NET_DNS_PERL_SOURCE	:= $(SRCDIR)/$(NET_DNS_PERL).$(NET_DNS_PERL_SUFFIX)
NET_DNS_PERL_DIR	:= $(BUILDDIR)/$(NET_DNS_PERL)
NET_DNS_PERL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NET_DNS_PERL_CONF_TOOL	:= perl
NET_DNS_PERL_CONF_OPT	:= \
	--noonline-tests \
	--noIPv6-tests

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/net-dns-perl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, net-dns-perl)
	@$(call install_fixup, net-dns-perl,PRIORITY,optional)
	@$(call install_fixup, net-dns-perl,SECTION,base)
	@$(call install_fixup, net-dns-perl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, net-dns-perl,DESCRIPTION,missing)

	@$(call install_tree, net-dns-perl, 0, 0, -, $(PERL_SITELIB))

	@$(call install_finish, net-dns-perl)

	@$(call touch)

# vim: syntax=make
