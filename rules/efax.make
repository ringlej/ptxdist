# -*-makefile-*-
# $Id: template 1681 2004-09-01 18:12:49Z  $
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
ifdef PTXCONF_EFAX
PACKAGES += efax
endif

#
# Paths and names
#
EFAX_VERSION		= 0.9
EFAX			= efax-$(EFAX_VERSION)
EFAX_SUFFIX		= tar.gz
EFAX_URL		= ftp://ftp.metalab.unc.edu/pub/Linux/apps/serialcomm/fax/$(EFAX).$(EFAX_SUFFIX)
EFAX_SOURCE		= $(SRCDIR)/$(EFAX).$(EFAX_SUFFIX)
EFAX_DIR		= $(BUILDDIR)/$(EFAX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

efax_get: $(STATEDIR)/efax.get

efax_get_deps = $(EFAX_SOURCE)

$(STATEDIR)/efax.get: $(efax_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(EFAX))
	$(call touch, $@)

$(EFAX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(EFAX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

efax_extract: $(STATEDIR)/efax.extract

efax_extract_deps = $(STATEDIR)/efax.get

$(STATEDIR)/efax.extract: $(efax_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(EFAX_DIR))
	@$(call extract, $(EFAX_SOURCE))
	@$(call patchin, $(EFAX))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

efax_prepare: $(STATEDIR)/efax.prepare

#
# dependencies
#
efax_prepare_deps = \
	$(STATEDIR)/efax.extract \
	$(STATEDIR)/virtual-xchain.install

EFAX_PATH	=  PATH=$(CROSS_PATH)
EFAX_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
EFAX_AUTOCONF =  $(CROSS_AUTOCONF)
EFAX_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/efax.prepare: $(efax_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(EFAX_DIR)/config.cache)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

efax_compile: $(STATEDIR)/efax.compile

efax_compile_deps = $(STATEDIR)/efax.prepare

$(STATEDIR)/efax.compile: $(efax_compile_deps)
	@$(call targetinfo, $@)
	cd $(EFAX_DIR) && $(EFAX_ENV) $(EFAX_PATH) make all
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

efax_install: $(STATEDIR)/efax.install

$(STATEDIR)/efax.install: $(STATEDIR)/efax.compile
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

efax_targetinstall: $(STATEDIR)/efax.targetinstall

efax_targetinstall_deps = $(STATEDIR)/efax.compile

$(STATEDIR)/efax.targetinstall: $(efax_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,efax)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(EFAX_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(EFAX_DIR)/efax, /usr/bin/efax)
	@$(call install_copy, 0, 0, 0755, $(EFAX_DIR)/efix, /usr/bin/efix)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

efax_clean:
	rm -rf $(STATEDIR)/efax.*
	rm -rf $(IMAGEDIR)/efax_*
	rm -rf $(EFAX_DIR)

# vim: syntax=make
