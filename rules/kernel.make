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
# Paths and names
#
KERNEL			:= linux-$(KERNEL_VERSION)
KERNEL_MD5		:= $(call remove_quotes,$(PTXCONF_KERNEL_MD5))
ifneq ($(KERNEL_NEEDS_GIT_URL),y)
KERNEL_SUFFIX		:= tar.xz
KERNEL_URL		:= $(call kernel-url, KERNEL)
else
KERNEL_SUFFIX		:= tar.gz
KERNEL_URL		:= https://git.kernel.org/torvalds/t/$(KERNEL).$(KERNEL_SUFFIX)
endif
KERNEL_DIR		:= $(BUILDDIR)/$(KERNEL)
KERNEL_CONFIG		:= $(call ptx/in-platformconfigdir, $(call remove_quotes, $(PTXCONF_KERNEL_CONFIG)))
KERNEL_LICENSE		:= GPL-2.0-only
KERNEL_SOURCE		:= $(SRCDIR)/$(KERNEL).$(KERNEL_SUFFIX)
KERNEL_DEVPKG		:= NO

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# use CONFIG_CC_STACKPROTECTOR if available. The rest makes no sense for the kernel
KERNEL_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_STACK \
	TARGET_HARDEN_FORTIFY \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

# check for old kernel modules rules
KERNEL_MAKEVARS = -C KERNEL_MAKEVARS-was-renamed-to-KERNEL_MAKE_OPT
$(STATEDIR)/kernel.% kernel_%config $(IMAGE_KERNEL_IMAGE) $(KERNEL_SOURCE): KERNEL_MAKEVARS=
$(STATEDIR)/kernel-header.% $(STATEDIR)/host-kernel-header.%: KERNEL_MAKEVARS=

KERNEL_CONF_OPT := \
	V=$(PTXDIST_VERBOSE) \
	ARCH=$(PTXCONF_KERNEL_ARCH_STRING) \
	CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) \
	INSTALL_MOD_PATH=$(KERNEL_PKGDIR) \
	PTX_KERNEL_DIR=$(KERNEL_DIR) \
	$(call remove_quotes,$(PTXCONF_KERNEL_EXTRA_MAKEVARS))

ifdef PTXCONF_KERNEL_MODULES_INSTALL
KERNEL_CONF_OPT += \
	DEPMOD=$(PTXCONF_SYSROOT_HOST)/sbin/depmod
endif

ifndef PTXCONF_KERNEL_GCC_PLUGINS
KERNEL_CONF_OPT += \
	HOSTCXX=false
endif

#
# support the different kernel image formats
#
KERNEL_IMAGE := $(call remove_quotes, $(PTXCONF_KERNEL_IMAGE))

# these are sane default
KERNEL_IMAGE_PATH_y := $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/$(KERNEL_IMAGE)

# vmlinux and vmlinuz are special
KERNEL_IMAGE_PATH_$(PTXCONF_KERNEL_IMAGE_VMLINUX) := $(KERNEL_DIR)/vmlinux
KERNEL_IMAGE_PATH_$(PTXCONF_KERNEL_IMAGE_VMLINUZ) := $(KERNEL_DIR)/vmlinuz
# avr32 is also special
KERNEL_IMAGE_PATH_$(PTXCONF_ARCH_AVR32) := $(KERNEL_DIR)/arch/$(PTXCONF_KERNEL_ARCH_STRING)/boot/images/$(KERNEL_IMAGE)


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

$(STATEDIR)/kernel.prepare:
	@$(call targetinfo)

	@$(call world/kconfig-setup, KERNEL)
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
	@$(call world/kconfig-sync, KERNEL)

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
	@$(MAKE) -C $(KERNEL_DIR) $(KERNEL_CONF_OPT) tags TAGS cscope

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

KERNEL_MAKE_OPT		:= $(KERNEL_CONF_OPT)
KERNEL_TOOL_PERF_OPTS	:= \
	WERROR=0 \
	NO_LIBPERL=1 \
	NO_LIBPYTHON=1 \
	NO_DWARF= \
	NO_SLANG= \
	NO_GTK2=1 \
	NO_DEMANGLE= \
	NO_LIBELF= \
	NO_LIBUNWIND=1 \
	NO_BACKTRACE= \
	NO_LIBNUMA=1 \
	NO_LIBAUDIT=1 \
	NO_LIBBIONIC=1 \
	NO_LIBCRYPTO=1 \
	NO_LIBDW_DWARF_UNWIND= \
	NO_PERF_READ_VDSO32=1 \
	NO_PERF_READ_VDSOX32=1 \
	NO_ZLIB= \
	NO_LIBBABELTRACE=1 \
	NO_LZMA=1 \
	NO_AUXTRACE= \
	NO_LIBBPF=1 \
	NO_SDT=1

$(STATEDIR)/kernel.compile:
	@$(call targetinfo)
	@rm -f \
		$(KERNEL_DIR)/usr/initramfs_data.cpio.* \
		$(KERNEL_DIR)/usr/.initramfs_data.cpio.*
	@$(call compile, KERNEL, $(KERNEL_MAKE_OPT) $(KERNEL_IMAGE) $(PTXCONF_KERNEL_MODULES_BUILD))
ifdef PTXCONF_KERNEL_TOOL_PERF
	@$(call compile, KERNEL, $(KERNEL_MAKE_OPT) $(KERNEL_TOOL_PERF_OPTS) -C tools/perf)
endif
ifdef PTXCONF_KERNEL_TOOL_IIO
#	# manual make to handle CPPFLAGS and broken parallel building for some kernel versions
	@PATH=$(CROSS_PATH) $(MAKE) -C $(KERNEL_DIR) \
		CPPFLAGS="-D__EXPORTED_HEADERS__ -I$(KERNEL_DIR)/include/uapi -I$(KERNEL_DIR)/include" \
		$(KERNEL_MAKE_OPT) $(PARALLELMFLAGS_BROKEN) -C tools/iio
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

KERNEL_INSTALL_OPT := $(KERNEL_MAKE_OPT) modules_install

$(STATEDIR)/kernel.install:
	@$(call targetinfo)
ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@$(call world/install, KERNEL)
endif
ifdef PTXCONF_KERNEL_DTC
	@install -m 755 "$(KERNEL_DIR)/scripts/dtc/dtc" "$(PTXCONF_SYSROOT_HOST)/bin/dtc"
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.targetinstall:
	@$(call targetinfo)

ifdef PTXCONF_KERNEL_XPKG
	@$(call install_init,  kernel)
	@$(call install_fixup, kernel, PRIORITY,optional)
	@$(call install_fixup, kernel, SECTION,base)
	@$(call install_fixup, kernel, AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, kernel, DESCRIPTION,missing)

	@$(call install_copy, kernel, 0, 0, 0755, /boot);

ifdef PTXCONF_KERNEL_INSTALL
	@$(call install_copy, kernel, 0, 0, 0644, $(KERNEL_IMAGE_PATH_y), /boot/$(KERNEL_IMAGE), n)
endif

# install the ELF kernel image for debugging purpose
ifdef PTXCONF_KERNEL_VMLINUX
	@$(call install_copy, kernel, 0, 0, 0644, $(KERNEL_DIR)/vmlinux, /boot/vmlinux, n)
endif

ifdef PTXCONF_KERNEL_TOOL_PERF
	@$(call install_copy, kernel, 0, 0, 0755, $(KERNEL_DIR)/tools/perf/perf, \
		/usr/bin/perf)
endif

ifdef PTXCONF_KERNEL_TOOL_IIO
	@$(call install_copy, kernel, 0, 0, 0755, $(wildcard $(KERNEL_DIR)/tools/iio/*generic_buffer), \
		/usr/bin/iio_generic_buffer)
	@$(call install_copy, kernel, 0, 0, 0755, $(KERNEL_DIR)/tools/iio/lsiio, \
		/usr/bin/lsiio)
	@$(call install_copy, kernel, 0, 0, 0755, $(KERNEL_DIR)/tools/iio/iio_event_monitor, \
		/usr/bin/iio_event_monitor)
endif

	@$(call install_finish, kernel)
endif

	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install-post
# ----------------------------------------------------------------------------

ifdef PTXCONF_IMAGE_KERNEL_INSTALL_EARLY
$(STATEDIR)/kernel.targetinstall.post: $(IMAGEDIR)/linuximage
ifdef PTXCONF_IMAGE_KERNEL_LZOP
$(STATEDIR)/kernel.targetinstall.post: $(IMAGEDIR)/linuximage.lzo
endif
endif

$(STATEDIR)/kernel.targetinstall.post:
	@$(call targetinfo)

ifdef PTXCONF_KERNEL_MODULES_INSTALL
	@$(call install_init,  kernel-modules)
	@$(call install_fixup, kernel-modules, PRIORITY,optional)
	@$(call install_fixup, kernel-modules, SECTION,base)
	@$(call install_fixup, kernel-modules, AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, kernel-modules, DESCRIPTION,missing)

	@$(call install_glob, kernel-modules, 0, 0, -, /lib/modules, *.ko,, k)
	@$(call install_glob, kernel-modules, 0, 0, -, /lib/modules,, *.ko */build */source, n)

	@$(call install_finish, kernel-modules)
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/kernel.clean:
	@$(call targetinfo)
	@$(call clean_pkg, KERNEL)
	@if [ -L $(KERNEL_DIR) ]; then \
		$(MAKE) -C $(KERNEL_DIR) $(KERNEL_MAKE_OPT) distclean; \
	fi

# ----------------------------------------------------------------------------
# oldconfig / menuconfig
# ----------------------------------------------------------------------------

kernel_oldconfig kernel_menuconfig kernel_nconfig: $(STATEDIR)/kernel.extract
	@$(call world/kconfig, KERNEL, $(subst kernel_,,$@))

# vim: syntax=make
