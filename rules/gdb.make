# -*-makefile-*-
# $Id: gdb.make,v 1.1 2003/09/02 14:12:15 robert Exp $
#
# (c) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_BUILD_GDB))
PACKAGES += gdb
endif

#
# Paths and names 
#
GDB_VERSION		= $(XGDB_VERSION)
GDB			= gdb-$(GDB_VERSION)
GDB_SUFFIX		= $(XGDB_SUFFIX)
GDB_SOURCE		= $(XGDB_SOURCE)
GDB_DIR			= $(BUILDDIR)/$(GDB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gdb_get: $(STATEDIR)/xchain-gdb.get
	
# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdb_extract: $(STATEDIR)/gdb.extract

$(STATEDIR)/gdb.extract: $(STATEDIR)/xchain-gdb.get
	@$(call targetinfo, gdb.extract)
	@$(call clean, $(GDB_DIR))
	@$(call extract, $(GDB_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gdb_prepare: $(STATEDIR)/gdb.prepare

GDB_PATH	=  PATH=$(CROSS_PATH)
GDB_ENV		=  $(CROSS_ENV)

#
# autoconf
#
GDB_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)
GDB_AUTOCONF	+= --build=$(GNU_HOST)
GDB_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
GDB_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/gdb.prepare: $(STATEDIR)/gdb.extract
	@$(call targetinfo, gdb.prepare)
	
	cd $(GDB_DIR) && 						\
		$(GDB_PATH) $(GDB_ENV) ./configure $(GDB_AUTOCONF)

ifeq (y,$(PTXCONF_BUILD_GDBSERVER))
	# configure is not executable, so run it with sh
	cd $(GDB_DIR)/gdb/gdbserver &&					\
		$(GDB_PATH) $(GDB_ENV) /bin/sh configure $(GDB_AUTOCONF)
endif
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdb_compile: $(STATEDIR)/gdb.compile

$(STATEDIR)/gdb.compile: $(STATEDIR)/gdb.prepare 
	@$(call targetinfo, gdb.compile)
	$(GDB_PATH) $(GDB_ENV) make -C $(GDB_DIR) 
ifeq (y,$(PTXCONF_BUILD_GDBSERVER))
	$(GDB_PATH) $(GDB_ENV) make -C $(GDB_DIR)/gdb/gdbserver
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdb_install: $(STATEDIR)/gdb.install

$(STATEDIR)/gdb.install: $(STATEDIR)/gdb.compile
	@$(call targetinfo, gdb.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdb_targetinstall: $(STATEDIR)/gdb.targetinstall

$(STATEDIR)/gdb.targetinstall: $(STATEDIR)/gdb.install
	@$(call targetinfo, gdb.targetinstall)
	install $(GDB_DIR)/gdb/gdb $(ROOTDIR)/bin
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/bin/gdb
ifeq (y,$(PTXCONF_BUILD_GDBSERVER))
	install $(GDB_DIR)/gdb/gdbserver/gdbserver $(ROOTDIR)/bin
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/bin/gdbserver
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdb_clean: 
	rm -rf $(STATEDIR)/gdb.* $(GDB_DIR)

# vim: syntax=make
