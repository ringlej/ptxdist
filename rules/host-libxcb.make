# -*-makefile-*-
#
# Copyright (C) 2007 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBXCB) += host-libxcb

#
# Paths and names
#
HOST_LIBXCB_DIR	= $(HOST_BUILDDIR)/$(LIBXCB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LIBXCB_PATH	:= PATH=$(HOST_PATH)
HOST_LIBXCB_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBXCB_AUTOCONF	:= \
	$(HOST_AUTOCONF) \
	--disable-build-docs

# vim: syntax=make
