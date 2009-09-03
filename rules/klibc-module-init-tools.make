# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle <jon@ringle.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KLIBC_MODULE_INIT_TOOLS) += klibc-module-init-tools

#
# Paths and names
#
KLIBC_MODULE_INIT_TOOLS		= klibc-$(MODULE_INIT_TOOLS)
KLIBC_MODULE_INIT_TOOLS_DIR	= $(KLIBC_BUILDDIR)/$(MODULE_INIT_TOOLS)

ifdef PTXCONF_KLIBC_MODULE_INIT_TOOLS
$(STATEDIR)/klibc.targetinstall.post: $(STATEDIR)/klibc-module-init-tools.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-module-init-tools.get: $(STATEDIR)/module-init-tools.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-module-init-tools.extract:
	@$(call targetinfo)
	@$(call clean, $(KLIBC_MODULE_INIT_TOOLS_DIR))
	@$(call extract, MODULE_INIT_TOOLS, $(KLIBC_BUILDDIR))
	@$(call patchin, KLIBC_MODULE_INIT_TOOLS, $(KLIBC_MODULE_INIT_TOOLS_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KLIBC_MODULE_INIT_TOOLS_PATH	:= PATH=$(CROSS_PATH)
KLIBC_MODULE_INIT_TOOLS_ENV	:= $(KLIBC_ENV)
KLIBC_MODULE_INIT_TOOLS_MAKEVARS := MAN5="" MAN8=""

#
# autoconf
#
KLIBC_MODULE_INIT_TOOLS_AUTOCONF := $(KLIBC_AUTOCONF)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-module-init-tools.targetinstall:
	@$(call targetinfo)

ifdef PTXCONF_KLIBC_MODULE_INIT_TOOLS_INSMOD
	@$(call install_initramfs, klibc-module-init-tools, 0, 0, 0755, -, /sbin/insmod);
endif
ifdef PTXCONF_KLIBC_MODULE_INIT_TOOLS_RMMOD
	@$(call install_initramfs, klibc-module-init-tools, 0, 0, 0755, -, /sbin/rmmod);
endif
ifdef PTXCONF_KLIBC_MODULE_INIT_TOOLS_LSMOD
	@$(call install_initramfs, klibc-module-init-tools, 0, 0, 0755, -, /bin/lsmod);
endif
ifdef PTXCONF_KLIBC_MODULE_INIT_TOOLS_MODINFO
	@$(call install_initramfs, klibc-module-init-tools, 0, 0, 0755, -, /sbin/modinfo);
endif
ifdef PTXCONF_KLIBC_MODULE_INIT_TOOLS_MODPROBE
	@$(call install_initramfs, klibc-module-init-tools, 0, 0, 0755, -, /sbin/modprobe);
endif
ifdef PTXCONF_KLIBC_MODULE_INIT_TOOLS_DEPMOD
	@$(call install_initramfs, klibc-module-init-tools, 0, 0, 0755, -, /sbin/depmod);
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

klibc-module-init-tools_clean:
	rm -rf $(STATEDIR)/klibc-module-init-tools.*
	rm -rf $(PKGDIR)/klibc-module-init-tools*
	rm -rf $(KLIBC_MODULE_INIT_TOOLS_DIR)

# vim: syntax=make
