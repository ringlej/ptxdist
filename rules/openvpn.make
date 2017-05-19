# -*-makefile-*-
#
# Copyright (C) 2007 by Carsten Schlote <c.schlote@konzeptpark.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENVPN) += openvpn

#
# Paths and names
#
OPENVPN_VERSION		:= 2.3.13
OPENVPN_MD5		:= 4955e1d35bf5dc2c3ed9b98c280ee661
OPENVPN			:= openvpn-$(OPENVPN_VERSION)
OPENVPN_SUFFIX		:= tar.xz
OPENVPN_URL		:= http://swupdate.openvpn.org/community/releases/$(OPENVPN).$(OPENVPN_SUFFIX)
OPENVPN_SOURCE		:= $(SRCDIR)/$(OPENVPN).$(OPENVPN_SUFFIX)
OPENVPN_DIR		:= $(BUILDDIR)/$(OPENVPN)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

OPENVPN_PATH	:= PATH=$(CROSS_PATH)
OPENVPN_ENV	:= \
	$(CROSS_ENV) \
	IFCONFIG=/usr/sbin/ifconfig \
	ROUTE=/usr/sbin/route \
	IPROUTE=/usr/sbin/ip \
	NETSTAT=/usr/bin/netstat

#
# autoconf
#
OPENVPN_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_OPENVPN_LZO)-lzo \
	--disable-plugins \
	--disable-debug \
	--$(call ptx/endis, PTXCONF_OPENVPN_SMALL)-small \
	--disable-iproute2 \
	--disable-selinux \
	--$(call ptx/endis, PTXCONF_OPENVPN_SYSTEMD)-systemd \
	--with-crypto-library=openssl

OPENVPN_INSTALL_SAMPLE_CONFIG_FILES := \
	client.conf loopback-client loopback-server README server.conf \
	static-home.conf static-office.conf tls-home.conf tls-office.conf \
	xinetd-client-config xinetd-server-config

OPENVPN_INSTALL_SAMPLE_CONFIG_SCRIPTS := \
	firewall.sh home.up office.up openvpn-shutdown.sh openvpn-startup.sh

OPENVPN_INSTALL_SAMPLE_SCRIPTS := bridge-start bridge-stop

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openvpn.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openvpn)
	@$(call install_fixup, openvpn,PRIORITY,optional)
	@$(call install_fixup, openvpn,SECTION,base)
	@$(call install_fixup, openvpn,AUTHOR,"Carsten Schlote <c.schlote@konzeptpark.de>")
	@$(call install_fixup, openvpn,DESCRIPTION,missing)

ifdef PTXCONF_OPENVPN_INSTALL_SAMPLE_CONFIGS
	@$(foreach file,$(OPENVPN_INSTALL_SAMPLE_CONFIG_FILES), \
		$(call install_copy, openvpn, 0, 0, 0644, \
		$(OPENVPN_DIR)/sample/sample-config-files/$(file), \
		/usr/share/openvpn/sample-config-files/$(file));)

	@$(foreach script,$(OPENVPN_INSTALL_SAMPLE_CONFIG_SCRIPTS), \
		$(call install_copy, openvpn, 0, 0, 0755, \
		$(OPENVPN_DIR)/sample/sample-config-files/$(script), \
		/usr/share/openvpn/sample-config-files/$(script));)
endif

ifdef PTXCONF_OPENVPN_INSTALL_SAMPLE_SCRIPTS
	@$(foreach script,$(OPENVPN_INSTALL_SAMPLE_SCRIPTS), \
		$(call install_copy, openvpn, 0, 0, 0755, \
		$(OPENVPN_DIR)/sample/sample-scripts/$(script), \
		/usr/share/openvpn/sample-scripts/$(script));)
endif

	@$(call install_copy, openvpn, 0, 0, 0755, -, /usr/sbin/openvpn)

	@$(call install_finish, openvpn)

	@$(call touch)

# vim: syntax=make

