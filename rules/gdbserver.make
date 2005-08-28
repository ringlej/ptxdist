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

#
# We provide this package
#
ifdef PTXCONF_GDBSERVER
PACKAGES += gdbserver
endif

GDBSERVER_BUILDDIR	= $(BUILDDIR)/$(GDB)-server-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gdbserver_get: $(STATEDIR)/gdbserver.get

$(STATEDIR)/gdbserver.get: $(gdb_get_deps)
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdbserver_extract: $(STATEDIR)/gdbserver.extract

$(STATEDIR)/gdbserver.extract: $(STATEDIR)/gdb.extract
	@$(call targetinfo, $@)
	$(call touch, $@)

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
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdbserver_compile: $(STATEDIR)/gdbserver.compile

$(STATEDIR)/gdbserver.compile: $(STATEDIR)/gdbserver.prepare 
	@$(call targetinfo, $@)
	$(GDBSERVER_PATH) make -C $(GDBSERVER_BUILDDIR)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdbserver_install: $(STATEDIR)/gdbserver.install

$(STATEDIR)/gdbserver.install:
	@$(call targetinfo, $@)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdbserver_targetinstall: $(STATEDIR)/gdbserver.targetinstall

$(STATEDIR)/gdbserver.targetinstall: $(STATEDIR)/gdbserver.compile
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,gdbserver)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(GDB_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(GDBSERVER_BUILDDIR)/gdbserver, /usr/bin/gdbserver)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdbserver_clean: 
	rm -rf $(STATEDIR)/gdbserver.* $(GDBSERVER_BUILDDIR)
	rm -rf $(IMAGEDIR)/gdbserver_*

# vim: syntax=make
