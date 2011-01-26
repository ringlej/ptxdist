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
HOST_PACKAGES-$(PTXCONF_HOST_APIEXTRACTOR) += host-apiextractor

#
# Paths and names
#
HOST_APIEXTRACTOR_VERSION	:= 0.10.3
HOST_APIEXTRACTOR_MD5		:= 3dffe34785c2e0df20529cfebc2227e5
HOST_APIEXTRACTOR		:= apiextractor-$(HOST_APIEXTRACTOR_VERSION)
HOST_APIEXTRACTOR_SUFFIX	:= tar.bz2
HOST_APIEXTRACTOR_URL		:= http://www.pyside.org/files/$(HOST_APIEXTRACTOR).$(HOST_APIEXTRACTOR_SUFFIX)
HOST_APIEXTRACTOR_SOURCE	:= $(SRCDIR)/$(HOST_APIEXTRACTOR).$(HOST_APIEXTRACTOR_SUFFIX)
HOST_APIEXTRACTOR_DIR		:= $(HOST_BUILDDIR)/$(HOST_APIEXTRACTOR)
HOST_APIEXTRACTOR_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_APIEXTRACTOR_CONF_TOOL	:= cmake
HOST_APIEXTRACTOR_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_TESTS:BOOL=OFF \
	-DDISABLE_DOCSTRINGS:BOOL=ON

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-apiextractor.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_APIEXTRACTOR)
	@sed -i -e 's,"/,"$(PTXCONF_SYSROOT_HOST)/,g' \
		'$(PTXCONF_SYSROOT_HOST)/lib/cmake/ApiExtractor-$(HOST_APIEXTRACTOR_VERSION)/ApiExtractorConfig.cmake'
	@$(call touch)

# vim: syntax=make
