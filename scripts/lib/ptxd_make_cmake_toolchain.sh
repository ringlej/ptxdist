#!/bin/bash

PTXDIST_CMAKE_TOOLCHAIN="${PTXDIST_GEN_CONFIG_DIR}/toolchain.cmake"
export PTXDIST_CMAKE_TOOLCHAIN

#
# generate cmake toolchain file from template
#
# stdout: cmake toolchain file
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
	SYSROOT_TOOLCHAIN="${PTXDIST_SYSROOT_TOOLCHAIN}" \
	SYSROOT_TARGET="${SYSROOT}" \
	\
	ptxd_replace_magic "${PTXDIST_TOPDIR}/config/toolchain-template.cmake" > "${1}"
}
export -f ptxd_make_cmake_toolchain
