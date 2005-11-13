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
HOST_PACKAGES-$(PTXCONF_HOSTTOOL_IPKG_UTILS) += hosttool-ipkg-utils

#
# Paths and names
#
HOSTTOOL-IPKG-UTILS_VERSION	= 1.7
HOSTTOOL-IPKG-UTILS		= ipkg-utils-$(HOSTTOOL-IPKG-UTILS_VERSION)
HOSTTOOL-IPKG-UTILS_SUFFIX	= tar.gz
HOSTTOOL-IPKG-UTILS_URL		= ftp://ftp.handhelds.org/packages/ipkg-utils/$(HOSTTOOL-IPKG-UTILS).$(HOSTTOOL-IPKG-UTILS_SUFFIX)
HOSTTOOL-IPKG-UTILS_SOURCE	= $(SRCDIR)/$(HOSTTOOL-IPKG-UTILS).$(HOSTTOOL-IPKG-UTILS_SUFFIX)
HOSTTOOL-IPKG-UTILS_DIR		= $(HOST_BUILDDIR)/$(HOSTTOOL-IPKG-UTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-ipkg-utils_get: $(STATEDIR)/hosttool-ipkg-utils.get

hosttool-ipkg-utils_get_deps = $(HOSTTOOL-IPKG-UTILS_SOURCE)

$(STATEDIR)/hosttool-ipkg-utils.get: $(hosttool-ipkg-utils_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOL-IPKG-UTILS))
	$(call touch, $@)

$(HOSTTOOL-IPKG-UTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOL-IPKG-UTILS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-ipkg-utils_extract: $(STATEDIR)/hosttool-ipkg-utils.extract

hosttool-ipkg-utils_extract_deps = $(STATEDIR)/hosttool-ipkg-utils.get

$(STATEDIR)/hosttool-ipkg-utils.extract: $(hosttool-ipkg-utils_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL-IPKG-UTILS_DIR))
	@$(call extract, $(HOSTTOOL-IPKG-UTILS_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOSTTOOL-IPKG-UTILS))
	perl -i -p -e "s,^PREFIX=(.*),PREFIX=$(PTXCONF_PREFIX),g" \
		$(HOSTTOOL-IPKG-UTILS_DIR)/Makefile
	perl -i -p -e "s,^	python setup.py install,	python setup.py install --prefix=$(PTXCONF_PREFIX),g" \
		$(HOSTTOOL-IPKG-UTILS_DIR)/Makefile
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-ipkg-utils_prepare: $(STATEDIR)/hosttool-ipkg-utils.prepare

#
# dependencies
#
hosttool-ipkg-utils_prepare_deps = \
	$(STATEDIR)/hosttool-ipkg-utils.extract

HOSTTOOL-IPKG-UTILS_PATH	=  PATH=$(CROSS_PATH)
HOSTTOOL-IPKG-UTILS_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/hosttool-ipkg-utils.prepare: $(hosttool-ipkg-utils_prepare_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-ipkg-utils_compile: $(STATEDIR)/hosttool-ipkg-utils.compile

hosttool-ipkg-utils_compile_deps = $(STATEDIR)/hosttool-ipkg-utils.prepare

$(STATEDIR)/hosttool-ipkg-utils.compile: $(hosttool-ipkg-utils_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOL-IPKG-UTILS_DIR) && $(HOSTTOOL-IPKG-UTILS_ENV) $(HOSTTOOL-IPKG-UTILS_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-ipkg-utils_install: $(STATEDIR)/hosttool-ipkg-utils.install

$(STATEDIR)/hosttool-ipkg-utils.install: $(STATEDIR)/hosttool-ipkg-utils.compile
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/bin
	# ipkg.py is forgotten by make install, so we copy it manually
	# FIXME: this should probably be fixed upstream
	cd $(HOSTTOOL-IPKG-UTILS_DIR) && (\
		$(HOSTTOOL-IPKG-UTILS_ENV) $(HOSTTOOL-IPKG-UTILS_PATH) make install;\
		cp -f ipkg.py $(PTXCONF_PREFIX)/bin/;\
	)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-ipkg-utils_targetinstall: $(STATEDIR)/hosttool-ipkg-utils.targetinstall

hosttool-ipkg-utils_targetinstall_deps = $(STATEDIR)/hosttool-ipkg-utils.install

$(STATEDIR)/hosttool-ipkg-utils.targetinstall: $(hosttool-ipkg-utils_targetinstall_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-ipkg-utils_clean:
	rm -rf $(STATEDIR)/hosttool-ipkg-utils.*
	rm -rf $(HOSTTOOL-IPKG-UTILS_DIR)

# vim: syntax=make
