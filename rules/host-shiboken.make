# -*-makefile-*-
#
# Copyright (C) 2011 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_SHIBOKEN) += host-shiboken

#
# Paths and names
#

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_SHIBOKEN_CONF_TOOL	:= cmake
HOST_SHIBOKEN_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_TESTS:BOOL=OFF

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-shiboken.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_SHIBOKEN)
	@sed -i -e 's,"/,"$(PTXCONF_SYSROOT_HOST)/,g' \
		'$(PTXCONF_SYSROOT_HOST)/lib/cmake/Shiboken-$(SHIBOKEN_VERSION)/ShibokenConfig.cmake'
	@$(call touch)

# vim: syntax=make
