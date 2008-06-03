# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
#
# Copyright (C) 2006 by Juergen Beisert
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
WIRESHARK_VERSION	:= 0.99.3a
WIRESHARK		:= wireshark-$(WIRESHARK_VERSION)
WIRESHARK_SUFFIX	:= tar.gz
WIRESHARK_URL		:= http://www.wireshark.org/download/src/all-versions/$(WIRESHARK).$(WIRESHARK_SUFFIX)
WIRESHARK_SOURCE	:= $(SRCDIR)/$(WIRESHARK).$(WIRESHARK_SUFFIX)
WIRESHARK_DIR		:= $(BUILDDIR)/$(WIRESHARK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

wireshark_get: $(STATEDIR)/wireshark.get

$(STATEDIR)/wireshark.get: $(wireshark_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(WIRESHARK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, WIRESHARK)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

wireshark_extract: $(STATEDIR)/wireshark.extract

$(STATEDIR)/wireshark.extract: $(wireshark_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(WIRESHARK_DIR))
	@$(call extract, WIRESHARK)
	@$(call patchin, WIRESHARK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

wireshark_prepare: $(STATEDIR)/wireshark.prepare

WIRESHARK_PATH	:= PATH=$(CROSS_PATH)
WIRESHARK_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
WIRESHARK_AUTOCONF = $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--disable-usr-local \
	--disable-threads \
	--disable-profile-build \
	--disable-gtktest \
	--disable-glibtest \
	--disable-editcap \
	--disable-mergecap \
	--disable-text2pcap \
	--disable-idl2eth \
	--disable-dftest \
	--disable-randpkt \
	--with-pcap=$(LIBPCAP_DIR)

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

ifdef PTXCONF_WIRESHARK_IPV6
WIRESHARK_AUTOCONF	+= --enable-ipv6
else
WIRESHARK_AUTOCONF	+= --disable-ipv6
endif

$(STATEDIR)/wireshark.prepare: $(wireshark_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(WIRESHARK_DIR)/config.cache)
	cd $(WIRESHARK_DIR) && \
		$(WIRESHARK_PATH) $(WIRESHARK_ENV) \
		./configure $(WIRESHARK_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

wireshark_compile: $(STATEDIR)/wireshark.compile

$(STATEDIR)/wireshark.compile: $(wireshark_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(WIRESHARK_DIR) && $(WIRESHARK_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

wireshark_install: $(STATEDIR)/wireshark.install

$(STATEDIR)/wireshark.install: $(wireshark_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, WIRESHARK)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

wireshark_targetinstall: $(STATEDIR)/wireshark.targetinstall

$(STATEDIR)/wireshark.targetinstall: $(wireshark_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, wireshark)
	@$(call install_fixup,wireshark,PACKAGE,wireshark)
	@$(call install_fixup,wireshark,PRIORITY,optional)
	@$(call install_fixup,wireshark,VERSION,$(WIRESHARK_VERSION))
	@$(call install_fixup,wireshark,SECTION,base)
	@$(call install_fixup,wireshark,AUTHOR,"Juergen Beisert <j.bisert\@pengutronix.de>")
	@$(call install_fixup,wireshark,DEPENDS,)
	@$(call install_fixup,wireshark,DESCRIPTION,missing)
#
# executables
#
	@$(call install_copy, wireshark, 0, 0, 0755, \
		$(WIRESHARK_DIR)/.libs/capinfos, /usr/bin/capinfos)
	@$(call install_copy, wireshark, 0, 0, 0755, \
		$(WIRESHARK_DIR)/.libs/dumpcap, /usr/bin/dumpcap)
	@$(call install_copy, wireshark, 0, 0, 0755, \
		$(WIRESHARK_DIR)/.libs/lt-tshark, /usr/bin/lt-tshark)
	@$(call install_copy, wireshark, 0, 0, 0755, \
		$(WIRESHARK_DIR)/.libs/tshark, /usr/bin/tshark)
#
# libraries used by some of the executables
#
	@$(call install_copy, wireshark, 0, 0, 0644, \
		$(WIRESHARK_DIR)/wiretap/.libs/libwiretap.so.0.0.1, \
		/usr/lib/libwiretap.so.0.0.1)
	@$(call install_link, wireshark, libwiretap.so.0.0.1, \
		/usr/lib/libwiretap.so.0)
	@$(call install_link, wireshark, libwiretap.so.0.0.1, \
		/usr/lib/libwiretap.so)

	@$(call install_copy, wireshark, 0, 0, 0644, \
		$(WIRESHARK_DIR)/epan/.libs/libwireshark.so.0.0.1, \
		/usr/lib/libwireshark.so.0.0.1)
	@$(call install_link, wireshark, libwireshark.so.0.0.1, \
		/usr/lib/libwireshark.so.0)
	@$(call install_link, wireshark, libwireshark.so.0.0.1, \
		/usr/lib/libwireshark.so)

	@$(call install_finish,wireshark)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

wireshark_clean:
	rm -rf $(STATEDIR)/wireshark.*
	rm -rf $(PKGDIR)/wireshark_*
	rm -rf $(WIRESHARK_DIR)

# vim: syntax=make
