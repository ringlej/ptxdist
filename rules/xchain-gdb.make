# -*-makefile-*-
# $Id: xchain-gdb.make,v 1.4 2003/07/16 04:23:28 mkl Exp $
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
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN_GDB))
PACKAGES += xchain-gdb
endif

#
# Paths and names 
#
GDB		= gdb-5.3
GDB_URL		= ftp://ftp.gnu.org/pub/gnu/gdb/$(GDB).tar.gz
GDB_SOURCE	= $(SRCDIR)/$(GDB).tar.gz
GDB_DIR		= $(BUILDDIR)/$(GDB)
GDB_EXTRACT 	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gdb_get: $(STATEDIR)/xchain-gdb.get

$(STATEDIR)/xchain-gdb.get: $(GDB_SOURCE)
	@$(call targetinfo, xchain-gdb.get)
	touch $@

$(GDB_SOURCE):
	@$(call targetinfo, $(GDB_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GDB_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gdb_extract: $(STATEDIR)/xchain-gdb.extract

$(STATEDIR)/xchain-gdb.extract: $(STATEDIR)/xchain-gdb.get
	@$(call targetinfo, xchain-gdb.extract)
	@$(call clean, $(GDB_DIR))
	$(GDB_EXTRACT) $(GDB_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gdb_prepare: $(STATEDIR)/xchain-gdb.prepare

$(STATEDIR)/xchain-gdb.prepare: $(STATEDIR)/xchain-gdb.extract
	@$(call targetinfo, xchain-gdb.prepare)
	cd $(GDB_DIR) && 						\
	./configure 							\
		--target=$(PTXCONF_GNU_TARGET)				\
		--prefix=$(PTXCONF_PREFIX) 				\
		--enable-targets=$(PTXCONF_GNU_TARGET)	
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN_GDBSERVER))
	cd $(GDB_DIR)/gdb/gdbserver &&					\
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH				\
	CC=$(PTXCONF_GNU_TARGET)-gcc sh ./configure			\
		--host=$(PTXCONF_GNU_TARGET)				\
		--prefix=$(ROOTDIR) 
endif
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gdb_compile: $(STATEDIR)/xchain-gdb.compile

$(STATEDIR)/xchain-gdb.compile: $(STATEDIR)/xchain-gdb.prepare 
	@$(call targetinfo, xchain-gdb.compile)
	cd $(GDB_DIR) && make 
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN_GDB))
	cd $(GDB_DIR)/gdb/gdbserver && PATH=$(PTXCONF_PREFIX)/bin:$$PATH make
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gdb_install: $(STATEDIR)/xchain-gdb.install

$(STATEDIR)/xchain-gdb.install: $(STATEDIR)/xchain-gdb.compile
	@$(call targetinfo, xchain-gdb.install)
	cd $(GDB_DIR) && make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gdb_targetinstall: $(STATEDIR)/xchain-gdb.targetinstall

$(STATEDIR)/xchain-gdb.targetinstall: $(STATEDIR)/xchain-gdb.install
	@$(call targetinfo, xchain-gdb.targetinstall)
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN_GDBSERVER))
	cp $(GDB_DIR)/gdb/gdbserver/gdbserver $(ROOTDIR)/bin
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/bin/gdbserver
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gdb_clean: 
	rm -rf $(STATEDIR)/xchain-gdb.* $(GDB_DIR)

# vim: syntax=make
