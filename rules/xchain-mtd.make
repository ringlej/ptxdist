# -*-makefile-*-
# $Id: xchain-mtd.make,v 1.3 2004/04/22 13:36:13 robert Exp $
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_MTD_XCHAIN
PACKAGES += xchain-mtd
endif

#
# Paths and names
#
XCHAIN_MTD		= $(MTD)
XCHAIN_MTD_SOURCE	= $(MTD_SOURCE)
XCHAIN_MTD_DIR		= $(XCHAIN_BUILDDIR)/$(XCHAIN_MTD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xchain-mtd_get: $(STATEDIR)/xchain-mtd.get

xchain-mtd_get_deps = $(XCHAIN_MTD_SOURCE)

$(STATEDIR)/xchain-mtd.get: $(xchain-mtd_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(XCHAIN_MTD))
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xchain-mtd_extract: $(STATEDIR)/xchain-mtd.extract

xchain-mtd_extract_deps = $(STATEDIR)/xchain-mtd.get

$(STATEDIR)/xchain-mtd.extract: $(xchain-mtd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(XCHAIN_MTD_DIR))
	@$(call extract, $(XCHAIN_MTD_SOURCE), $(XCHAIN_BUILDDIR))
	@$(call patchin, $(XCHAIN_MTD), $(XCHAIN_MTD_DIR))
#
# Makefile is currently fucked up... @#*$
# FIXME: patch sent to maintainer, remove this for fixed version
#
	perl -i -p -e 's/\(CFLAGS\) -o/\(LDFLAGS\) -o/g' $(XCHAIN_MTD_DIR)/util/Makefile
	perl -i -p -e 's/^CFLAGS \+\=/override CFLAGS +=/g' $(XCHAIN_MTD_DIR)/util/Makefile
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xchain-mtd_prepare: $(STATEDIR)/xchain-mtd.prepare

#
# dependencies
#
xchain-mtd_prepare_deps = \
	$(STATEDIR)/xchain-zlib.install \
	$(STATEDIR)/xchain-mtd.extract

XCHAIN_MTD_MAKEVARS = \
	$(HOSTCC_ENV) \
	CFLAGS=-I$(PTXCONF_PREFIX)/include \
	LDFLAGS=-L$(PTXCONF_PREFIX)/lib

$(STATEDIR)/xchain-mtd.prepare: $(xchain-mtd_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xchain-mtd_compile: $(STATEDIR)/xchain-mtd.compile

xchain-mtd_compile_deps = $(STATEDIR)/xchain-mtd.prepare

$(STATEDIR)/xchain-mtd.compile: $(xchain-mtd_compile_deps)
	@$(call targetinfo, $@)
	cd $(XCHAIN_MTD_DIR)/util && make $(XCHAIN_MTD_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xchain-mtd_install: $(STATEDIR)/xchain-mtd.install

$(STATEDIR)/xchain-mtd.install: $(STATEDIR)/xchain-mtd.compile
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/bin

ifdef PTXCONF_MTD_XCHAIN_MKJFFS
	install $(XCHAIN_MTD_DIR)/util/mkfs.jffs $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_MTD_XCHAIN_MKJFFS2
	install $(XCHAIN_MTD_DIR)/util/mkfs.jffs2 $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_MTD_XCHAIN_JFFS2DUMP
	install $(XCHAIN_MTD_DIR)/util/jffs2dump $(PTXCONF_PREFIX)/bin
endif
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xchain-mtd_targetinstall: $(STATEDIR)/xchain-mtd.targetinstall

xchain-mtd_targetinstall_deps = $(STATEDIR)/xchain-mtd.install

$(STATEDIR)/xchain-mtd.targetinstall: $(xchain-mtd_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xchain-mtd_clean:
	rm -rf $(STATEDIR)/xchain-mtd.*
	rm -rf $(XCHAIN_MTD_DIR)

# vim: syntax=make
