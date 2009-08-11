# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
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
ifneq ($(PTXCONF_COMPILER_PREFIX),$(PTXCONF_COMPILER_PREFIX_KERNEL))
	KERNEL_TOOLCHAIN_LINK := $(PTXDIST_WORKSPACE)/.ktoolchain/
endif
endif


#
# Paths and names
#
KERNEL			:= linux-$(KERNEL_VERSION)
KERNEL_SUFFIX		:= tar.bz2
KERNEL_DIR		:= $(BUILDDIR)/$(KERNEL)
KERNEL_PKGDIR		:= $(PKGDIR)/$(KERNEL)
KERNEL_CONFIG		:= $(call remove_quotes, $(PTXDIST_PLATFORMCONFIGDIR)/$(PTXCONF_KERNEL_CONFIG))

ifdef PTXCONF_KERNEL_LOCAL_FLAG
KERNEL_URL		:= file://$(PTXCONF_SETUP_KERNELDIR_PREFIX)/$(KERNEL_VERSION)
else
KERNEL_URL		:= \
	http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL).$(KERNEL_SUFFIX) \
	http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/testing/$(KERNEL_TESTING)$(KERNEL).$(KERNEL_SUFFIX) \
	http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/testing/v$(KERNEL_VERSION)/$(KERNEL_TESTING)$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_SOURCE		:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
endif

#
# support the different kernel image formats
#
KERNEL_IMAGE_PATH-$(PTXCONF_KERNEL_IMAGE_BZ)	+= $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/bzImage
KERNEL_IMAGE_PATH-$(PTXCONF_KERNEL_IMAGE_U)	+= $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/uImage
KERNEL_IMAGE_PATH-$(PTXCONF_KERNEL_IMAGE_VM)	+= $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/vmImage
KERNEL_IMAGE_PATH-$(PTXCONF_KERNEL_IMAGE_Z)	+= $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/zImage
KERNEL_IMAGE_PATH-$(PTXCONF_KERNEL_IMAGE_VMLINUX) += $(KERNEL_DIR)/vmlinux

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
	CROSS_COMPILE=$(KERNEL_TOOLCHAIN_LINK)$(PTXCONF_COMPILER_PREFIX_KERNEL) \
	\
	INSTALL_MOD_PATH=$(KERNEL_PKGDIR) \
	PTX_KERNEL_DIR=$(KERNEL_DIR) \
	$(call remove_quotes,$(PTXCONF_KERNEL_EXTRA_MAKEVARS))

ifdef PTXCONF_KERNEL_MODULES_INSTALL
KERNEL_MAKEVARS += \
	DEPMOD=$(PTXCONF_SYSROOT_CROSS)/sbin/$(PTXCONF_GNU_TARGET)-depmod
endif

KERNEL_IMAGE	:= $(PTXCONF_KERNEL_IMAGE)

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

$(STATEDIR)/kernel.prepare: $(KERNEL_CONFIG)
	@$(call targetinfo)

	@echo "Using kernel config file: $(KERNEL_CONFIG)"
	@install -m 644 $(KERNEL_CONFIG) $(KERNEL_DIR)/.config

ifdef PTXCONF_KLIBC
# tell the kernel where our spec file for initramfs is
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(KLIBC_CONTROL)\",g' \
		$(KERNEL_DIR)/.config
endif

	@$(call ptx/oldconfig, KERNEL)
	@cp $(KERNEL_DIR)/.config $(KERNEL_CONFIG)

ifdef PTXCONF_KLIBC
# Don't keep expanded $(KLIBC_CONTROL) in $(KERNEL_CONFIG) because
# it contains local workdir path that is not relevant to other developers.
	@sed -i -e 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"<Automatically set by PTXDist>\",g' \
		$(KERNEL_CONFIG)
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
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) $(KERNEL_IMAGE) $(PTXCONF_KERNEL_MODULES_BUILD)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.targetinstall:
	@$(call targetinfo)

#	# we _always_ need the kernel in the image dir
	@for i in $(KERNEL_IMAGE_PATH-y); do				\
		if [ -f $$i ]; then					\
			install -m 644 $$i $(IMAGEDIR)/linuximage;	\
		fi;							\
	done

	@if test \! -e $(IMAGEDIR)/linuximage; then				\
		echo "$(PTXCONF_KERNEL_IMAGE) not found, maybe bzImage on ARM";	\
		exit 1;								\
	fi

ifneq ($(or $(PTXCONF_KERNEL_INSTALL),$(PTXCONF_KERNEL_VMLINUX)),)
	@$(call install_init,  kernel)
	@$(call install_fixup, kernel, PACKAGE, kernel)
	@$(call install_fixup, kernel, PRIORITY,optional)
	@$(call install_fixup, kernel, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel, SECTION,base)
	@$(call install_fixup, kernel, AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, kernel, DEPENDS,)
	@$(call install_fixup, kernel, DESCRIPTION,missing)

ifdef PTXCONF_KERNEL_INSTALL
	@for i in $(KERNEL_IMAGE_PATH-y); do 				\
		if [ -f $$i ]; then					\
			$(call install_copy, kernel, 0, 0, 0644, $$i, /boot/$(KERNEL_IMAGE), n); \
		fi;							\
	done
endif

ifdef PTXCONF_KERNEL_VMLINUX
#
# install the ELF kernel image for debugging purpose
# e.g. oprofile
#
	@$(call install_copy, kernel, 0, 0, 0644, $(KERNEL_DIR)/vmlinux, /boot/vmlinux, n)
endif

	@$(call install_finish, kernel)
endif


ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@if test -e $(KERNEL_PKGDIR); then \
		rm -rf $(KERNEL_PKGDIR); \
	fi
	@cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) modules_install
endif

	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.targetinstall.post:
	@$(call targetinfo)

ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@$(call install_init,  kernel-modules)
	@$(call install_fixup, kernel-modules, PACKAGE,kernel-modules)
	@$(call install_fixup, kernel-modules, PRIORITY,optional)
	@$(call install_fixup, kernel-modules, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel-modules, SECTION,base)
	@$(call install_fixup, kernel-modules, AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
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

kernel_clean:
	rm -rf $(STATEDIR)/kernel.* $(STATEDIR)/kernel-modules.*
	rm -rf $(PKGDIR)/kernel_* $(PKGDIR)/kernel-modules_*
	@if [ -L $(KERNEL_DIR) ]; then			\
		pushd $(KERNEL_DIR);			\
		quilt pop -af;				\
		rm -rf series patches .pc;		\
		$(MAKE) $(KERNEL_MAKEVARS) distclean;	\
		popd; 					\
	fi
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
