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
HOST_CMAKE_VERSION	:= 3.7.2
HOST_CMAKE_MD5		:= 79bd7e65cd81ea3aa2619484ad6ff25a
HOST_CMAKE		:= cmake-$(HOST_CMAKE_VERSION)
HOST_CMAKE_SUFFIX	:= tar.gz
HOST_CMAKE_URL		:= http://www.cmake.org/files/v3.7/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_SOURCE	:= $(SRCDIR)/$(HOST_CMAKE).$(HOST_CMAKE_SUFFIX)
HOST_CMAKE_DIR		:= $(HOST_BUILDDIR)/$(HOST_CMAKE)
HOST_CMAKE_LICENSE	:= BSD-3-Clause AND Apache-2.0 AND bzip2-1.0.5 AND (MIT OR public_domain) AND MIT
HOST_CMAKE_LICENSE_FILES := \
	file://Copyright.txt;md5=7a64bc564202bf7401d9a8ef33c9564d \
	file://Utilities/GitSetup/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57 \
	file://Utilities/cmbzip2/LICENSE;md5=7023994919680c533b77301b306ea1c9 \
	file://Utilities/cmjsoncpp/LICENSE;md5=c56ee55c03a55f8105b969d8270632ce \
	file://Utilities/cmlibuv/LICENSE;md5=bb5ea0d651f4c3519327171906045775

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_CMAKE_CONF_ENV	:= \
	$(HOST_ENV) \
	MAKEFLAGS="$(PARALLELMFLAGS)"

HOST_CMAKE_BUILD_OOT	:= YES
HOST_CMAKE_CONF_TOOL	:= autoconf
HOST_CMAKE_CONF_OPT	:= \
	$(HOST_AUTOCONF) \
	-- \
	-DBUILD_TESTING=NO \
	-DCMAKE_USE_OPENSSL=NO


$(STATEDIR)/host-cmake.install.post: \
	$(PTXDIST_CMAKE_TOOLCHAIN_TARGET) \
	$(PTXDIST_CMAKE_TOOLCHAIN_HOST)

# vim: syntax=make
