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
DBENCH_VERSION	= 3.04
DBENCH		= dbench-$(DBENCH_VERSION)
DBENCH_SUFFIX	= tar.gz
DBENCH_URL	= http://samba.org/ftp/tridge/dbench/$(DBENCH).$(DBENCH_SUFFIX)
DBENCH_SOURCE	= $(SRCDIR)/$(DBENCH).$(DBENCH_SUFFIX)
DBENCH_DIR	= $(BUILDDIR)/$(DBENCH)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dbench_get: $(STATEDIR)/dbench.get

$(STATEDIR)/dbench.get: $(dbench_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DBENCH_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DBENCH)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dbench_extract: $(STATEDIR)/dbench.extract

$(STATEDIR)/dbench.extract: $(dbench_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DBENCH_DIR))
	@$(call extract, DBENCH)
	@$(call patchin, DBENCH)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dbench_prepare: $(STATEDIR)/dbench.prepare

DBENCH_PATH	=  PATH=$(CROSS_PATH)
DBENCH_ENV 	=  $(CROSS_ENV)
DBENCH_MAKEVARS =  prefix=$(SYSROOT)

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

	@$(call install_init, dbench)
	@$(call install_fixup, dbench,PACKAGE,dbench)
	@$(call install_fixup, dbench,PRIORITY,optional)
	@$(call install_fixup, dbench,VERSION,$(DBENCH_VERSION))
	@$(call install_fixup, dbench,SECTION,base)
	@$(call install_fixup, dbench,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, dbench,DEPENDS,)
	@$(call install_fixup, dbench,DESCRIPTION,missing)

ifdef PTXCONF_DBENCH_DBENCH
	@$(call install_copy, dbench, 0, 0, 0755, \
		$(DBENCH_DIR)/dbench, \
		/usr/bin/dbench)
endif
ifdef PTXCONF_DBENCH_TBENCH
	@$(call install_copy, dbench, 0, 0, 0755, \
		$(DBENCH_DIR)/tbench, \
		/usr/bin/tbench)
endif
ifdef PTXCONF_DBENCH_TBENCH_SERVER
	@$(call install_copy, dbench, 0, 0, 0755, \
		$(DBENCH_DIR)/tbench_srv, \
		/usr/bin/tbench_srv)
endif

	@$(call install_finish, dbench)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dbench_clean:
	rm -rf $(STATEDIR)/dbench.*
	rm -rf $(PKGDIR)/dbench_*
	rm -rf $(DBENCH_DIR)

# vim: syntax=make
