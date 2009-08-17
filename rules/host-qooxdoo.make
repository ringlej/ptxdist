# -*-makefile-*-
#
# Copyright (C) 2009 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_QOOXDOO) += host-qooxdoo

#
# Paths and names
#
HOST_QOOXDOO_VERSION	:= 0.8.2
HOST_QOOXDOO		:= qooxdoo-$(HOST_QOOXDOO_VERSION)-sdk
HOST_QOOXDOO_SUFFIX	:= zip
HOST_QOOXDOO_URL	:= $(PTXCONF_SETUP_SFMIRROR)/qooxdoo/$(HOST_QOOXDOO).$(HOST_QOOXDOO_SUFFIX)
HOST_QOOXDOO_SOURCE	:= $(SRCDIR)/$(HOST_QOOXDOO).$(HOST_QOOXDOO_SUFFIX)
HOST_QOOXDOO_DIR	:= $(HOST_BUILDDIR)/$(HOST_QOOXDOO)
HOST_QOOXDOO_LICENSE	:= LGPLv2.1

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_QOOXDOO_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_QOOXDOO)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/host-qooxdoo.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-qooxdoo.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-qooxdoo.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-qooxdoo_clean:
	rm -rf $(STATEDIR)/host-qooxdoo.*
	rm -rf $(HOST_QOOXDOO_DIR)

# vim: syntax=make
