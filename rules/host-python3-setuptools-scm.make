# -*-makefile-*-
#
# Copyright (C) 2016 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_SETUPTOOLS_SCM) += host-python3-setuptools-scm

#
# Paths and names
#
HOST_PYTHON3_SETUPTOOLS_SCM_VERSION	:= 1.10.1
HOST_PYTHON3_SETUPTOOLS_SCM_MD5		:= 99823e2cd564b996f18820a065f0a974
HOST_PYTHON3_SETUPTOOLS_SCM		:= setuptools_scm-$(HOST_PYTHON3_SETUPTOOLS_SCM_VERSION)
HOST_PYTHON3_SETUPTOOLS_SCM_SUFFIX	:= tar.bz2
HOST_PYTHON3_SETUPTOOLS_SCM_URL		:= https://pypi.python.org/packages/source/s/setuptools_scm/$(HOST_PYTHON3_SETUPTOOLS_SCM).$(HOST_PYTHON3_SETUPTOOLS_SCM_SUFFIX)
HOST_PYTHON3_SETUPTOOLS_SCM_SOURCE	:= $(SRCDIR)/$(HOST_PYTHON3_SETUPTOOLS_SCM).$(HOST_PYTHON3_SETUPTOOLS_SCM_SUFFIX)
HOST_PYTHON3_SETUPTOOLS_SCM_DIR		:= $(HOST_BUILDDIR)/$(HOST_PYTHON3_SETUPTOOLS_SCM)
HOST_PYTHON3_SETUPTOOLS_SCM_LICENSE	:= MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_PYTHON3_SETUPTOOLS_SCM_CONF_TOOL	:= python3

# vim: syntax=make
