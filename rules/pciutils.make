# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
# Copyright (C) 2009 by Wolfram Sang, Pengutronix
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PCIUTILS) += pciutils

#
# Paths and names
#
PCIUTILS_VERSION	:= 3.3.0
PCIUTILS_MD5		:= 3c19adf32a8457983b71ff376ef7dafe
PCIUTILS		:= pciutils-$(PCIUTILS_VERSION)
PCIUTILS_SUFFIX		:= tar.xz
PCIUTILS_URL		:= $(call ptx/mirror, KERNEL, ../software/utils/pciutils/$(PCIUTILS).$(PCIUTILS_SUFFIX))
PCIUTILS_SOURCE		:= $(SRCDIR)/$(PCIUTILS).$(PCIUTILS_SUFFIX)
PCIUTILS_DIR		:= $(BUILDDIR)/$(PCIUTILS)
PCIUTILS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PCIUTILS_CONF_TOOL	:= NO
PCIUTILS_COMPILE_ENV	:= $(CROSS_ENV)

PCIUTILS_MAKE_OPT := \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	PREFIX=/usr \
	SBINDIR='\$$(PREFIX)/bin' \
	HOST=$(PTXCONF_ARCH_STRING)-linux \
	RELEASE=$(KERNEL_HEADER_VERSION) \
	ZLIB=$(call ptx/yesno, PTXCONF_PCIUTILS_COMPRESS) \
	LIBKMOD=$(call ptx/yesno, PTXCONF_PCIUTILS_LIBKMOD) \
	SHARED=$(call ptx/yesno, PTXCONF_PCIUTILS_LIBPCI) \
	STRIP= \
	DNS=no \
	HWDB=no

PCIUTILS_INSTALL_OPT := \
	$(PCIUTILS_MAKE_OPT) \
	install \
	$(call ptx/ifdef,PTXCONF_PCIUTILS_LIBPCI,install-lib,)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pciutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pciutils)
	@$(call install_fixup, pciutils,PRIORITY,optional)
	@$(call install_fixup, pciutils,SECTION,base)
	@$(call install_fixup, pciutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, pciutils,DESCRIPTION,missing)

ifdef PTXCONF_PCIUTILS_TOOLS
	@$(call install_copy, pciutils, 0, 0, 0755, -, /usr/bin/lspci)
	@$(call install_copy, pciutils, 0, 0, 0755, -, /usr/bin/setpci)
	@$(call install_copy, pciutils, 0, 0, 0755, -, /usr/bin/update-pciids)
endif

ifdef PTXCONF_PCIUTILS_LIBPCI
	@$(call install_lib, pciutils, 0, 0, 0644, libpci)
endif

ifdef PTXCONF_PCIUTILS_COMPRESS
	@$(call install_copy, pciutils, 0, 0, 0644, -, \
		/usr/share/pci.ids.gz, n)
else
	@$(call install_copy, pciutils, 0, 0, 0644, -, \
		/usr/share/pci.ids, n)
endif
	@$(call install_finish, pciutils)

	@$(call touch)

# vim: syntax=make
