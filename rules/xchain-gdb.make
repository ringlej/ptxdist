# -*-makefile-*-
# $Id: xchain-gdb.make,v 1.5 2003/08/27 18:55:13 robert Exp $
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
ifeq (y,$(PTXCONF_BUILD_XGDB))
PACKAGES += xchain-gdb
endif

#
# Paths and names 
#
XGDB_VERSION		= 5.3
XGDB			= gdb-$(XGDB_VERSION)
XGDB_SUFFIX		= tar.gz
XGDB_URL		= ftp://ftp.gnu.org/pub/gnu/gdb/$(XGDB).$(XGDB_SUFFIX)
XGDB_SOURCE		= $(SRCDIR)/$(XGDB).tar.gz
XGDB_DIR		= $(BUILDDIR)/xchain-$(XGDB)
XGDB_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-gdb_get: $(STATEDIR)/xchain-gdb.get

$(STATEDIR)/xchain-gdb.get: $(XGDB_SOURCE)
	@$(call targetinfo, xchain-gdb.get)
	touch $@

$(XGDB_SOURCE):
	@$(call targetinfo, $(XGDB_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(XGDB_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-gdb_extract: $(STATEDIR)/xchain-gdb.extract

$(STATEDIR)/xchain-gdb.extract: $(STATEDIR)/xchain-gdb.get
	@$(call targetinfo, xchain-gdb.extract)
	@$(call clean, $(XGDB_DIR))
	install -d $(XGDB_DIR)
	cd $(XGDB_DIR) && $(XGDB_EXTRACT) $(XGDB_SOURCE) | $(TAR) -C $(XGDB_DIR) -xf -
	mv $(XGDB_DIR)/$(XGDB)/* $(XGDB_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-gdb_prepare: $(STATEDIR)/xchain-gdb.prepare

#
# autoconf
#
XGDB_AUTOCONF	=  --prefix=$(PTXCONF_PREFIX)
XGDB_AUTOCONF	+= --build=$(GNU_HOST)
XGDB_AUTOCONF	+= --host=$(GNU_HOST)
XGDB_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/xchain-gdb.prepare: $(STATEDIR)/xchain-gdb.extract
	@$(call targetinfo, xchain-gdb.prepare)
	cd $(XGDB_DIR) && ./configure $(XGDB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-gdb_compile: $(STATEDIR)/xchain-gdb.compile

$(STATEDIR)/xchain-gdb.compile: $(STATEDIR)/xchain-gdb.prepare 
	@$(call targetinfo, xchain-gdb.compile)
	cd $(XGDB_DIR) && make 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-gdb_install: $(STATEDIR)/xchain-gdb.install

$(STATEDIR)/xchain-gdb.install: $(STATEDIR)/xchain-gdb.compile
	@$(call targetinfo, xchain-gdb.install)
	cd $(XGDB_DIR) && make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-gdb_targetinstall: $(STATEDIR)/xchain-gdb.targetinstall

$(STATEDIR)/xchain-gdb.targetinstall: $(STATEDIR)/xchain-gdb.install
	@$(call targetinfo, xchain-gdb.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-gdb_clean: 
	rm -rf $(STATEDIR)/xchain-gdb.* $(XGDB_DIR)

# vim: syntax=make
