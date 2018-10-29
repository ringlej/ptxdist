# -*-makefile-*-
#
# Copyright (C) 2014 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_KERNEL_HEADER) += host-kernel-header

#
# Paths and names
#
ifndef PTXCONF_KERNEL_HEADER
TOOLCHAIN_CONFIG	:= $(PTXDIST_PLATFORMDIR)/selected_toolchain/ptxconfig
ifneq ($(wildcard $(TOOLCHAIN_CONFIG)),)
HOST_KERNEL_HEADER_VERSION	:= $(call remove_quotes,$(shell ptxd_get_kconfig $(TOOLCHAIN_CONFIG) PTXCONF_KERNEL_HEADERS_VERSION))
HOST_KERNEL_HEADER_MD5		:= $(call remove_quotes,$(shell ptxd_get_kconfig $(TOOLCHAIN_CONFIG) PTXCONF_KERNEL_HEADERS_MD5))
else
HOST_KERNEL_HEADER_VERSION	:= 4.19
HOST_KERNEL_HEADER_MD5		:= 740a90cf810c2105df8ee12e5d0bb900
endif
HOST_KERNEL_HEADER		:= linux-$(HOST_KERNEL_HEADER_VERSION)
HOST_KERNEL_HEADER_SUFFIX	:= tar.xz
HOST_KERNEL_HEADER_URL		:= $(call kernel-url, HOST_KERNEL_HEADER)
HOST_KERNEL_HEADER_SOURCE	:= $(SRCDIR)/linux-$(HOST_KERNEL_HEADER_VERSION).$(HOST_KERNEL_HEADER_SUFFIX)
else
HOST_KERNEL_HEADER_VERSION	= $(KERNEL_HEADER_VERSION)
endif
HOST_KERNEL_HEADER_DIR		= $(HOST_BUILDDIR)/kernel-header-$(HOST_KERNEL_HEADER_VERSION)
HOST_KERNEL_HEADER_PKGDIR	= $(PKGDIR)/host-kernel-header-$(HOST_KERNEL_HEADER_VERSION)
HOST_KERNEL_HEADER_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_KERNEL_HEADER_CONF_ENV	:= $(HOST__ENV)
HOST_KERNEL_HEADER_PATH		:= PATH=$(HOST_PATH)
HOST_KERNEL_HEADER_CONF_TOOL	:= NO
HOST_KERNEL_HEADER_MAKE_OPT	:= \
	V=$(PTXDIST_VERBOSE)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-kernel-header.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-kernel-header.install:
	@$(call targetinfo)
	@cd $(HOST_KERNEL_HEADER_DIR) && \
	$(HOST_KERNEL_HEADER_PATH) $(HOST_KERNEL_HEADER_ENV) \
		$(MAKE) $(HOST_KERNEL_HEADER_MAKE_OPT) headers_install \
			INSTALL_HDR_PATH=$(HOST_KERNEL_HEADER_PKGDIR)/kernel-headers
	@$(call touch)

# vim: syntax=make
