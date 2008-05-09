# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
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
# handle special compilers
#
ifdef PTXCONF_KERNEL
    ifneq ($(PTX_COMPILER_PREFIX),$(PTX_COMPILER_PREFIX_KERNEL))
        ifeq ($(wildcard .ktoolchain/$(PTX_COMPILER_PREFIX_KERNEL)gcc),)
            $(warning *** no .ktoolchain link found. Please create a link)
            $(warning *** .ktoolchain to the bin directory of your $(PTX_COMPILER_PREFIX_KERNEL) toolchain)
            $(error )
        endif
    KERNEL_TOOLCHAIN_LINK := $(PTXDIST_WORKSPACE)/.ktoolchain/
    endif
endif

#
# Paths and names
#
KERNEL			:= linux-$(KERNEL_VERSION)
KERNEL_SUFFIX		:= tar.bz2
KERNEL_TESTING		= $(subst rc,testing/,$(findstring rc,$(KERNEL_VERSION)))
KERNEL_URL		= http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL_TESTING)$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_SOURCE		:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_DIR		:= $(BUILDDIR)/$(KERNEL)
KERNEL_PKGDIR		:= $(PKGDIR)/$(KERNEL)

KERNEL_CONFIG		:= $(call remove_quotes, $(PTXDIST_PLATFORMCONFIGDIR)/$(PTXCONF_KERNEL_CONFIG))

#
# Some configuration stuff for the different kernel image formats
#
ifdef PTXCONF_KERNEL_IMAGE_Z
KERNEL_IMAGE_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/zImage
endif

ifdef PTXCONF_KERNEL_IMAGE_BZ
KERNEL_IMAGE_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/bzImage
endif

ifdef PTXCONF_KERNEL_IMAGE_U
KERNEL_IMAGE_PATH	:= \
	$(KERNEL_DIR)/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/images/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/images/vmlinux.UBoot
endif

ifdef PTXCONF_KERNEL_IMAGE_VM
KERNEL_IMAGE_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/vmImage
endif

ifdef PTXCONF_KERNEL_IMAGE_VMLINUX
KERNEL_IMAGE_PATH	:= $(KERNEL_DIR)/vmlinux
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KERNEL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, KERNEL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(KERNEL_DIR))
	@$(call extract, KERNEL)
	@$(call patchin, KERNEL)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KERNEL_PATH	:= PATH=$(CROSS_PATH)
KERNEL_ENV 	:= KCONFIG_NOTIMESTAMP=1
KERNEL_MAKEVARS := \
	$(PARALLELMFLAGS) \
	HOSTCC=$(HOSTCC) \
	ARCH=$(PTXCONF_KERNEL_ARCH_STRING) \
	CROSS_COMPILE=$(KERNEL_TOOLCHAIN_LINK)$(PTX_COMPILER_PREFIX_KERNEL) \
	\
	INSTALL_MOD_PATH=$(KERNEL_PKGDIR) \
	PTX_KERNEL_DIR=$(KERNEL_DIR)

ifdef PTXCONF_KERNEL_MODULES_INSTALL
KERNEL_MAKEVARS += \
	DEPMOD=$(PTXCONF_SYSROOT_CROSS)/sbin/$(PTXCONF_GNU_TARGET)-depmod
endif

KERNEL_IMAGE	:= $(PTXCONF_KERNEL_IMAGE)

$(KERNEL_CONFIG):
	@echo
	@echo "*************************************************************************"
	@echo "**** Please generate a kernelconfig with \"ptxdist menuconfig kernel\" ****"
	@echo "*************************************************************************"
	@echo
	@echo
	@exit 1

$(STATEDIR)/kernel.prepare: $(KERNEL_CONFIG) $(STATEDIR)/cross-module-init-tools.install
	@$(call targetinfo, $@)

	@if [ -f $(KERNEL_CONFIG) ]; then				\
		echo "Using kernel config file: $(KERNEL_CONFIG)";	\
		install -m 644 $(KERNEL_CONFIG) $(KERNEL_DIR)/.config; 	\
	else								\
		echo "ERROR: No such kernel config: $(KERNEL_CONFIG)";	\
		exit 1;							\
	fi

ifdef PTXCONF_KLIBC
# tell the kernel where our spec file for initramfs is
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(KLIBC_CONTROL)\",g' \
		$(KERNEL_DIR)/.config
endif

	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) \
		$(KERNEL_MAKEVARS) oldconfig

	cp $(KERNEL_DIR)/.config $(KERNEL_CONFIG)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.compile:
	@$(call targetinfo, $@)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) $(KERNEL_IMAGE) $(PTXCONF_KERNEL_MODULES_BUILD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.targetinstall:
	@$(call targetinfo, $@)

# we _always_ need the kernel in the image dir
	@for i in $(KERNEL_IMAGE_PATH); do				\
		if [ -f $$i ]; then					\
			install -m 644 $$i $(IMAGEDIR)/linuximage;	\
		fi;							\
	done

	@if test \! -e $(IMAGEDIR)/linuximage; then				\
		echo "$(PTXCONF_KERNEL_IMAGE) not found, maybe bzImage on ARM";	\
		exit 1;								\
	fi

#
# install the ELF kernel image for debugging purpose
# e.g. oprofile
#
ifdef PTXCONF_KERNEL_VMLINUX
	$(call install_copy, kernel, 0, 0, 0644, $(KERNEL_DIR)/vmlinux, /boot/vmlinux, n)
endif


ifdef PTXCONF_KERNEL_INSTALL
	@$(call install_init,  kernel)
	@$(call install_fixup, kernel, PACKAGE, kernel)
	@$(call install_fixup, kernel, PRIORITY,optional)
	@$(call install_fixup, kernel, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel, SECTION,base)
	@$(call install_fixup, kernel, AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, kernel, DEPENDS,)
	@$(call install_fixup, kernel, DESCRIPTION,missing)

	@for i in $(KERNEL_IMAGE_PATH); do 				\
		if [ -f $$i ]; then					\
			$(call install_copy, kernel, 0, 0, 0644, $$i, /boot/$(KERNEL_IMAGE), n); \
		fi;							\
	done
	@$(call install_finish, kernel)
endif

ifdef PTXCONF_KERNEL_MODULES_INSTALL
	if test -e $(KERNEL_PKGDIR); then \
		rm -rf $(KERNEL_PKGDIR); \
	fi
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) modules_install
endif

	@$(call touch, $@)


# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.targetinstall.post:
	@$(call targetinfo, $@)

ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@$(call install_init,  kernel-modules)
	@$(call install_fixup, kernel-modules, PACKAGE,kernel-modules)
	@$(call install_fixup, kernel-modules, PRIORITY,optional)
	@$(call install_fixup, kernel-modules, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel-modules, SECTION,base)
	@$(call install_fixup, kernel-modules, AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, kernel-modules, DEPENDS,)
	@$(call install_fixup, kernel-modules, DESCRIPTION,missing)

	@cd $(KERNEL_PKGDIR) &&					\
		for file in `find . -type f | sed -e "s/\.\//\//g"`; do	\
			$(call install_copy, kernel-modules, 0, 0, 0644, $(KERNEL_PKGDIR)/$${file}, $${file}, n); \
		done

	@$(call install_finish, kernel-modules)
endif

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel_clean:
	rm -rf $(STATEDIR)/kernel.*
	rm -rf $(IMAGEDIR)/kernel_*
	rm -rf $(KERNEL_DIR)

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

kernel_oldconfig kernel_menuconfig: $(STATEDIR)/kernel.extract
	@if test -e $(KERNEL_CONFIG); then \
		cp $(KERNEL_CONFIG) $(KERNEL_DIR)/.config; \
	fi
	@cd $(KERNEL_DIR) && \
		$(KERNEL_PATH) $(KERNEL_ENV) $(MAKE) $(KERNEL_MAKEVARS) $(subst kernel_,,$@)
	@if cmp -s $(KERNEL_DIR)/.config $(KERNEL_CONFIG); then \
		echo "kernel configuration unchanged"; \
	else \
		cp $(KERNEL_DIR)/.config $(KERNEL_CONFIG); \
	fi


# vim: syntax=make
