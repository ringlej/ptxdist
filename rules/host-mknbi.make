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
HOST_MKNBI	= $(MKNBI)
HOST_MKNBI_DIR	= $(HOST_BUILDDIR)/$(HOST_MKNBI)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-mknbi_get: $(STATEDIR)/host-mknbi.get

$(STATEDIR)/host-mknbi.get: $(STATEDIR)/mknbi.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mknbi_extract: $(STATEDIR)/host-mknbi.extract

$(STATEDIR)/host-mknbi.extract: $(host-mknbi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MKNBI_DIR))
	@$(call extract, MKNBI, $(HOST_BUILDDIR))
	@$(call patchin, MKNBI, $(HOST_MKNBI_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mknbi_prepare: $(STATEDIR)/host-mknbi.prepare

HOST_MKNBI_MAKEVARS	= CC=$(HOSTCC)
HOST_MKNBI_ENV	= CFLAGS=-I$(PTXCONF_PREFIX)/include PREFIX=$(PTXCONF_PREFIX)/usr/local

$(STATEDIR)/host-mknbi.prepare: $(host-mknbi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mknbi_compile: $(STATEDIR)/host-mknbi.compile

$(STATEDIR)/host-mknbi.compile: $(host-mknbi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MKNBI_DIR) && $(HOST_MKNBI_ENV) make $(HOST_MKNBI_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mknbi_install: $(STATEDIR)/host-mknbi.install

$(STATEDIR)/host-mknbi.install: $(host-mknbi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_MKNBI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

host-mknbi_targetinstall: $(STATEDIR)/host-mknbi.targetinstall

$(STATEDIR)/host-mknbi.targetinstall: $(host-mknbi_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mknbi_clean:
	rm -rf $(STATEDIR)/host-mknbi.*
	rm -rf $(HOST_MKNBI_DIR)

# vim: syntax=make
