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
HOST_PACKAGES-$(PTXCONF_HOSTTOOL_MTD) += hosttool-mtd

#
# Paths and names
#
HOSTTOOL_MTD		= $(MTD)
HOSTTOOL_MTD_SOURCE	= $(MTD_SOURCE)
HOSTTOOL_MTD_DIR	= $(HOST_BUILDDIR)/$(HOSTTOOL_MTD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-mtd_get: $(STATEDIR)/hosttool-mtd.get

hosttool-mtd_get_deps = $(STATEDIR)/mtd.get

$(STATEDIR)/hosttool-mtd.get: $(hosttool-mtd_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOL_MTD))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-mtd_extract: $(STATEDIR)/hosttool-mtd.extract

hosttool-mtd_extract_deps = $(STATEDIR)/hosttool-mtd.get

$(STATEDIR)/hosttool-mtd.extract: $(hosttool-mtd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_MTD_DIR))
	@$(call extract, $(HOSTTOOL_MTD_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOSTTOOL_MTD), $(HOSTTOOL_MTD_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-mtd_prepare: $(STATEDIR)/hosttool-mtd.prepare

#
# dependencies
#
hosttool-mtd_prepare_deps = \
	$(STATEDIR)/hosttool-zlib.install \
	$(STATEDIR)/hosttool-mtd.extract

HOSTTOOL_MTD_MAKEVARS = \
	$(HOSTCC_ENV) \
	CFLAGS="-I$(PTXCONF_PREFIX)/include -I$(HOSTTOOL_MTD_DIR)/include" \
	LDFLAGS=-L$(PTXCONF_PREFIX)/lib

$(STATEDIR)/hosttool-mtd.prepare: $(hosttool-mtd_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-mtd_compile: $(STATEDIR)/hosttool-mtd.compile

hosttool-mtd_compile_deps = $(STATEDIR)/hosttool-mtd.prepare

$(STATEDIR)/hosttool-mtd.compile: $(hosttool-mtd_compile_deps)
	@$(call targetinfo, $@)
ifdef PTXCONF_HOSTTOOL_MTD_MKJFFS
	cd $(HOSTTOOL_MTD_DIR)/util && make mkfs.jffs $(HOSTTOOL_MTD_MAKEVARS)
endif
ifdef PTXCONF_HOSTTOOL_MTD_MKJFFS2
	cd $(HOSTTOOL_MTD_DIR)/util && make mkfs.jffs2 $(HOSTTOOL_MTD_MAKEVARS)
endif
ifdef PTXCONF_HOSTTOOL_MTD_JFFS_DUMP
	cd $(HOSTTOOL_MTD_DIR)/util && make jffs_dump $(HOSTTOOL_MTD_MAKEVARS)
endif
ifdef PTXCONF_HOSTTOOL_MTD_JFFS2_DUMP
	cd $(HOSTTOOL_MTD_DIR)/util && make jffs2dump $(HOSTTOOL_MTD_MAKEVARS)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-mtd_install: $(STATEDIR)/hosttool-mtd.install

$(STATEDIR)/hosttool-mtd.install: $(STATEDIR)/hosttool-mtd.compile
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/bin

ifdef PTXCONF_HOSTTOOL_MTD_MKJFFS
	install $(HOSTTOOL_MTD_DIR)/util/mkfs.jffs $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_HOSTTOOL_MTD_MKJFFS2
	install $(HOSTTOOL_MTD_DIR)/util/mkfs.jffs2 $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_HOSTTOOL_MTD_JFFS_DUMP
	install $(HOSTTOOL_MTD_DIR)/util/jffs_dump $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_HOSTTOOL_MTD_JFFS2_DUMP
	install $(HOSTTOOL_MTD_DIR)/util/jffs2dump $(PTXCONF_PREFIX)/bin
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-mtd_targetinstall: $(STATEDIR)/hosttool-mtd.targetinstall

hosttool-mtd_targetinstall_deps = $(STATEDIR)/hosttool-mtd.install

$(STATEDIR)/hosttool-mtd.targetinstall: $(hosttool-mtd_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-mtd_clean:
	rm -rf $(STATEDIR)/hosttool-mtd.*
	rm -rf $(HOSTTOOL_MTD_DIR)

# vim: syntax=make
