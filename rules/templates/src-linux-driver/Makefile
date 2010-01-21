ifeq ($(PTX_KERNEL_DIR),)

all:
	@echo "please export PTX_KERNEL_DIR"

clean:
	rm -rf *.o *.ko *.kmod *.mod.c .*.cmd .*.o.d Module.symvers .tmp_versions modules.order

else

PWD	:= $(shell pwd)
obj-m	:= @name@.o

modules modules_install clean:
	$(MAKE) -C $(PTX_KERNEL_DIR) M=$(PWD) V=$(V) $@

endif
