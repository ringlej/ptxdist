# -*-makefile-*-
#
# Copyright (C) 2008 by mol@pengutronix.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_NCURSES) += host-ncurses

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
HOST_NCURSES_CONF_TOOL	:= autoconf
HOST_NCURSES_CONF_OPT	= \
	$(HOST_AUTOCONF) \
	$(NCURSES_AUTOCONF_SHARED)

# vim: syntax=make
