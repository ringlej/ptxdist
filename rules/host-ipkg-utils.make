# -*-makefile-*-
# $Id: template 2224 2005-01-20 15:19:18Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_IPKG_UTILS) += host-ipkg-utils

#
# Paths and names
#
HOSTTOOL-IPKG-UTILS_VERSION	= 1.7
HOSTTOOL-IPKG-UTILS		= ipkg-utils-$(HOSTTOOL-IPKG-UTILS_VERSION)
HOSTTOOL-IPKG-UTILS_SUFFIX	= tar.gz
HOSTTOOL-IPKG-UTILS_URL		= ftp://ftp.handhelds.org/packages/ipkg-utils/$(HOSTTOOL-IPKG-UTILS).$(HOSTTOOL-IPKG-UTILS_SUFFIX)
HOSTTOOL-IPKG-UTILS_SOURCE	= $(SRCDIR)/$(HOSTTOOL-IPKG-UTILS).$(HOSTTOOL-IPKG-UTILS_SUFFIX)
HOSTTOOL-IPKG-UTILS_DIR		= $(HOST_BUILDDIR)/$(HOSTTOOL-IPKG-UTILS)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-ipkg-utils_get: $(STATEDIR)/host-ipkg-utils.get

host-ipkg-utils_get_deps = $(HOSTTOOL-IPKG-UTILS_SOURCE)

$(STATEDIR)/host-ipkg-utils.get: $(host-ipkg-utils_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOL-IPKG-UTILS))
	@$(call touch, $@)

$(HOSTTOOL-IPKG-UTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOL-IPKG-UTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-ipkg-utils_extract: $(STATEDIR)/host-ipkg-utils.extract

host-ipkg-utils_extract_deps = $(STATEDIR)/host-ipkg-utils.get

$(STATEDIR)/host-ipkg-utils.extract: $(host-ipkg-utils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL-IPKG-UTILS_DIR))
	@$(call extract, $(HOSTTOOL-IPKG-UTILS_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOSTTOOL-IPKG-UTILS), $(HOSTTOOL-IPKG-UTILS_DIR))
	perl -i -p -e "s,^PREFIX=(.*),PREFIX=$(PTXCONF_HOST_PREFIX)/usr,g" \
		$(HOSTTOOL-IPKG-UTILS_DIR)/Makefile
	perl -i -p -e "s,^	python setup.py install,	python setup.py install --prefix=$(PTXCONF_HOST_PREFIX)/usr,g" \
		$(HOSTTOOL-IPKG-UTILS_DIR)/Makefile
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-ipkg-utils_prepare: $(STATEDIR)/host-ipkg-utils.prepare

#
# dependencies
#
host-ipkg-utils_prepare_deps = \
	$(STATEDIR)/host-ipkg-utils.extract

HOSTTOOL-IPKG-UTILS_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOL-IPKG-UTILS_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/host-ipkg-utils.prepare: $(host-ipkg-utils_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-ipkg-utils_compile: $(STATEDIR)/host-ipkg-utils.compile

host-ipkg-utils_compile_deps = $(STATEDIR)/host-ipkg-utils.prepare

$(STATEDIR)/host-ipkg-utils.compile: $(host-ipkg-utils_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOL-IPKG-UTILS_DIR) && $(HOSTTOOL-IPKG-UTILS_ENV) $(HOSTTOOL-IPKG-UTILS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-ipkg-utils_install: $(STATEDIR)/host-ipkg-utils.install

$(STATEDIR)/host-ipkg-utils.install: $(STATEDIR)/host-ipkg-utils.compile
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_HOST_PREFIX)/usr/bin
	# ipkg.py is forgotten by MAKE_INSTALL, so we copy it manually
	# FIXME: this should probably be fixed upstream
	@$(call install, HOSTTOOL-IPKG-UTILS,,h)
	mkdir -p $(PTXCONF_HOST_PREFIX)/usr/bin
	cp -f $(HOSTTOOL-IPKG-UTILS_DIR)/ipkg.py $(PTXCONF_HOST_PREFIX)/usr/bin/
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-ipkg-utils_targetinstall: $(STATEDIR)/host-ipkg-utils.targetinstall

host-ipkg-utils_targetinstall_deps = $(STATEDIR)/host-ipkg-utils.install

$(STATEDIR)/host-ipkg-utils.targetinstall: $(host-ipkg-utils_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-ipkg-utils_clean:
	rm -rf $(STATEDIR)/host-ipkg-utils.*
	rm -rf $(HOSTTOOL-IPKG-UTILS_DIR)

# vim: syntax=make
