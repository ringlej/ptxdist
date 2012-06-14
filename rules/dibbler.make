# -*-makefile-*-
#
# Copyright (C) 2010 by Remy Bohmer <linux@bohmer.net>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DIBBLER) += dibbler

#
# Paths and names
#
DIBBLER_VERSION	:= 0.7.3
DIBBLER_MD5	:= 39be72da38c2e6d33fd43a2811a276b1
DIBBLER		:= dibbler-$(DIBBLER_VERSION)
DIBBLER_SUFFIX	:= tar.gz
DIBBLER_URL	:= http://klub.com.pl/dhcpv6/dibbler/$(DIBBLER)-src.$(DIBBLER_SUFFIX)
DIBBLER_SOURCE	:= $(SRCDIR)/$(DIBBLER)-src.$(DIBBLER_SUFFIX)
DIBBLER_DIR	:= $(BUILDDIR)/$(DIBBLER)
DIBBLER_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

DIBBLER_MAKE_ENV := $(CROSS_ENV_CC) $(CROSS_ENV_CXX)
DIBBLER_MAKE_OPT := CHOST=$(PTXCONF_GNU_TARGET)
DIBBLER_MAKE_PAR := NO

#
# autoconf
#
# Remove the pre-configure of a sub-component, so configure is
# called in make for correct cross-compilation
$(STATEDIR)/dibbler.prepare:
	@$(call targetinfo)
	@rm -f $(DIBBLER_DIR)/poslib/config.h
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

DIBBLER_INSTALL_OPT := \
	INST_WORKDIR=$(DIBBLER_PKGDIR)/var/lib/dibbler \
	INST_MANDIR=$(DIBBLER_PKGDIR)/usr/share/man \
	INST_DOCDIR=$(DIBBLER_PKGDIR)/usr/share/doc \
	INST_BINDIR=$(DIBBLER_PKGDIR)/usr/sbin \
	INST_CONFDIR=$(DIBBLER_PKGDIR)/etc/dibbler \
	install

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dibbler.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  dibbler)
	@$(call install_fixup, dibbler,PRIORITY,optional)
	@$(call install_fixup, dibbler,SECTION,base)
	@$(call install_fixup, dibbler,AUTHOR,"Remy Bohmer <linux@bohmer.net>")
	@$(call install_fixup, dibbler,DESCRIPTION,missing)

	@$(call install_copy, dibbler, 0, 0, 0755, /etc/dibbler)
	@$(call install_copy, dibbler, 0, 0, 0755, /var/lib/dibbler)
	@$(call install_copy, dibbler, 0, 0, 0755, /var/log/dibbler)

ifdef PTXCONF_DIBBLER_SERVER
	@$(call install_copy, dibbler, 0, 0, 0755, -, /usr/sbin/dibbler-server)
	@$(call install_copy, dibbler, 0, 0, 0644, -, /etc/dibbler/server.conf)
	@$(call install_alternative, dibbler, 0, 0, 0644, /etc/dibbler/server-stateless.conf)
endif

ifdef PTXCONF_DIBBLER_SERVER_STARTSCRIPT
	@$(call install_alternative, dibbler, 0, 0, 0755, /etc/init.d/dibbler-server)

ifneq ($(call remove_quotes,$(PTXCONF_DIBBLER_SERVER_BBINIT_LINK)),)
	@$(call install_link, dibbler, \
		../init.d/dibbler-server, \
		/etc/rc.d/$(PTXCONF_DIBBLER_SERVER_BBINIT_LINK))
endif
endif

ifdef PTXCONF_DIBBLER_CLIENT
	@$(call install_copy, dibbler, 0, 0, 0755, -, /usr/sbin/dibbler-client)
	@$(call install_alternative, dibbler, 0, 0, 0644, /etc/dibbler/client.conf)
	@$(call install_alternative, dibbler, 0, 0, 0644, /etc/dibbler/client-stateless.conf)
endif

ifdef PTXCONF_DIBBLER_CLIENT_STARTSCRIPT
	@$(call install_alternative, dibbler, 0, 0, 0755, /etc/init.d/dibbler-client)

ifneq ($(call remove_quotes,$(PTXCONF_DIBBLER_CLIENT_BBINIT_LINK)),)
	@$(call install_link, dibbler, \
		../init.d/dibbler-client, \
		/etc/rc.d/$(PTXCONF_DIBBLER_CLIENT_BBINIT_LINK))
endif
endif

ifdef PTXCONF_DIBBLER_RELAY
	@$(call install_copy, dibbler, 0, 0, 0755, -, /usr/sbin/dibbler-relay)
	@$(call install_alternative, dibbler, 0, 0, 0644, /etc/dibbler/relay.conf)
endif

ifdef PTXCONF_DIBBLER_RELAY_STARTSCRIPT
	@$(call install_alternative, dibbler, 0, 0, 0755, /etc/init.d/dibbler-relay)

ifneq ($(call remove_quotes,$(PTXCONF_DIBBLER_RELAY_BBINIT_LINK)),)
	@$(call install_link, dibbler, \
		../init.d/dibbler-relay, \
		/etc/rc.d/$(PTXCONF_DIBBLER_RELAY_BBINIT_LINK))
endif
endif

	@$(call install_finish, dibbler)
	@$(call touch)

# vim: syntax=make
