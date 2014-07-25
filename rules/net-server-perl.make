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
PACKAGES-$(PTXCONF_NET_SERVER_PERL) += net-server-perl

#
# Paths and names
#
NET_SERVER_PERL_VERSION	:= 2.007
NET_SERVER_PERL_MD5	:= b256c35a18caecc8fce9e6e1f2825658
NET_SERVER_PERL		:= Net-Server-$(NET_SERVER_PERL_VERSION)
NET_SERVER_PERL_SUFFIX	:= tar.gz
NET_SERVER_PERL_URL	:= http://cpan.metacpan.org/authors/id/R/RH/RHANDOM/$(NET_SERVER_PERL).$(NET_SERVER_PERL_SUFFIX)
NET_SERVER_PERL_SOURCE	:= $(SRCDIR)/$(NET_SERVER_PERL).$(NET_SERVER_PERL_SUFFIX)
NET_SERVER_PERL_DIR	:= $(BUILDDIR)/$(NET_SERVER_PERL)
NET_SERVER_PERL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NET_SERVER_PERL_CONF_TOOL	:= perl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/net-server-perl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, net-server-perl)
	@$(call install_fixup, net-server-perl,PRIORITY,optional)
	@$(call install_fixup, net-server-perl,SECTION,base)
	@$(call install_fixup, net-server-perl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, net-server-perl,DESCRIPTION,missing)

	@$(call install_copy, net-server-perl, 0, 0, 0755, -, /usr/bin/net-server)
	@$(call install_tree, net-server-perl, 0, 0, -, $(PERL_SITELIB)/Net)

	@$(call install_finish, net-server-perl)

	@$(call touch)

# vim: syntax=make
