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
PACKAGES-$(PTXCONF_TREECC) += treecc

#
# Paths and names
#
TREECC_VERSION	= 0.3.6
TREECC		= treecc-$(TREECC_VERSION)
TREECC_SUFFIX	= tar.gz
TREECC_URL	= ftp://ftp.gnu.org/pub/gnu/dotgnu/pnet/$(TREECC).$(TREECC_SUFFIX)
TREECC_SOURCE	= $(SRCDIR)/$(TREECC).$(TREECC_SUFFIX)
TREECC_DIR	= $(BUILDDIR)/$(TREECC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

treecc_get: $(STATEDIR)/treecc.get

$(STATEDIR)/treecc.get: $(treecc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(TREECC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, TREECC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

treecc_extract: $(STATEDIR)/treecc.extract

$(STATEDIR)/treecc.extract: $(treecc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TREECC_DIR))
	@$(call extract, TREECC)
	@$(call patchin, TREECC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

treecc_prepare: $(STATEDIR)/treecc.prepare

TREECC_PATH	=  PATH=$(CROSS_PATH)
TREECC_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
TREECC_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/treecc.prepare: $(treecc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(TREECC_DIR)/config.cache)
	cd $(TREECC_DIR) && \
		$(TREECC_PATH) $(TREECC_ENV) \
		./configure $(TREECC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

treecc_compile: $(STATEDIR)/treecc.compile

$(STATEDIR)/treecc.compile: $(treecc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(TREECC_DIR) && $(TREECC_ENV) $(TREECC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

treecc_install: $(STATEDIR)/treecc.install

$(STATEDIR)/treecc.install: $(treecc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, TREECC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

treecc_targetinstall: $(STATEDIR)/treecc.targetinstall

$(STATEDIR)/treecc.targetinstall: $(treecc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, treecc)
	@$(call install_fixup, treecc,PACKAGE,treecc)
	@$(call install_fixup, treecc,PRIORITY,optional)
	@$(call install_fixup, treecc,VERSION,$(TREECC_VERSION))
	@$(call install_fixup, treecc,SECTION,base)
	@$(call install_fixup, treecc,AUTHOR,"Benedikt Spranger <b.spranger\@linutronix.de>")
	@$(call install_fixup, treecc,DEPENDS,)
	@$(call install_fixup, treecc,DESCRIPTION,missing)

	@$(call install_copy, treecc, 0, 0, 0755, $(TREECC_DIR)/treecc, /usr/bin/treecc)

	@$(call install_finish, treecc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

treecc_clean:
	rm -rf $(STATEDIR)/treecc.*
	rm -rf $(IMAGEDIR)/treecc_*
	rm -rf $(TREECC_DIR)

# vim: syntax=make
