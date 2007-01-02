PTX_PREFIX		:= $(call remove_quotes, $(PTXCONF_PREFIX))
PTX_PREFIX_HOST		:= $(call remove_quotes, $(PTXCONF_HOST_PREFIX))
PTX_PREFIX_CROSS	:= $(call remove_quotes, $(PTXCONF_CROSS_PREFIX))

%.ptx-extract:
	@mkdir -p `dirname $@`
	@touch $@
