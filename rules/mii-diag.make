# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
#
# Copyright (C) 2004 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_MII-DIAG
PACKAGES += mii-diag
endif

#
# Paths and names
#
MII-DIAG_VERSION	= 2.09
MII-DIAG		= mii-diag-$(MII-DIAG_VERSION).orig
MII-DIAG_SUFFIX		= tar.gz
MII-DIAG_URL		= $(PTXCONF_DEBMIRROR)/pool/main/m/mii-diag/mii-diag_$(MII-DIAG_VERSION).orig.$(MII-DIAG_SUFFIX)
MII-DIAG_SOURCE		= $(SRCDIR)/mii-diag_$(MII-DIAG_VERSION).orig.$(MII-DIAG_SUFFIX)
MII-DIAG_DIR		= $(BUILDDIR)/$(MII-DIAG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mii-diag_get: $(STATEDIR)/mii-diag.get

mii-diag_get_deps = $(MII-DIAG_SOURCE)

$(STATEDIR)/mii-diag.get: $(mii-diag_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(MII-DIAG))
	touch $@

$(MII-DIAG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MII-DIAG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mii-diag_extract: $(STATEDIR)/mii-diag.extract

mii-diag_extract_deps = $(STATEDIR)/mii-diag.get

$(STATEDIR)/mii-diag.extract: $(mii-diag_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MII-DIAG_DIR))
	@$(call extract, $(MII-DIAG_SOURCE))
	@$(call patchin, $(MII-DIAG))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mii-diag_prepare: $(STATEDIR)/mii-diag.prepare

#
# dependencies
#
mii-diag_prepare_deps = \
	$(STATEDIR)/mii-diag.extract \
	$(STATEDIR)/virtual-xchain.install

MII-DIAG_PATH	=  PATH=$(CROSS_PATH)
MII-DIAG_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/mii-diag.prepare: $(mii-diag_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mii-diag_compile: $(STATEDIR)/mii-diag.compile

mii-diag_compile_deps = $(STATEDIR)/mii-diag.prepare

$(STATEDIR)/mii-diag.compile: $(mii-diag_compile_deps)
	@$(call targetinfo, $@)
	cd $(MII-DIAG_DIR) && $(MII-DIAG_ENV) $(MII-DIAG_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mii-diag_install: $(STATEDIR)/mii-diag.install

$(STATEDIR)/mii-diag.install: $(STATEDIR)/mii-diag.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mii-diag_targetinstall: $(STATEDIR)/mii-diag.targetinstall

mii-diag_targetinstall_deps = $(STATEDIR)/mii-diag.compile

$(STATEDIR)/mii-diag.targetinstall: $(mii-diag_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/sbin
	install  $(MII-DIAG_DIR)/mii-diag $(ROOTDIR)/usr/sbin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/mii-diag
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mii-diag_clean:
	rm -rf $(STATEDIR)/mii-diag.*
	rm -rf $(MII-DIAG_DIR)

# vim: syntax=make
