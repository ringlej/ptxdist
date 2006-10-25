# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBPCAP) += libpcap

#
# Paths and names
#
LIBPCAP_VERSION	:= 0.9.5
LIBPCAP		:= libpcap-$(LIBPCAP_VERSION)
LIBPCAP_SUFFIX	:= tar.gz
LIBPCAP_URL	:= http://www.tcpdump.org/release/$(LIBPCAP).$(LIBPCAP_SUFFIX)
LIBPCAP_SOURCE	:= $(SRCDIR)/$(LIBPCAP).$(LIBPCAP_SUFFIX)
LIBPCAP_DIR	:= $(BUILDDIR)/$(LIBPCAP)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

libpcap_get: $(STATEDIR)/libpcap.get

$(STATEDIR)/libpcap.get: $(libpcap_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIBPCAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIBPCAP)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

libpcap_extract: $(STATEDIR)/libpcap.extract

$(STATEDIR)/libpcap.extract: $(libpcap_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPCAP_DIR))
	@$(call extract, LIBPCAP)
	@$(call patchin, LIBPCAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

libpcap_prepare: $(STATEDIR)/libpcap.prepare

LIBPCAP_PATH := PATH=$(CROSS_PATH)
LIBPCAP_ENV := \
	$(CROSS_ENV) \
	ac_cv_linux_vers=2

#
# autoconf
#
LIBPCAP_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-pcap=linux

# FIXME: Missing switches
# --disable-protochain disable \"protochain\" insn
# --enable-optimizer-dbg  build optimizer debugging code
# --enable-yydebug build parser debugging code
# --with-dag  include Endace DAG support
# --with-septel include Septel support
#

ifdef PTXCONF_LIBPCAP_IPV6
LIBPCAP_AUTOCONF += --enable-ipv6
else
LIBPCAP_AUTOCONF += --disable-ipv6
endif

$(STATEDIR)/libpcap.prepare: $(libpcap_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBPCAP_BUILDDIR))
	cd $(LIBPCAP_DIR) && \
		$(LIBPCAP_PATH) $(LIBPCAP_ENV) \
		./configure $(LIBPCAP_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

libpcap_compile: $(STATEDIR)/libpcap.compile

$(STATEDIR)/libpcap.compile: $(libpcap_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(LIBPCAP_DIR) && \
		$(LIBPCAP_ENV) $(LIBPCAP_PATH) $(LIBPCAP_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

libpcap_install: $(STATEDIR)/libpcap.install

$(STATEDIR)/libpcap.install: $(libpcap_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIBPCAP)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

libpcap_targetinstall: $(STATEDIR)/libpcap.targetinstall

$(STATEDIR)/libpcap.targetinstall: $(libpcap_targetinstall_deps_default)
	@$(call targetinfo, $@)
# no targetinstall, cause it's a static lib (mkl)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

libpcap_clean:
	rm -rf $(STATEDIR)/libpcap.*
	rm -rf $(LIBPCAP_DIR)

# vim: syntax=make
