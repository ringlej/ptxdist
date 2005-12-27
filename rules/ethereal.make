# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ETHEREAL) += ethereal

#
# Paths and names
#
ETHEREAL_VERSION	= 0.10.6
ETHEREAL		= ethereal-$(ETHEREAL_VERSION)
ETHEREAL_SUFFIX		= tar.bz2
ETHEREAL_URL		= http://netmirror.org/mirror/ftp.ethereal.com/$(ETHEREAL).$(ETHEREAL_SUFFIX)
ETHEREAL_SOURCE		= $(SRCDIR)/$(ETHEREAL).$(ETHEREAL_SUFFIX)
ETHEREAL_DIR		= $(BUILDDIR)/$(ETHEREAL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ethereal_get: $(STATEDIR)/ethereal.get

ethereal_get_deps = $(ETHEREAL_SOURCE)

$(STATEDIR)/ethereal.get: $(ethereal_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(ETHEREAL))
	@$(call touch, $@)

$(ETHEREAL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(ETHEREAL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ethereal_extract: $(STATEDIR)/ethereal.extract

ethereal_extract_deps = $(STATEDIR)/ethereal.get

$(STATEDIR)/ethereal.extract: $(ethereal_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHEREAL_DIR))
	@$(call extract, $(ETHEREAL_SOURCE))
	@$(call patchin, $(ETHEREAL))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ethereal_prepare: $(STATEDIR)/ethereal.prepare

#
# dependencies
#
ethereal_prepare_deps =  $(STATEDIR)/ethereal.extract
ethereal_prepare_deps += $(STATEDIR)/virtual-xchain.install
ethereal_prepare_deps += $(STATEDIR)/libpcap.install

ETHEREAL_PATH	=  PATH=$(CROSS_PATH)
ETHEREAL_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
ETHEREAL_AUTOCONF =  $(CROSS_AUTOCONF_USR)

ETHEREAL_AUTOCONF += --disable-usr-local
ETHEREAL_AUTOCONF += --disable-threads
ETHEREAL_AUTOCONF += --disable-profile-build
ETHEREAL_AUTOCONF += --disable-gtktest
ETHEREAL_AUTOCONF += --disable-glibtest
ETHEREAL_AUTOCONF += --disable-editcap
ETHEREAL_AUTOCONF += --disable-mergecap
ETHEREAL_AUTOCONF += --disable-text2pcap
ETHEREAL_AUTOCONF += --disable-idl2eth
ETHEREAL_AUTOCONF += --disable-dftest
ETHEREAL_AUTOCONF += --disable-randpkt
ETHEREAL_AUTOCONF += --disable-ipv6
ETHEREAL_AUTOCONF += --with-pcap=$(LIBPCAP_DIR)

ifdef PTXCONF_ETHEREAL_ETHEREAL
ETHEREAL_AUTOCONF += --enable-ethereal
else
ETHEREAL_AUTOCONF += --disable-ethereal
endif
ifdef PTXCONF_ETHEREAL_TETHEREAL
ETHEREAL_AUTOCONF += --enable-tethereal
else
ETHEREAL_AUTOCONF += --disable-tethereal
endif

$(STATEDIR)/ethereal.prepare: $(ethereal_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHEREAL_DIR)/config.cache)
	cd $(ETHEREAL_DIR) && \
		$(ETHEREAL_PATH) $(ETHEREAL_ENV) \
		./configure $(ETHEREAL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ethereal_compile: $(STATEDIR)/ethereal.compile

ethereal_compile_deps = $(STATEDIR)/ethereal.prepare

$(STATEDIR)/ethereal.compile: $(ethereal_compile_deps)
	@$(call targetinfo, $@)
	cd $(ETHEREAL_DIR) && $(ETHEREAL_ENV) $(ETHEREAL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ethereal_install: $(STATEDIR)/ethereal.install

$(STATEDIR)/ethereal.install: $(STATEDIR)/ethereal.compile
	@$(call targetinfo, $@)
	# FIXME: RSC: why do we do that on install, not on targetinstall? 
	@$(call install, ETHEREAL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ethereal_targetinstall: $(STATEDIR)/ethereal.targetinstall

ethereal_targetinstall_deps =  $(STATEDIR)/ethereal.compile
ethereal_targetinstall_deps += $(STATEDIR)/libpcap.targetinstall

$(STATEDIR)/ethereal.targetinstall: $(ethereal_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ethereal_clean:
	rm -rf $(STATEDIR)/ethereal.*
	rm -rf $(ETHEREAL_DIR)

# vim: syntax=make
