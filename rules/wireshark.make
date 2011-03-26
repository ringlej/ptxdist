# -*-makefile-*-
#
# Copyright (C) 2006 by Juergen Beisert
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
PACKAGES-$(PTXCONF_WIRESHARK) += wireshark

#
# Paths and names
#
WIRESHARK_VERSION	:= 1.2.5
WIRESHARK		:= wireshark-$(WIRESHARK_VERSION)
WIRESHARK_SUFFIX	:= tar.gz
WIRESHARK_URL		:= http://www.wireshark.org/download/src/all-versions/$(WIRESHARK).$(WIRESHARK_SUFFIX)
WIRESHARK_SOURCE	:= $(SRCDIR)/$(WIRESHARK).$(WIRESHARK_SUFFIX)
WIRESHARK_DIR		:= $(BUILDDIR)/$(WIRESHARK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(WIRESHARK_SOURCE):
	@$(call targetinfo)
	@$(call get, WIRESHARK)

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
	$(GLOBAL_IPV6_OPTION) \
	--disable-usr-local \
	--disable-threads \
	--disable-profile-build \
	--disable-glibtest \
	--disable-editcap \
	--disable-mergecap \
	--disable-text2pcap \
	--disable-dftest \
	--disable-randpkt \
	--with-pcap=$(LIBPCAP_DIR) \
	--with-pcre \
	--without-gcrypt \
	--without-libcap

ifdef PTXCONF_WIRESHARK_TSHARK
WIRESHARK_AUTOCONF	+= --enable-tshark
else
WIRESHARK_AUTOCONF	+= --disable-tshark
endif

ifdef PTXCONF_WIRESHARK_WIRESHARK
WIRESHARK_AUTOCONF	+= --enable-wireshark
else
WIRESHARK_AUTOCONF	+= --disable-wireshark
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wireshark.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wireshark)
	@$(call install_fixup, wireshark,PRIORITY,optional)
	@$(call install_fixup, wireshark,SECTION,base)
	@$(call install_fixup, wireshark,AUTHOR,"Juergen Beisert <j.bisert@pengutronix.de>")
	@$(call install_fixup, wireshark,DESCRIPTION,missing)
#
# executables
#
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/capinfos)
	@$(call install_copy, wireshark, 0, 0, 0755, -, /usr/bin/dumpcap)
	@$(call install_copy, wireshark, 0, 0, 0755, -, \
		/usr/bin/tshark)
#
# libraries used by some of the executables
#
	@$(call install_lib, wireshark, 0, 0, 0644, libwsutil)
	@$(call install_lib, wireshark, 0, 0, 0644, libwiretap)
	@$(call install_lib, wireshark, 0, 0, 0644, libwireshark)

	@$(call install_finish, wireshark)

	@$(call touch)

# vim: syntax=make
