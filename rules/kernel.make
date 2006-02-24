# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2006 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

PACKAGES-$(PTXCONF_KERNEL_NATIVE_COMPILE) += kernel
PACKAGES-$(PTXCONF_KERNEL_TARGET_COMPILE) += kernel

ifdef NATIVE
KERNEL_CONFIG		:= $(PTXDIST_WORKSPACE)/kernelconfig.native
KERNEL_VERSION		:= $(call remove_quotes, $(PTXCONF_KERNEL_NATIVE_VERSION))
KERNEL_VERSION_MAJOR	:= $(KERNEL_NATIVE_VERSION_MAJOR)
KERNEL_VERSION_MINOR	:= $(KERNEL_NATIVE_VERSION_MINOR)
KERNEL_SERIES		:= $(PTXDIST_WORKSPACE)/kernel-patches-native/$(PTXCONF_KERNEL_NATIVE_SERIES)
else
KERNEL_CONFIG		:= $(PTXDIST_WORKSPACE)/kernelconfig.target
KERNEL_VERSION		:= $(call remove_quotes, $(PTXCONF_KERNEL_TARGET_VERSION))
KERNEL_VERSION_MAJOR	:= $(KERNEL_TARGET_VERSION_MAJOR)
KERNEL_VERSION_MINOR	:= $(KERNEL_TARGET_VERSION_MINOR)
KERNEL_SERIES		:= $(PTXDIST_WORKSPACE)/kernel-patches-target/$(PTXCONF_KERNEL_TARGET_SERIES)
endif

KERNEL		:= linux-$(KERNEL_VERSION)
KERNEL_SUFFIX	:= tar.bz2
KERNEL_URL	:= http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_SOURCE	:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)

ifdef KERNEL_TARGET_EXTERNAL
KERNEL_DIR	:= $(call remove_quotes, $(KERNEL_EXTERNAL_DIR))
else
KERNEL_DIR	:= $(BUILDDIR)/$(KERNEL)
endif

# FIXME: what's this?
# Here we are installing kernel modules which are copied to proper place
# later (after depmod is run). The real question is, What to do with external
# kernel modules?
KERNEL_INST_DIR	:= $(BUILDDIR)/$(KERNEL)-install

#
# Some configuration stuff for the different kernel image formats
#

# FIXME: there's probably a more intelligent solution than duplicating this

ifdef PTXCONF_KERNEL_TARGET_IMAGE_Z
KERNEL_TARGET		:= zImage
KERNEL_TARGET_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/zImage
endif
ifdef PTXCONF_KERNEL_TARGET_IMAGE_BZ
KERNEL_TARGET		:= bzImage
KERNEL_TARGET_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/bzImage
endif
ifdef PTXCONF_KERNEL_TARGET_IMAGE_U
KERNEL_TARGET		:= uImage
KERNEL_TARGET_PATH	:= \
	$(KERNEL_DIR)/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/images/vmlinux.UBoot \
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/uImage
endif
ifdef PTXCONF_KERNEL_TARGET_IMAGE_VMLINUX
KERNEL_TARGET		:= vmlinux
KERNEL_TARGET_PATH	:= $(KERNEL_DIR)/vmlinux
endif

ifdef PTXCONF_KERNEL_NATIVE_IMAGE_Z
KERNEL_TARGET		:= zImage
KERNEL_TARGET_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/zImage
endif
ifdef PTXCONF_KERNEL_NATIVE_IMAGE_BZ
KERNEL_TARGET		:= bzImage
KERNEL_TARGET_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/bzImage
endif
ifdef PTXCONF_KERNEL_NATIVE_IMAGE_U
KERNEL_TARGET		:= uImage
KERNEL_TARGET_PATH	:= \
	$(KERNEL_DIR)/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/images/vmlinux.UBoot \
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/uImage
endif
ifdef PTXCONF_KERNEL_NATIVE_IMAGE_VMLINUX
KERNEL_TARGET		:= vmlinux
KERNEL_TARGET_PATH	:= $(KERNEL_DIR)/vmlinux
endif

# ----------------------------------------------------------------------------
# Menuconfig
# ----------------------------------------------------------------------------

kernel_menuconfig: $(STATEDIR)/kernel.extract

ifndef PTXCONF_USE_EXTERNAL_KERNEL
	@if [ -f $(KERNEL_CONFIG) ]; then \
		install -m 644 $(KERNEL_CONFIG) $(KERNEL_DIR)/.config; \
	fi
endif

	cd $(KERNEL_DIR) && $(KERNEL_PATH) make menuconfig $(KERNEL_MAKEVARS)

ifndef PTXCONF_USE_EXTERNAL_KERNEL
	@if [ -f $(KERNEL_DIR)/.config ]; then \
		install -m 644 $(KERNEL_DIR)/.config $(KERNEL_CONFIG); \
	fi
endif

	@if [ -f $(STATEDIR)/kernel.compile ]; then \
		rm $(STATEDIR)/kernel.compile; \
	fi

# ----------------------------------------------------------------------------
# Oldconfig
# ----------------------------------------------------------------------------

kernel_oldconfig: $(STATEDIR)/kernel.extract

ifndef PTXCONF_USE_EXTERNAL_KERNEL
	@if [ -f $(KERNEL_CONFIG) ]; then \
		install -m 644 $(KERNEL_CONFIG) $(KERNEL_DIR)/.config; \
	fi
endif

	cd $(KERNEL_DIR) && $(KERNEL_PATH) make oldconfig $(KERNEL_MAKEVARS)

ifndef PTXCONF_USE_EXTERNAL_KERNEL
	@if [ -f $(KERNEL_DIR)/.config ]; then \
		install -m 644 $(KERNEL_DIR)/.config $(KERNEL_CONFIG); \
	fi
endif

	@if [ -f $(STATEDIR)/kernel.compile ]; then \
		rm $(STATEDIR)/kernel.compile; \
	fi

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel_get: $(STATEDIR)/kernel.get

ifndef PTXCONF_USE_EXTERNAL_KERNEL
kernel_get_deps = $(KERNEL_SOURCE)
endif

$(STATEDIR)/kernel.get: $(kernel_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KERNEL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kernel_extract: $(STATEDIR)/kernel.extract

ifndef PTXCONF_USE_EXTERNAL_KERNEL
kernel_extract_deps := $(STATEDIR)/kernel-base.extract
endif

$(STATEDIR)/kernel.extract: $(kernel_extract_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(STATEDIR)/kernel-base.extract: $(STATEDIR)/kernel.get
	@$(call targetinfo, $@)
	@$(call clean, $(KERNEL_DIR))
	@$(call extract, $(KERNEL_SOURCE))

#
# kernels before 2.4.19 extract to "linux" instead of "linux-<version>"
#
ifeq (2.4.18,$(KERNEL_VERSION))
	mv $(BUILDDIR)/linux $(KERNEL_DIR)
endif

#
# apply the patch series
#
	@if [ -e $(KERNEL_SERIES) ]; then \
		$(PTXDIST_TOPDIR)/scripts/apply_patch_series.sh -s $(KERNEL_SERIES) -d $(KERNEL_DIR); \
	fi

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kernel_prepare: $(STATEDIR)/kernel.prepare

kernel_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel.extract

ifeq ($(KERNEL_VERSION_MINOR), 4)
kernel_prepare_deps += $(STATEDIR)/host-modutils.install
else
kernel_prepare_deps += $(STATEDIR)/host-module-init-tools.install
endif
ifdef PTXCONF_KLIBC
kernel_prepare_deps += $(STATEDIR)/klibc.install
endif

KERNEL_PATH	:=  PATH=$(CROSS_PATH)
KERNEL_MAKEVARS = \
	HOSTCC=$(HOSTCC) \
	$(PARALLELMFLAGS) \
	ARCH=$(call remove_quotes,$(PTXCONF_ARCH)) \
	CROSS_COMPILE=$(COMPILER_PREFIX)

ifeq ($(KERNEL_VERSION_MINOR), 4)
KERNEL_MAKEVARS += DEPMOD=$(call remove_quotes,$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-depmod.old)
else
KERNEL_MAKEVARS += DEPMOD=$(call remove_quotes,$(PTXCONF_PREFIX)/sbin/depmod)
endif

ifdef PTXCONF_KERNEL_TARGET_IMAGE_U
KERNEL_MAKEVARS += MKIMAGE=$(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
endif
ifdef PTXCONF_KERNEL_HOST_IMAGE_U
KERNEL_MAKEVARS += MKIMAGE=$(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
endif

# This was defined before; we leave it here for reference. [RSC]
# GENKSYMS=$(COMPILER_PREFIX)genksyms

$(STATEDIR)/kernel.prepare: $(kernel_prepare_deps)
	@$(call targetinfo, $@)

ifndef PTXCONF_USE_EXTERNAL_KERNEL
	@if [ -f $(KERNEL_CONFIG) ]; then                               \
		echo "Using kernel config file: $(KERNEL_CONFIG)";      \
		install -m 644 $(KERNEL_CONFIG) $(KERNEL_DIR)/.config;  \
	else                                                            \
		echo "ERROR: No such kernel config: $(KERNEL_CONFIG)";  \
		exit 1;                                                 \
	fi

ifdef PTXCONF_KLIBC
	# tell the kernel where our spec file for initramfs is
	#
	# FIXME: this doesn't really work, because other options
	#        do depend on this
	sed -ie 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(KLIBC_DIR)/initramfs_spec\",g' $(KERNEL_DIR)/.config
endif
	@echo 
	@echo "------------- make oldconfig -------------"
	@echo
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make oldconfig $(KERNEL_MAKEVARS)
	@echo 
	@echo "---------------- make dep ----------------"
	@echo 
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make dep $(KERNEL_MAKEVARS)
	@echo 
	@echo "---------- make modules_prepare ----------"
	@echo 
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make modules_prepare $(KERNEL_MAKEVARS)
else
	@echo "PTXCONF_USE_EXTERNAL_KERNEL is set, proceeding"
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kernel_compile: $(STATEDIR)/kernel.compile

kernel_compile_deps =  $(STATEDIR)/kernel.prepare

# FIXME: remove this when select magic works
ifdef PTXCONF_KERNEL_IMAGE_U
kernel_compile_deps += $(STATEDIR)/host-umkimage.install
endif

ifdef PTXCONF_KLIBC
kernel_compile_deps += $(STATEDIR)/klibc.install
endif

$(STATEDIR)/kernel.compile: $(kernel_compile_deps)
	@$(call targetinfo, $@)

	mkdir -p $(PTXCONF_PREFIX)/bin
	echo "#!/bin/sh" > $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	echo '$(call remove_quotes,$(PTXCONF_PREFIX))/bin/u-boot-mkimage "$$@"' >> $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	chmod +x $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make \
		$(KERNEL_TARGET) modules $(KERNEL_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel_install: $(STATEDIR)/kernel.install

$(STATEDIR)/kernel.install:
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

kernel_targetinstall: $(STATEDIR)/kernel.targetinstall

$(STATEDIR)/kernel.targetinstall: $(STATEDIR)/kernel.compile
	@$(call targetinfo, $@)

ifdef  PTXCONF_KERNEL_TARGET_INSTALL
	@$(call install_init,  kernel)
	@$(call install_fixup, kernel, PACKAGE, kernel)
	@$(call install_fixup, kernel, PRIORITY,optional)
	@$(call install_fixup, kernel, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel, SECTION,base)
	@$(call install_fixup, kernel, AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, kernel, DEPENDS,)
	@$(call install_fixup, kernel, DESCRIPTION,missing)

	for i in $(KERNEL_TARGET_PATH); do 				\
		if [ -f $$i ]; then					\
			$(call install_copy, kernel, 0, 0, 0644, $$i, /boot/$(KERNEL_TARGET), n)\
		fi;							\
	done
	@$(call install_finish, kernel)
endif
ifdef PTXCONF_KERNEL_TARGET_INSTALL_MODULES
	rm -fr $(KERNEL_INST_DIR)

	@$(call install_init,  kernel)
	@$(call install_fixup, kernel, PACKAGE,kernel-modules)
	@$(call install_fixup, kernel, PRIORITY,optional)
	@$(call install_fixup, kernel, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel, SECTION,base)
	@$(call install_fixup, kernel, AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, kernel, DEPENDS,)
	@$(call install_fixup, kernel, DESCRIPTION,missing)

	cd $(KERNEL_DIR) && $(KERNEL_PATH) make 			\
		modules_install $(KERNEL_MAKEVARS) INSTALL_MOD_PATH=$(KERNEL_INST_DIR)

	cd $(KERNEL_INST_DIR) &&					\
		for file in `find . -type f | sed -e "s/\.\//\//g"`; do	\
			$(call install_copy, kernel, 0, 0, 0664, $(KERNEL_INST_DIR)/$$file, $$file, n) \
		done

	rm -fr $(KERNEL_INST_DIR)

	@$(call install_finish, kernel)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel_clean:
ifndef PTXCONF_USE_EXTERNAL_KERNEL
	rm -rf $(KERNEL_DIR)
endif
	rm -f $(STATEDIR)/kernel.*

# vim: syntax=make
