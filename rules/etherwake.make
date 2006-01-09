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
PACKAGES-$(PTXCONF_ETHERWAKE) += etherwake

#
# Paths and names
#
ETHERWAKE_VERSION	= 1.08
ETHERWAKE		= etherwake-$(ETHERWAKE_VERSION).orig
ETHERWAKE_SUFFIX	= tar.gz
ETHERWAKE_URL		= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/e/etherwake/etherwake_$(ETHERWAKE_VERSION).orig.$(ETHERWAKE_SUFFIX)
ETHERWAKE_SOURCE	= $(SRCDIR)/etherwake_$(ETHERWAKE_VERSION).orig.$(ETHERWAKE_SUFFIX)
ETHERWAKE_DIR		= $(BUILDDIR)/$(ETHERWAKE)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

etherwake_get: $(STATEDIR)/etherwake.get

etherwake_get_deps = $(ETHERWAKE_SOURCE)

$(STATEDIR)/etherwake.get: $(etherwake_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(ETHERWAKE))
	@$(call touch, $@)

$(ETHERWAKE_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(ETHERWAKE_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

etherwake_extract: $(STATEDIR)/etherwake.extract

etherwake_extract_deps = $(STATEDIR)/etherwake.get

$(STATEDIR)/etherwake.extract: $(etherwake_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHERWAKE_DIR))
	@$(call extract, $(ETHERWAKE_SOURCE))
	@$(call patchin, $(ETHERWAKE))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

etherwake_prepare: $(STATEDIR)/etherwake.prepare

#
# dependencies
#
etherwake_prepare_deps = \
	$(STATEDIR)/etherwake.extract \
	$(STATEDIR)/virtual-xchain.install

ETHERWAKE_PATH	=  PATH=$(CROSS_PATH)
ETHERWAKE_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/etherwake.prepare: $(etherwake_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ETHERWAKE_DIR)/config.cache)
	cd $(ETHERWAKE_DIR) && \
		perl -i -p -e 's/CC.*=.*//' $(ETHERWAKE_DIR)/Makefile
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

etherwake_compile: $(STATEDIR)/etherwake.compile

etherwake_compile_deps = $(STATEDIR)/etherwake.prepare

$(STATEDIR)/etherwake.compile: $(etherwake_compile_deps)
	@$(call targetinfo, $@)
	cd $(ETHERWAKE_DIR) && $(ETHERWAKE_ENV) $(ETHERWAKE_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

etherwake_install: $(STATEDIR)/etherwake.install

$(STATEDIR)/etherwake.install: $(STATEDIR)/etherwake.compile
	@$(call targetinfo, $@)
	# FIXME
	#@$(call install, ETHERWAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

etherwake_targetinstall: $(STATEDIR)/etherwake.targetinstall

etherwake_targetinstall_deps = $(STATEDIR)/etherwake.compile

$(STATEDIR)/etherwake.targetinstall: $(etherwake_targetinstall_deps)
	@$(call targetinfo, $@)
	
	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,etherwake)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(ETHERWAKE_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(ETHERWAKE_DIR)/etherwake, /usr/sbin/etherwake)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

etherwake_clean:
	rm -rf $(STATEDIR)/etherwake.*
	rm -rf $(IMAGEDIR)/etherwake_*
	rm -rf $(ETHERWAKE_DIR)

# vim: syntax=make
