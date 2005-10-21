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
ifdef PTXCONF_HOSTTOOL_MKNBI
HOST_PACKAGES += hosttool-mknbi
endif

#
# Paths and names
#
HOSTTOOL_MKNBI_VERSION		= 1.4.4
HOSTTOOL_MKNBI			= mknbi-$(HOSTTOOL_MKNBI_VERSION)
HOSTTOOL_MKNBI_SUFFIX		= tar.gz
HOSTTOOL_MKNBI_URL		= $(PTXCONF_SETUP_SFMIRROR)/etherboot/$(HOSTTOOL_MKNBI).$(HOSTTOOL_MKNBI_SUFFIX)
HOSTTOOL_MKNBI_SOURCE		= $(SRCDIR)/$(HOSTTOOL_MKNBI).$(HOSTTOOL_MKNBI_SUFFIX)
HOSTTOOL_MKNBI_DIR		= $(HOST_BUILDDIR)/$(HOSTTOOL_MKNBI)
HOSTTOOL_MKNBI_FLAGS 		= BUILD_ROOT=$(PTXCONF_PREFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hosttool-mknbi_get: $(STATEDIR)/hosttool-mknbi.get

hosttool-mknbi_get_deps = $(HOSTTOOL_MKNBI_SOURCE)

$(STATEDIR)/hosttool-mknbi.get: $(hosttool-mknbi_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOSTTOOL_MKNBI))
	$(call touch, $@)

$(HOSTTOOL_MKNBI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOSTTOOL_MKNBI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hosttool-mknbi_extract: $(STATEDIR)/hosttool-mknbi.extract

hosttool-mknbi_extract_deps = $(STATEDIR)/hosttool-mknbi.get

$(STATEDIR)/hosttool-mknbi.extract: $(hosttool-mknbi_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOSTTOOL_MKNBI_DIR))
	@$(call extract, $(HOSTTOOL_MKNBI_SOURCE), $(HOST_BUILDDIR))
	@$(call patchin, $(HOSTTOOL_MKNBI), $(HOSTTOOL_MKNBI_DIR) )
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hosttool-mknbi_prepare: $(STATEDIR)/hosttool-mknbi.prepare

#
# dependencies
#
hosttool-mknbi_prepare_deps =  $(STATEDIR)/hosttool-mknbi.extract
#hosttool-mknbi_prepare_deps += $(STATEDIR)/hosttool-zlib.install

HOSTTOOL_MKNBI_MAKEVARS	= CC=$(HOSTCC)
HOSTTOOL_MKNBI_ENV	= CFLAGS=-I$(PTXCONF_PREFIX)/include PREFIX=$(PTXCONF_PREFIX)/usr/local

$(STATEDIR)/hosttool-mknbi.prepare: $(hosttool-mknbi_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hosttool-mknbi_compile: $(STATEDIR)/hosttool-mknbi.compile

hosttool-mknbi_compile_deps = $(STATEDIR)/hosttool-mknbi.prepare

$(STATEDIR)/hosttool-mknbi.compile: $(hosttool-mknbi_compile_deps)
	@$(call targetinfo, $@)
	cd $(HOSTTOOL_MKNBI_DIR) && $(HOSTTOOL_MKNBI_ENV) make $(HOSTTOOL_MKNBI_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hosttool-mknbi_install: $(STATEDIR)/hosttool-mknbi.install

$(STATEDIR)/hosttool-mknbi.install: $(STATEDIR)/hosttool-mknbi.compile
	@$(call targetinfo, $@)
	mkdir -p $(PTXCONF_PREFIX)/bin
	cd $(HOSTTOOL_MKNBI_DIR) && $(HOSTTOOL_MKNBI_FLAGS) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hosttool-mknbi_targetinstall: $(STATEDIR)/hosttool-mknbi.targetinstall

hosttool-mknbi_targetinstall_deps = $(STATEDIR)/hosttool-mknbi.install

$(STATEDIR)/hosttool-mknbi.targetinstall: $(hosttool-mknbi_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hosttool-mknbi_clean:
	rm -rf $(STATEDIR)/hosttool-mknbi.*
	rm -rf $(HOSTTOOL_MKNBI_DIR)

# vim: syntax=make
