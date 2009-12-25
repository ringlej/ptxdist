# -*-makefile-*-

PTXCONF_PLATFORM		:= $(call remove_quotes, $(PTXCONF_PLATFORM))
PTXCONF_GNU_TARGET		:= $(call remove_quotes, $(PTXCONF_GNU_TARGET))
PTXCONF_COMPILER_PREFIX		:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX))

PTXCONF_SYSROOT_HOST		:= $(call remove_quotes, $(PTXCONF_SYSROOT_HOST))
PTXCONF_SYSROOT_CROSS		:= $(call remove_quotes, $(PTXCONF_SYSROOT_CROSS))
PTXCONF_SYSROOT_TARGET		:= $(call remove_quotes, $(PTXCONF_SYSROOT_TARGET))

PTXDIST_SYSROOT_HOST		:= $(PTXCONF_SYSROOT_HOST)
PTXDIST_SYSROOT_CROSS		:= $(PTXCONF_SYSROOT_CROSS)
PTXDIST_SYSROOT_TARGET		:= $(PTXCONF_SYSROOT_TARGET)
SYSROOT				:= $(PTXCONF_SYSROOT_TARGET)

PTXCONF_COMPILER_PREFIX_KERNEL	:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX_KERNEL))
PTXCONF_COMPILER_PREFIX_BOOTLOADER := \
				   $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX_BOOTLOADER))
PTXCONF_COMPILER_PREFIX		:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX))
COMPILER_PREFIX			:= $(PTXCONF_COMPILER_PREFIX)

HOSTCC				:= $(call remove_quotes, $(PTXCONF_SETUP_HOST_CC))
HOSTCXX				:= $(call remove_quotes, $(PTXCONF_SETUP_HOST_CXX))

PTXCONF_ARCH_STRING		:= $(call remove_quotes, $(PTXCONF_ARCH_STRING))
PTXCONF_KERNEL_ARCH_STRING	:= $(call remove_quotes, $(PTXCONF_KERNEL_ARCH_STRING))
PTXCONF_U_BOOT_V2_ARCH_STRING	:= $(call remove_quotes, $(PTXCONF_U_BOOT_V2_ARCH_STRING))
PTXCONF_BAREBOX_ARCH_STRING	:= $(call remove_quotes, $(PTXCONF_BAREBOX_ARCH_STRING))

PTXCONF_TARGET_EXTRA_CFLAGS	:= $(call remove_quotes, $(PTXCONF_TARGET_EXTRA_CFLAGS))
PTXCONF_TARGET_EXTRA_CXXFLAGS	:= $(call remove_quotes, $(PTXCONF_TARGET_EXTRA_CXXFLAGS))
PTXCONF_TARGET_EXTRA_CPPFLAGS	:= $(call remove_quotes, $(PTXCONF_TARGET_EXTRA_CPPFLAGS))
PTXCONF_TARGET_EXTRA_LDFLAGS	:= $(call remove_quotes, $(PTXCONF_TARGET_EXTRA_LDFLAGS))

# vim: syntax=make
