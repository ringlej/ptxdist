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
KLIBC_VERSION	:= 1.4.30
KLIBC		:= klibc-$(KLIBC_VERSION)
KLIBC_SUFFIX	:= tar.gz
KLIBC_URL	:= http://www.kernel.org/pub/linux/libs/klibc/Testing/1.4.x/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_SOURCE	:= $(SRCDIR)/$(KLIBC).$(KLIBC_SUFFIX)
KLIBC_DIR	:= $(BUILDDIR)/$(KLIBC)

ifdef PTXCONF_KLIBC
$(STATEDIR)/kernel.compile: $(STATEDIR)/klibc.install
endif

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

$(STATEDIR)/klibc.prepare: $(klibc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

klibc_compile: $(STATEDIR)/klibc.compile

# CROSS_COMPILE define the crosscompiler to use
# KLIBCARCH define the target architecture
# INSTALLROOT where to install the executables
KLIBC_MAKEVARS := \
	KLIBCARCH=$(PTXCONF_ARCH_STRING) \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	INSTALLROOT=$(SYSROOT)

$(STATEDIR)/klibc.compile: $(klibc_compile_deps_default) $(STATEDIR)/kernel.prepare
	@$(call targetinfo, $@)
	rm -f $(KLIBC_DIR)/.config
	ln -sf $(KERNEL_DIR) $(KLIBC_DIR)/linux
	cd $(KLIBC_DIR) && $(MAKE) $(KLIBC_MAKEVARS)
	@$(call touch, $@)

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
klibc_install: $(STATEDIR)/klibc.install

#
# where the klibc "install" target installs the target binaries
#
KLIBC_BINSRC := $(KLIBC_DIR)/usr
# where to store the file info
KLIBC_CONTROL := $(KLIBC_DIR)/initramfs_spec

#
$(STATEDIR)/klibc.install: $(klibc_install_deps_default)
	@$(call targetinfo, $@)

	echo "dir /dev/ 755 0 0" > $(KLIBC_CONTROL)
	echo "dir /proc/ 755 0 0" >> $(KLIBC_CONTROL)
	echo "dir /sys/ 755 0 0" >> $(KLIBC_CONTROL)
	echo "dir /bin/ 755 0 0" >> $(KLIBC_CONTROL)
	echo "nod /dev/console 644 0 0 c 5 1" >> $(KLIBC_CONTROL)
	echo "nod /dev/loop0 644 0 0 b 7 0" >> $(KLIBC_CONTROL)
#
# select the static parts first
#
ifdef PTXCONF_KLIBC_STATIC_CAT
	echo "file /bin/cat $(KLIBC_BINSRC)/utils/static/cat 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_CHROOT
	echo "file /bin/chroot $(KLIBC_BINSRC)/utils/static/chroot 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_DD
	echo "file /bin/dd $(KLIBC_BINSRC)/utils/static/dd 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_FALSE
	echo "file /bin/false $(KLIBC_BINSRC)/utils/static/false 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_INSMOD
	echo "file /bin/insmod $(KLIBC_BINSRC)/utils/static/insmod 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_LN
	echo "file /bin/ln $(KLIBC_BINSRC)/utils/static/ln 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MINIPS
	echo "file /bin/minips $(KLIBC_BINSRC)/utils/static/minips 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MKDIR
	echo "file /bin/mkdir $(KLIBC_BINSRC)/utils/static/mkdir 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MKFIFO
	echo "file /bin/mkfifo $(KLIBC_BINSRC)/utils/static/mkfifo 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_MOUNT
	echo "file /bin/mount $(KLIBC_BINSRC)/utils/static/mount 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_NUKE
	echo "file /bin/nuke $(KLIBC_BINSRC)/utils/static/nuke 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_PIVOT_ROOT
	echo "file /bin/pivot_root $(KLIBC_BINSRC)/utils/static/pivot_root 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_SLEEP
	echo "file /bin/sleep $(KLIBC_BINSRC)/utils/static/sleep 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_TRUE
	echo "file /bin/true $(KLIBC_BINSRC)/utils/static/true 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_UMOUNT
	echo "file /bin/umount $(KLIBC_BINSRC)/utils/static/umount 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_STATIC_UNAME
	echo "file /bin/uname $(KLIBC_BINSRC)/utils/static/uname 755 0 0" >> $(KLIBC_CONTROL)
endif

ifdef PTXCONF_KLIBC_STATIC_DASH
	echo "file /bin/sh $(KLIBC_BINSRC)/dash/sh 755 0 0" >> $(KLIBC_CONTROL)
endif

ifdef PTXCONF_KLIBC_KINIT
	echo "file /kinit $(KLIBC_BINSRC)/kinit/kinit 755 0 0" >> $(KLIBC_CONTROL)
endif

#
# select the dynamics
# FIXME: Untested and not fully supported yet!
#
ifdef PTXCONF_KLIBC_DYNAMIC_LIB
	echo "dir /lib/ 755 0 0" >> $(KLIBC_CONTROL)
	echo "file /lib/klibc.so $(KLIBC_BINSRC)/utils/klibc/klibc.so 755 0 0" >> $(KLIBC_CONTROL)
endif
ifdef PTXCONF_KLIBC_SHARED_CAT
	echo "file /bin/sh $(KLIBC_BINSRC)/usr/dash/sh 755 0 0" >> $(KLIBC_CONTROL)
endif

# FIXME: add remaining possible commands

#
# add the link when enabled
#
ifneq ($(call remove_quotes,$(PTXCONF_KLIBC_INIT)),)
	echo "slink /init $(PTXCONF_KLIBC_INIT) 755 0 0" >> $(KLIBC_CONTROL)
endif
#
# adding user specific files to the list
# Note: files without a leading '/' get a prefix path of the current project
#
ifdef PTXCONF_KLIBC_USER_SPEC
	cat $(PTXDIST_WORKSPACE)/initramfs_spec | while read type target source rest; do	\
		if [ "$$type" == "file" ]; then						\
			if [ "$$(echo "$$source" | grep "^/")" == "" ]; then		\
				source=$(PTXDIST_WORKSPACE)/$$source;			\
			fi;								\
		fi;									\
		echo "$$type $$target $$source $$rest" >> $(KLIBC_CONTROL);		\
	done
endif
#
# install the compiler wrapper to be used to link programs against klibc
#
	install $(KLIBC_DIR)/klcc/klcc $(PTXCONF_CROSS_PREFIX)/bin/klcc
#
# install a few commands to the local architecture directory
# but important is the klibc.a only to link programs against it
#
	cd $(KLIBC_DIR) && $(MAKE) $(KLIBC_MAKEVARS) install

#
# make sure the kernel regenerates the initramfs image
#
	rm -f $(KERNEL_DIR)/usr/initramfs_data.cpio.gz

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
	rm -rf $(PTXCONF_CROSS_PREFIX)/bin/klcc

# vim: syntax=make
