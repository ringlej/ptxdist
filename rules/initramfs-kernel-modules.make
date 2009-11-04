# -*-makefile-*-
#
# Copyright (C) 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INITRAMFS_KERNEL_MODULES) += initramfs-kernel-modules

#
# Paths and names
#
INITRAMFS_KERNEL_MODULES_VERSION	:= 1.0.0
INITRAMFS_KERNEL_MODULES		:= initramfs-kernel-modules-$(INITRAMFS_KERNEL_MODULES_VERSION)
INITRAMFS_KERNEL_MODULES_DIR		:= $(KLIBC_BUILDDIR)/$(INITRAMFS_KERNEL_MODULES)

ifdef PTXCONF_KLIBC_MODULE_INIT_TOOLS
$(STATEDIR)/klibc.targetinstall.post: $(STATEDIR)/initramfs-kernel-modules.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(INITRAMFS_KERNEL_MODULES_SOURCE):
	@$(call targetinfo)
	@$(call get, INITRAMFS_KERNEL_MODULES)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-kernel-modules.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

INITRAMFS_KERNEL_MODULES_PATH	:= PATH=$(CROSS_PATH)
INITRAMFS_KERNEL_MODULES_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/initramfs-kernel-modules.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-kernel-modules.compile: $(STATEDIR)/kernel.prepare
	@$(call targetinfo)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) $(PTXCONF_KERNEL_MODULES_BUILD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-kernel-modules.install:
	@$(call targetinfo)
	@$(call clean, $(INITRAMFS_KERNEL_MODULES_PKGDIR))
	@cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(filter-out INSTALL_MOD_PATH=%,$(KERNEL_MAKEVARS)) \
		INSTALL_MOD_PATH=$(INITRAMFS_KERNEL_MODULES_PKGDIR) \
		modules_install

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/initramfs-kernel-modules.targetinstall:
	@$(call targetinfo)
	@cd $(INITRAMFS_KERNEL_MODULES_PKGDIR) && \
	find lib -type d | while read dir; do \
		$(call install_initramfs, initramfs-kernel-modules, 0, 0, 0755, /$${dir}); \
	done

ifdef PTXCONF_INITRAMFS_KERNEL_MODULES_ALL
	@cd $(INITRAMFS_KERNEL_MODULES_PKGDIR) && \
	find lib -type f | while read file; do \
		$(call install_initramfs, initramfs-kernel-modules, 0, 0, 0644, -, /$${file}); \
	done
endif

ifdef PTXCONF_INITRAMFS_KERNEL_MODULES_USER_SPEC
	cat $(PTXDIST_WORKSPACE)/initramfs_modules | while read file; do \
		$(call install_initramfs, initramfs-kernel-modules, 0, 0, 0644, -, /$${file}); \
	done
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

initramfs-kernel-modules_clean:
	rm -rf $(STATEDIR)/initramfs-kernel-modules.*
	rm -rf $(PKGDIR)/initramfs-kernel-modules{-,_}*
	rm -rf $(INITRAMFS_KERNEL_MODULES_DIR)

# vim: syntax=make
