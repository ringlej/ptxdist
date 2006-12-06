ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
	obj-m  := module-template.o

else
# Normal Makefile
PWD	:= $(shell pwd)

modules modules_install clean:
	$(MAKE) -C $(PTX_KERNEL_DIR) M=$(PWD) $@
endif
