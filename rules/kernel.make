# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003, 2004, 2005 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_DONT_COMPILE_KERNEL
PACKAGES += kernel
endif

#
# Use a PTXdist built kernel which is parametrized here or use one from 
# an external directory
#

ifdef PTXCONF_USE_EXTERNAL_KERNEL
KERNEL_DIR		= $(call remove_quotes,$(PTXCONF_KERNEL_DIR))
else

# version stuff in now in rules/Version.make
# NB: make s*cks

KERNEL		= linux-$(KERNEL_VERSION)
KERNEL_SUFFIX	= tar.bz2
KERNEL_URL	= http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_SOURCE	= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_DIR	= $(BUILDDIR)/$(KERNEL)
KERNEL_CONFIG	= $(PTXCONF_KERNEL_CONFIG)
endif

#
# Some configuration stuff for the different kernel image formats
#

ifdef PTXCONF_KERNEL_IMAGE_Z
KERNEL_TARGET		= zImage
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/zImage
endif
ifdef PTXCONF_KERNEL_IMAGE_BZ
KERNEL_TARGET		= bzImage
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/bzImage
endif
ifdef PTXCONF_KERNEL_IMAGE_U
KERNEL_TARGET		=  uImage
KERNEL_TARGET_PATH	=  $(KERNEL_DIR)/uImage 
KERNEL_TARGET_PATH	+= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/images/vmlinux.UBoot
KERNEL_TARGET_PATH	+= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/uImage
endif
ifdef PTXCONF_KERNEL_IMAGE_VMLINUX
KERNEL_TARGET		= vmlinux
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/vmlinux
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
# Get patchstack-patches
# ----------------------------------------------------------------------------

kernel-patchstack_get: $(STATEDIR)/kernel-patchstack.get

# Remove quotes from patch names
PTXCONF_KERNEL_PATCH1_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH1_NAME))
PTXCONF_KERNEL_PATCH2_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH2_NAME))
PTXCONF_KERNEL_PATCH3_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH3_NAME))
PTXCONF_KERNEL_PATCH4_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH4_NAME))
PTXCONF_KERNEL_PATCH5_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH5_NAME))
PTXCONF_KERNEL_PATCH6_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH6_NAME))
PTXCONF_KERNEL_PATCH7_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH7_NAME))
PTXCONF_KERNEL_PATCH8_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH8_NAME))
PTXCONF_KERNEL_PATCH9_NAME  := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH9_NAME))
PTXCONF_KERNEL_PATCH10_NAME := $(call remove_quotes,$(PTXCONF_KERNEL_PATCH10_NAME))

ifdef PTXCONF_KERNEL_PATCH1_URL
ifneq ($(PTXCONF_KERNEL_PATCH1_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH1_NAME).get
ifdef PTXCONF_KERNEL_PATCH1_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH1_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH1_NAME).get:
	@$(call targetinfo, "Patch 1")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH1_URL), $(PTXCONF_KERNEL_PATCH1_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH2_URL
ifneq ($(PTXCONF_KERNEL_PATCH2_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH2_NAME).get
ifdef PTXCONF_KERNEL_PATCH2_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH2_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH2_NAME).get:
	@$(call targetinfo, "Patch 2")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH2_URL), $(PTXCONF_KERNEL_PATCH2_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH3_URL
ifneq ($(PTXCONF_KERNEL_PATCH3_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH3_NAME).get
ifdef PTXCONF_KERNEL_PATCH3_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH3_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH3_NAME).get:
	@$(call targetinfo, "Patch 3")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH3_URL), $(PTXCONF_KERNEL_PATCH3_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH4_URL
ifneq ($(PTXCONF_KERNEL_PATCH4_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH4_NAME).get
ifdef PTXCONF_KERNEL_PATCH4_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH4_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH4_NAME).get:
	@$(call targetinfo, "Patch 4")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH4_URL), $(PTXCONF_KERNEL_PATCH4_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH5_URL
ifneq ($(PTXCONF_KERNEL_PATCH5_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH5_NAME).get
ifdef PTXCONF_KERNEL_PATCH5_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH5_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH5_NAME).get:
	@$(call targetinfo, "Patch 5")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH5_URL), $(PTXCONF_KERNEL_PATCH5_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH6_URL
ifneq ($(PTXCONF_KERNEL_PATCH6_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH6_NAME).get
ifdef PTXCONF_KERNEL_PATCH6_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH6_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH6_NAME).get:
	@$(call targetinfo, "Patch 6")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH6_URL), $(PTXCONF_KERNEL_PATCH6_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH7_URL
ifneq ($(PTXCONF_KERNEL_PATCH7_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH7_NAME).get
ifdef PTXCONF_KERNEL_PATCH7_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH7_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH7_NAME).get:
	@$(call targetinfo, "Patch 7")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH7_URL), $(PTXCONF_KERNEL_PATCH7_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH8_URL
ifneq ($(PTXCONF_KERNEL_PATCH8_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH8_NAME).get
ifdef PTXCONF_KERNEL_PATCH8_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH8_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH8_NAME).get:
	@$(call targetinfo, "Patch 8")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH8_URL), $(PTXCONF_KERNEL_PATCH8_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH9_URL
ifneq ($(PTXCONF_KERNEL_PATCH9_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH9_NAME).get
ifdef PTXCONF_KERNEL_PATCH9_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH9_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH9_NAME).get:
	@$(call targetinfo, "Patch 9")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH9_URL), $(PTXCONF_KERNEL_PATCH9_NAME))
	touch $@
endif
endif

ifdef PTXCONF_KERNEL_PATCH10_URL
ifneq ($(PTXCONF_KERNEL_PATCH10_URL),"")
kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH10_NAME).get
ifdef PTXCONF_KERNEL_PATCH10_XCHAIN
xchain_kernel_patchstack_get_deps += $(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH10_NAME).get
endif
$(STATEDIR)/kernel-feature-$(PTXCONF_KERNEL_PATCH10_NAME).get:
	@$(call targetinfo, "Patch 10")
	@$(call get_feature_patch, $(KERNEL), $(PTXCONF_KERNEL_PATCH10_URL), $(PTXCONF_KERNEL_PATCH10_NAME))
	touch $@
endif
endif

$(STATEDIR)/kernel-patchstack.get: $(kernel_patchstack_get_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel_get: $(STATEDIR)/kernel.get

ifndef PTXCONF_USE_EXTERNAL_KERNEL
kernel_get_deps = \
	$(KERNEL_SOURCE) \
	$(STATEDIR)/kernel-patchstack.get
endif

$(STATEDIR)/kernel.get: $(kernel_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(KERNEL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(KERNEL_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kernel_extract: $(STATEDIR)/kernel.extract

ifndef PTXCONF_USE_EXTERNAL_KERNEL
kernel_extract_deps = $(STATEDIR)/kernel-base.extract
endif

$(STATEDIR)/kernel.extract: $(kernel_extract_deps)
	@$(call targetinfo, $@)
	touch $@

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

# Also add the "patchstack" like patches
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH1_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH2_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH3_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH4_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH5_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH6_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH7_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH8_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH9_NAME)) 
	@$(call feature_patchin, $(KERNEL_DIR), $(PTXCONF_KERNEL_PATCH10_NAME)) 

	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kernel_prepare: $(STATEDIR)/kernel.prepare

kernel_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel.extract

# FIXME: Ladis removed that, probably because 2.6 doesn't need it any
# more. Check if the 2.4 targets do still work... [RSC]
#kernel_prepare_deps += $(STATEDIR)/xchain-modutils.install

KERNEL_PATH	= PATH=$(CROSS_PATH)
KERNEL_MAKEVARS	= \
	ARCH=$(call remove_quotes,$(PTXCONF_ARCH)) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	HOSTCC=$(HOSTCC) \
	DEPMOD=$(call remove_quotes,$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-depmod)

ifdef PTXCONF_KERNEL_IMAGE_U
KERNEL_MAKEVARS += MKIMAGE=u-boot-mkimage.sh
endif

# This was defined before; we leave it here for reference. [RSC]
# GENKSYMS=$(COMPILER_PREFIX)genksyms

$(STATEDIR)/kernel.prepare: $(kernel_prepare_deps)
	@$(call targetinfo, $@)

ifndef PTXCONF_USE_EXTERNAL_KERNEL
	@if [ -f $(KERNEL_CONFIG) ]; then	                        \
		echo "Using kernel config file: $(KERNEL_CONFIG)"; 	\
		install -m 644 $(KERNEL_CONFIG) $(KERNEL_DIR)/.config;	\
	else								\
		echo "ERROR: No kernel config file found.";		\
		exit 1;							\
	fi

	cd $(KERNEL_DIR) && $(KERNEL_PATH) make include/linux/version.h $(KERNEL_MAKEVARS)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make oldconfig $(KERNEL_MAKEVARS)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make dep $(KERNEL_MAKEVARS)
endif
	touch $@

# ----------------------------------------------------------------------------
# Modversions-Prepare
# ----------------------------------------------------------------------------

#
# Some packages (like rtnet.) need modversions.h
#
# we build it only when needed cause it can be build only if kernel modules
# are selected
#
$(STATEDIR)/kernel-modversions.prepare: $(STATEDIR)/kernel.prepare
	@$(call targetinfo, $@)

	cd $(KERNEL_DIR) && $(KERNEL_PATH) make 			\
		$(KERNEL_DIR)/include/linux/modversions.h		\
		$(KERNEL_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kernel_compile: $(STATEDIR)/kernel.compile

kernel_compile_deps =  $(STATEDIR)/kernel.prepare
ifdef PTXCONF_KERNEL_IMAGE_U
kernel_compile_deps += $(STATEDIR)/xchain-umkimage.install
endif

$(STATEDIR)/kernel.compile: $(kernel_compile_deps)
	@$(call targetinfo, $@)

	mkdir -p $(PTXCONF_PREFIX)/bin
	echo "#!/bin/sh" > $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	echo 'u-boot-mkimage "$$@"' >> $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	chmod +x $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh

	cd $(KERNEL_DIR) && $(KERNEL_PATH) make $(KERNEL_TARGET) modules $(KERNEL_MAKEVARS)

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel_install: $(STATEDIR)/kernel.install

$(STATEDIR)/kernel.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

kernel_targetinstall: $(STATEDIR)/kernel.targetinstall

kernel_targetinstall_deps =  $(STATEDIR)/kernel.compile
kernel_targetinstall_deps += $(STATEDIR)/hosttool-module-init-tools.install

$(STATEDIR)/kernel.targetinstall: $(kernel_targetinstall_deps)
	@$(call targetinfo, $@)
ifdef PTXCONF_KERNEL_INSTALL
	mkdir -p $(ROOTDIR)/boot;				\
	for i in $(KERNEL_TARGET_PATH); do 			\
		if [ -f $$i ]; then				\
			install $$i $(ROOTDIR)/boot/ ;		\
		fi;						\
	done;							\
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make 		\
		modules_install $(KERNEL_MAKEVARS) INSTALL_MOD_PATH=$(ROOTDIR)
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel_clean:
ifndef PTXCONF_USE_EXTERNAL_KERNEL
# remove feature patches, but only if xchain-kernel was cleaned before.
	if [ ! -f $(STATEDIR)/xchain-kernel.get ]; then 								\
		for i in `ls $(STATEDIR)/kernel-feature-*.* | sed -e 's/.*kernel-feature-\(.*\)\..*$$/\1/g'`; do 	\
			if [ $$? -eq 0 ]; then										\
				rm -f $(STATEDIR)/kernel-feature-$$i*;							\
				rm -fr $(TOPDIR)/feature-patches/$$i;							\
			fi;												\
		done;													\
		rm -f $(STATEDIR)/kernel-patchstack.get;								\
	fi;
	rm -rf $(KERNEL_DIR)
endif
	rm -f $(STATEDIR)/kernel.*

# vim: syntax=make
