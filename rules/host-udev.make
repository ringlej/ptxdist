# -*-makefile-*-
# $Id$
#
# Copyright (C) 2009 by Luotao Fu <l.fu@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_E2FSPROGS) += host-udev

#
# Paths and names
#
HOST_UDEV		= $(UDEV)
HOST_UDEV_DIR	= $(HOST_BUILDDIR)/$(HOST_UDEV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-udev.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOST_UDEV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOST_UDEV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-udev.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_UDEV_DIR))
	@$(call extract, HOST_UDEV, $(HOST_BUILDDIR))
	@$(call patchin, HOST_UDEV, $(HOST_UDEV_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_UDEV_PATH	:= PATH=$(HOST_PATH)
HOST_UDEV_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_UDEV_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-udev.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_UDEV_DIR)/config.cache)
	cd $(HOST_UDEV_DIR) && \
		$(HOST_UDEV_PATH) $(HOST_UDEV_ENV) \
		./configure $(HOST_UDEV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-udev.compile:
	@$(call targetinfo, $@)
	cd $(HOST_UDEV_DIR) && $(HOST_UDEV_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-udev.install:
	@$(call targetinfo, $@)
	@$(call install, HOST_UDEV,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-udev_clean:
	rm -rf $(STATEDIR)/host-udev.*
	rm -rf $(HOST_UDEV_DIR)

# vim: syntax=make
