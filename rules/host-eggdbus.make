# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_EGGDBUS) += host-eggdbus

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_EGGDBUS_CONF_TOOL := autoconf

# vim: syntax=make
