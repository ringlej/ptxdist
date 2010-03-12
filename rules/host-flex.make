# -*-makefile-*-
#
# Copyright (C) 2010 by Erwin Rol <erwin@erwinrol.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_FLEX) += host-flex

#
# Paths and names
#
HOST_FLEX_DIR		= $(HOST_BUILDDIR)/$(FLEX)

# vim: syntax=make
