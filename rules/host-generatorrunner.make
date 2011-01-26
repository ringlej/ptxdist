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
HOST_PACKAGES-$(PTXCONF_HOST_GENERATORRUNNER) += host-generatorrunner

#
# Paths and names
#
HOST_GENERATORRUNNER_VERSION	:= 0.6.9
HOST_GENERATORRUNNER_MD5	:= b99c5564104a56147806d467ff1a187b
HOST_GENERATORRUNNER		:= generatorrunner-$(HOST_GENERATORRUNNER_VERSION)
HOST_GENERATORRUNNER_SUFFIX	:= tar.bz2
HOST_GENERATORRUNNER_URL	:= http://www.pyside.org/files/$(HOST_GENERATORRUNNER).$(HOST_GENERATORRUNNER_SUFFIX)
HOST_GENERATORRUNNER_SOURCE	:= $(SRCDIR)/$(HOST_GENERATORRUNNER).$(HOST_GENERATORRUNNER_SUFFIX)
HOST_GENERATORRUNNER_DIR	:= $(HOST_BUILDDIR)/$(HOST_GENERATORRUNNER)
HOST_GENERATORRUNNER_LICENSE	:= unknown
# The plugin dir is compiled into the generator
HOST_GENERATORRUNNER_DEVPKG	:= NO

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_GENERATORRUNNER_CONF_TOOL	:= cmake
HOST_GENERATORRUNNER_CONF_OPT	:= \
	$(HOST_CMAKE_OPT_SYSROOT) \
	-DBUILD_TESTS:BOOL=OFF \

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-generatorrunner.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_GENERATORRUNNER)
	@sed -i -e 's,\(GENERATORRUNNER_PLUGIN_DIR \)$(PTXCONF_SYSROOT_HOST),\1,g' \
		'$(PTXCONF_SYSROOT_HOST)/lib/cmake/GeneratorRunner-$(HOST_GENERATORRUNNER_VERSION)/GeneratorRunnerConfig.cmake'
	@$(call touch)

# vim: syntax=make
