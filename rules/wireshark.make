# -*-makefile-*-
#
# Copyright (C) 2006 by Juergen Beisert
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#           (C) 2013 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WIRESHARK) += wireshark

#
# Paths and names
#
WIRESHARK_VERSION	:= 1.8.7
WIRESHARK_MD5		:= f4198728a20aa40752906031e08544f8
WIRESHARK		:= wireshark-$(WIRESHARK_VERSION)
WIRESHARK_SUFFIX	:= tar.bz2
WIRESHARK_URL		:= http://www.wireshark.org/download/src/all-versions/$(WIRESHARK).$(WIRESHARK_SUFFIX)
WIRESHARK_SOURCE	:= $(SRCDIR)/$(WIRESHARK).$(WIRESHARK_SUFFIX)
WIRESHARK_DIR		:= $(BUILDDIR)/$(WIRESHARK)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WIRESHARK_PATH	:= PATH=$(CROSS_PATH)
WIRESHARK_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
WIRESHARK_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--disable-usr-local \
	--disable-wireshark \
	--disable-packet-editor \
	--disable-profile-build \
	--disable-gtktest \
	--disable-glibtest \
	--enable-tshark \
	--enable-editcap \
	--enable-capinfos \
	--enable-mergecap \
	--disable-text2pcap \
	--disable-dftest \
	--disable-randpkt \
	--disable-airpcap \
	--enable-dumpcap \
	--disable-rawshark \
	--disable-pcap-ng-default \
	$(GLOBAL_IPV6_OPTION) \
	--disable-setcap-install \
	--disable-setuid-install \
	--with-pcap=$(LIBPCAP_DIR) \
	--without-plugins \
	--without-gcrypt \
	--without-libcap

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wireshark.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wireshark)
	@$(call install_fixup, wireshark,PRIORITY,optional)
	@$(call install_fixup, wireshark,SECTION,base)
	@$(call install_fixup, wireshark,AUTHOR,"Juergen Beisert <j.beisert@pengutronix.de>")
	@$(call install_fixup, wireshark,DESCRIPTION,missing)
#
# executables
#
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/editcap)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/capinfos)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/mergecap)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/dumpcap)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/tshark)
#
# libraries used by some of the executables
#
	@$(call install_lib, wireshark, 0, 0, 0644, libwireshark)
	@$(call install_lib, wireshark, 0, 0, 0644, libwiretap)
	@$(call install_lib, wireshark, 0, 0, 0644, libwsutil)

	@$(call install_finish, wireshark)

	@$(call touch)

# vim: syntax=make
