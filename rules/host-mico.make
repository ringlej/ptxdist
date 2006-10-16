# -*-makefile-*-
# $Id$
#
# Copyright (C) 2006 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MICO) += host-mico

#
# Paths and names
#
HOST_MICO		= $(MICO)
HOST_MICO_DIR		= $(HOST_BUILDDIR)/$(HOST_MICO)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-mico_get: $(STATEDIR)/host-mico.get

$(STATEDIR)/host-mico.get: $(STATEDIR)/mico.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mico_extract: $(STATEDIR)/host-mico.extract

$(STATEDIR)/host-mico.extract: $(host-mico_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MICO_DIR))
	mkdir -p $(HOST_BUILDDIR)
	tmpdir=`mktemp -d`; \
	$(call extract, MICO, $$tmpdir) \
	mv $$tmpdir/mico $(HOST_MICO_DIR); \
	rm -fr $$tmpdir
	@$(call patchin, MICO, $(HOST_MICO_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mico_prepare: $(STATEDIR)/host-mico.prepare

HOST_MICO_PATH	=  PATH=$(HOST_PATH)
HOST_MICO_ENV 	=  $(HOSTCC_ENV)

#
# autoconf
#
HOST_MICO_AUTOCONF =  $(HOST_AUTOCONF)

$(STATEDIR)/host-mico.prepare: $(host-mico_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MICO_DIR)/config.cache)
	cd $(HOST_MICO_DIR) && \
		$(HOST_MICO_PATH) $(HOST_MICO_ENV) \
		./configure $(HOST_MICO_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mico_compile: $(STATEDIR)/host-mico.compile

$(STATEDIR)/host-mico.compile: $(host-mico_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MICO_DIR) && $(HOST_MICO_ENV) $(HOST_MICO_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mico_install: $(STATEDIR)/host-mico.install

$(STATEDIR)/host-mico.install: $(host-mico_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_MICO,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mico_clean:
	rm -rf $(STATEDIR)/host-mico.*
	rm -rf $(HOST_MICO_DIR)

# vim: syntax=make
