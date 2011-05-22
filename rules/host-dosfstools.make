# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_DOSFSTOOLS) += host-dosfstools

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_DOSFSTOOLS_CONF_TOOL	:= NO
HOST_DOSFSTOOLS_INSTALL_OPT	:= PREFIX= install

# vim: syntax=make
