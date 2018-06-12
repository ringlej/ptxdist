# -*-makefile-*-
#
# Copyright (C) 2016 by Robin van der Gracht <robin@protonic.nl>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_PYTHON3_SHIBOKEN) += host-python3-shiboken

#
# Paths and names
#

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_PYTHON3_SHIBOKEN_CONF_TOOL	:= cmake
HOST_PYTHON3_SHIBOKEN_CONF_OPT	= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_TESTS:BOOL=OFF \
	-DDISABLE_DOCSTRINGS:BOOL=ON \
	-DUSE_PYTHON3:BOOL=ON \
	-DPython3_PREFERRED_VERSION=python$(PYTHON3_MAJORMINOR)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-python3-shiboken.install:
	@$(call targetinfo)
	@$(call world/install, HOST_PYTHON3_SHIBOKEN)
	@sed -i -e 's,"$(PTXCONF_SYSROOT_HOST),",g' \
		$(HOST_PYTHON3_SHIBOKEN_PKGDIR)/lib/cmake/Shiboken-$(PYTHON3_SHIBOKEN_VERSION)/ShibokenConfig.cpython-*.cmake
	@$(call touch)

$(STATEDIR)/host-python3-shiboken.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_PYTHON3_SHIBOKEN)
	@sed -i -e 's,(/,($(PTXCONF_SYSROOT_HOST)/,g' \
		'$(PTXCONF_SYSROOT_HOST)/lib/cmake/Shiboken-$(PYTHON3_SHIBOKEN_VERSION)/ShibokenConfig.cmake'
	@sed -i -e 's,"/,"$(PTXCONF_SYSROOT_HOST)/,g' \
		$(PTXCONF_SYSROOT_HOST)/lib/cmake/Shiboken-$(PYTHON3_SHIBOKEN_VERSION)/ShibokenConfig.cpython-*.cmake
	@$(call touch)

# vim: syntax=make
