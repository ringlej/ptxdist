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

#
# We provide this package
#
PACKAGES-$(PTXCONF_KERNEL) += kernel

#
# Paths and names
#
KERNEL			:= linux-$(KERNEL_VERSION)
KERNEL_SUFFIX		:= tar.bz2
KERNEL_TESTING		= $(shell [ -n "$$(echo $(KERNEL_VERSION) | grep rc)" ] && echo "testing/")
KERNEL_URL		= http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL_TESTING)$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_SOURCE		:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_DIR		:= $(BUILDDIR)/$(KERNEL)

KERNEL_CONFIG		:= $(call remove_quotes,$(PTXDIST_WORKSPACE)/$(PTXCONF_KERNEL$(KERNEL_STYLE)_CONFIG))
KERNEL_SERIES		:= $(PTXDIST_WORKSPACE)/kernel-patches$(KERNEL_style)/$(PTXCONF_KERNEL$(KERNEL_STYLE)_SERIES)

KERNEL_DIR_INSTALL	:= $(BUILDDIR)/$(KERNEL)-install


#
# Some configuration stuff for the different kernel image formats
#
ifdef PTXCONF_KERNEL_IMAGE_Z
KERNEL_IMAGE_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/zImage
endif

ifdef PTXCONF_KERNEL_IMAGE_BZ
KERNEL_IMAGE_PATH	:= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/bzImage
endif

ifdef PTXCONF_KERNEL_IMAGE_U
KERNEL_IMAGE_PATH	:= \
	$(KERNEL_DIR)/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/images/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/images/vmlinux.UBoot
endif

ifdef PTXCONF_KERNEL_IMAGE_VMLINUX
KERNEL_IMAGE_PATH	:= $(KERNEL_DIR)/vmlinux
endif

ifdef NATIVE
KERNEL_IMAGE_PATH	:= $(KERNEL_DIR)/vmlinux
endif


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel_get: $(STATEDIR)/kernel.get

$(STATEDIR)/kernel.get: $(kernel_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KERNEL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, KERNEL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kernel_extract: $(STATEDIR)/kernel.extract

$(STATEDIR)/kernel.extract: $(kernel_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KERNEL_DIR))
	@$(call extract, KERNEL)
	@$(call patchin, KERNEL,,$(KERNEL_SERIES))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kernel_prepare: $(STATEDIR)/kernel.prepare

KERNEL_PATH	:= PATH=$(CROSS_PATH)
KERNEL_ENV 	:= $(CROSS_ENV)
KERNEL_MAKEVARS := \
	$(PARALLELMFLAGS) \
	HOSTCC=$(HOSTCC) \
	DEPMOD=$(PTXCONF_CROSS_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-depmod \
	INSTALL_MOD_PATH=$(KERNEL_DIR_INSTALL) \
	PTX_KERNEL_DIR=$(KERNEL_DIR)

ifdef NATIVE
KERNEL_MAKEVARS += ARCH=um
KERNEL_IMAGE	:= vmlinuz
else
KERNEL_MAKEVARS += \
	ARCH=$(PTXCONF_ARCH) \
	CROSS_COMPILE=$(COMPILER_PREFIX)
KERNEL_IMAGE	:= $(PTXCONF_KERNEL_IMAGE)
endif

$(STATEDIR)/kernel.prepare: $(kernel_prepare_deps_default) $(KERNEL_CONFIG)
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
	@sed -ie 's,^CONFIG_INITRAMFS_SOURCE.*$$,CONFIG_INITRAMFS_SOURCE=\"$(KLIBC_CONTROL)\",g' \
		$(KERNEL_DIR)/.config
endif

	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) oldconfig

	cp $(KERNEL_DIR)/.config $(KERNEL_CONFIG)

# '-' is neccessary because modules_prepare fails on kernels < 2.6.6
	-cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) modules_prepare

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kernel_compile: $(STATEDIR)/kernel.compile

$(STATEDIR)/kernel.compile: $(kernel_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) $(KERNEL_TARGET) $(PTXCONF_KERNEL_MODULES_BUILD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel_install: $(STATEDIR)/kernel.install

$(STATEDIR)/kernel.install: $(kernel_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

kernel_targetinstall: $(STATEDIR)/kernel.targetinstall.post

$(STATEDIR)/kernel.targetinstall: $(kernel_targetinstall_deps_default)
	@$(call targetinfo, $@)

# we _always_ need the kernel in the image dir
	@for i in $(KERNEL_IMAGE_PATH); do				\
		if [ -f $$i ]; then					\
			install -D $$i $(IMAGEDIR)/linuximage;		\
		fi;							\
	done

ifdef  PTXCONF_KERNEL_INSTALL
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
	test -e $(KERNEL_DIR_INSTALL) && rm -rf $(KERNEL_DIR_INSTALL)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) $(MAKE) \
		$(KERNEL_MAKEVARS) modules_install
endif

	@$(call touch, $@)


# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.targetinstall.post: $(STATEDIR)/kernel.targetinstall
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

	@cd $(KERNEL_DIR_INSTALL) &&					\
		for file in `find . -type f | sed -e "s/\.\//\//g"`; do	\
			$(call install_copy, kernel-modules, 0, 0, 0644, $(KERNEL_DIR_INSTALL)/$${file}, $${file}, n); \
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
	@cp $(KERNEL_CONFIG) $(KERNEL_DIR)/.config
	@cd $(KERNEL_DIR) && \
		$(KERNEL_PATH) $(MAKE) $(KERNEL_MAKEVARS) $(subst kernel_,,$@)
	@if cmp -s $(KERNEL_DIR)/.config $(KERNEL_CONFIG); then \
		echo "kernel configuration unchanged"; \
	else \
		cp $(KERNEL_DIR)/.config $(KERNEL_CONFIG); \
	fi


# vim: syntax=make
