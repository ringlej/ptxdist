ifneq ($(KERNELRELEASE),)
 # kbuild part of makefile
	obj-m  := module-template.o
else
 # Normal Makefile
all::
	$(MAKE) -C $(KERNELDIR) M=`pwd`
endif

