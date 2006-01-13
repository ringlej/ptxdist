# -*-makefile-*-
# $Id: template 2606 2005-05-10 21:49:41Z rsc $
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
PACKAGES-$(PTXCONF_DBENCH) += dbench

#
# Paths and names
#
DBENCH_VERSION	= 3.03
DBENCH		= dbench-$(DBENCH_VERSION)
DBENCH_SUFFIX	= tar.gz
DBENCH_URL	= http://samba.org/ftp/tridge/dbench/$(DBENCH).$(DBENCH_SUFFIX)
DBENCH_SOURCE	= $(SRCDIR)/$(DBENCH).$(DBENCH_SUFFIX)
DBENCH_DIR	= $(BUILDDIR)/$(DBENCH)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dbench_get: $(STATEDIR)/dbench.get

$(STATEDIR)/dbench.get: $(dbench_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(DBENCH))
	@$(call touch, $@)

$(DBENCH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(DBENCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dbench_extract: $(STATEDIR)/dbench.extract

$(STATEDIR)/dbench.extract: $(dbench_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DBENCH_DIR))
	@$(call extract, $(DBENCH_SOURCE))
	@$(call patchin, $(DBENCH))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dbench_prepare: $(STATEDIR)/dbench.prepare

DBENCH_PATH	=  PATH=$(CROSS_PATH)
DBENCH_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
DBENCH_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/dbench.prepare: $(dbench_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DBENCH_DIR)/config.cache)
	cd $(DBENCH_DIR) && \
		$(DBENCH_PATH) $(DBENCH_ENV) \
		./configure $(DBENCH_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dbench_compile: $(STATEDIR)/dbench.compile

$(STATEDIR)/dbench.compile: $(dbench_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(DBENCH_DIR) && $(DBENCH_ENV) $(DBENCH_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dbench_install: $(STATEDIR)/dbench.install

$(STATEDIR)/dbench.install: $(dbench_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, DBENCH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dbench_targetinstall: $(STATEDIR)/dbench.targetinstall

$(STATEDIR)/dbench.targetinstall: $(dbench_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,dbench)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(DBENCH_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_DBENCH_DBENCH
	@$(call install_copy, 0, 0, 0755, \
		$(DBENCH_DIR)/dbench, \
		$(PTXCONF_TESTSUITE_DIR)/$(DBENCH)/dbench)
endif
ifdef PTXCONF_DBENCH_TBENCH
	@$(call install_copy, 0, 0, 0755, \
		$(DBENCH_DIR)/tbench, \
		$(PTXCONF_TESTSUITE_DIR)/$(DBENCH)/tbench)
endif
ifdef PTXCONF_DBENCH_TBENCH_SERVER
	@$(call install_copy, 0, 0, 0755, \
		$(DBENCH_DIR)/tbench_srv, \
		$(PTXCONF_TESTSUITE_DIR)/$(DBENCH)/tbench_srv)
endif

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dbench_clean:
	rm -rf $(STATEDIR)/dbench.*
	rm -rf $(IMAGEDIR)/dbench_*
	rm -rf $(DBENCH_DIR)

# vim: syntax=make
