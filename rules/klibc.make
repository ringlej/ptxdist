# -*-makefile-*-
#
# Copyright (C) 2005 by Sascha Hauer
#               2009 by Jon Ringle <jon@ringle.org>
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KLIBC) += klibc

#
# Paths and names
#
KLIBC_VERSION	:= 1.5.15
KLIBC		:= klibc-$(KLIBC_VERSION)
KLIBC_SUFFIX	:= tar.gz
KLIBC_SOURCE	:= $(SRCDIR)/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_DIR	:= $(BUILDDIR)/$(KLIBC)

KLIBC_URL := \
	http://www.kernel.org/pub/linux/libs/klibc/Testing/$(KLIBC).$(KLIBC_SUFFIX) \
	http://eu.kernel.org/pub/linux/libs/klibc/Testing/$(KLIBC).$(KLIBC_SUFFIX)

ifdef PTXCONF_KLIBC
$(STATEDIR)/kernel.compile: $(STATEDIR)/klibc.targetinstall.post
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(KLIBC_SOURCE):
	@$(call targetinfo)
	@$(call get, KLIBC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc.prepare: $(STATEDIR)/kernel.prepare
	@$(call targetinfo)
	@echo					>  $(KLIBC_DIR)/defconfig
	@echo "CONFIG_KLIBC=y"			>> $(KLIBC_DIR)/defconfig
	@echo "CONFIG_KLIBC_ERRLIST=y"		>> $(KLIBC_DIR)/defconfig
	@echo "CONFIG_KLIBC_ZLIB=y"		>> $(KLIBC_DIR)/defconfig
ifdef PTXCONF_ARCH_ARM
	@echo "# ARM options"			>> $(KLIBC_DIR)/defconfig
	@echo "# CONFIG_KLIBC_THUMB is not set"	>> $(KLIBC_DIR)/defconfig
	@echo "CONFIG_AEABI=y"			>> $(KLIBC_DIR)/defconfig
endif
ifdef PTXCONF_ARCH_X86
	@echo "# i386 option"			>> $(KLIBC_DIR)/defconfig
	@echo "CONFIG_REGPARM=y"		>> $(KLIBC_DIR)/defconfig
endif
	@ln -sf $(KERNEL_DIR) $(KLIBC_DIR)/linux
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

KLIBC_MAKEVARS := \
	$(PARALLELMFLAGS) \
	KLIBCARCH=$(PTXCONF_ARCH_STRING) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	INSTALLROOT=$(PTXDIST_SYSROOT_TARGET)

$(STATEDIR)/klibc.compile:
	@$(call targetinfo)
	@rm -f $(KLIBC_DIR)/.config
	@cd $(KLIBC_DIR) && $(MAKE) $(KLIBC_MAKEVARS) prefix=$(PTXDIST_SYSROOT_TARGET)/usr
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc.install:
	@$(call targetinfo)

	@rm -f $(KLIBC_DIR)/.config
	@install $(KLIBC_DIR)/klcc/klcc $(PTXCONF_SYSROOT_CROSS)/bin/klcc
	@cd $(KLIBC_DIR) && $(MAKE) $(KLIBC_MAKEVARS) install

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

KLIBC_BINSRC := $(KLIBC_DIR)/usr

KLIBC_UTILS-$(PTXCONF_KLIBC_CAT)	+= cat
KLIBC_UTILS-$(PTXCONF_KLIBC_CHROOT)	+= chroot
KLIBC_UTILS-$(PTXCONF_KLIBC_CPIO)	+= cpio
KLIBC_UTILS-$(PTXCONF_KLIBC_DD)		+= dd
KLIBC_UTILS-$(PTXCONF_KLIBC_DMESG)	+= dmesg
KLIBC_UTILS-$(PTXCONF_KLIBC_FALSE)	+= false
KLIBC_UTILS-$(PTXCONF_KLIBC_HALT)	+= halt
KLIBC_UTILS-$(PTXCONF_KLIBC_KILL)	+= kill
KLIBC_UTILS-$(PTXCONF_KLIBC_LN)		+= ln
KLIBC_UTILS-$(PTXCONF_KLIBC_LS)		+= ls
KLIBC_UTILS-$(PTXCONF_KLIBC_MINIPS)	+= minips
KLIBC_UTILS-$(PTXCONF_KLIBC_MKDIR)	+= mkdir
KLIBC_UTILS-$(PTXCONF_KLIBC_MKFIFO)	+= mkfifo
KLIBC_UTILS-$(PTXCONF_KLIBC_MKNOD)	+= mknod
KLIBC_UTILS-$(PTXCONF_KLIBC_MOUNT)	+= mount
KLIBC_UTILS-$(PTXCONF_KLIBC_NUKE)	+= nuke
KLIBC_UTILS-$(PTXCONF_KLIBC_PIVOT_ROOT)	+= pivot_root
KLIBC_UTILS-$(PTXCONF_KLIBC_POWEROFF)	+= poweroff
KLIBC_UTILS-$(PTXCONF_KLIBC_READLINK)	+= readlink
KLIBC_UTILS-$(PTXCONF_KLIBC_REBOOT)	+= reboot
KLIBC_UTILS-$(PTXCONF_KLIBC_SLEEP)	+= sleep
KLIBC_UTILS-$(PTXCONF_KLIBC_SYNC)	+= sync
KLIBC_UTILS-$(PTXCONF_KLIBC_TRUE)	+= true
KLIBC_UTILS-$(PTXCONF_KLIBC_UMOUNT)	+= umount
KLIBC_UTILS-$(PTXCONF_KLIBC_UNAME)	+= uname

KLIBC_KINIT-$(PTXCONF_KLIBC_FSTYPE)	+= fstype
KLIBC_KINIT-$(PTXCONF_KLIBC_IPCONFIG)	+= ipconfig
#KLIBC_KINIT-$(PTXCONF_KLIBC_KINIT)	+= # kinit is copied to /
KLIBC_KINIT-$(PTXCONF_KLIBC_NFSMOUNT)	+= nfsmount
KLIBC_KINIT-$(PTXCONF_KLIBC_RESUME)	+= resume
KLIBC_KINIT-$(PTXCONF_KLIBC_RUN_INIT)	+= run-init

ifdef PTXCONF_KLIBC_STATIC
KLIBC_SUBDIR	:= static
KLIBC_EXT	:=
else
KLIBC_SUBDIR	:= shared
KLIBC_EXT	:= .shared
endif

$(STATEDIR)/klibc.targetinstall:
	@$(call targetinfo)

	@echo "# Generated initramfs" > $(KLIBC_CONTROL)

	@$(call install_initramfs, klibc, 0, 0, 0755, /bin);
	@$(call install_initramfs, klibc, 0, 0, 0755, /dev);
	@$(call install_initramfs, klibc, 0, 0, 0755, /etc);
	@$(call install_initramfs, klibc, 0, 0, 0755, /lib);
	@$(call install_initramfs, klibc, 0, 0, 0755, /proc);
	@$(call install_initramfs, klibc, 0, 0, 0755, /sbin);
	@$(call install_initramfs, klibc, 0, 0, 0755, /sys);

	@$(call install_initramfs_node, klibc, 0, 0, 0600, c, 5, 1, /dev/console);

	@for prog in $(KLIBC_UTILS-y); do \
		$(call install_initramfs, klibc, 0, 0, 0755, \
			$(KLIBC_DIR)/usr/utils/$(KLIBC_SUBDIR)/$${prog}, /bin/$${prog}); \
	done

	@for prog in $(KLIBC_KINIT-y); do \
		$(call install_initramfs, klibc, 0, 0, 0755, \
			$(KLIBC_DIR)/usr/kinit/$${prog}/$(KLIBC_SUBDIR)/$${prog}, /bin/$${prog}); \
	done

ifdef PTXCONF_KLIBC_KINIT
	@$(call install_initramfs, klibc, 0, 0, 0755, \
		$(KLIBC_DIR)/usr/kinit/kinit$(KLIBC_EXT), /kinit);
endif

ifdef PTXCONF_KLIBC_DASH
	@$(call install_initramfs, klibc, 0, 0, 0755, \
		$(KLIBC_DIR)/usr/dash/sh$(KLIBC_EXT), /bin/sh);
endif

ifdef PTXCONF_KLIBC_SHARED
	@for lib in $(KLIBC_DIR)/usr/klibc/klibc-*.so; do \
		$(call install_initramfs, klibc, 0, 0, 0755, \
			$${lib}, /lib/$$(basename $${lib})); \
	done
endif

#
# add the link when enabled
#
ifneq ($(call remove_quotes,$(PTXCONF_KLIBC_INIT)),)
	@$(call install_initramfs_link, klibc, /init, $(PTXCONF_KLIBC_INIT));
endif

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

klibc_clean:
	rm -rf $(STATEDIR)/klibc.*
	rm -rf $(PKGDIR)/klibc{-,_}*
	rm -rf $(KLIBC_DIR)
	rm -rf $(PTXCONF_SYSROOT_CROSS)/bin/klcc
	rm -rf $(SYSROOT)/usr/lib/klibc
	rm -rf $(KLIBC_CONTROL)

# vim: syntax=make
