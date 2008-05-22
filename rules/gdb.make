# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
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
PACKAGES-$(PTXCONF_GDB) += gdb

#
# Paths and names
#
GDB_VERSION	:= $(call remove_quotes,$(PTXCONF_GDB__VERSION))
GDB		:= gdb-$(GDB_VERSION)
GDB_SUFFIX	:= tar.bz2
GDB_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/gdb/$(GDB).$(GDB_SUFFIX)
GDB_SOURCE	:= $(SRCDIR)/$(GDB).$(GDB_SUFFIX)
GDB_DIR		:= $(BUILDDIR)/$(GDB)
GDB_BUILDDIR	:= $(BUILDDIR)/$(GDB)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GDB_SOURCE):
	@$(call targetinfo)
	@$(call get, GDB)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/gdb.extract: $(GDB_SOURCE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GDB_PATH	:= PATH=$(CROSS_PATH)
GDB_ENV		:= \
	$(CROSS_ENV) \
	$(CROSS_ENV_FLAGS_FOR_TARGET)

ifndef PTXCONF_GDB__SHARED
GDB_MAKEVARS	:=  LDFLAGS=-static
endif

#
# autoconf
#
GDB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--with-build-sysroot=$(SYSROOT)

$(STATEDIR)/gdb.prepare:
	@$(call targetinfo)
	@$(call clean, $(GDB_BUILDDIR))
	mkdir -p $(GDB_BUILDDIR)
	cd $(GDB_BUILDDIR) && \
		$(GDB_PATH) $(GDB_ENV) \
		$(GDB_DIR)/configure $(GDB_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/gdb.compile:
	@$(call targetinfo)
	cd $(GDB_BUILDDIR) && $(GDB_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdb.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/gdb.targetinstall:
	@$(call targetinfo)

	mkdir -p $(ROOTDIR)/usr/bin

	@$(call install_init, gdb)
	@$(call install_fixup, gdb,PACKAGE,gdb)
	@$(call install_fixup, gdb,PRIORITY,optional)
	@$(call install_fixup, gdb,VERSION,$(GDB_VERSION))
	@$(call install_fixup, gdb,SECTION,base)
	@$(call install_fixup, gdb,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, gdb,DEPENDS,)
	@$(call install_fixup, gdb,DESCRIPTION,missing)

	@$(call install_copy, gdb, 0, 0, 0755, $(GDB_BUILDDIR)/gdb/gdb, /usr/bin/gdb)

	@$(call install_finish, gdb)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdb_clean:
	rm -rf $(STATEDIR)/gdb.* $(GDB_DIR)
	rm -rf $(IMAGEDIR)/gdb_*

# vim: syntax=make
