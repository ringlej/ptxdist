# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_ATK) += host-atk

#
# Paths and names
#
HOST_ATK_DIR	= $(HOST_BUILDDIR)/$(ATK)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_ATK_PATH	:= PATH=$(HOST_PATH)
HOST_ATK_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_ATK_AUTOCONF := \
	$(HOST_AUTOCONF) \
	--disable-glibtest

# vim: syntax=make
