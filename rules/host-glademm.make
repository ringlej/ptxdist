# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel <r.schwebel@pengutronix.de>
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
HOST_PACKAGES-$(PTXCONF_HOST_GLADEMM) += host-glademm

#
# Paths and names
#
HOST_GLADEMM_DIR	= $(HOST_BUILDDIR)/$(GLADEMM)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_GLADEMM_PATH	:= PATH=$(HOST_PATH)
HOST_GLADEMM_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_GLADEMM_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
