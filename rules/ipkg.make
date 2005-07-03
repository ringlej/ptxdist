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
ifdef PTXCONF_IPKG
PACKAGES += ipkg
endif

#
# Paths and names
#
IPKG_VERSION		= 0.99.151
IPKG			= ipkg-$(IPKG_VERSION)
IPKG_SUFFIX		= tar.gz
IPKG_URL		= http://www.handhelds.org/download/packages/ipkg/$(IPKG).$(IPKG_SUFFIX)
IPKG_SOURCE		= $(SRCDIR)/$(IPKG).$(IPKG_SUFFIX)
IPKG_DIR		= $(BUILDDIR)/$(IPKG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ipkg_get: $(STATEDIR)/ipkg.get

ipkg_get_deps = $(IPKG_SOURCE)

$(STATEDIR)/ipkg.get: $(ipkg_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(IPKG))
	touch $@

$(IPKG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(IPKG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ipkg_extract: $(STATEDIR)/ipkg.extract

ipkg_extract_deps = $(STATEDIR)/ipkg.get

$(STATEDIR)/ipkg.extract: $(ipkg_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(IPKG_DIR))
	@$(call extract, $(IPKG_SOURCE))
	@$(call patchin, $(IPKG))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ipkg_prepare: $(STATEDIR)/ipkg.prepare

#
# dependencies
#
ipkg_prepare_deps = \
	$(STATEDIR)/ipkg.extract \
	$(STATEDIR)/virtual-xchain.install

IPKG_PATH	=  PATH=$(CROSS_PATH)
IPKG_ENV 	=  $(CROSS_ENV)
#IPKG_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#IPKG_ENV	+=

#
# autoconf
#
IPKG_AUTOCONF =  $(CROSS_AUTOCONF)
IPKG_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/ipkg.prepare: $(ipkg_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(IPKG_DIR)/config.cache)
	cd $(IPKG_DIR) && \
		$(IPKG_PATH) $(IPKG_ENV) \
		./configure $(IPKG_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ipkg_compile: $(STATEDIR)/ipkg.compile

ipkg_compile_deps = $(STATEDIR)/ipkg.prepare

$(STATEDIR)/ipkg.compile: $(ipkg_compile_deps)
	@$(call targetinfo, $@)
	cd $(IPKG_DIR) && $(IPKG_ENV) $(IPKG_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ipkg_install: $(STATEDIR)/ipkg.install

$(STATEDIR)/ipkg.install: $(STATEDIR)/ipkg.compile
	@$(call targetinfo, $@)
	cd $(IPKG_DIR) && $(IPKG_ENV) $(IPKG_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ipkg_targetinstall: $(STATEDIR)/ipkg.targetinstall

ipkg_targetinstall_deps = $(STATEDIR)/ipkg.compile

$(STATEDIR)/ipkg.targetinstall: $(ipkg_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,ipkg)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(IPKG_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(IPKG_DIR)/.libs/libipkg.so.0.0.0, /usr/lib/libipkg.so.0.0.0)
	@$(call install_link, libipkg.so.0.0.0, /usr/lib/libipkg.so.0.0)
	@$(call install_link, libipkg.so.0.0.0, /usr/lib/libipkg.so.0)

	@$(call install_copy, 0, 0, 0755, $(IPKG_DIR)/.libs/ipkg-cl, /usr/bin/ipkg)

ifdef PTXCONF_IPKG_EXTRACT_TEST
	@$(call install_copy, 0, 0, 0755, $(IPKG_DIR)/install_extract_test, /usr/bin/install_extract_test)
endif
ifdef PTXCONF_IPKG_HASH_TEST
	@$(call install_copy, 0, 0, 0755, $(IPKG_DIR)/install_hash_test, /usr/bin/install_hash_test)
endif

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ipkg_clean:
	rm -rf $(STATEDIR)/ipkg.*
	rm -rf $(IMAGEDIR)/ipkg_*
	rm -rf $(IPKG_DIR)

# vim: syntax=make
