# -*-makefile-*-
#
# Copyright (C) 2014 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CYTHON) += host-cython

#
# Paths and names
#
HOST_CYTHON_VERSION	:= 0.20.1
HOST_CYTHON_MD5		:= 52431696c64e618036537c4d9aa79d99
HOST_CYTHON		:= Cython-$(HOST_CYTHON_VERSION)
HOST_CYTHON_SUFFIX	:= tar.gz
HOST_CYTHON_URL		:= https://pypi.python.org/packages/81/87/9ceffc2c15a06fcdd82e621b54598da684271ed0c6722b316e7a30e4c18e/$(HOST_CYTHON).$(HOST_CYTHON_SUFFIX)
HOST_CYTHON_SOURCE	:= $(SRCDIR)/$(HOST_CYTHON).$(HOST_CYTHON_SUFFIX)
HOST_CYTHON_DIR		:= $(HOST_BUILDDIR)/$(HOST_CYTHON)
HOST_CYTHON_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CYTHON_CONF_TOOL	:= python

# vim: syntax=make
