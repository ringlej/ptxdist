# -*-makefile-*-
# $Id: xchain-gdb.make,v 1.1 2003/06/25 13:30:33 robert Exp $
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
GDB_SOURCE		= $(SRCDIR)/$(GDB).tar.gz
GDB_DIR		= $(BUILDDIR)/$(GDB)
GDB_EXTRACT 	= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gdb_get: $(STATEDIR)/xchain-gdb.get

$(STATEDIR)/xchain-gdb.get: $(GDB_SOURCE)
	touch $@

$(GDB_SOURCE):
	@echo
	@echo ------------------- 
	@echo target: xchain-gdb.get
	@echo -------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GDB_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gdb_extract: $(STATEDIR)/xchain-gdb.extract

$(STATEDIR)/xchain-gdb.extract: $(STATEDIR)/xchain-gdb.get
	@echo
	@echo ----------------------- 
	@echo target: xchain-gdb.extract
	@echo -----------------------
	@echo
	$(GDB_EXTRACT) $(GDB_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gdb_prepare: $(STATEDIR)/xchain-gdb.prepare

$(STATEDIR)/xchain-gdb.prepare: $(STATEDIR)/xchain-gdb.extract
	@echo
	@echo ----------------------- 
	@echo target: xchain-gdb.prepare
	@echo -----------------------
	@echo
	cd $(GDB_DIR) && 						\
	./configure 							\
		--target=$(PTXCONF_GNU_TARGET)				\
		--prefix=$(PTXCONF_PREFIX) 				\
		--enable-targets=$(PTXCONF_GNU_TARGET)	
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN_GDBSERVER))
	cd $(GDB_DIR)/gdb/gdbserver &&					\
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
	@echo
	@echo ----------------------- 
	@echo target: xchain-gdb.compile
	@echo -----------------------
	@echo
	cd $(GDB_DIR) && make 
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN_GDB))
	cd $(GDB_DIR)/gdb/gdbserver && make
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gdb_install: $(STATEDIR)/xchain-gdb.install

$(STATEDIR)/xchain-gdb.install: $(STATEDIR)/xchain-gdb.compile
	@echo
	@echo ----------------------- 
	@echo target: xchain-gdb.install
	@echo -----------------------
	@echo
#	[ -d $(PTXCONF_PREFIX) ] || 					\
#		$(SUDO) install -g users -m 0755 			\
#				-o $(PTXUSER) 				\
#				-d $(PTXCONF_PREFIX)
	cd $(GDB_DIR) && make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gdb_targetinstall: $(STATEDIR)/xchain-gdb.targetinstall

$(STATEDIR)/xchain-gdb.targetinstall: $(STATEDIR)/xchain-gdb.install
	@echo
	@echo ----------------------------- 
	@echo target: xchain-gdb.targetinstall
	@echo -----------------------------
	@echo
ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN_GDBSERVER))
	$(CROSSSTRIP) -S $(GDB_DIR)/gdb/gdbserver/gdbserver
	cp $(GDB_DIR)/gdb/gdbserver/gdbserver $(ROOTDIR)/bin
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gdb_clean: 
	rm -rf $(STATEDIR)/xchain-gdb.* $(GDB_DIR)

# vim: syntax=make
