# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_CMAKE) += host-cmake

#
# Paths and names
#
HOST_CMAKE_VERSION	:= 2.8.4
HOST_CMAKE_MD5		:= 209b7d1d04b2e00986538d74ba764fcf
HOST_CMAKE		:= cmake-$(HOST_CMAKE_VERSION)
HOST_CMAKE_SUFFIX	:= tar.gz
HOST_CMAKE_URL		:= http://www.cmake.org/files/v2.8/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_SOURCE	:= $(SRCDIR)/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_DIR		:= $(HOST_BUILDDIR)/$(HOST_CMAKE)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HOST_CMAKE_SOURCE):
	@$(call targetinfo)
	@$(call get, HOST_CMAKE)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CMAKE_BUILD_OOT := YES
HOST_CMAKE_CONF_TOOL := autoconf

$(STATEDIR)/host-cmake.install.post: \
	$(PTXDIST_CMAKE_TOOLCHAIN_TARGET) \
	$(PTXDIST_CMAKE_TOOLCHAIN_HOST)

# vim: syntax=make
