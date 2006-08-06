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
HOST_PACKAGES-$(PTXCONF_HOST_E2FSPROGS) += host-e2fsprogs

#
# Paths and names
#
HOST_E2FSPROGS_VERSION	=  $(E2FSPROGS_VERSION)
HOST_E2FSPROGS		:= e2fsprogs-$(HOST_E2FSPROGS_VERSION)
HOST_E2FSPROGS_SUFFIX	:= tar.gz
HOST_E2FSPROGS_URL	:= $(PTXCONF_SETUP_SFMIRROR)/e2fsprogs/$(HOST_E2FSPROGS).$(HOST_E2FSPROGS_SUFFIX)
HOST_E2FSPROGS_SOURCE	:= $(SRCDIR)/$(HOST_E2FSPROGS).$(HOST_E2FSPROGS_SUFFIX)
HOST_E2FSPROGS_DIR	:= $(HOST_BUILDDIR)/$(HOST_E2FSPROGS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-e2fsprogs_get:	$(STATEDIR)/host-e2fsprogs.get

$(STATEDIR)/host-e2fsprogs.get:	$(host-e2fsprogs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-e2fsprogs_extract: $(STATEDIR)/host-e2fsprogs.extract

$(STATEDIR)/host-e2fsprogs.extract: $(host-e2fsprogs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_E2FSPROGS_DIR))
	@$(call extract, E2FSPROGS, $(HOST_BUILDDIR))
	@$(call patchin, E2FSPROGS, $(HOST_E2FSPROGS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-e2fsprogs_prepare: $(STATEDIR)/host-e2fsprogs.prepare

HOST_E2FSPROGS_PATH	:= PATH=$(HOST_PATH)
HOST_E2FSPROGS_ENV 	:= $(HOSTCC_ENV)

#
# autoconf
#
HOST_E2FSPROGS_AUTOCONF := $(HOST_AUTOCONF)

$(STATEDIR)/host-e2fsprogs.prepare: $(host-e2fsprogs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_E2FSPROGS_DIR)/config.cache)
	cd $(HOST_E2FSPROGS_DIR) && \
		$(HOST_E2FSPROGS_PATH) $(HOST_E2FSPROGS_ENV) \
		./configure $(HOST_E2FSPROGS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-e2fsprogs_compile: $(STATEDIR)/host-e2fsprogs.compile

$(STATEDIR)/host-e2fsprogs.compile: $(host-e2fsprogs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_E2FSPROGS_DIR) && $(HOST_E2FSPROGS_ENV) $(HOST_E2FSPROGS_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-e2fsprogs_install: $(STATEDIR)/host-e2fsprogs.install

$(STATEDIR)/host-e2fsprogs.install: $(host-e2fsprogs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_E2FSPROGS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-e2fsprogs_clean:
	rm -rf $(STATEDIR)/host-e2fsprogs.*
	rm -rf $(HOST_E2FSPROGS_DIR)

# vim: syntax=make

