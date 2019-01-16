# -*-makefile-*-
#
# Copyright (C) 2019 by Ladislav Michl <ladis@linux-mips.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIBIIO) += libiio

#
# Paths and names
#
LIBIIO_VERSION	:= 0.17
LIBIIO_MD5	:= 05a45aad2d50ef8c8a015d0caaf3802d
LIBIIO		:= libiio-$(LIBIIO_VERSION)
LIBIIO_SUFFIX	:= tar.gz
LIBIIO_URL	:= https://github.com/analogdevicesinc/libiio/archive/v$(LIBIIO_VERSION).$(LIBIIO_SUFFIX)
LIBIIO_SOURCE	:= $(SRCDIR)/$(LIBIIO).$(LIBIIO_SUFFIX)
LIBIIO_DIR	:= $(BUILDDIR)/$(LIBIIO)
LIBIIO_LICENSE	:= LGPL-2.1-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBIIO_CONF_TOOL	:= cmake
LIBIIO_CONF_OPT		:= \
	$(CROSS_CMAKE_USR) \
	-DENABLE_IPV6=$(call ptx/onoff, PTXCONF_GLOBAL_IPV6) \
	-DWITH_DOC=OFF \
	-DWITH_IIOD=OFF \
	-DWITH_LOCAL_BACKEND=ON \
	-DWITH_LOCAL_CONFIG=OFF \
	-DWITH_XML_BACKEND=OFF \
	-DWITH_USB_BACKEND=OFF \
	-DWITH_SERIAL_BACKEND=OFF \
	-DWITH_NETWORK_BACKEND=OFF \
	-DWITH_MATLAB_BINDINGS_API=OFF \
	-DPYTHON_BINDINGS=OFF \
	-DCSHARP_BINDINGS=OFF \
	-DWITH_TESTS=$(call ptx/onoff, PTXCONF_LIBIIO_TEST_TOOLS)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libiio.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libiio)
	@$(call install_fixup, libiio, PRIORITY, optional)
	@$(call install_fixup, libiio, SECTION, base)
	@$(call install_fixup, libiio, AUTHOR, "Ladislav Michl <ladis@linux-mips.org>")
	@$(call install_fixup, libiio, DESCRIPTION, \
		"A library for interfacing with Linux IIO devices")

	@$(call install_lib, libiio, 0, 0, 0644, libiio)

ifdef PTXCONF_LIBIIO_TEST_TOOLS
	@$(foreach testprog, adi_xflow_check attr genxml info readdev reg writedev, \
		$(call install_copy, libiio, 0, 0, 0755, -, \
			/usr/bin/iio_$(testprog))$(ptx/nl))
endif
	@$(call install_finish, libiio)

	@$(call touch)

# vim: syntax=make
