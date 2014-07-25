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
PACKAGES-$(PTXCONF_NET_IP_PERL) += net-ip-perl

#
# Paths and names
#
NET_IP_PERL_VERSION	:= 1.26
NET_IP_PERL_MD5		:= 3a98e3ac45d69ea38a63a7e678bd716d
NET_IP_PERL		:= Net-IP-$(NET_IP_PERL_VERSION)
NET_IP_PERL_SUFFIX	:= tar.gz
NET_IP_PERL_URL		:= http://search.cpan.org/CPAN/authors/id/M/MA/MANU//$(NET_IP_PERL).$(NET_IP_PERL_SUFFIX)
NET_IP_PERL_SOURCE	:= $(SRCDIR)/$(NET_IP_PERL).$(NET_IP_PERL_SUFFIX)
NET_IP_PERL_DIR		:= $(BUILDDIR)/$(NET_IP_PERL)
NET_IP_PERL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NET_IP_PERL_CONF_TOOL	:= perl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/net-ip-perl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, net-ip-perl)
	@$(call install_fixup, net-ip-perl,PRIORITY,optional)
	@$(call install_fixup, net-ip-perl,SECTION,base)
	@$(call install_fixup, net-ip-perl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, net-ip-perl,DESCRIPTION,missing)

	@$(call install_tree, net-ip-perl, 0, 0, -, $(PERL_SITELIB)/Net)

	@$(call install_finish, net-ip-perl)

	@$(call touch)

# vim: syntax=make
