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
HOST_QOOXDOO_VERSION	:= 1.0
HOST_QOOXDOO_MD5	:= 1176bf4dd5e4ed96b4007f283caa6af3
HOST_QOOXDOO		:= qooxdoo-$(HOST_QOOXDOO_VERSION)-sdk
HOST_QOOXDOO_SUFFIX	:= zip
HOST_QOOXDOO_URL	:= $(call ptx/mirror, SF, qooxdoo/$(HOST_QOOXDOO).$(HOST_QOOXDOO_SUFFIX))
HOST_QOOXDOO_SOURCE	:= $(SRCDIR)/$(HOST_QOOXDOO).$(HOST_QOOXDOO_SUFFIX)
HOST_QOOXDOO_DIR	:= $(HOST_BUILDDIR)/$(HOST_QOOXDOO)
HOST_QOOXDOO_LICENSE	:= LGPL-2.1-only

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

# vim: syntax=make
