# -*-makefile-*-
#
# Copyright (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_MESALIB) += host-mesalib

HOST_MESALIB_DIR	= $(HOST_BUILDDIR)/Mesa-$(MESALIB_VERSION)
HOST_MESALIB_SUBDIR	:= src/glsl

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MESALIB_CONF_TOOL	:= NO
HOST_MESALIB_MAKE_OPT	:= $(HOST_ENV) builtin_compiler

# vim: syntax=make
