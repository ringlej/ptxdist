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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_LIB_XAU) += host-xorg-lib-xau

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_XORG_LIB_XAU_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
