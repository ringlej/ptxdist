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
PACKAGES-$(PTXCONF_GRPC) += grpc

#
# Paths and names
#
GRPC_VERSION	:= 1.17.2
GRPC_MD5	:= 346ecc9a9162664f7f50aadcdb4eac8e
GRPC		:= grpc-$(GRPC_VERSION)
GRPC_SUFFIX	:= tar.gz
GRPC_URL	:= https://github.com/grpc/grpc/archive/v$(GRPC_VERSION).$(GRPC_SUFFIX)
GRPC_SOURCE	:= $(SRCDIR)/$(GRPC).$(GRPC_SUFFIX)
GRPC_DIR	:= $(BUILDDIR)/$(GRPC)
GRPC_LICENSE	:= BSD-3-Clause

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
GRPC_CONF_TOOL	:= cmake

GRPC_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_SHARED_LIBS=ON \
	-DCMAKE_CXX_FLAGS='-Wno-error=ignored-qualifiers' \
	-DgRPC_BACKWARDS_COMPATIBILITY_MODE=OFF \
	-DgRPC_BUILD_CSHARP_EXT=OFF \
	-DgRPC_BUILD_TESTS=OFF \
	-D_gRPC_CARES_LIBRARIES=cares \
	-DgRPC_CARES_PROVIDER=none \
	-DgRPC_PROTOBUF_PROVIDER=package \
	-DgRPC_SSL_PROVIDER=package \
	-DgRPC_ZLIB_PROVIDER=package \
	-DgRPC_NATIVE_CPP_PLUGIN=$(PTXDIST_SYSROOT_HOST)/bin/grpc_cpp_plugin \
	-DPROTOBUF_PROTOC_EXECUTABLE=$(PTXDIST_SYSROOT_HOST)/bin/protoc

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/grpc.install:
	@$(call targetinfo)
	@$(call world/install, GRPC)

	@install -d $(GRPC_PKGDIR)/usr/lib/pkgconfig/
	VERSION=$$(sed -n '/CORE_VERSION =/s/.*=\s*\(.*\)/\1/p' $(GRPC_DIR)/Makefile) \
		ptxd_replace_magic $(GRPC_DIR)/grpc.pc.in > \
		$(GRPC_PKGDIR)/usr/lib/pkgconfig/grpc.pc
	VERSION=$$(sed -n '/CPP_VERSION =/s/.*=\s*\(.*\)/\1/p' $(GRPC_DIR)/Makefile) \
		ptxd_replace_magic $(GRPC_DIR)/grpc++.pc.in > \
		$(GRPC_PKGDIR)/usr/lib/pkgconfig/grpc++.pc

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/grpc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, grpc)
	@$(call install_fixup, grpc,PRIORITY,optional)
	@$(call install_fixup, grpc,SECTION,base)
	@$(call install_fixup, grpc,AUTHOR,"Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, grpc,DESCRIPTION,missing)

	@$(call install_lib, grpc, 0, 0, 0644, libaddress_sorting)
	@$(call install_lib, grpc, 0, 0, 0644, libgpr)
	@$(call install_lib, grpc, 0, 0, 0644, libgrpc)
	@$(call install_lib, grpc, 0, 0, 0644, libgrpc++)

	@$(call install_finish, grpc)

	@$(call touch)

# vim: syntax=make
