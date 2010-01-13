# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
HOST_CMAKE_VERSION	:= 2.8.0
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

HOST_CMAKE_PATH	:= PATH=$(HOST_PATH)
HOST_CMAKE_ENV 	:= $(HOST_ENV)
HOST_CMAKE_BUILD_OOT := YES

#
# autoconf
#
HOST_CMAKE_AUTOCONF := $(HOST_AUTOCONF)

$(STATEDIR)/host-cmake.install.post: $(PTXDIST_CMAKE_TOOLCHAIN)

# vim: syntax=make
