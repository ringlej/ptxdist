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
PACKAGES-$(PTXCONF_KERNEL_HEADER) += kernel-header

#
# Paths and names
#
KERNEL_HEADER			:= linux-$(KERNEL_HEADER_VERSION)
KERNEL_HEADER_MD5		:= $(call remove_quotes,$(PTXCONF_KERNEL_HEADER_MD5))
ifneq ($(KERNEL_HEADER_NEEDS_GIT_URL),y)
KERNEL_HEADER_SUFFIX		:= tar.xz
KERNEL_HEADER_URL		:= $(call kernel-url, KERNEL_HEADER)
else
KERNEL_HEADER_SUFFIX		:= tar.gz
KERNEL_HEADER_URL		:= https://git.kernel.org/torvalds/t/$(KERNEL_HEADER).$(KERNEL_HEADER_SUFFIX)
endif
KERNEL_HEADER_SOURCE		:= $(SRCDIR)/linux-$(KERNEL_HEADER_VERSION).$(KERNEL_HEADER_SUFFIX)
KERNEL_HEADER_DIR		:= $(BUILDDIR)/kernel-header-$(KERNEL_HEADER_VERSION)
KERNEL_HEADER_PKGDIR		:= $(PKGDIR)/kernel-header-$(KERNEL_HEADER_VERSION)
KERNEL_HEADER_LICENSE		:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KERNEL_HEADER_CONF_ENV		:= $(CROSS_ENV)
KERNEL_HEADER_PATH		:= PATH=$(CROSS_PATH)
KERNEL_HEADER_CONF_TOOL		:= NO
KERNEL_HEADER_MAKE_OPT		:= \
	V=$(PTXDIST_VERBOSE) \
	HOSTCC=$(HOSTCC) \
	ARCH=$(GENERIC_KERNEL_ARCH) \
	CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-header.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel-header.install:
	@$(call targetinfo)
	@cd $(KERNEL_HEADER_DIR) && \
	$(KERNEL_HEADER_PATH) $(KERNEL_HEADER_ENV) \
		$(MAKE) $(KERNEL_HEADER_MAKE_OPT) headers_install \
			INSTALL_HDR_PATH=$(KERNEL_HEADER_PKGDIR)/kernel-headers
	@$(call touch)

# vim: syntax=make
