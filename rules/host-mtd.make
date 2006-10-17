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
HOST_PACKAGES-$(PTXCONF_HOST_MTD) += host-mtd

#
# Paths and names
#
HOST_MTD	= $(MTD_UTILS)
HOST_MTD_DIR	= $(HOST_BUILDDIR)/$(HOST_MTD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-mtd_get: $(STATEDIR)/host-mtd.get

$(STATEDIR)/host-mtd.get: $(STATEDIR)/mtd.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mtd_extract: $(STATEDIR)/host-mtd.extract

$(STATEDIR)/host-mtd.extract: $(host-mtd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MTD_DIR))
	@$(call extract, MTD_UTILS, $(HOST_BUILDDIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mtd_prepare: $(STATEDIR)/host-mtd.prepare

HOST_MTD_MAKEVARS = \
	$(HOSTCC_ENV) \
	CFLAGS="-I$(PTXCONF_PREFIX)/include -I$(HOST_MTD_DIR)/include" \
	LDFLAGS=-L$(PTXCONF_PREFIX)/lib

$(STATEDIR)/host-mtd.prepare: $(host-mtd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mtd_compile: $(STATEDIR)/host-mtd.compile

$(STATEDIR)/host-mtd.compile: $(host-mtd_compile_deps_default)
	@$(call targetinfo, $@)
ifdef PTXCONF_HOST_MTD_MKJFFS
	cd $(HOST_MTD_DIR) && make mkfs.jffs $(HOST_MTD_MAKEVARS)
endif
ifdef PTXCONF_HOST_MTD_MKJFFS2
	cd $(HOST_MTD_DIR) && make mkfs.jffs2 $(HOST_MTD_MAKEVARS)
endif
ifdef PTXCONF_HOST_MTD_JFFS_DUMP
	cd $(HOST_MTD_DIR) && make jffs-dump $(HOST_MTD_MAKEVARS)
endif
ifdef PTXCONF_HOST_MTD_JFFS2_DUMP
	cd $(HOST_MTD_DIR) && make jffs2dump $(HOST_MTD_MAKEVARS)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mtd_install: $(STATEDIR)/host-mtd.install

$(STATEDIR)/host-mtd.install: $(host-mtd_install_deps_default)
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/bin

ifdef PTXCONF_HOST_MTD_MKJFFS
	install $(HOST_MTD_DIR)/mkfs.jffs $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_HOST_MTD_MKJFFS2
	install $(HOST_MTD_DIR)/mkfs.jffs2 $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_HOST_MTD_JFFS_DUMP
	install $(HOST_MTD_DIR)/jffs-dump $(PTXCONF_PREFIX)/bin
endif
ifdef PTXCONF_HOST_MTD_JFFS2_DUMP
	install $(HOST_MTD_DIR)/jffs2dump $(PTXCONF_PREFIX)/bin
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-mtd_targetinstall: $(STATEDIR)/host-mtd.targetinstall

$(STATEDIR)/host-mtd.targetinstall: $(host-mtd_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mtd_clean:
	rm -rf $(STATEDIR)/host-mtd.*
	rm -rf $(HOST_MTD_DIR)

# vim: syntax=make
