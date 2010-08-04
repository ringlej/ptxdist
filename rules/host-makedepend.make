# -*-makefile-*-
#
# Copyright (C) 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MAKEDEPEND) += host-makedepend

#
# Paths and names
#
HOST_MAKEDEPEND_VERSION	:= 1.0.2
HOST_MAKEDEPEND		:= makedepend-$(HOST_MAKEDEPEND_VERSION)
HOST_MAKEDEPEND_SUFFIX	:= tar.bz2
HOST_MAKEDEPEND_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/util/$(HOST_MAKEDEPEND).$(HOST_MAKEDEPEND_SUFFIX)
HOST_MAKEDEPEND_SOURCE	:= $(SRCDIR)/$(HOST_MAKEDEPEND).$(HOST_MAKEDEPEND_SUFFIX)
HOST_MAKEDEPEND_DIR	:= $(HOST_BUILDDIR)/$(HOST_MAKEDEPEND)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MAKEDEPEND_CONF_TOOL	:= autoconf

# vim: syntax=make
