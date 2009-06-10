# -*-makefile-*-

$(PTXDIST_CMAKE_TOOLCHAIN):
	@$(CROSS_ENV) ptxd_make_cmake_toolchain "${@}"

# vim: syntax=make
