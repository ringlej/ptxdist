# -*-makefile-*-
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
HOST_PACKAGES-$(PTXCONF_HOST_MKNBI) += host-mknbi

#
# Paths and names
#
HOST_MKNBI_VERSION		= 1.4.4
HOST_MKNBI			= mknbi-$(HOST_MKNBI_VERSION)
HOST_MKNBI_SUFFIX		= tar.gz
HOST_MKNBI_URL		= $(PTXCONF_SETUP_SFMIRROR)/etherboot/$(HOST_MKNBI).$(HOST_MKNBI_SUFFIX)
HOST_MKNBI_SOURCE		= $(SRCDIR)/$(HOST_MKNBI).$(HOST_MKNBI_SUFFIX)
HOST_MKNBI_DIR		= $(HOST_BUILDDIR)/$(HOST_MKNBI)
HOST_MKNBI_FLAGS 		= BUILD_ROOT=$(PTXCONF_PREFIX)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-mknbi_get: $(STATEDIR)/host-mknbi.get

host-mknbi_get_deps = $(HOST_MKNBI_SOURCE)

$(STATEDIR)/host-mknbi.get: $(host-mknbi_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOST_MKNBI))
	@$(call touch, $@)

$(HOST_MKNBI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOST_MKNBI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mknbi_extract: $(STATEDIR)/host-mknbi.extract

host-mknbi_extract_deps = $(STATEDIR)/host-mknbi.get

$(STATEDIR)/host-mknbi.extract: $(host-mknbi_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKNBI_DIR))
	@$(call extract, $(HOST_MKNBI_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOST_MKNBI), $(HOST_MKNBI_DIR) )
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mknbi_prepare: $(STATEDIR)/host-mknbi.prepare

#
# dependencies
#
host-mknbi_prepare_deps =  $(STATEDIR)/host-mknbi.extract

HOST_MKNBI_MAKEVARS	= CC=$(HOSTCC)
HOST_MKNBI_ENV	= CFLAGS=-I$(PTXCONF_PREFIX)/include PREFIX=$(PTXCONF_PREFIX)/usr/local

$(STATEDIR)/host-mknbi.prepare: $(host-mknbi_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mknbi_compile: $(STATEDIR)/host-mknbi.compile

host-mknbi_compile_deps = $(STATEDIR)/host-mknbi.prepare

$(STATEDIR)/host-mknbi.compile: $(host-mknbi_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOST_MKNBI_DIR) && $(HOST_MKNBI_ENV) make $(HOST_MKNBI_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mknbi_install: $(STATEDIR)/host-mknbi.install

$(STATEDIR)/host-mknbi.install: $(STATEDIR)/host-mknbi.compile
	@$(call targetinfo, $@)
	@$(call install, HOST_MKNBI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-mknbi_targetinstall: $(STATEDIR)/host-mknbi.targetinstall

host-mknbi_targetinstall_deps = $(STATEDIR)/host-mknbi.install

$(STATEDIR)/host-mknbi.targetinstall: $(host-mknbi_targetinstall_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mknbi_clean:
	rm -rf $(STATEDIR)/host-mknbi.*
	rm -rf $(HOST_MKNBI_DIR)

# vim: syntax=make
