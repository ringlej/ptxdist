# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
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
# version stuff in now in rules/Version.make
# NB: make s*cks
#
KERNEL			= linux-$(KERNEL_VERSION)
KERNEL_SUFFIX		= tar.bz2
KERNEL_URL		= ftp://ftp.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_SOURCE		= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_DIR		= $(BUILDDIR)/$(KERNEL)

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
	@if [ -f $(PTXCONF_KERNEL_CONFIG) ]; then \
		install -m 644 $(PTXCONF_KERNEL_CONFIG) $(KERNEL_DIR)/.config; \
	fi

	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		menuconfig

	@if [ -f $(KERNEL_DIR)/.config ]; then \
		install -m 644 $(KERNEL_DIR)/.config $(PTXCONF_KERNEL_CONFIG); \
	fi

	@if [ -f $(STATEDIR)/kernel.compile ]; then \
		rm $(STATEDIR)/kernel.compile; \
	fi

# ----------------------------------------------------------------------------
# Get patchstack-patches
# ----------------------------------------------------------------------------

kernel-patchstack_get: $(STATEDIR)/kernel-patchstack.get

# Remove quotes from patch names
PTXCONF_KERNEL_PATCH1_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH1_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH2_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH2_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH3_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH3_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH4_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH4_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH5_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH5_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH6_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH6_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH7_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH7_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH8_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH8_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH9_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH9_NAME))#"	<-- emacs, vi hack
PTXCONF_KERNEL_PATCH10_NAME := $(subst ",,$(PTXCONF_KERNEL_PATCH10_NAME))#"	<-- emacs, vi hack

# This is for kernel & xchain-kernel!

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

kernel_get_deps = \
	$(KERNEL_SOURCE) \
	$(STATEDIR)/kernel-patchstack.get

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

kernel_extract_deps = \
	$(STATEDIR)/kernel-base.extract	\
	$(addprefix $(STATEDIR)/, $(addsuffix .install, $(KERNEL_PATCHES)))

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
	$(STATEDIR)/xchain-modutils.install \
	$(STATEDIR)/kernel.extract

KERNEL_PATH	= PATH=$(CROSS_PATH)
KERNEL_MAKEVARS	= \
	ARCH=$(PTXCONF_ARCH) \
	CROSS_COMPILE=$(PTXCONF_COMPILER_PREFIX) \
	HOSTCC=$(HOSTCC) \
	DEPMOD=true

	# This was defined before; we leave it here for reference. [RSC]
	# GENKSYMS=$(PTXCONF_COMPILER_PREFIX)genksyms

KERNEL_ENV	= $(CROSS_ENV_CFLAGS)

ifdef PTXCONF_KERNEL_IMAGE_U
	KERNEL_MAKEVARS += MKIMAGE=u-boot-mkimage.sh
endif

$(STATEDIR)/kernel.prepare: $(kernel_prepare_deps)
	@$(call targetinfo, $@)

	if [ -f $(PTXCONF_KERNEL_CONFIG) ]; then	                        \
		install -m 644 $(PTXCONF_KERNEL_CONFIG) $(KERNEL_DIR)/.config;	\
	fi

	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) 		\
		include/linux/version.h
	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) 		\
		oldconfig
	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) 		\
		dep
	echo "#!/bin/sh" > $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	echo 'u-boot-mkimage "$$@"' >> $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh

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

	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		$(KERNEL_DIR)/include/linux/modversions.h
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
	$(KERNEL_PATH) $(KERNEL_ENV) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		$(KERNEL_TARGET) modules
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

$(STATEDIR)/kernel.targetinstall: $(STATEDIR)/kernel.compile
	@$(call targetinfo, $@)
ifdef PTXCONF_KERNEL_INSTALL
	mkdir -p $(ROOTDIR)/boot;				\
	for i in $(KERNEL_TARGET_PATH); do 			\
		if [ -f $$i ]; then				\
			install $$i $(ROOTDIR)/boot/ ;		\
		fi;						\
	done;							\
	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		modules_install INSTALL_MOD_PATH=$(ROOTDIR)
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel_clean:
	# remove feature patches, but only if xchain-kernel was cleaned
	# before. 
	if [ ! -f $(STATEDIR)/xchain-kernel.get ]; then 								\
		for i in `ls $(STATEDIR)/kernel-feature-*.* | sed -e 's/.*kernel-feature-\(.*\)\..*$$/\1/g'`; do 	\
			if [ $$? -eq 0 ]; then										\
				rm -f $(STATEDIR)/kernel-feature-$$i*;							\
				rm -fr $(TOPDIR)/feature-patches/$$i;							\
			fi;												\
		done;													\
		rm -f $(STATEDIR)/kernel-patchstack.get;								\
	fi;
	# remove kernel & dir
	rm -rf $(STATEDIR)/kernel.* $(KERNEL_DIR)

# vim: syntax=make
