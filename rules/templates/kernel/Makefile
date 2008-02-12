ifeq ($(PTX_KERNEL_DIR),)

all:
	@echo "please export PTX_KERNEL_DIR"

clean:
	rm -rf *.ko *.kmod *.mod.c .*.cmd .*.o.d Module.symvers .tmp_versions

else

PWD	:= $(shell pwd)
obj-m  := module-template.o

modules modules_install clean:
	$(MAKE) -C $(PTX_KERNEL_DIR) M=$(PWD) V=$(V) $@

endif
