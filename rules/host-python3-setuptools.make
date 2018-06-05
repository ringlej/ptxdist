# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_SETUPTOOLS) += host-python3-setuptools

#
# Paths and names
#
HOST_PYTHON3_SETUPTOOLS_VERSION	:= 17.0
HOST_PYTHON3_SETUPTOOLS_MD5	:= a661715d164163ec7a01a9277a6d49da
HOST_PYTHON3_SETUPTOOLS		:= setuptools-$(HOST_PYTHON3_SETUPTOOLS_VERSION)
HOST_PYTHON3_SETUPTOOLS_SUFFIX	:= zip
HOST_PYTHON3_SETUPTOOLS_URL	:= https://pypi.python.org/packages/source/s/setuptools/$(HOST_PYTHON3_SETUPTOOLS).$(HOST_PYTHON3_SETUPTOOLS_SUFFIX)
HOST_PYTHON3_SETUPTOOLS_SOURCE	:= $(SRCDIR)/$(HOST_PYTHON3_SETUPTOOLS).$(HOST_PYTHON3_SETUPTOOLS_SUFFIX)
HOST_PYTHON3_SETUPTOOLS_DIR	:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_SETUPTOOLS)
HOST_PYTHON3_SETUPTOOLS_LICENSE	:= PSF AND ZPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_SETUPTOOLS_CONF_TOOL	:= python3

# vim: syntax=make
