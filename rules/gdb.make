# -*-makefile-*-
# $Id: gdb.make,v 1.4 2003/11/17 03:24:42 mkl Exp $
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
ifdef PTXCONF_GDB
PACKAGES += gdb
endif

#
# We depend on this package
#
ifdef PTXCONF_GDB_TERMCAP
PACKAGES += termcap
endif

ifdef PTXCONF_GDB_NCURSES
PACKAGES += ncurses
endif

#
# Paths and names 
#
GDB_VERSION	= 5.3
GDB		= gdb-$(GDB_VERSION)
GDB_SUFFIX	= tar.gz
GDB_URL		= ftp://ftp.gnu.org/pub/gnu/gdb/$(GDB).$(GDB_SUFFIX)
GDB_SOURCE	= $(SRCDIR)/$(GDB).tar.gz
GDB_DIR		= $(BUILDDIR)/$(GDB)
GDB_BUILDDIR	= $(BUILDDIR)/$(GDB)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gdb_get: $(STATEDIR)/gdb.get

gdb_get_deps = $(GDB_SOURCE)

$(STATEDIR)/gdb.get: $(gdb_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GDB))
	touch $@

$(GDB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GDB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdb_extract: $(STATEDIR)/gdb.extract

$(STATEDIR)/gdb.extract: $(STATEDIR)/gdb.get
	@$(call targetinfo, $@)
	@$(call clean, $(GDB_DIR))
	@$(call extract, $(GDB_SOURCE))
	@$(call patchin, $(GDB))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gdb_prepare: $(STATEDIR)/gdb.prepare

#
# dependencies
#
gdb_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/gdb.extract

ifdef PTXCONF_GDB_TERMCAP
gdb_prepare_deps += $(STATEDIR)/termcap.install
endif
ifdef PTXCONF_GDB_NCURSES
gdb_prepare_deps += $(STATEDIR)/ncurses.install
endif

GDB_PATH	=  PATH=$(CROSS_PATH)
GDB_ENV		=  $(CROSS_ENV)

ifndef PTXCONF_GDB_SHARED
GDB_MAKEVARS	=  LDFLAGS=-static
endif

#
# autoconf
#
GDB_AUTOCONF	=  --prefix=/usr
GDB_AUTOCONF	+= --build=$(GNU_HOST)
GDB_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
GDB_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/gdb.prepare: $(gdb_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GDB_BUILDDIR))
	mkdir -p $(GDB_BUILDDIR)
	cd $(GDB_BUILDDIR) && \
		$(GDB_PATH) $(GDB_ENV) \
		$(GDB_DIR)/configure $(GDB_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdb_compile: $(STATEDIR)/gdb.compile

$(STATEDIR)/gdb.compile: $(STATEDIR)/gdb.prepare 
	@$(call targetinfo, $@)
#
# the libiberty part is compiled for the host system
#
# don't pass target CFLAGS to it, so override them and call the configure script
#
	$(GDB_PATH) make -C $(GDB_BUILDDIR) $(GDB_MAKEVARS) CFLAGS='' CXXFLAGS='' configure-build-libiberty
	$(GDB_PATH) make -C $(GDB_BUILDDIR) $(GDB_MAKEVARS) 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdb_install: $(STATEDIR)/gdb.install

$(STATEDIR)/gdb.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdb_targetinstall: $(STATEDIR)/gdb.targetinstall

gdb_targetinstall_deps = \
	$(STATEDIR)/gdb.compile

ifdef PTXCONF_GDB_SHARED
ifdef PTXCONF_NCURSES
gdb_targetinstall_deps += $(STATEDIR)/ncurses.targetinstall
endif
endif

$(STATEDIR)/gdb.targetinstall: $(gdb_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/usr/bin
	install $(GDB_BUILDDIR)/gdb/gdb $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/gdb
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdb_clean: 
	rm -rf $(STATEDIR)/gdb.* $(GDB_DIR)

# vim: syntax=make
