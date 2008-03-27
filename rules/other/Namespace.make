PTX_PREFIX		:= $(call remove_quotes, $(PTXCONF_PREFIX))
PTX_PREFIX_HOST		:= $(call remove_quotes, $(PTXCONF_HOST_PREFIX))
PTX_PREFIX_CROSS	:= $(call remove_quotes, $(PTXCONF_CROSS_PREFIX))

PTX_COMPILER_PREFIX		:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX))
PTX_COMPILER_PREFIX_KERNEL	:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX_KERNEL))
PTX_COMPILER_PREFIX_UBOOT	:= $(call remove_quotes, $(PTXCONF_COMPILER_PREFIX_UBOOT))

%.ptx-extract:
	@mkdir -p `dirname $@`
	@touch $@
