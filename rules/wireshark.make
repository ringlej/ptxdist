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
WIRESHARK_VERSION	:= 2.0.3
WIRESHARK_MD5		:= 62dc20f5a77542feed2e38f18db8ae3b
WIRESHARK		:= wireshark-$(WIRESHARK_VERSION)
WIRESHARK_SUFFIX	:= tar.bz2
WIRESHARK_URL		:= http://www.wireshark.org/download/src/all-versions/$(WIRESHARK).$(WIRESHARK_SUFFIX)
WIRESHARK_SOURCE	:= $(SRCDIR)/$(WIRESHARK).$(WIRESHARK_SUFFIX)
WIRESHARK_DIR		:= $(BUILDDIR)/$(WIRESHARK)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
WIRESHARK_CONF_TOOL	:= autoconf
WIRESHARK_CONF_OPT	= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-usr-local \
	--disable-wireshark \
	--disable-packet-editor \
	--disable-profile-build \
	--disable-gtktest \
	--disable-glibtest \
	--enable-tshark \
	--enable-editcap \
	--enable-capinfos \
	--enable-captype \
	--enable-mergecap \
	--enable-reordercap \
	--disable-text2pcap \
	--disable-dftest \
	--disable-randpkt \
	--disable-airpcap \
	--enable-dumpcap \
	--disable-rawshark \
	--disable-androiddump \
	--disable-androiddump-use-libpcap \
	--disable-echld \
	--disable-tfshark \
	--disable-pcap-ng-default \
	$(GLOBAL_IPV6_OPTION) \
	--disable-setcap-install \
	--disable-setuid-install \
	--without-qt \
	--without-gtk2 \
	--without-gtk3 \
	--without-gnutls \
	--without-gcrypt \
	--with-libnl=3 \
	--without-libsmi \
	--without-osx-integration \
	--with-pcap=$(SYSROOT)/usr \
	--with-zlib \
	--without-lua \
	--without-portaudio \
	--without-libcap \
	--without-ssl \
	--without-krb5 \
	--without-c-ares \
	--without-adns \
	--without-geoip \
	--without-sbc \
	--without-plugins \
	--without-extcap

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
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/capinfos)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/captype)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/dumpcap)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/editcap)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/idl2wrs)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/mergecap)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/reordercap)
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
