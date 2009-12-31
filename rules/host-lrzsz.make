# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LRZSZ) += host-lrzsz

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_LRZSZ_CONF_TOOL	:= autoconf

# vim: syntax=make
