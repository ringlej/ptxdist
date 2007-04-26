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
PACKAGES-$(PTXCONF_GDBSERVER) += gdbserver

GDBSERVER_DIR		= $(BUILDDIR)/$(GDB)-server
GDBSERVER_BUILDDIR	= $(BUILDDIR)/$(GDB)-server-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gdbserver_get: $(STATEDIR)/gdbserver.get

gdbserver_get_deps := \
	$(gdbserver_get_deps_default) \
	$(STATEDIR)/gdb.get

$(STATEDIR)/gdbserver.get: $(gdbserver_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdbserver_extract: $(STATEDIR)/gdbserver.extract

gdbserver_extract_deps := \
	$(gdbserver_extract_deps_default) \
	$(STATEDIR)/gdb.get \
	$(STATEDIR)/gdb.extract

$(STATEDIR)/gdbserver.extract: $(gdbserver_extract_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gdbserver_prepare: $(STATEDIR)/gdbserver.prepare

GDBSERVER_PATH		= $(GDB_PATH)
GDBSERVER_ENV		= $(GDB_ENV)

ifndef PTXCONF_GDBSERVER_SHARED
GDBSERVER_ENV		+=  LDFLAGS=-static
endif

#
# autoconf
#
GDBSERVER_AUTOCONF	= $(GDB_AUTOCONF)

$(STATEDIR)/gdbserver.prepare: $(gdbserver_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(GDBSERVER_BUILDDIR))
	mkdir -p $(GDBSERVER_BUILDDIR)
#
# we call sh, cause configure is not executable
#
	cd $(GDBSERVER_BUILDDIR) && $(GDBSERVER_PATH) $(GDBSERVER_ENV) \
		sh $(GDB_DIR)/gdb/gdbserver/configure $(GDBSERVER_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdbserver_compile: $(STATEDIR)/gdbserver.compile

$(STATEDIR)/gdbserver.compile: $(gdbserver_compile_deps_default)
	@$(call targetinfo, $@)
	$(GDBSERVER_PATH) make -C $(GDBSERVER_BUILDDIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdbserver_install: $(STATEDIR)/gdbserver.install

$(STATEDIR)/gdbserver.install: $(gdbserver_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdbserver_targetinstall: $(STATEDIR)/gdbserver.targetinstall

$(STATEDIR)/gdbserver.targetinstall: $(gdbserver_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, gdbserver)
	@$(call install_fixup, gdbserver,PACKAGE,gdbserver)
	@$(call install_fixup, gdbserver,PRIORITY,optional)
	@$(call install_fixup, gdbserver,VERSION,$(GDB_VERSION))
	@$(call install_fixup, gdbserver,SECTION,base)
	@$(call install_fixup, gdbserver,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gdbserver,DEPENDS,)
	@$(call install_fixup, gdbserver,DESCRIPTION,missing)

	@$(call install_copy, gdbserver, 0, 0, 0755, $(GDBSERVER_BUILDDIR)/gdbserver, /usr/bin/gdbserver)

	@$(call install_finish, gdbserver)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdbserver_clean: 
	rm -rf $(STATEDIR)/gdbserver.* $(GDBSERVER_BUILDDIR)
	rm -rf $(IMAGEDIR)/gdbserver_*

# vim: syntax=make
