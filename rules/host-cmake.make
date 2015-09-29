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
HOST_CMAKE_VERSION	:= 3.1.1
HOST_CMAKE_MD5		:= 0ae4f25dbec66697c0c3cec1b9e885ae
HOST_CMAKE		:= cmake-$(HOST_CMAKE_VERSION)
HOST_CMAKE_SUFFIX	:= tar.gz
HOST_CMAKE_URL		:= http://www.cmake.org/files/v3.1/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_SOURCE	:= $(SRCDIR)/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_DIR		:= $(HOST_BUILDDIR)/$(HOST_CMAKE)
HOST_CMAKE_LICENSE	:= BSD-3-Clause, Apache-2.0, bzip2-1.0.5
HOST_CMAKE_LICENSE_FILES := \
	file://Copyright.txt;md5=3ba5a6c34481652ce573e5c4e1d707e4 \
	file://Utilities/GitSetup/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57 \
	file://Utilities/cmbzip2/LICENSE;md5=7023994919680c533b77301b306ea1c9

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CMAKE_BUILD_OOT := YES
HOST_CMAKE_CONF_TOOL := autoconf

$(STATEDIR)/host-cmake.install.post: \
	$(PTXDIST_CMAKE_TOOLCHAIN_TARGET) \
	$(PTXDIST_CMAKE_TOOLCHAIN_HOST)

# vim: syntax=make
