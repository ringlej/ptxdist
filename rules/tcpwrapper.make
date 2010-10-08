# -*-makefile-*-
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_TCPWRAPPER) += tcpwrapper

#
# Paths and names
#
TCPWRAPPER_VERSION		:= 7.6
TCPWRAPPER_MD5			:= e6fa25f71226d090f34de3f6b122fb5a
TCPWRAPPER			:= tcp_wrappers_$(TCPWRAPPER_VERSION)
TCPWRAPPER_URL			:= ftp://ftp.porcupine.org/pub/security/$(TCPWRAPPER).tar.gz
TCPWRAPPER_SOURCE		:= $(SRCDIR)/$(TCPWRAPPER).tar.gz
TCPWRAPPER_DIR			:= $(BUILDDIR)/$(TCPWRAPPER)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(TCPWRAPPER_SOURCE):
	@$(call targetinfo)
	@$(call get, TCPWRAPPER)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

TCPWRAPPER_PATH		:= PATH=$(CROSS_PATH)
TCPWRAPPER_MAKE_ENV	:= $(CROSS_ENV)
TCPWRAPPER_MAKE_OPT	:= linux

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcpwrapper.install:
	@$(call targetinfo)
	install -d $(SYSROOT)/include
	install $(TCPWRAPPER_DIR)/tcpd.h $(SYSROOT)/include
	install -d $(SYSROOT)/lib
	install $(TCPWRAPPER_DIR)/libwrap.a $(SYSROOT)/lib
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/tcpwrapper.targetinstall:
	@$(call targetinfo)

	@$(call install_init, tcpwrapper)
	@$(call install_fixup, tcpwrapper,PRIORITY,optional)
	@$(call install_fixup, tcpwrapper,SECTION,base)
	@$(call install_fixup, tcpwrapper,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, tcpwrapper,DESCRIPTION,missing)

ifdef PTXCONF_TCPWRAPPER_INSTALL_TCPD
	@$(call install_copy, tcpwrapper, 0, 0, 0755, $(TCPWRAPPER_DIR)/tcpd, /usr/sbin/tcpd)
endif

ifdef PTXCONF_TCPWRAPPER_INSTALL_HOSTS_ACCESS_CONFIGS
	@$(call install_alternative, tcpwrapper, 0, 0, 0644, /etc/hosts.allow)
	@$(call install_alternative, tcpwrapper, 0, 0, 0644, /etc/hosts.deny)
endif

	@$(call install_finish, tcpwrapper)
	@$(call touch)

# vim: syntax=make
