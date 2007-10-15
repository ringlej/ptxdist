# -*-makefile-*-
# $Id: template 3079 2005-09-02 18:09:51Z rsc $
#
# Copyright (C) 2005 by BSP
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PNET) += pnet

#
# Paths and names
#
PNET_VERSION	= 0.7.2
PNET		= pnet-$(PNET_VERSION)
PNET_SUFFIX	= tar.gz
PNET_URL	= ftp://ftp.gnu.org/pub/gnu/dotgnu/pnet/$(PNET).$(PNET_SUFFIX)
PNET_SOURCE	= $(SRCDIR)/$(PNET).$(PNET_SUFFIX)
PNET_DIR	= $(BUILDDIR)/$(PNET)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pnet_get: $(STATEDIR)/pnet.get

$(STATEDIR)/pnet.get: $(pnet_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PNET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PNET)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pnet_extract: $(STATEDIR)/pnet.extract

$(STATEDIR)/pnet.extract: $(pnet_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PNET_DIR))
	@$(call extract, PNET)
	@$(call patchin, PNET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pnet_prepare: $(STATEDIR)/pnet.prepare

PNET_PATH	=  PATH=$(CROSS_PATH)
PNET_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
PNET_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/pnet.prepare: $(pnet_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PNET_DIR)/config.cache)
	cd $(PNET_DIR) && \
		$(PNET_PATH) $(PNET_ENV) \
		./configure $(PNET_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pnet_compile: $(STATEDIR)/pnet.compile

$(STATEDIR)/pnet.compile: $(pnet_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PNET_DIR) && $(PNET_ENV) $(PNET_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pnet_install: $(STATEDIR)/pnet.install

$(STATEDIR)/pnet.install: $(pnet_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PNET)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pnet_targetinstall: $(STATEDIR)/pnet.targetinstall

$(STATEDIR)/pnet.targetinstall: $(pnet_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, pnet)
	@$(call install_fixup, pnet,PACKAGE,pnet)
	@$(call install_fixup, pnet,PRIORITY,optional)
	@$(call install_fixup, pnet,VERSION,$(PNET_VERSION))
	@$(call install_fixup, pnet,SECTION,base)
	@$(call install_fixup, pnet,AUTHOR,"Benedikt Spranger <b.spranger\@linutronix.de>")
	@$(call install_fixup, pnet,DEPENDS,)
	@$(call install_fixup, pnet,DESCRIPTION,missing)

	@$(call install_copy, pnet, 0, 0, 0755, $(PNET_DIR)/engine/ilrun, /usr/bin/ilrun)
	@$(call install_copy, pnet, 0, 0, 0755, $(PNET_DIR)/engine/ilverify, /usr/bin/ilverify)
		
	@$(call install_finish, pnet)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pnet_clean:
	rm -rf $(STATEDIR)/pnet.*
	rm -rf $(IMAGEDIR)/pnet_*
	rm -rf $(PNET_DIR)

# vim: syntax=make
