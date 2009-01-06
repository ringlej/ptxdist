# -*-makefile-*-
# $Id: pppd.make 3876 2006-01-12 20:18:48Z rsc $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#             GYRO net GmbH <info@gyro-net.de>, Hannover, Germany
# Copyright (C) 2008 by Juergen Beisert <juergen@kreuzholzen.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PPP) += ppp

#
# Paths and names
#
PPP_VERSION	:= 2.4.4
PPP		:= ppp-$(PPP_VERSION)
PPP_SUFFIX	:= tar.gz
PPP_URL		:= ftp://ftp.samba.org/pub/ppp/$(PPP).$(PPP_SUFFIX)
PPP_SOURCE	:= $(SRCDIR)/$(PPP).$(PPP_SUFFIX)
PPP_DIR		:= $(BUILDDIR)/$(PPP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PPP_SOURCE):
	@$(call targetinfo)
	@$(call get, PPP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/ppp.extract:
	@$(call targetinfo)
	@$(call clean, $(PPP_DIR))
	@$(call extract, PPP)
	@$(call patchin, PPP)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PPP_PATH	:= PATH=$(CROSS_PATH)
PPP_ENV		:= CROSS=$(CROSS_ENV)

#
# path to where the shared library based plugins get installed
# (and be searched at runtime)
#
PPP_SHARED_INST_PATH := /usr/lib/pppd/$(PPP_VERSION)

$(STATEDIR)/ppp.prepare:
	@$(call targetinfo)
	cd $(PPP_DIR) && $(PPP_PATH) $(PPP_ENV) ./configure

# FIXME: Should also be entries in the menu
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,MPPE=y)

ifdef PTXCONF_PPP_TDB
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,USE_TDB=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,USE_TDB=y)
endif

ifdef PTXCONF_PPP_MS_CHAP
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,CHAPMS=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,CHAPMS=y)
endif

ifdef PTXCONF_PPP_IPV6
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,HAVE_INET6=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,HAVE_INET6=y)
endif

ifdef PTXCONF_PPP_MS_CBCP
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,CBCP=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,CBCP=y)
endif

ifdef PTXCONF_PPP_SHADOW
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,HAS_SHADOW=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,HAS_SHADOW=y)
endif

ifdef PTXCONF_PPP_NEEDS_CRYPT
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,USE_CRYPT=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,USE_CRYPT=y)
endif

ifdef PTXCONF_PPP_PLUGINS
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,PLUGIN=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,PLUGIN=y)
endif

ifndef PTXCONF_PPP_IPX
	@perl -p -i -e 's/-DIPX_CHANGE //' $(PPP_DIR)/pppd/Makefile
	@perl -p -i -e 's/ipxcp.o //' $(PPP_DIR)/pppd/Makefile
endif

ifndef PTXCONF_PPP_MULTILINK
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,HAVE_MULTILINK=y)
	@perl -p -i -e 's/-DHAVE_MULTILINK //' $(PPP_DIR)/pppd/Makefile
	@perl -p -i -e 's/multilink.o //' $(PPP_DIR)/pppd/Makefile
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/ppp.compile:
	@$(call targetinfo)
	cd $(PPP_DIR) && \
		$(PPP_PATH) $(MAKE) $(PPP_ENV) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ppp.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ppp.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ppp)
	@$(call install_fixup, ppp,PACKAGE,ppp)
	@$(call install_fixup, ppp,PRIORITY,optional)
	@$(call install_fixup, ppp,VERSION,$(PPP_VERSION))
	@$(call install_fixup, ppp,SECTION,base)
	@$(call install_fixup, ppp,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, ppp,DEPENDS,)
	@$(call install_fixup, ppp,DESCRIPTION,missing)

	@$(call install_copy, ppp, 0, 0, 0755, \
		$(PPP_DIR)/pppd/pppd, /usr/sbin/pppd)

ifdef PTXCONF_PPP_INST_CHAT
	@$(call install_copy, ppp, 0, 0, 0755, \
		$(PPP_DIR)/chat/chat, /usr/sbin/chat)
endif

	# install configuration files
	@$(call install_alternative, ppp, 0, 0, 0600, /etc/ppp/options, n)
	@$(call install_alternative, ppp, 0, 0, 0750, /etc/ppp/ip-up, n)
	@$(call install_alternative, ppp, 0, 0, 0750, /etc/ppp/ip-down, n)
	@$(call install_alternative, ppp, 0, 0, 0600, /etc/ppp/options.server, n)
	@$(call install_alternative, ppp, 0, 0, 0600, /etc/ppp/options.ttyS0, n)
	@$(call install_alternative, ppp, 0, 0, 0600, /etc/ppp/pap-secrets, n)

# handle system startup on demand
ifdef PTXCONF_PPP_INSTALL_START_SCRIPT
	@$(call install_copy, ppp, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/pppd, \
		/etc/init.d/pppd)
endif
ifneq ($(PTXCONF_PPP_INSTALL_START_LINK),"")
	@$(call install_link, ppp, ../init.d/pppd, \
		/etc/rc.d/$(PTXCONF_PPP_INSTALL_START_LINK))
endif

ifdef PTXCONF_PPP_INST_PPPDUMP
	@$(call install_copy, ppp, 0, 0, 0755, \
		$(PPP_DIR)/pppdump/pppdump, /usr/sbin/pppdump)
endif

ifdef PTXCONF_PPP_INST_PPPSTATS
	@$(call install_copy, ppp, 0, 0, 0755, \
		$(PPP_DIR)/pppstats/pppstats, /usr/sbin/pppstats)
endif

ifdef PTXCONF_PPP_PLUGINS
	@$(call install_copy, ppp, 0, 0, 0755, $(PPP_SHARED_INST_PATH))

ifdef PTXCONF_PPP_OATM
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/pppoatm/pppoatm.so, \
		$(PPP_SHARED_INST_PATH)/pppoatm.so)
endif
ifdef PTXCONF_PPP_RADIUS
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/radius/radius.so, \
		$(PPP_SHARED_INST_PATH)/radius.so)
endif
ifdef PTXCONF_PPP_RADATTR
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/radius/radattr.so, \
		$(PPP_SHARED_INST_PATH)/radattr.so)
endif
ifdef PTXCONF_PPP_RADREALMS
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/radius/radrealms.so, \
		$(PPP_SHARED_INST_PATH)/radrealms.so)
endif
ifdef PTXCONF_PPP_OE
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/rp-pppoe/rp-pppoe.so, \
		$(PPP_SHARED_INST_PATH)/rp-pppoe.so)
endif
ifdef PTXCONF_PPP_MINCONN
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/minconn.so, \
		$(PPP_SHARED_INST_PATH)/minconn.so)
endif
ifdef PTXCONF_PPP_PASSPROMPT
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/passprompt.so, \
		$(PPP_SHARED_INST_PATH)/passprompt.so)
endif
ifdef PTXCONF_PPP_PASSWORDFD
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/passwordfd.so, \
		$(PPP_SHARED_INST_PATH)/passwordfd.so)
endif
ifdef PTXCONF_PPP_WINBIND
	@$(call install_copy, ppp, 0, 0, 0644, \
		$(PPP_DIR)/pppd/plugins/winbind.so, \
		$(PPP_SHARED_INST_PATH)/winbind.so)
endif
endif
	@$(call install_finish, ppp)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ppp_clean:
	rm -rf $(STATEDIR)/ppp.*
	rm -rf $(PKGDIR)/ppp_*
	rm -rf $(PPP_DIR)

# vim: syntax=make
