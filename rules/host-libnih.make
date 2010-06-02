# -*-makefile-*-
#
# Copyright (C) 2010 by Tim Sander <tim01@iss.tu-darmstadt.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBNIH) += host-libnih

#
# Paths and names
#
HOST_LIBNIH_DIR	= $(HOST_BUILDDIR)/$(LIBNIH)

#
# autoconf
#
HOST_LIBNIH_AUTOCONF	:= $(HOST_AUTOCONF)

# vim: syntax=make
