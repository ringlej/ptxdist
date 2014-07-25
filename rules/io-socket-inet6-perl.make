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
PACKAGES-$(PTXCONF_IO_SOCKET_INET6_PERL) += io-socket-inet6-perl

#
# Paths and names
#
IO_SOCKET_INET6_PERL_VERSION	:= 2.72
IO_SOCKET_INET6_PERL_MD5	:= 510ddc1bd75a8340ca7226123fb545c1
IO_SOCKET_INET6_PERL		:= IO-Socket-INET6-$(IO_SOCKET_INET6_PERL_VERSION)
IO_SOCKET_INET6_PERL_SUFFIX	:= tar.gz
IO_SOCKET_INET6_PERL_URL	:= http://cpan.metacpan.org/authors/id/S/SH/SHLOMIF/$(IO_SOCKET_INET6_PERL).$(IO_SOCKET_INET6_PERL_SUFFIX)
IO_SOCKET_INET6_PERL_SOURCE	:= $(SRCDIR)/$(IO_SOCKET_INET6_PERL).$(IO_SOCKET_INET6_PERL_SUFFIX)
IO_SOCKET_INET6_PERL_DIR	:= $(BUILDDIR)/$(IO_SOCKET_INET6_PERL)
IO_SOCKET_INET6_PERL_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

IO_SOCKET_INET6_PERL_CONF_TOOL	:= perl

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/io-socket-inet6-perl.targetinstall:
	@$(call targetinfo)

	@$(call install_init, io-socket-inet6-perl)
	@$(call install_fixup, io-socket-inet6-perl,PRIORITY,optional)
	@$(call install_fixup, io-socket-inet6-perl,SECTION,base)
	@$(call install_fixup, io-socket-inet6-perl,AUTHOR,"Michael Olbrich <m.olbrich@pengutronix.de>")
	@$(call install_fixup, io-socket-inet6-perl,DESCRIPTION,missing)

	@$(call install_tree, io-socket-inet6-perl, 0, 0, -, $(PERL_SITELIB)/IO)

	@$(call install_finish, io-socket-inet6-perl)

	@$(call touch)

# vim: syntax=make
