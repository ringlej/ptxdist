# -*-makefile-*-
# $Id: hosttool-fakeroot.make,v 1.2 2004/08/26 06:23:52 rsc Exp $
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
ifdef PTXCONF_HOSTTOOLS_FAKEROOT
HOSTTOOLS += hosttool-fakeroot
endif

#
# Paths and names
#
HOSTTOOLS_FAKEROOT_VERSION	= 1.0.7
HOSTTOOLS_FAKEROOT		= fakeroot-$(HOSTTOOLS_FAKEROOT_VERSION)
HOSTTOOLS_FAKEROOT_SUFFIX	= tar.gz
HOSTTOOLS_FAKEROOT_URL		= http://ftp.debian.org/debian/pool/main/f/fakeroot/fakeroot_$(HOSTTOOLS_FAKEROOT_VERSION).$(HOSTTOOLS_FAKEROOT_SUFFIX)
HOSTTOOLS_FAKEROOT_SOURCE	= $(SRCDIR)/fakeroot_$(HOSTTOOLS_FAKEROOT_VERSION).$(HOSTTOOLS_FAKEROOT_SUFFIX)
HOSTTOOLS_FAKEROOT_DIR		= $(HOSTTOOLS_BUILDDIR)/$(HOSTTOOLS_FAKEROOT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-fakeroot_get: $(STATEDIR)/hosttool-fakeroot.get

hosttool-fakeroot_get_deps = $(HOSTTOOLS_FAKEROOT_SOURCE)

$(STATEDIR)/hosttool-fakeroot.get: $(hosttool-fakeroot_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(HOSTTOOLS_FAKEROOT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOLS_FAKEROOT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-fakeroot_extract: $(STATEDIR)/hosttool-fakeroot.extract

hosttool-fakeroot_extract_deps = $(STATEDIR)/hosttool-fakeroot.get

$(STATEDIR)/hosttool-fakeroot.extract: $(hosttool-fakeroot_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOLS_FAKEROOT_DIR))
	@$(call extract, $(HOSTTOOLS_FAKEROOT_SOURCE), $(HOSTTOOLS_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-fakeroot_prepare: $(STATEDIR)/hosttool-fakeroot.prepare

#
# dependencies
#
hosttool-fakeroot_prepare_deps = \
	$(STATEDIR)/hosttool-fakeroot.extract

HOSTTOOLS_FAKEROOT_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOLS_FAKEROOT_ENV 	=  $(HOSTCC_ENV)
#HOSTTOOLS_FAKEROOT_ENV	+=

#
# autoconf
#
HOSTTOOLS_FAKEROOT_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST)
 	--host=$(GNU_HOST)
 	--target=$(GNU_HOST)

$(STATEDIR)/hosttool-fakeroot.prepare: $(hosttool-fakeroot_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOLS_FAKEROOT_DIR)/config.cache)
	cd $(HOSTTOOLS_FAKEROOT_DIR) && \
		$(HOSTTOOLS_FAKEROOT_PATH) $(HOSTTOOLS_FAKEROOT_ENV) \
		./configure $(HOSTTOOLS_FAKEROOT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-fakeroot_compile: $(STATEDIR)/hosttool-fakeroot.compile

hosttool-fakeroot_compile_deps = $(STATEDIR)/hosttool-fakeroot.prepare

$(STATEDIR)/hosttool-fakeroot.compile: $(hosttool-fakeroot_compile_deps)
	@$(call targetinfo, $@)
	$(HOSTTOOLS_FAKEROOT_PATH) make -C $(HOSTTOOLS_FAKEROOT_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-fakeroot_install: $(STATEDIR)/hosttool-fakeroot.install

$(STATEDIR)/hosttool-fakeroot.install: $(STATEDIR)/hosttool-fakeroot.compile
	@$(call targetinfo, $@)
	$(HOSTTOOLS_FAKEROOT_PATH) make -C $(HOSTTOOLS_FAKEROOT_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-fakeroot_targetinstall: $(STATEDIR)/hosttool-fakeroot.targetinstall

hosttool-fakeroot_targetinstall_deps = $(STATEDIR)/hosttool-fakeroot.compile

$(STATEDIR)/hosttool-fakeroot.targetinstall: $(hosttool-fakeroot_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-fakeroot_clean:
	rm -rf $(STATEDIR)/hosttool-fakeroot.*
	rm -rf $(HOSTTOOLS_FAKEROOT_DIR)

# vim: syntax=make
