# -*-makefile-*-
# $Id$
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
	CFLAGS="-I$(PTXCONF_PREFIX)/include -I$(XCHAIN_MTD_DIR)/include" \
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
ifdef PTXCONF_MTD_XCHAIN_MKJFFS
	cd $(XCHAIN_MTD_DIR)/util && make mkfs.jffs $(XCHAIN_MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_XCHAIN_MKJFFS2
	cd $(XCHAIN_MTD_DIR)/util && make mkfs.jffs2 $(XCHAIN_MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_XCHAIN_JFFS_DUMP
	cd $(XCHAIN_MTD_DIR)/util && make jffs_dump $(XCHAIN_MTD_MAKEVARS)
endif
ifdef PTXCONF_MTD_XCHAIN_JFFS2_DUMP
	cd $(XCHAIN_MTD_DIR)/util && make jffs2_dump $(XCHAIN_MTD_MAKEVARS)
endif

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
ifdef PTXCONF_MTD_XCHAIN_JFFS_DUMP
	install $(XCHAIN_MTD_DIR)/util/jffs_dump $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_MTD_XCHAIN_JFFS2_DUMP
	install $(XCHAIN_MTD_DIR)/util/jffs2_dump $(PTXCONF_PREFIX)/bin
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
