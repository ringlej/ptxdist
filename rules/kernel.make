# -*-makefile-*-
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
#               2010 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KERNEL) += kernel


#
# when using a production release,
# we use the precompiled kernel from /opt
#
ifdef PTXCONF_PROJECT_USE_PRODUCTION
KERNEL_BDIR		:= $(PTXDIST_PROD_PLATFORMDIR)/build-target
else
KERNEL_BDIR		:= $(BUILDDIR)
endif


#
# Paths and names
#
KERNEL			:= linux-$(KERNEL_VERSION)
KERNEL_SUFFIX		:= tar.bz2
KERNEL_DIR		:= $(KERNEL_BDIR)/$(KERNEL)
KERNEL_CONFIG		:= $(call remove_quotes, $(PTXDIST_PLATFORMCONFIGDIR)/$(PTXCONF_KERNEL_CONFIG))
KERNEL_LICENSE		:= GPLv2

ifdef PTXCONF_KERNEL_LOCAL_FLAG
KERNEL_URL		:= file://$(PTXCONF_SETUP_KERNELDIR_PREFIX)/$(KERNEL_VERSION)
else
KERNEL_URL		:= \
	http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL).$(KERNEL_SUFFIX) \
	http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/testing/$(KERNEL).$(KERNEL_SUFFIX) \
	http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/testing/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR).$(KERNEL_VERSION_MICRO)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_SOURCE		:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(KERNEL_SOURCE):
	@$(call targetinfo)
	@$(call get, KERNEL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KERNEL_PATH	:= PATH=$(CROSS_PATH)
KERNEL_ENV 	:= KCONFIG_NOTIMESTAMP=1
KERNEL_MAKEVARS := \
	$(PARALLELMFLAGS) \
	HOSTCC=$(HOSTCC) \
	ARCH=$(PTXCONF_KERNEL_ARCH_STRING) \
	CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) \
	\
	INSTALL_MOD_PATH=$(KERNEL_PKGDIR) \
	PTX_KERNEL_DIR=$(KERNEL_DIR) \
	$(call remove_quotes,$(PTXCONF_KERNEL_EXTRA_MAKEVARS))

ifdef PTXCONF_KERNEL_MODULES_INSTALL
KERNEL_MAKEVARS += \
	DEPMOD=$(PTXCONF_SYSROOT_CROSS)/sbin/$(PTXCONF_GNU_TARGET)-depmod
endif


#
# support the different kernel image formats
#
KERNEL_IMAGE := $(call remove_quotes, $(PTXCONF_KERNEL_IMAGE))

# these are sane default
KERNEL_IMAGE_PATH_y := $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/$(KERNEL_IMAGE)

# vmlinux is special
KERNEL_IMAGE_PATH_$(PTXCONF_KERNEL_IMAGE_VMLINUX) := $(KERNEL_DIR)/vmlinux


ifndef PTXCONF_PROJECT_USE_PRODUCTION

ifdef PTXCONF_KERNEL
$(KERNEL_CONFIG):
	@echo
	@echo "*************************************************************************"
	@echo "**** Please generate a kernelconfig with 'ptxdist menuconfig kernel' ****"
	@echo "*************************************************************************"
	@echo
	@echo
	@exit 1
endif


#
# when compiling the rootfs into the kernel, we just include an empty
# file for now. the rootfs isn't build yet.
#
KERNEL_INITRAMFS_SOURCE_$(PTXCONF_IMAGE_KERNEL_INITRAMFS) += $(STATEDIR)/empty.cpio
KERNEL_INITRAMFS_SOURCE_$(PTXCONF_KLIBC) += $(INITRAMFS_CONTROL)

$(STATEDIR)/kernel.prepare: $(KERNEL_CONFIG)
	@$(call targetinfo)

	@echo "Using kernel config file: $(<)"
	@install -m 644 "$(<)" "$(KERNEL_DIR)/.config"
ifdef PTXCONF_KERNEL_IMAGE_SIMPLE
	cp $(PTXCONF_KERNEL_IMAGE_SIMPLE_DTS) \
		$(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/dts/$(PTXCONF_KERNEL_IMAGE_SIMPLE_TARGET).dts
endif

ifdef KERNEL_INITRAMFS_SOURCE_y
	@touch "$(KERNEL_INITRAMFS_SOURCE_y)"
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(KERNEL_INITRAMFS_SOURCE_y)\",g' \
		"$(KERNEL_DIR)/.config"
endif

	@$(call ptx/oldconfig, KERNEL)
	@cp "$(KERNEL_DIR)/.config" "$(<)"

#
# Don't keep the expanded path to INITRAMS_SOURCE in $(KERNEL_CONFIG),
# because it contains local workdir path which is not relevant to
# other developers.
#
ifdef KERNEL_INITRAMFS_SOURCE_y
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"# Automatically set by PTXDist\",g' \
		"$(<)"
endif
	@$(call touch)


# ----------------------------------------------------------------------------
# tags
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.tags:
	@$(call targetinfo)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) \
		$(KERNEL_MAKEVARS) TAGS cscope

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.compile:
	@$(call targetinfo)
	@rm -f \
		$(KERNEL_DIR)/usr/initramfs_data.cpio.* \
		$(KERNEL_DIR)/usr/.initramfs_data.cpio.*
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) \
		$(KERNEL_MAKEVARS) $(KERNEL_IMAGE)
	@$(call touch)

endif # !PTXCONF_PROJECT_USE_PRODUCTION

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.install:
	@$(call targetinfo)
	@rm -rf "$(KERNEL_HEADERS_DIR)"
	@cd $(KERNEL_DIR) && \
	if $(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) $(KERNEL_MAKEVARS) help | \
		grep headers_install > /dev/null 2>&1; then \
		$(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) $(KERNEL_MAKEVARS) headers_install INSTALL_HDR_PATH=$(KERNEL_HEADERS_DIR); \
	else \
		mkdir -p $(KERNEL_HEADERS_INCLUDE_DIR)/asm && \
		cp -r \
			$(KERNEL_DIR)/include/linux \
			$(KERNEL_DIR)/include/asm/* \
			$(KERNEL_DIR)/include/asm-generic \
			$(KERNEL_HEADERS_INCLUDE_DIR); \
	fi

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.targetinstall:
	@$(call targetinfo)

# delete the kernel image, it might be out-of-date
	@rm -f $(IMAGEDIR)/linuximage

ifneq ($(PTXCONF_KERNEL_INSTALL)$(PTXCONF_KERNEL_VMLINUX),)
	@$(call install_init,  kernel)
	@$(call install_fixup, kernel, PACKAGE, kernel)
	@$(call install_fixup, kernel, PRIORITY,optional)
	@$(call install_fixup, kernel, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel, SECTION,base)
	@$(call install_fixup, kernel, AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, kernel, DEPENDS,)
	@$(call install_fixup, kernel, DESCRIPTION,missing)

	@$(call install_copy, kernel, 0, 0, 0755, /boot);
ifdef PTXCONF_KERNEL_INSTALL
	$(call install_copy, kernel, 0, 0, 0644, $(KERNEL_IMAGE_PATH_y), /boot/$(KERNEL_IMAGE), n)
endif

# install the ELF kernel image for debugging purpose
ifdef PTXCONF_KERNEL_VMLINUX
	@$(call install_copy, kernel, 0, 0, 0644, $(KERNEL_DIR)/vmlinux, /boot/vmlinux, n)
endif

	@$(call install_finish, kernel)
endif

ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@rm -rf $(KERNEL_PKGDIR)
	@cd $(KERNEL_DIR) && $(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) \
		$(KERNEL_MAKEVARS) modules_install
endif

	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_KERNEL_INSTALL_EARLY
$(STATEDIR)/kernel.targetinstall.post: $(IMAGEDIR)/linuximage
endif

$(STATEDIR)/kernel.targetinstall.post:
	@$(call targetinfo)

ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@$(call install_init,  kernel-modules)
	@$(call install_fixup, kernel-modules, PACKAGE,kernel-modules)
	@$(call install_fixup, kernel-modules, PRIORITY,optional)
	@$(call install_fixup, kernel-modules, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel-modules, SECTION,base)
	@$(call install_fixup, kernel-modules, AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, kernel-modules, DEPENDS,)
	@$(call install_fixup, kernel-modules, DESCRIPTION,missing)

	@cd $(KERNEL_PKGDIR) && \
		find lib -type f | while read file; do \
			$(call install_copy, kernel-modules, 0, 0, 0644, -, /$${file}, n) \
	done

	@$(call install_finish, kernel-modules)
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ifndef PTXCONF_PROJECT_USE_PRODUCTION

kernel_clean:
	rm -rf $(STATEDIR)/kernel.* $(STATEDIR)/kernel-modules.*
	rm -rf $(PKGDIR)/kernel_* $(PKGDIR)/kernel-modules_*
	@if [ -L $(KERNEL_DIR) ]; then \
		pushd $(KERNEL_DIR); \
		quilt pop -af; \
		rm -rf series patches .pc; \
		$(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) $(KERNEL_MAKEVARS) distclean; \
		popd; \
	fi
	rm -rf $(KERNEL_DIR)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

kernel_oldconfig kernel_menuconfig: $(STATEDIR)/kernel.extract
	@if [ -e $(KERNEL_CONFIG) ]; then \
		cp $(KERNEL_CONFIG) $(KERNEL_DIR)/.config; \
	fi

	@cd $(KERNEL_DIR) && \
		$(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) $(KERNEL_MAKEVARS) $(subst kernel_,,$@)

	@if cmp -s $(KERNEL_DIR)/.config $(KERNEL_CONFIG); then \
		echo "kernel configuration unchanged"; \
	else \
		cp $(KERNEL_DIR)/.config $(KERNEL_CONFIG); \
	fi

endif

# vim: syntax=make
