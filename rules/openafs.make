# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003,2004 by leifj@it.su.se
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENAFS) += openafs

#
# Paths and names
#
OPENAFS_VERSION		= 1.2.11
OPENAFS			= openafs-$(OPENAFS_VERSION)
OPENAFS_SUFFIX		= -src.tar.gz
OPENAFS_URL		= http://www.openafs.org/dl/openafs/1.2.11/$(OPENAFS)$(OPENAFS_SUFFIX)
OPENAFS_SOURCE		= $(SRCDIR)/$(OPENAFS)$(OPENAFS_SUFFIX)
OPENAFS_DIR		= $(BUILDDIR)/$(OPENAFS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openafs_get: $(STATEDIR)/openafs.get

$(STATEDIR)/openafs.get: $(openafs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OPENAFS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, OPENAFS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openafs_extract: $(STATEDIR)/openafs.extract

$(STATEDIR)/openafs.extract: $(openafs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENAFS_DIR))
	@$(call extract, OPENAFS)
	@$(call patchin, OPENAFS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openafs_prepare: $(STATEDIR)/openafs.prepare

OPENAFS_PATH	=  PATH=$(CROSS_PATH)
OPENAFS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
OPENAFS_AUTOCONF =  $(CROSS_AUTOCONF_USR)
OPENAFS_AUTOCONF += -enable-tansac-paths
OPENAFS_AUTOCONF += --with-afs-sysname=$(OPENAFS_SYS)
OPENAFS_AUTOCONF += --with-linux-kernel-headers=$(KERNEL_DIR)

OPENAFS_SYS=i386_linux24

$(STATEDIR)/openafs.prepare: $(openafs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENAFS_DIR)/config.cache)
	cd $(OPENAFS_DIR) && \
		$(OPENAFS_PATH) $(OPENAFS_ENV) \
		./configure $(OPENAFS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openafs_compile: $(STATEDIR)/openafs.compile

$(STATEDIR)/openafs.compile: $(openafs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(OPENAFS_DIR) && $(OPENAFS_PATH) make
	cd $(OPENAFS_DIR) && $(OPENAFS_PATH) make dest
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openafs_install: $(STATEDIR)/openafs.install

$(STATEDIR)/openafs.install: $(openafs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openafs_targetinstall: $(STATEDIR)/openafs.targetinstall

$(STATEDIR)/openafs.targetinstall: $(openafs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, openafs)
	@$(call install_fixup, openafs,PACKAGE,openafs)
	@$(call install_fixup, openafs,PRIORITY,optional)
	@$(call install_fixup, openafs,VERSION,$(OPENAFS_VERSION))
	@$(call install_fixup, openafs,SECTION,base)
	@$(call install_fixup, openafs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, openafs,DEPENDS,)
	@$(call install_fixup, openafs,DESCRIPTION,missing)
	
	@$(call install_copy, openafs, 0, 0, 0744, $(OPENAFS_DIR)/$(OPENAFS_SYS)/dest/root.client/usr/vice, /usr/bin/vice)

	@$(call install_finish, openafs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openafs_clean:
	rm -rf $(STATEDIR)/openafs.*
	rm -rf $(PKGDIR)/openafs_*
	rm -rf $(OPENAFS_DIR)

# vim: syntax=make
