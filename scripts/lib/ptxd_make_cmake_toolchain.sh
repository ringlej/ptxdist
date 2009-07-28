#!/bin/bash

PTXDIST_CMAKE_TOOLCHAIN="${PTXDIST_GEN_CONFIG_DIR}/toolchain.cmake"
export PTXDIST_CMAKE_TOOLCHAIN

#
# generate cmake toolchain file from template
#
# $1:	cmake toolchain file
#
# FIXME: take care about non linux
#
ptxd_make_cmake_toolchain() {
    SYSTEM_NAME="Linux" \
	SYSTEM_VERSION="1" \
	\
	CC="$(which "${CC}")" \
	CXX="$(which "${CXX}")" \
	\
	SYSROOT="${PTXDIST_PATH_SYSROOT_ALL//:/ }" \
	\
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/cmake/toolchain.cmake.in" > "${1}"
}
export -f ptxd_make_cmake_toolchain
