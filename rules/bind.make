# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BIND) += bind

#
# Paths and names
#
BIND_VERSION	= 9.3.0rc3
BIND		= bind-$(BIND_VERSION)
BIND_SUFFIX	= tar.gz
BIND_URL	= ftp://ftp.isc.org/isc/bind9/$(BIND_VERSION)/$(BIND).$(BIND_SUFFIX)
BIND_SOURCE	= $(SRCDIR)/$(BIND).$(BIND_SUFFIX)
BIND_DIR	= $(BUILDDIR)/$(BIND)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bind_get: $(STATEDIR)/bind.get

bind_get_deps = $(BIND_SOURCE)

$(STATEDIR)/bind.get: $(bind_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(BIND_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BIND_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bind_extract: $(STATEDIR)/bind.extract

bind_extract_deps = $(STATEDIR)/bind.get

$(STATEDIR)/bind.extract: $(bind_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BIND_DIR))
	@$(call extract, $(BIND_SOURCE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bind_prepare: $(STATEDIR)/bind.prepare

#
# dependencies
#
bind_prepare_deps = \
	$(STATEDIR)/bind.extract \
	$(STATEDIR)/virtual-xchain.install

BIND_PATH	=  PATH=$(CROSS_PATH)
BIND_ENV 	=  $(CROSS_ENV)
#BIND_ENV	+=

#
# autoconf
#
BIND_AUTOCONF =  $(CROSS_AUTOCONF)
BIND_AUTOCONF += --prefix=$(CROSS_LIB_DIR)
BIND_AUTOCONF += --with-randomdev=/dev/random

ifdef PTXCONF_BIND_THREADS
BIND_AUTOCONF += --enable-threads
endif

ifdef PTXCONF_BIND_CRYPTO
BIND_AUTOCONF += --with-openssl=$(OPENSSL_DIR)
bind_prepare_deps += $(STATEDIR)/openssl.install
endif

ifdef PTXCONF_BIND_IPV6
BIND_AUTOCONF += --enable-ipv6
else
BIND_AUTOCONF += --disable-ipv6
endif

$(STATEDIR)/bind.prepare: $(bind_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BIND_DIR)/config.cache)
	cd $(BIND_DIR) && \
		$(BIND_PATH) $(BIND_ENV) \
		./configure $(BIND_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bind_compile: $(STATEDIR)/bind.compile

bind_compile_deps = $(STATEDIR)/bind.prepare

$(STATEDIR)/bind.compile: $(bind_compile_deps)
	@$(call targetinfo, $@)
	$(BIND_PATH) make -C $(BIND_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bind_install: $(STATEDIR)/bind.install

$(STATEDIR)/bind.install: $(STATEDIR)/bind.compile
	@$(call targetinfo, $@)
	# FIXME: RSC: is it right that we only install and do not targetinstall? 
	@$(call install, BIND)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bind_targetinstall: $(STATEDIR)/bind.targetinstall

bind_targetinstall_deps = $(STATEDIR)/bind.compile

$(STATEDIR)/bind.targetinstall: $(bind_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bind_clean:
	rm -rf $(STATEDIR)/bind.*
	rm -rf $(BIND_DIR)

# vim: syntax=make
