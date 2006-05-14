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
ETHEREAL_URL		= http://netmirror.org/mirror/ftp.ethereal.com/all-versions/$(ETHEREAL).$(ETHEREAL_SUFFIX)
ETHEREAL_SOURCE		= $(SRCDIR)/$(ETHEREAL).$(ETHEREAL_SUFFIX)
ETHEREAL_DIR		= $(BUILDDIR)/$(ETHEREAL)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ethereal_get: $(STATEDIR)/ethereal.get

$(STATEDIR)/ethereal.get: $(ethereal_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ETHEREAL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, ETHEREAL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ethereal_extract: $(STATEDIR)/ethereal.extract

$(STATEDIR)/ethereal.extract: $(ethereal_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHEREAL_DIR))
	@$(call extract, ETHEREAL)
	@$(call patchin, $(ETHEREAL))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ethereal_prepare: $(STATEDIR)/ethereal.prepare

ETHEREAL_PATH	=  PATH=$(CROSS_PATH)
ETHEREAL_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
ETHEREAL_AUTOCONF =  $(CROSS_AUTOCONF_USR) \
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
	--disable-ipv6 \
	--with-pcap=$(LIBPCAP_DIR)

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

$(STATEDIR)/ethereal.prepare: $(ethereal_prepare_deps_default)
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

$(STATEDIR)/ethereal.compile: $(ethereal_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(ETHEREAL_DIR) && $(ETHEREAL_ENV) $(ETHEREAL_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ethereal_install: $(STATEDIR)/ethereal.install

$(STATEDIR)/ethereal.install: $(ethereal_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, ETHEREAL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ethereal_targetinstall: $(STATEDIR)/ethereal.targetinstall

$(STATEDIR)/ethereal.targetinstall: $(ethereal_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ethereal_clean:
	rm -rf $(STATEDIR)/ethereal.*
	rm -rf $(ETHEREAL_DIR)

# vim: syntax=make
