# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
CROSS_PACKAGES-$(PTXCONF_CROSS_GDB) += cross-gdb

#
# Paths and names
#
CROSS_GDB_VERSION	= $(GDB_VERSION)
CROSS_GDB		= $(GDB)
CROSS_GDB_SUFFIX	= $(GDB_SUFFIX)
CROSS_GDB_URL		= $(GDB_URL)
CROSS_GDB_SOURCE	= $(GDB_SOURCE)
CROSS_GDB_DIR		= $(CROSS_BUILDDIR)/$(CROSS_GDB)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cross-gdb_get: $(STATEDIR)/cross-gdb.get

cross-gdb_get_deps = $(CROSS_GDB_SOURCE)

$(STATEDIR)/cross-gdb.get: $(cross-gdb_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cross-gdb_extract: $(STATEDIR)/cross-gdb.extract

cross-gdb_extract_deps = $(STATEDIR)/cross-gdb.get

$(STATEDIR)/cross-gdb.extract: $(cross-gdb_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_GDB_DIR))
	@$(call extract, $(CROSS_GDB_SOURCE), $(CROSS_BUILDDIR))
	@$(call patchin, $(CROSS_GDB), $(CROSS_GDB_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cross-gdb_prepare: $(STATEDIR)/cross-gdb.prepare

#
# dependencies
#
cross-gdb_prepare_deps := $(STATEDIR)/cross-gdb.extract
ifdef PTXCONF_GDB_TERMCAP
cross-gdb_prepare_deps += $(STATEDIR)/host-termcap.install
endif

CROSS_GDB_PATH	=  PATH=$(CROSS_PATH)
CROSS_GDB_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
CROSS_GDB_AUTOCONF =  --prefix=$(PTXCONF_PREFIX)
CROSS_GDB_AUTOCONF += --build=$(GNU_HOST)
CROSS_GDB_AUTOCONF += --host=$(GNU_HOST)
CROSS_GDB_AUTOCONF += --target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/cross-gdb.prepare: $(cross-gdb_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CROSS_GDB_DIR)/config.cache)
	cd $(CROSS_GDB_DIR) && \
		$(CROSS_GDB_PATH) $(CROSS_GDB_ENV) \
		./configure $(CROSS_GDB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cross-gdb_compile: $(STATEDIR)/cross-gdb.compile

cross-gdb_compile_deps = $(STATEDIR)/cross-gdb.prepare

$(STATEDIR)/cross-gdb.compile: $(cross-gdb_compile_deps)
	@$(call targetinfo, $@)
	cd $(CROSS_GDB_DIR) && $(CROSS_GDB_ENV) $(CROSS_GDB_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cross-gdb_install: $(STATEDIR)/cross-gdb.install

cross-gdb_install_deps = $(STATEDIR)/cross-gdb.compile

$(STATEDIR)/cross-gdb.install: $(cross-gdb_install_deps)
	@$(call targetinfo, $@)
	@$(call install, CROSS_GDB,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cross-gdb_clean:
	rm -rf $(STATEDIR)/cross-gdb.*
	rm -rf $(CROSS_GDB_DIR)

# vim: syntax=make
