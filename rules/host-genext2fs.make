# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Randall Loomis
# Copyright (C) 2003 by Ixia Corporation (www.ixiacom.com)
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GENEXT2FS) += host-genext2fs

#
# Paths and names
#
HOST_GENEXT2FS_VERSION	= 1.4rc1
HOST_GENEXT2FS		= genext2fs-$(HOST_GENEXT2FS_VERSION)
HOST_GENEXT2FS_SUFFIX	= tar.gz
HOST_GENEXT2FS_URL	= $(PTXCONF_SETUP_SFMIRROR)/genext2fs/$(HOST_GENEXT2FS).$(HOST_GENEXT2FS_SUFFIX)
HOST_GENEXT2FS_SOURCE	= $(SRCDIR)/$(HOST_GENEXT2FS).$(HOST_GENEXT2FS_SUFFIX)
HOST_GENEXT2FS_DIR	= $(HOST_BUILDDIR)/$(HOST_GENEXT2FS)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-genext2fs_get: $(STATEDIR)/host-genext2fs.get

$(STATEDIR)/host-genext2fs.get: $(host-genext2fs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_GENEXT2FS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_GENEXT2FS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-genext2fs_extract: $(STATEDIR)/host-genext2fs.extract

$(STATEDIR)/host-genext2fs.extract: $(host-genext2fs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GENEXT2FS_DIR))
	@$(call extract, HOST_GENEXT2FS,$(HOST_BUILDDIR))
	@$(call patchin, $(HOST_GENEXT2FS),$(HOST_GENEXT2FS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-genext2fs_prepare: $(STATEDIR)/host-genext2fs.prepare

HOST_GENEXT2FS_PATH	=  PATH=$(HOST_PATH)
HOST_GENEXT2FS_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOST_GENEXT2FS_AUTOCONF =  $(HOST_AUTOCONF)

$(STATEDIR)/host-genext2fs.prepare: $(host-genext2fs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_GENEXT2FS_DIR)/config.cache)
	cd $(HOST_GENEXT2FS_DIR) && \
		$(HOST_GENEXT2FS_PATH) $(HOST_GENEXT2FS_ENV) \
		./configure $(HOST_GENEXT2FS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-genext2fs_compile: $(STATEDIR)/host-genext2fs.compile

$(STATEDIR)/host-genext2fs.compile: $(host-genext2fs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_GENEXT2FS_DIR) && $(HOST_GENEXT2FS_ENV) $(HOST_GENEXT2FS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-genext2fs_install: $(STATEDIR)/host-genext2fs.install

$(STATEDIR)/host-genext2fs.install: $(host-genext2fs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_GENEXT2FS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-genext2fs_clean:
	rm -rf $(STATEDIR)/host-genext2fs.*
	rm -rf $(HOST_GENEXT2FS_DIR)

# vim: syntax=make
