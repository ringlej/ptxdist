# -*-makefile-*-
# $Id: template 3345 2005-11-14 17:14:19Z rsc $
#
# Copyright (C) 2005 by Sascha Hauer
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
KLIBC_URL	:= \
	http://www.kernel.org/pub/linux/libs/klibc/Testing/$(KLIBC).$(KLIBC_SUFFIX) \
	http://eu.kernel.org/pub/linux/libs/klibc/Testing/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_SOURCE	:= $(SRCDIR)/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_DIR	:= $(BUILDDIR)/$(KLIBC)

ifdef PTXCONF_KLIBC
$(STATEDIR)/kernel.compile: $(STATEDIR)/klibc.install
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

KLIBC_PATH	:= PATH=$(CROSS_PATH)
KLIBC_ENV 	:= $(CROSS_ENV)

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
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

# CROSS_COMPILE define the crosscompiler to use
# KLIBCARCH define the target architecture
# INSTALLROOT where to install the executables
KLIBC_MAKEVARS := \
	$(PARALLELMFLAGS) \
	KLIBCARCH=$(PTXCONF_ARCH_STRING) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	INSTALLROOT=$(SYSROOT)

$(STATEDIR)/klibc.compile:
	@$(call targetinfo)
	rm -f $(KLIBC_DIR)/.config
	ln -sf $(KERNEL_DIR) $(KLIBC_DIR)/linux
	cd $(KLIBC_DIR) && $(MAKE) $(KLIBC_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# this won't generate any files here for the target. All selected files will
# later be part of the kernel image itself (initramfs). Instead only a control
# file will be generated and all parts of the klibc get installed into
# $(SYSROOT)/usr/lib/klibc.
# To link applications against klibc, use the "klcc" wrapper instead of the
# cross compiler. klcc will be build here and uses the $(COMPILER_PREFIX).
# While kernel building the klibc files will be fetched from their build location!
# ----------------------------------------------------------------------------
#

#
# where the klibc "install" target installs the target binaries
#
KLIBC_BINSRC := $(KLIBC_DIR)/usr
# where to store the file info
KLIBC_CONTROL := $(KLIBC_DIR)/initramfs_spec


$(STATEDIR)/klibc.install:
	@$(call targetinfo)

	@echo "dir /dev/ 755 0 0"		>  $(KLIBC_CONTROL)
	@echo "dir /proc/ 755 0 0"		>> $(KLIBC_CONTROL)
	@echo "dir /sys/ 755 0 0"		>> $(KLIBC_CONTROL)
	@echo "dir /bin/ 755 0 0"		>> $(KLIBC_CONTROL)
	@echo "nod /dev/console 644 0 0 c 5 1"	>> $(KLIBC_CONTROL)
	@echo "nod /dev/loop0 644 0 0 b 7 0"	>> $(KLIBC_CONTROL)
#
# select the static parts first
#
ifdef PTXCONF_KLIBC_STATIC_CAT
	@echo "file /bin/cat $(KLIBC_BINSRC)/utils/static/cat 755 0 0"		>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_CHROOT
	@echo "file /bin/chroot $(KLIBC_BINSRC)/utils/static/chroot 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_CPIO
	@echo "file /bin/cpio $(KLIBC_BINSRC)/utils/static/cpio 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_DD
	@echo "file /bin/dd $(KLIBC_BINSRC)/utils/static/dd 755 0 0"		>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_DMESG
	@echo "file /bin/dmesg $(KLIBC_BINSRC)/utils/static/dmesg 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_FALSE
	@echo "file /bin/false $(KLIBC_BINSRC)/utils/static/false 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_FSTYPE
	@echo "file /bin/fstype $(KLIBC_BINSRC)/kinit/fstype/static/fstype 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_HALT
	@echo "file /bin/halt $(KLIBC_BINSRC)/utils/static/halt 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_IPCONIFG
	@echo "file /bin/ipconfig $(KLIBC_BINSRC)/kinit/ipconfig/static/ipconfig 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_KILL
	@echo "file /bin/kill $(KLIBC_BINSRC)/utils/static/kill 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_LN
	@echo "file /bin/ln $(KLIBC_BINSRC)/utils/static/ln 755 0 0"		>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MINIPS
	@echo "file /bin/minips $(KLIBC_BINSRC)/utils/static/minips 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MKDIR
	@echo "file /bin/mkdir $(KLIBC_BINSRC)/utils/static/mkdir 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MKFIFO
	@echo "file /bin/mkfifo $(KLIBC_BINSRC)/utils/static/mkfifo 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MKNOD
	@echo "file /bin/mknod $(KLIBC_BINSRC)/utils/static/mknod 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MOUNT
	@echo "file /bin/mount $(KLIBC_BINSRC)/utils/static/mount 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_NFSMOUNT
	@echo "file /bin/nfsmount $(KLIBC_BINSRC)/kinit/nfsmount/static/nfsmount 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_NUKE
	@echo "file /bin/nuke $(KLIBC_BINSRC)/utils/static/nuke 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_PIVOT_ROOT
	@echo "file /bin/pivot_root $(KLIBC_BINSRC)/utils/static/pivot_root 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_POWEROFF
	@echo "file /bin/poweroff $(KLIBC_BINSRC)/utils/static/poweroff 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_READLINK
	@echo "file /bin/readlink $(KLIBC_BINSRC)/utils/static/readlink 755 0 0">> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_REBOOT
	@echo "file /bin/reboot $(KLIBC_BINSRC)/utils/static/reboot 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_RESUME
	@echo "file /bin/resume $(KLIBC_BINSRC)/kinit/resume/static/resume 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_RUN_INIT
	@echo "file /bin/run-init $(KLIBC_BINSRC)/kinit/run-init/static/run-init 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_SLEEP
	@echo "file /bin/sleep $(KLIBC_BINSRC)/utils/static/sleep 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_SYNC
	@echo "file /bin/sync $(KLIBC_BINSRC)/utils/static/sync 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_TRUE
	@echo "file /bin/true $(KLIBC_BINSRC)/utils/static/true 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_UMOUNT
	@echo "file /bin/umount $(KLIBC_BINSRC)/utils/static/umount 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_UNAME
	@echo "file /bin/uname $(KLIBC_BINSRC)/utils/static/uname 755 0 0"	>> $(KLIBC_CONTROL)
endif

ifdef PTXCONF_KLIBC_STATIC_DASH
	@echo "file /bin/sh $(KLIBC_BINSRC)/dash/sh 755 0 0"			>> $(KLIBC_CONTROL)
endif

ifdef PTXCONF_KLIBC_KINIT
	@echo "file /kinit $(KLIBC_BINSRC)/kinit/kinit 755 0 0"			>> $(KLIBC_CONTROL)
endif

#
# select the dynamics
# FIXME: Untested and not fully supported yet!
#
ifdef PTXCONF_KLIBC_DYNAMIC_LIB
	@echo "dir /lib/ 755 0 0" >> $(KLIBC_CONTROL)
	@echo "file /lib/klibc.so $(KLIBC_BINSRC)/utils/klibc/klibc.so 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_CAT
	@echo "file /bin/cat $(KLIBC_BINSRC)/utils/shared/cat 755 0 0"		>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_CHROOT
	@echo "file /bin/chroot $(KLIBC_BINSRC)/utils/shared/chroot 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_CPIO
	@echo "file /bin/cpio $(KLIBC_BINSRC)/utils/shared/cpio 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_DD
	@echo "file /bin/dd $(KLIBC_BINSRC)/utils/shared/dd 755 0 0"		>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_DMESG
	@echo "file /bin/dmesg $(KLIBC_BINSRC)/utils/shared/dmesg 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_FALSE
	@echo "file /bin/false $(KLIBC_BINSRC)/utils/shared/false 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_FSTYPE
	@echo "file /bin/fstype $(KLIBC_BINSRC)/kinit/fstype/shared/fstype 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_HALT
	@echo "file /bin/halt $(KLIBC_BINSRC)/utils/shared/halt 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_IPCONIFG
	@echo "file /bin/ipconfig $(KLIBC_BINSRC)/kinit/ipconfig/shared/ipconfig 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_KILL
	@echo "file /bin/kill $(KLIBC_BINSRC)/utils/shared/kill 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_LN
	@echo "file /bin/ln $(KLIBC_BINSRC)/utils/shared/ln 755 0 0"		>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_MINIPS
	@echo "file /bin/minips $(KLIBC_BINSRC)/utils/shared/minips 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_MKDIR
	@echo "file /bin/mkdir $(KLIBC_BINSRC)/utils/shared/mkdir 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_MKFIFO
	@echo "file /bin/mkfifo $(KLIBC_BINSRC)/utils/shared/mkfifo 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_MKNOD
	@echo "file /bin/mknod $(KLIBC_BINSRC)/utils/shared/mknod 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_MOUNT
	@echo "file /bin/mount $(KLIBC_BINSRC)/utils/shared/mount 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_NFSMOUNT
	@echo "file /bin/nfsmount $(KLIBC_BINSRC)/kinit/nfsmount/shared/nfsmount 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_NUKE
	@echo "file /bin/nuke $(KLIBC_BINSRC)/utils/shared/nuke 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_PIVOT_ROOT
	@echo "file /bin/pivot_root $(KLIBC_BINSRC)/utils/shared/pivot_root 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_POWEROFF
	@echo "file /bin/poweroff $(KLIBC_BINSRC)/utils/shared/poweroff 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_READLINK
	@echo "file /bin/readlink $(KLIBC_BINSRC)/utils/shared/readlink 755 0 0">> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_REBOOT
	@echo "file /bin/reboot $(KLIBC_BINSRC)/utils/shared/reboot 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_RESUME
	@echo "file /bin/resume $(KLIBC_BINSRC)/kinit/resume/shared/resume 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_RUN_INIT
	@echo "file /bin/run-init $(KLIBC_BINSRC)/kinit/run-init/shared/run-init 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_SLEEP
	@echo "file /bin/sleep $(KLIBC_BINSRC)/utils/shared/sleep 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_SYNC
	@echo "file /bin/sync $(KLIBC_BINSRC)/utils/shared/sync 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_TRUE
	@echo "file /bin/true $(KLIBC_BINSRC)/utils/shared/true 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_UMOUNT
	@echo "file /bin/umount $(KLIBC_BINSRC)/utils/shared/umount 755 0 0"	>> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_UNAME
	@echo "file /bin/uname $(KLIBC_BINSRC)/utils/shared/uname 755 0 0"	>> $(KLIBC_CONTROL)
endif

#
# add the link when enabled
#
ifneq ($(call remove_quotes,$(PTXCONF_KLIBC_INIT)),)
	@echo "slink /init $(PTXCONF_KLIBC_INIT) 755 0 0" >> $(KLIBC_CONTROL)
endif
#
# adding user specific files to the list
# Note: files without a leading '/' get a prefix path of the current project
#
ifdef PTXCONF_KLIBC_USER_SPEC
	cat $(PTXDIST_WORKSPACE)/initramfs_spec | while read type target source rest; do	\
		if [ "$$type" == "file" ]; then							\
			if [ "$$(echo "$$source" | grep "^/")" == "" ]; then			\
				source=$(PTXDIST_WORKSPACE)/$$source;				\
			fi;									\
		fi;										\
		echo "$$type $$target $$source $$rest" >> $(KLIBC_CONTROL);			\
	done
endif
#
# install the compiler wrapper to be used to link programs against klibc
#
	install $(KLIBC_DIR)/klcc/klcc $(PTXCONF_SYSROOT_CROSS)/bin/klcc
#
# install a few commands to the local architecture directory
# but important is the klibc.a only to link programs against it
#
	cd $(KLIBC_DIR) && $(MAKE) $(KLIBC_MAKEVARS) install

#
# make sure the kernel regenerates the initramfs image
#
	rm -f $(KERNEL_DIR)/usr/initramfs_data.cpio.gz

	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc.targetinstall:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

klibc_clean:
	rm -rf $(STATEDIR)/klibc.*
	rm -rf $(PKGDIR)/klibc_*
	rm -rf $(KLIBC_DIR)
	rm -rf $(PTXCONF_SYSROOT_CROSS)/bin/klcc

# vim: syntax=make
