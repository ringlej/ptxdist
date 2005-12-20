# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: rsc: make a host tool

#
# We provide this package
#
PACKAGES-$(PTXCONF_XGDB) += xchain-gdb

XCHAIN_GDB_BUILDDIR	= $(BUILDDIR)/xchain-$(GDB)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gdb_get: $(STATEDIR)/xchain-gdb.get

$(STATEDIR)/xchain-gdb.get: $(gdb_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gdb_extract: $(STATEDIR)/xchain-gdb.extract

$(STATEDIR)/xchain-gdb.extract: $(STATEDIR)/gdb.extract
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gdb_prepare_deps = $(STATEDIR)/xchain-gdb.prepare
ifdef PTXCONF_GDB_TERMCAP
xchain-gdb_prepare_deps +=$(STATEDIR)/host-termcap.install
endif

xchain-gdb_prepare: $(xchain-gdb_prepare_deps)


#
# autoconf
#
XCHAIN_GDB_AUTOCONF = \
	--prefix=$(PTXCONF_PREFIX) \
	--build=$(GNU_HOST) \
	--host=$(GNU_HOST) \
	--target=$(PTXCONF_GNU_TARGET)

XCHAIN_GDB_ENV = $(HOSTCC_ENV)

$(STATEDIR)/xchain-gdb.prepare: $(STATEDIR)/xchain-gdb.extract
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_GDB_BUILDDIR))
	mkdir -p $(XCHAIN_GDB_BUILDDIR)
	cd $(XCHAIN_GDB_BUILDDIR) && $(XCHAIN_GDB_ENV) \
		$(GDB_DIR)/configure $(XCHAIN_GDB_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gdb_compile: $(STATEDIR)/xchain-gdb.compile

$(STATEDIR)/xchain-gdb.compile: $(STATEDIR)/xchain-gdb.prepare 
	@$(call targetinfo, $@)
	make -C $(XCHAIN_GDB_BUILDDIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gdb_install: $(STATEDIR)/xchain-gdb.install

$(STATEDIR)/xchain-gdb.install: $(STATEDIR)/xchain-gdb.compile
	@$(call targetinfo, $@)
	@$(call install, XCHAIN_GDB, $(XCHAIN_GDB_BUILDDIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gdb_targetinstall: $(STATEDIR)/xchain-gdb.targetinstall

$(STATEDIR)/xchain-gdb.targetinstall: $(STATEDIR)/xchain-gdb.install
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gdb_clean: 
	rm -rf $(STATEDIR)/xchain-gdb.* $(XCHAIN_GDB_BUILDDIR)

# vim: syntax=make
