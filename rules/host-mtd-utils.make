# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003-2008 by Pengutronix e.K., Hildesheim, Germany
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

$(STATEDIR)/host-mtd-utils.get: $(STATEDIR)/mtd-utils.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mtd-utils.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_MTD_UTILS_DIR))
	@$(call extract, MTD_UTILS, $(HOST_BUILDDIR))
	@$(call patchin, MTD_UTILS, $(HOST_MTD_UTILS_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MTD_UTILS_COMPILE_ENV := \
	$(HOST_ENV) \
	WITHOUT_XATTR=1 #\
#	WITHOUT_LZO=1

HOST_MTD_UTILS_MAKEVARS	:= \
	PREFIX="$(PTXCONF_SYSROOT_HOST)" \
	WITHOUT_XATTR=1 #\
#	WITHOUT_LZO=1

$(STATEDIR)/host-mtd-utils.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mtd-utils.compile:
	@$(call targetinfo)
	cd $(HOST_MTD_UTILS_DIR) && \
		$(HOST_MTD_UTILS_PATH) \
		$(HOST_MTD_UTILS_COMPILE_ENV) \
		$(MAKE) $(HOST_MTD_UTILS_MAKEVARS) $(PARALLELMFLAGS_BROKEN)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mtd-utils_clean:
	rm -rf $(STATEDIR)/host-mtd-utils.*
	rm -rf $(HOST_MTD_UTILS_DIR)

# vim: syntax=make
