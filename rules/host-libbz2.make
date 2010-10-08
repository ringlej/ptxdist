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
HOST_PACKAGES-$(PTXCONF_HOST_LIBBZ2) += host-libbz2

#
# Paths and names
#
HOST_LIBBZ2_VERSION	:= 1.0.4
HOST_LIBBZ2_MD5		:= fc310b254f6ba5fbb5da018f04533688
HOST_LIBBZ2		:= bzip2-$(HOST_LIBBZ2_VERSION)
HOST_LIBBZ2_SUFFIX	:= tar.gz
HOST_LIBBZ2_URL		:= http://www.bzip.org/1.0.4/$(HOST_LIBBZ2).$(HOST_LIBBZ2_SUFFIX)
HOST_LIBBZ2_SOURCE	:= $(SRCDIR)/$(HOST_LIBBZ2).$(HOST_LIBBZ2_SUFFIX)
HOST_LIBBZ2_DIR		:= $(HOST_BUILDDIR)/$(HOST_LIBBZ2)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

HOST_LIBBZ2_INSTALL_OPT := install PREFIX=$(HOST_LIBBZ2_PKGDIR)

# vim: syntax=make
