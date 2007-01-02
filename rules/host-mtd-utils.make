# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2006 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MTD_UTILS) += host-mtd-utils

#
# Paths and names
#
HOST_MTD_UTILS_DIR	= $(HOST_BUILDDIR)/$(MTD_UTILS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-mtd-utils_get: $(STATEDIR)/host-mtd-utils.get

$(STATEDIR)/host-mtd-utils.get: $(STATEDIR)/mtd-utils.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mtd-utils_extract: $(STATEDIR)/host-mtd-utils.extract

$(STATEDIR)/host-mtd-utils.extract: $(host-mtd-utils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MTD_UTILS_DIR))
	@$(call extract, MTD_UTILS, $(HOST_BUILDDIR))
	@$(call patchin, MTD_UTILS, $(HOST_MTD_UTILS_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mtd-utils_prepare: $(STATEDIR)/host-mtd-utils.prepare

HOST_MTD_UTILS_PATH	:= PATH=$(HOST_PATH)
HOST_MTD_UTILS_ENV 	:= $(HOST_ENV)
HOST_MTD_UTILS_MAKEVARS	:= \
	CPPFLAGS="$(HOST_CPPFLAGS)" \
	LDFLAGS="$(HOST_LDFLAGS)" \
	PREFIX="$(PTX_PREFIX_HOST)"

$(STATEDIR)/host-mtd-utils.prepare: $(host-mtd-utils_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mtd-utils_compile: $(STATEDIR)/host-mtd-utils.compile

$(STATEDIR)/host-mtd-utils.compile: $(host-mtd-utils_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(HOST_MTD_UTILS_DIR) && $(HOST_MTD_UTILS_PATH) $(MAKE) $(PARALLELMFLAGS) $(HOST_MTD_UTILS_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mtd-utils_install: $(STATEDIR)/host-mtd-utils.install

$(STATEDIR)/host-mtd-utils.install: $(host-mtd-utils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOST_MTD_UTILS,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mtd-utils_clean:
	rm -rf $(STATEDIR)/host-mtd-utils.*
	rm -rf $(HOST_MTD_UTILS_DIR)

# vim: syntax=make
