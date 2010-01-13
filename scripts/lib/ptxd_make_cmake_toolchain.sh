#!/bin/bash
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PTXDIST_CMAKE_TOOLCHAIN_TARGET="${PTXDIST_GEN_CONFIG_DIR}/toolchain-target.cmake"
export PTXDIST_CMAKE_TOOLCHAIN_TARGET

#
# generate cmake toolchain file from template
#
# $1:	cmake toolchain file
#
# FIXME: take care about non linux
#
ptxd_make_cmake_toolchain_target() {
    SYSTEM_NAME="Linux" \
	SYSTEM_VERSION="1" \
	\
	CC="$(which "${CC}")" \
	CXX="$(which "${CXX}")" \
	\
	SYSROOT="${PTXDIST_PATH_SYSROOT_ALL//:/ }" \
	\
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/cmake/toolchain-target.cmake.in" > "${1}"
}
export -f ptxd_make_cmake_toolchain_target
