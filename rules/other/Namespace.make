PLATFORMDIR			:= $(call remove_quotes, $(PLATFORMDIR))

ifneq ($(PTXDIST_PLATFORM),)
PTXDIST_PLATFORM_PREFIX=platform-
endif

PTXCONF_PLATFORM		:= $(call remove_quotes,$(PTXCONF_PLATFORM))
PTXCONF_SYSROOT_TARGET		:= $(call remove_quotes, $(PTXCONF_SYSROOT_TARGET))
PTXCONF_SYSROOT_HOST		:= $(call remove_quotes, $(PTXCONF_SYSROOT_HOST))
PTXCONF_SYSROOT_CROSS		:= $(call remove_quotes, $(PTXCONF_SYSROOT_CROSS))

PTX_COMPILER_PREFIX		:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX))
PTX_COMPILER_PREFIX_KERNEL	:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX_KERNEL))
PTX_COMPILER_PREFIX_UBOOT	:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX_UBOOT))

%.ptx-extract:
	@mkdir -p `dirname $@`
	@touch $@
