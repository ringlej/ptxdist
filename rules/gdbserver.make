# -*-makefile-*-
# $Id: gdbserver.make,v 1.2 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_BUILD_GDBSERVER
PACKAGES += gdbserver
endif

GDBSERVER_BUILDDIR	= $(BUILDDIR)/$(GDB)-server-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gdbserver_get: $(STATEDIR)/gdbserver.get

$(STATEDIR)/gdbserver.get: $(gdb_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdbserver_extract: $(STATEDIR)/gdbserver.extract

$(STATEDIR)/gdbserver.extract: $(STATEDIR)/gdb.extract
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gdbserver_prepare: $(STATEDIR)/gdbserver.prepare

gdbserver_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/gdbserver.extract

GDBSERVER_PATH		= $(GDB_PATH)
GDBSERVER_ENV		= $(GDB_ENV)

ifndef PTXCONF_GDBSERVER_SHARED
GDBSERVER_ENV		+=  LDFLAGS=-static
endif

#
# autoconf
#
GDBSERVER_AUTOCONF	= $(GDB_AUTOCONF)

$(STATEDIR)/gdbserver.prepare: $(gdbserver_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GDBSERVER_BUILDDIR))
	mkdir -p $(GDBSERVER_BUILDDIR)
#
# we call sh, cause configure is not executable
#
	cd $(GDBSERVER_BUILDDIR) && $(GDBSERVER_PATH) $(GDBSERVER_ENV) \
		sh $(GDB_DIR)/gdb/gdbserver/configure $(GDBSERVER_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdbserver_compile: $(STATEDIR)/gdbserver.compile

$(STATEDIR)/gdbserver.compile: $(STATEDIR)/gdbserver.prepare 
	@$(call targetinfo, $@)
	$(GDBSERVER_PATH) make -C $(GDBSERVER_BUILDDIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdbserver_install: $(STATEDIR)/gdbserver.install

$(STATEDIR)/gdbserver.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdbserver_targetinstall: $(STATEDIR)/gdbserver.targetinstall

$(STATEDIR)/gdbserver.targetinstall: $(STATEDIR)/gdbserver.compile
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/bin
	install $(GDBSERVER_BUILDDIR)/gdbserver $(ROOTDIR)/bin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/bin/gdbserver
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdbserver_clean: 
	rm -rf $(STATEDIR)/gdbserver.* $(GDBSERVER_BUILDDIR)

# vim: syntax=make
