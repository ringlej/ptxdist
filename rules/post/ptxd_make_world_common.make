# -*-makefile-*-
#
# Copyright (C) 2009, 2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

world/env/impl = \
	MAKE="$(call ptx/escape,$(MAKE))"					\
	PTXDIST_SYSROOT_TARGET="$(call ptx/escape,$(PTXDIST_SYSROOT_TARGET))"	\
	PTXDIST_SYSROOT_HOST="$(call ptx/escape,$(PTXDIST_SYSROOT_HOST))"	\
	PTXDIST_SYSROOT_CROSS="$(call ptx/escape,$(PTXDIST_SYSROOT_CROSS))"	\
										\
	ptx_state_dir="$(call ptx/escape,$(STATEDIR))"				\
	ptx_lib_dir="$(call ptx/escape,$(PTXDIST_LIB_DIR))"			\
	ptx_pkg_dir="$(call ptx/escape,$(PKGDIR))"				\
										\
	ptx_path_target="${call ptx/escape,$(CROSS_PATH)}"			\
	ptx_conf_env_target="$(call ptx/escape,$(CROSS_ENV))"			\
	ptx_conf_opt_autoconf_target="$(call ptx/escape,$(CROSS_AUTOCONF_USR))"	\
	ptx_conf_opt_cmake_target="$(call ptx/escape,$(CROSS_CMAKE_USR))"	\
	ptx_conf_opt_qmake_target="$(call ptx/escape,$(CROSS_QMAKE_OPT))"	\
										\
	ptx_path_host="${call ptx/escape,$(HOST_PATH)}"				\
	ptx_conf_env_host="$(call ptx/escape,$(HOST_ENV))"			\
	ptx_conf_opt_autoconf_host="$(call ptx/escape,$(HOST_AUTOCONF))"	\
	ptx_conf_opt_cmake_host="$(call ptx/escape,$(HOST_CMAKE_OPT))"		\
										\
	ptx_path_cross="${call ptx/escape,$(HOST_CROSS_PATH)}"			\
	ptx_conf_env_cross="$(call ptx/escape,$(HOST_CROSS_ENV))"		\
	ptx_conf_opt_autoconf_cross="$(call ptx/escape,$(HOST_CROSS_AUTOCONF))"	\
										\
	pkg_stamp="$(notdir $(@))"						\
	pkg_pkg_dir="$(call ptx/escape,$($(1)_PKGDIR))"				\
	pkg_license="$(call ptx/escape,$($(1)_LICENSE))"			\
	pkg_deps="$(call ptx/escape,$(PTX_MAP_dep_$(1)))"			\
										\
	pkg_pkg="$(call ptx/escape,$($(1)))"					\
	pkg_path="$(call ptx/escape,$($(1)_PATH))"				\
	pkg_src="$(call ptx/escape,$($(1)_SOURCE))"				\
	pkg_url="$(call ptx/escape,$($(1)_URL))"				\
										\
	pkg_dir="$(call ptx/escape,$($(1)_DIR))"				\
	pkg_subdir="$(call ptx/escape,$($(1)_SUBDIR))"				\
										\
	pkg_tags_opt="$(call ptx/escape,$($(1)_TAGS_OPT))"			\
										\
	pkg_build_oot="$(call ptx/escape,$($(1)_BUILD_OOT))"			\
	pkg_build_dir="$(call ptx/escape,$($(1)_BUILD_DIR))"			\
										\
	pkg_conf_tool="$(call ptx/escape,$($(1)_CONF_TOOL))"			\
	pkg_conf_env="$(call ptx/escape,$($(1)_CONF_ENV))"			\
	pkg_conf_opt="$(call ptx/escape,$($(1)_CONF_OPT))"			\
										\
	pkg_make_env="$(call ptx/escape,$($(1)_MAKE_ENV))" 			\
	pkg_make_opt="$(call ptx/escape,$($(1)_MAKE_OPT))"			\
	pkg_make_par="$(call ptx/escape,$($(1)_MAKE_PAR))"			\
										\
	pkg_install_opt="$(call ptx/escape,$($(1)_INSTALL_OPT))"		\
	pkg_binconfig_glob="$(call ptx/escape,$($(1)_BINCONFIG_GLOB))"		\
										\
	pkg_deprecated_builddir="$(call ptx/escape,$($(1)_BUILDDIR))"		\
	pkg_deprecated_env="$(call ptx/escape,$($(1)_ENV))"			\
	pkg_deprecated_autoconf="$(call ptx/escape,$($(1)_AUTOCONF))"		\
	pkg_deprecated_cmake="$(call ptx/escape,$($(1)_CMAKE))"			\
	pkg_deprecated_compile_env="$(call ptx/escape,$($(1)_COMPILE_ENV))"	\
	pkg_deprecated_makevars="$(call ptx/escape, $($(1)_MAKEVARS))"

world/env= \
	$(call world/env/impl,$(strip $(1)))

# vim: syntax=make
