# -*-makefile-*-
# $Id: xchain-gdb.make,v 1.9 2003/11/17 03:43:42 mkl Exp $
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_XGDB
PACKAGES += xchain-gdb
endif

XCHAIN_GDB_BUILDDIR	= $(BUILDDIR)/xchain-$(GDB)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gdb_get: $(STATEDIR)/xchain-gdb.get

$(STATEDIR)/xchain-gdb.get: $(gdb_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gdb_extract: $(STATEDIR)/xchain-gdb.extract

$(STATEDIR)/xchain-gdb.extract: $(STATEDIR)/gdb.extract
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gdb_prepare: $(STATEDIR)/xchain-gdb.prepare

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
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gdb_compile: $(STATEDIR)/xchain-gdb.compile

$(STATEDIR)/xchain-gdb.compile: $(STATEDIR)/xchain-gdb.prepare 
	@$(call targetinfo, $@)
	make -C $(XCHAIN_GDB_BUILDDIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gdb_install: $(STATEDIR)/xchain-gdb.install

$(STATEDIR)/xchain-gdb.install: $(STATEDIR)/xchain-gdb.compile
	@$(call targetinfo, $@)
	make -C $(XCHAIN_GDB_BUILDDIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gdb_targetinstall: $(STATEDIR)/xchain-gdb.targetinstall

$(STATEDIR)/xchain-gdb.targetinstall: $(STATEDIR)/xchain-gdb.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gdb_clean: 
	rm -rf $(STATEDIR)/xchain-gdb.* $(XCHAIN_GDB_BUILDDIR)

# vim: syntax=make
