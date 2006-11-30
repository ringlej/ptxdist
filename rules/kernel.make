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

PACKAGES-$(PTXCONF_KERNEL_COMPILE) += kernel

ifdef NATIVE
KERNEL_CONFIG		:= $(PTXDIST_WORKSPACE)/$(call remove_quotes, $(PTXCONF_KERNEL_NATIVE_CONFIG))
KERNEL_VERSION		:= $(call remove_quotes, $(PTXCONF_KERNEL_NATIVE_VERSION))
KERNEL_VERSION_MAJOR	:= $(KERNEL_NATIVE_VERSION_MAJOR)
KERNEL_VERSION_MINOR	:= $(KERNEL_NATIVE_VERSION_MINOR)
KERNEL_SERIESFILE	:= $(call remove_quotes, $(PTXCONF_KERNEL_NATIVE_SERIES))
KERNEL_SERIES		:= $(PTXDIST_WORKSPACE)/kernel-patches-native/$(KERNEL_SERIESFILE)
else
KERNEL_CONFIG		:= $(PTXDIST_WORKSPACE)/$(call remove_quotes, $(PTXCONF_KERNEL_TARGET_CONFIG))
KERNEL_VERSION		:= $(call remove_quotes, $(PTXCONF_KERNEL_TARGET_VERSION))
KERNEL_VERSION_MAJOR	:= $(KERNEL_TARGET_VERSION_MAJOR)
KERNEL_VERSION_MINOR	:= $(KERNEL_TARGET_VERSION_MINOR)
KERNEL_SERIESFILE	:= $(call remove_quotes, $(PTXCONF_KERNEL_TARGET_SERIES))
KERNEL_SERIES		:= $(PTXDIST_WORKSPACE)/kernel-patches-target/$(KERNEL_SERIESFILE)
endif

KERNEL		:= linux-$(KERNEL_VERSION)
KERNEL_SUFFIX	:= tar.bz2
KERNEL_TESTING	= $(shell [ -n "$$(echo $(KERNEL_VERSION) | grep rc)" ] && echo "testing/")
KERNEL_URL	= http://www.kernel.org/pub/linux/kernel/v$(KERNEL_VERSION_MAJOR).$(KERNEL_VERSION_MINOR)/$(KERNEL_TESTING)$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_SOURCE	:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_DIR	:= $(BUILDDIR)/$(KERNEL)

# FIXME: what's this?
# Here we are installing kernel modules which are copied to proper place
# later (after depmod is run). The real question is, What to do with external
# kernel modules?
KERNEL_INST_DIR	:= $(BUILDDIR)/$(KERNEL)-install

#
# Some configuration stuff for the different kernel image formats
#

ifdef NATIVE
KERNEL_TARGET		:= vmlinux
KERNEL_TARGET_PATH	:= $(KERNEL_DIR)/vmlinux
else
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
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/images/uImage \
	$(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/uImage
endif
ifdef PTXCONF_KERNEL_TARGET_IMAGE_VMLINUX
KERNEL_TARGET		:= vmlinux
KERNEL_TARGET_PATH	:= $(KERNEL_DIR)/vmlinux
endif
endif

# ----------------------------------------------------------------------------
# Menuconfig
# ----------------------------------------------------------------------------

kernel_menuconfig: $(STATEDIR)/kernel.extract

	cp $(KERNEL_CONFIG) $(KERNEL_DIR)/.config
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make menuconfig $(KERNEL_MAKEVARS)
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make silentoldconfig $(KERNEL_MAKEVARS)
	cp $(KERNEL_DIR)/.config $(KERNEL_CONFIG)
	@if [ -f $(STATEDIR)/kernel.compile ]; then \
		rm $(STATEDIR)/kernel.compile; \
	fi

# ----------------------------------------------------------------------------
# Oldconfig
# ----------------------------------------------------------------------------

kernel_oldconfig: $(STATEDIR)/kernel.extract

	cd $(KERNEL_DIR) && $(KERNEL_PATH) make oldconfig $(KERNEL_MAKEVARS)
	@if [ -f $(STATEDIR)/kernel.compile ]; then \
		rm $(STATEDIR)/kernel.compile; \
	fi

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

# FIXME: Use deps_default

kernel_get: $(STATEDIR)/kernel.get

kernel_get_deps = $(KERNEL_SOURCE)

$(STATEDIR)/kernel.get: $(kernel_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KERNEL_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, KERNEL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kernel_extract: $(STATEDIR)/kernel.extract

kernel_extract_deps = $(STATEDIR)/kernel.get

$(STATEDIR)/kernel.extract: $(kernel_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(KERNEL_DIR))
	@$(call extract, KERNEL)

ifeq (2.4.18,$(KERNEL_VERSION))
	# kernels before 2.4.19 extract to "linux" instead of "linux-<version>"
	mv $(BUILDDIR)/linux $(KERNEL_DIR)
endif

	# apply the patch series
	@if [ -n "$(KERNEL_SERIESFILE)" ]; then \
		if [ -e $(KERNEL_SERIES) ]; then \
			$(PTXDIST_TOPDIR)/scripts/apply_patch_series.sh -s $(KERNEL_SERIES) -d $(KERNEL_DIR); \
		else \
			echo "the series file $(KERNEL_SERIES) does not exist."; \
			exit 1; \
		fi; \
	fi

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kernel_prepare: $(STATEDIR)/kernel.prepare

kernel_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel.extract

KERNEL_PATH	:=  PATH=$(CROSS_PATH)
KERNEL_MAKEVARS = \
	HOSTCC=$(HOSTCC) \
	$(PARALLELMFLAGS) \

ifdef NATIVE
KERNEL_MAKEVARS += ARCH=um
else
KERNEL_MAKEVARS += ARCH=$(call remove_quotes,$(PTXCONF_ARCH))
KERNEL_MAKEVARS += CROSS_COMPILE=$(COMPILER_PREFIX)
endif


ifeq ($(KERNEL_VERSION_MINOR), 4)
KERNEL_MAKEVARS += DEPMOD=$(call remove_quotes,$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-depmod.old)
else
KERNEL_MAKEVARS += DEPMOD=$(call remove_quotes,$(PTXCONF_PREFIX)/sbin/$(PTXCONF_GNU_TARGET)-depmod)
endif

ifdef PTXCONF_KERNEL_TARGET_IMAGE_U
KERNEL_MAKEVARS += MKIMAGE=$(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
endif

$(STATEDIR)/kernel.prepare: $(kernel_prepare_deps)
	@$(call targetinfo, $@)

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
	@echo "---------- make modules_prepare ----------"
	@echo
	# '-' is neccessary because modules_prepare fails on kernels < 2.6.6
	-cd $(KERNEL_DIR) && $(KERNEL_PATH) make modules_prepare $(KERNEL_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kernel_compile: $(STATEDIR)/kernel.compile

kernel_compile_deps =  $(STATEDIR)/kernel.prepare

ifdef PTXCONF_KERNEL_TARGET_IMAGE_U
kernel_compile_deps += $(STATEDIR)/host-umkimage.install
endif

ifdef PTXCONF_KLIBC
kernel_compile_deps += $(STATEDIR)/klibc.install
endif

#
# build modules only on request
#
ifdef PTXCONF_KERNEL_INSTALL_MODULES
MODULE_TARGET = modules
endif

$(STATEDIR)/kernel.compile: $(kernel_compile_deps)
	@$(call targetinfo, $@)

	mkdir -p $(PTXCONF_PREFIX)/bin
	echo "#!/bin/sh" > $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	echo '$(call remove_quotes,$(PTXCONF_PREFIX))/bin/u-boot-mkimage "$$@"' >> $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	chmod +x $(PTXCONF_PREFIX)/bin/u-boot-mkimage.sh
	cd $(KERNEL_DIR) && $(KERNEL_PATH) make \
		$(KERNEL_TARGET) $(MODULE_TARGET) $(KERNEL_MAKEVARS)
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

kernel_targetinstall: $(STATEDIR)/kernel.targetinstall

$(STATEDIR)/kernel.targetinstall: $(STATEDIR)/kernel.compile
	@$(call targetinfo, $@)

ifdef  PTXCONF_KERNEL_INSTALL
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
			$(call install_copy, kernel, 0, 0, 0644, $$i, /boot/$(KERNEL_TARGET), n); \
			chmod a+x $(ROOTDIR)/boot/$(KERNEL_TARGET);	\
			install -D $$i $(IMAGEDIR)/linuximage;		\
		fi;							\
	done
	@$(call install_finish, kernel)
endif
	# we _always_ need the kernel in the image dir
	# to be in sync with documentation!
	# but in this case we do not need a kernel ipkg
	for i in $(KERNEL_TARGET_PATH); do	\
		if [ -f $$i ]; then					\
			install -D $$i $(IMAGEDIR)/linuximage;		\
		fi;							\
	done

ifdef PTXCONF_KERNEL_INSTALL_MODULES
	rm -fr $(KERNEL_INST_DIR)

	@$(call install_init,  kernel-modules)
	@$(call install_fixup, kernel-modules, PACKAGE,kernel-modules)
	@$(call install_fixup, kernel-modules, PRIORITY,optional)
	@$(call install_fixup, kernel-modules, VERSION,$(KERNEL_VERSION))
	@$(call install_fixup, kernel-modules, SECTION,base)
	@$(call install_fixup, kernel-modules, AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, kernel-modules, DEPENDS,)
	@$(call install_fixup, kernel-modules, DESCRIPTION,missing)

	cd $(KERNEL_DIR) && $(KERNEL_PATH) make 			\
		modules_install $(KERNEL_MAKEVARS) INSTALL_MOD_PATH=$(KERNEL_INST_DIR)

	cd $(KERNEL_INST_DIR) &&					\
		for file in `find . -type f | sed -e "s/\.\//\//g"`; do	\
			$(call install_copy, kernel-modules, 0, 0, 0644, $(KERNEL_INST_DIR)/$$file, $$file, n); \
		done

	rm -fr $(KERNEL_INST_DIR)

	@$(call install_finish, kernel-modules)
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel_clean:
	rm -rf $(KERNEL_DIR)
	rm -f $(STATEDIR)/kernel.*

# vim: syntax=make
