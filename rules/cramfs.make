# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

# FIXME: RSC: make this a hosttool

#
# We provide this package
#
PACKAGES-$(PTXCONF_CRAMFS) += cramfs

#
# Paths and names
#
CRAMFS_VERSION	= 1.1
CRAMFS		= cramfs-$(CRAMFS_VERSION)
CRAMFS_SUFFIX	= tar.gz
CRAMFS_URL	= $(PTXCONF_SETUP_SFMIRROR)/cramfs/$(CRAMFS).$(CRAMFS_SUFFIX)
CRAMFS_SOURCE	= $(SRCDIR)/$(CRAMFS).$(CRAMFS_SUFFIX)
CRAMFS_DIR	= $(BUILDDIR)/$(CRAMFS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cramfs_get: $(STATEDIR)/cramfs.get

$(STATEDIR)/cramfs.get: $(cramfs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CRAMFS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CRAMFS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cramfs_extract: $(STATEDIR)/cramfs.extract

$(STATEDIR)/cramfs.extract: $(cramfs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CRAMFS_DIR))
	@$(call extract, CRAMFS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cramfs_prepare: $(STATEDIR)/cramfs.prepare

$(STATEDIR)/cramfs.prepare: $(cramfs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cramfs_compile: $(STATEDIR)/cramfs.compile

$(STATEDIR)/cramfs.compile: $(cramfs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CRAMFS_DIR) && \
		make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cramfs_install: $(STATEDIR)/cramfs.install

$(STATEDIR)/cramfs.install: $(cramfs_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	# @$(call install, CRAMFS)
	cp $(CRAMFS_DIR)/mkcramfs $(PTXCONF_HOST_PREFIX)/bin
	cp $(CRAMFS_DIR)/cramfsck $(PTXCONF_HOST_PREFIX)/bin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

cramfs_targetinstall: $(STATEDIR)/cramfs.targetinstall

$(STATEDIR)/cramfs.targetinstall: $(cramfs_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cramfs_clean:
	rm -rf $(STATEDIR)/cramfs.*
	rm -rf $(CRAMFS_DIR)

# vim: syntax=make
