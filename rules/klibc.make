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
KLIBC_VERSION	:= 1.4
KLIBC		:= klibc-$(KLIBC_VERSION)
KLIBC_SUFFIX	:= tar.gz
KLIBC_URL	:= http://www.kernel.org/pub/linux/libs/klibc/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_SOURCE	:= $(SRCDIR)/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_DIR	:= $(BUILDDIR)/$(KLIBC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

klibc_get: $(STATEDIR)/klibc.get

$(STATEDIR)/klibc.get: $(klibc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(KLIBC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, KLIBC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

klibc_extract: $(STATEDIR)/klibc.extract

$(STATEDIR)/klibc.extract: $(klibc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(KLIBC_DIR))
	@$(call extract, KLIBC)
	@$(call patchin, KLIBC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

klibc_prepare: $(STATEDIR)/klibc.prepare

KLIBC_PATH	:= PATH=$(CROSS_PATH)
KLIBC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#

$(STATEDIR)/klibc.prepare: $(klibc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

klibc_compile: $(STATEDIR)/klibc.compile

klibc_compile_deps := \
	$(klibc_compile_deps_default) \
	$(STATEDIR)/kernel.prepare
#
# INSTALLROOT whats it?
#
$(STATEDIR)/klibc.compile: $(klibc_compile_deps)
	@$(call targetinfo, $@)
	cd $(KLIBC_DIR) && make V=1 ARCH=$(PTXCONF_ARCH) CROSS_COMPILE=$(COMPILER_PREFIX) KLIBCKERNELSRC=$(KERNEL_DIR)/ KLIBCKERNELOBJ=$(KERNEL_DIR)/ INSTALLROOT=$(PTXCONF_PREFIX)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

klibc_install: $(STATEDIR)/klibc.install

#
# where the klibc install target installs the target binaries
# 
PTXCONF_KLIBC_BINSRC := $(KLIBC_DIR)/usr
#
# FIXME: Maybe its better to use the files from their build directory
#        instead using the ones from the installed place
#
$(STATEDIR)/klibc.install: $(klibc_install_deps_default)
	@$(call targetinfo, $@)

	echo "dir /dev/ 755 0 0" > $(KLIBC_DIR)/initramfs_spec
	echo "dir /proc/ 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
	echo "dir /sys/ 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
	echo "dir /bin/ 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
	echo "dir /lib/ 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
	echo "nod /dev/console 644 0 0 c 5 1" >> $(KLIBC_DIR)/initramfs_spec
	echo "nod /dev/loop0 644 0 0 b 7 0" >> $(KLIBC_DIR)/initramfs_spec
ifdef PTXCONF_KLIBC_KINIT_STATIC
	echo "file /bin/kinit $(PTXCONF_KLIBC_BINSRC)/bin/kinit 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_SH
	echo "file /bin/sh $(PTXCONF_KLIBC_BINSRC)/bin/sh 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_SHARED
	echo "file /usr/lib/libc.so $(PTXCONF_KLIBC_BINSRC)/lib/libc.so 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_CAT
	echo "file /bin/cat $(PTXCONF_KLIBC_BINSRC)/$(PTXCONF_GNU_TARGET)/usr/lib/klibc/bin/cat 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_INSMOD
	echo "file /bin/insmod $(KLIBC_DIR)/utils/static/insmod 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_MOUNT
	echo "file /bin/mount $(KLIBC_DIR)/utils/static/mount 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_DD
	echo "file /bin/dd $(KLIBC_DIR)/utils/static/dd 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_CHROOT
	echo "file /bin/chroot $(KLIBC_DIR)/utils/static/chroot 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_FALSE
	echo "file /bin/false $(KLIBC_DIR)/utils/static/false 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_FSTYPE
	echo "file /bin/fstype $(KLIBC_DIR)/utils/static/fstype 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_LN
	echo "file /bin/ln $(KLIBC_DIR)/utils/static/ln 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_MINIPS
	echo "file /bin/minips $(KLIBC_DIR)/utils/static/minips 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_MKDIR
	echo "file /bin/mkdir $(KLIBC_DIR)/utils/static/mkdir 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_MKFIFO
	echo "file /bin/mkfifo $(KLIBC_DIR)/utils/static/mkfifo 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_NUKE
	echo "file /bin/nuke $(KLIBC_DIR)/utils/static/nuke 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_PIVOT_ROOT
	echo "file /bin/pivot_root $(KLIBC_DIR)/utils/static/pivot_root 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_PRINTF
	echo "file /bin/printf $(KLIBC_DIR)/utils/static/printf 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_RUN_INIT
	echo "file /bin/run-init $(KLIBC_DIR)/utils/static/run-init 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_SLEEP
	echo "file /bin/sleep $(KLIBC_DIR)/utils/static/sleep 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_TRUE
	echo "file /bin/true $(KLIBC_DIR)/utils/static/true 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_UMOUNT
	echo "file /bin/umount $(KLIBC_DIR)/utils/static/umount 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_UNAME
	echo "file /bin/uname $(KLIBC_DIR)/utils/static/uname 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_NFSMOUNT
	echo "file /bin/nfsmount $(KLIBC_DIR)/nfsmount/static/nfsmount 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifneq ($(call remove_quotes,$(PTXCONF_KLIBC_INIT)),)
	echo "slink /init $(PTXCONF_KLIBC_INIT) 755 0 0" >> $(KLIBC_DIR)/initramfs_spec
endif
ifdef PTXCONF_KLIBC_USER_SPEC
	cat $(PTXDIST_WORKSPACE)/initramfs_spec | while read type target source rest; do	\
		if [ "$$type" == "file" ]; then						\
			if [ "$$(echo "$$source" | grep "^/")" == "" ]; then		\
				source=$(PTXDIST_WORKSPACE)/$$source;			\
			fi;								\
		fi;									\
		echo "$$type $$target $$source $$rest" >> $(KLIBC_DIR)/initramfs_spec;	\
	done
endif

	install $(KLIBC_DIR)/klcc/klcc $(PTXCONF_PREFIX)/bin/klcc
	cd $(KLIBC_DIR) && make V=1 ARCH=$(PTXCONF_ARCH) CROSS_COMPILE=$(COMPILER_PREFIX) KLIBCKERNELSRC=$(KERNEL_DIR)/ KLIBCKERNELOBJ=$(KERNEL_DIR)/ INSTALLROOT=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET) install

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

klibc_targetinstall: $(STATEDIR)/klibc.targetinstall

$(STATEDIR)/klibc.targetinstall: $(klibc_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

klibc_clean:
	rm -rf $(STATEDIR)/klibc.*
	rm -rf $(IMAGEDIR)/klibc_*
	rm -rf $(KLIBC_DIR)

# vim: syntax=make
