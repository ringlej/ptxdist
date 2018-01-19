# -*-makefile-*-
#
# Copyright (C) 2018 by Bastian Stender <bst@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CYTHON3) += host-cython3

#
# Paths and names
#
HOST_CYTHON3_VERSION	:= 0.27.3
HOST_CYTHON3_MD5	:= 6149238287d662bd5d5e572482252493
HOST_CYTHON3		:= Cython-$(HOST_CYTHON3_VERSION)
HOST_CYTHON3_SUFFIX	:= tar.gz
HOST_CYTHON3_URL	:= https://pypi.python.org/packages/ee/2a/c4d2cdd19c84c32d978d18e9355d1ba9982a383de87d0fcb5928553d37f4/$(HOST_CYTHON3).$(HOST_CYTHON3_SUFFIX)
HOST_CYTHON3_SOURCE	:= $(SRCDIR)/$(HOST_CYTHON3).$(HOST_CYTHON3_SUFFIX)
HOST_CYTHON3_DIR	:= $(HOST_BUILDDIR)/$(HOST_CYTHON3)
HOST_CYTHON3_LICENSE	:= Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CYTHON3_CONF_TOOL	:= python3

# vim: syntax=make
