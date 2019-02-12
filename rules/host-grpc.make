# -*-makefile-*-
#
# Copyright (C) 2018 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_GRPC) += host-grpc

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_GRPC_CONF_TOOL	:= cmake

HOST_GRPC_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DCMAKE_CXX_FLAGS='-Wno-error=ignored-qualifiers' \
	-DgRPC_BACKWARDS_COMPATIBILITY_MODE=OFF \
	-DgRPC_BUILD_CSHARP_EXT=OFF \
	-DgRPC_BUILD_TESTS=OFF \
	-D_gRPC_CARES_LIBRARIES=cares \
	-DgRPC_CARES_PROVIDER=none \
	-DgRPC_PROTOBUF_PROVIDER=package \
	-DgRPC_SSL_PROVIDER=package \
	-DgRPC_ZLIB_PROVIDER=package

# vim: syntax=make
