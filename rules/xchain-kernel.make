# $Id: xchain-kernel.make,v 1.3 2003/06/25 12:19:05 robert Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# There are two "groups" of targets here: that ones starting with xchain- are
# only used for the cross chain. The "normal" targets are used for building the 
# runtime kernel.  
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_KERNEL_2_4_18))
PACKAGES += xchain-kernel
PACKAGES += kernel
endif
ifeq (y,$(PTXCONF_KERNEL_2_4_19))
PACKAGES += xchain-kernel
PACKAGES += kernel
endif

#
# Paths and names 
#
# FIXME: make extraversion configurable!
# 
ifeq (y,$(PTXCONF_KERNEL_2_4_18))
KERNEL			= linux-2.4.18
KERNEL_URL		= ftp://ftp.kernel.org/pub/linux/kernel/v2.4/$(KERNEL).tar.bz2 
KERNEL_SOURCE		= $(SRCDIR)/$(KERNEL).tar.bz2
KERNEL_DIR		= $(BUILDDIR)/$(KERNEL)
KERNEL_EXTRACT 		= bzip2 -dc

KERNEL_RMKPATCH		= patch-2.4.18-rmk7
KERNEL_RMKPATCH_URL	= ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/v2.4/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_DIR	= $(BUILDDIR)/$(KERNEL)
KERNEL_RMKPATCH_EXTRACT	= bzip2 -dc

KERNEL_PXAPATCH 	= diff-2.4.18-rmk7-pxa3
KERNEL_PXAPATCH_URL 	= ftp://ftp.arm.linux.org.uk/pub/armlinux/people/nico/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_DIR	= $(BUILDDIR)/$(KERNEL)
KERNEL_PXAPATCH_EXTRACT = gzip -dc

KERNEL_PTXPATCH		= patch-2.4.18-rmk7-ptx3
KERNEL_PTXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_URL	= http://www.pengutronix.de/software/dnp/patch-2.4.18-rmk7-ptx3
KERNEL_PTXPATCH_DIR	= $(BUILDDIR)/$(KERNEL)
KERNEL_PTXPATCH_EXTRACT	= cat

ifeq (y, $(PTXCONF_RTAI_ALLSOFT))
KERNEL_RTAIPATCH	= patch-2.4.18-allsoft
endif
ifeq (y, $(PTXCONF_RTAI_RTHAL))
KERNEL_RTAIPATCH	= patch-2.4.18-rthal5g
endif
KERNEL_RTAIPATCH_DIR	= $(BUILDDIR)/rtai-patches
endif

ifeq (y,$(PTXCONF_KERNEL_2_4_19))
KERNEL			= linux-2.4.19
KERNEL_URL		= ftp://ftp.rfc822.org/pub/linux/kernel/v2.4/$(KERNEL).tar.bz2 
KERNEL_SOURCE		= $(SRCDIR)/$(KERNEL).tar.bz2
KERNEL_DIR		= $(BUILDDIR)/$(KERNEL)
KERNEL_EXTRACT 		= bzip2 -dc

KERNEL_RMKPATCH		= patch-2.4.19-rmk4
KERNEL_RMKPATCH_URL	= ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/v2.4/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_DIR	= $(BUILDDIR)/$(KERNEL)
KERNEL_RMKPATCH_EXTRACT	= bzip2 -dc

KERNEL_PXAPATCH 	= diff-2.4.19-rmk4-pxa1
KERNEL_PXAPATCH_URL 	= ftp://ftp.arm.linux.org.uk/pub/armlinux/people/nico/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_DIR	= $(BUILDDIR)/$(KERNEL)
KERNEL_PXAPATCH_EXTRACT = gzip -dc

KERNEL_PTXPATCH		= linux-2.4.19-rmk4-pxa1-ptx10.diff
KERNEL_PTXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_URL	= http://www.pengutronix.de/software/linux-arm/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_DIR	= $(BUILDDIR)/$(KERNEL)
KERNEL_PTXPATCH_EXTRACT	= cat

ifeq (y, $(PTXCONF_RTAI_ALLSOFT))
KERNEL_RTAIPATCH	= patch-2.4.19-allsoft
endif
ifeq (y, $(PTXCONF_RTAI_RTHAL))
KERNEL_RTAIPATCH	= patch-2.4.19-rthal5g
endif
KERNEL_RTAIPATCH_DIR	= $(BUILDDIR)/rtai-patches
endif

ifeq (y, $(PTXCONF_KERNEL_IMAGE_Z))
KERNEL_TARGET		= zImage
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/$(PTXCONF_ARCH)/boot/zImage
endif
ifeq (y, $(PTXCONF_KERNEL_IMAGE_BZ))
KERNEL_TARGET		= bzImage
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/$(PTXCONF_ARCH)/boot/bzImage
endif
ifeq (y, $(PTXCONF_KERNEL_IMAGE_U))
KERNEL_TARGET		= uImage
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/uImage
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel_get: $(STATEDIR)/kernel.get
xchain-kernel_get: $(STATEDIR)/xchain-kernel.get

kernel_get_deps =  $(KERNEL_SOURCE)
ifeq (y, $(PTXCONF_ARCH_ARM))
kernel_get_deps += $(KERNEL_RMKPATCH_SOURCE)
kernel_get_deps += $(KERNEL_PTXPATCH_SOURCE)
ifeq (y, $(PTXCONF_KERNEL_XSCALE))
kernel_get_deps += $(KERNEL_PXAPATCH_SOURCE)
ifeq (y, $(PTXCONF_KERNEL_XSCALE_PTX))
kernel_get_deps += $(KERNEL_PTXPATCH_SOURCE)
endif # PTXCONF_KERNEL_XSCALE_PTX
endif # PTXCONF_KERNEL_XSCALE
endif # PTXCONF_ARCH_ARM

$(STATEDIR)/kernel.get: $(kernel_get_deps)
	touch $@

$(STATEDIR)/xchain-kernel.get: $(kernel_get_deps)

$(KERNEL_SOURCE):
	@$(call targetinfo, kernel.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_URL)

$(KERNEL_RMKPATCH_SOURCE):
	@$(call targetinfo, kernel-armpatch.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_RMKPATCH_URL)

$(KERNEL_PXAPATCH_SOURCE):
	@$(call targetinfo, kernel-pxapatch.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_PXAPATCH_URL)

$(KERNEL_PTXPATCH_SOURCE):
	@$(call targetinfo, kernel-ptxpatch.get)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_PTXPATCH_URL)

#
# RTAI patches are included in the normal RTAI packet
# 
rtai-patches_get: $(STATEDIR)/rtai-patches.get

$(STATEDIR)/rtai-patches.get: $(RTAI_SOURCE)
	touch $@

#
# xchain
#
$(STATEDIR)/xchain-kernel.get: $(kernel_get_deps)
	@$(call targetinfo, xchain-kernel.get)
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

kernel_extract: $(STATEDIR)/kernel.extract

kernel_extract_deps =  $(STATEDIR)/kernel.get
ifeq (y, $(PTXCONF_RTAI))
kernel_extract_deps += $(STATEDIR)/rtai-patches.extract
endif
ifeq (y, $(PTXCONF_KERNEL_MTD))
kernel_extract_deps += $(STATEDIR)/mtd.extract
endif

$(STATEDIR)/kernel.extract: $(kernel_extract_deps)
	@$(call targetinfo, kernel.extract)
#	# remove old kernel directories before we extract
	rm -fr $(KERNEL_DIR)
	$(KERNEL_EXTRACT) $(KERNEL_SOURCE) | tar -C $(BUILDDIR) -xf -
#	#
#	# kernels before 2.4.19 extract to "linux" instead of "linux-version"
#	# 
        ifeq (y,$(PTXCONF_KERNEL_2_4_18))
	cd $(BUILDDIR) && mv linux $(KERNEL_DIR)
        endif
#	#
#	# ARM patch 
#	#
        ifeq (y,$(PTXCONF_ARCH_ARM))
	cd $(KERNEL_DIR) && 						\
		$(KERNEL_RMKPATCH_EXTRACT) $(KERNEL_RMKPATCH_SOURCE) |  \
		patch -p1
        endif
#	# 
#	# XSCALE patch
#	#
        ifeq (y, $(PTXCONF_KERNEL_XSCALE))
	cd $(KERNEL_DIR) && 						\
		$(KERNEL_PXAPATCH_EXTRACT) $(KERNEL_PXAPATCH_SOURCE) |  \
		patch -p1
        endif
#	#
#	# MTD patch
#	#
        ifeq (y, $(PTXCONF_KERNEL_MTD))
	echo "y" | /bin/sh $(MTD_DIR)/patches/patchin.sh -j $(KERNEL_DIR)
        endif
#	#
#	# XSCALE_PTX patch
#	# 
        ifeq (y, $(PTXCONF_KERNEL_XSCALE_PTX))
	cd $(KERNEL_DIR) && 						\
		$(KERNEL_PTXPATCH_EXTRACT) $(KERNEL_PTXPATCH_SOURCE) |	\
		patch -p1
        endif
#	#
#	# patches for all architectures
#	#
        ifeq (y, $(PTXCONF_RTAI))
	cd $(KERNEL_DIR) && 						 \
		patch -p1 < $(KERNEL_RTAIPATCH_DIR)/$(RTAI)/patches/$(KERNEL_RTAIPATCH)
        endif	
	touch $@

#
# RTAI patch
#

rtai-patches_extract: $(STATEDIR)/rtai-patches.extract

$(STATEDIR)/rtai-patches.extract: $(STATEDIR)/rtai-patches.get
	@$(call targetinfo, rtai-patches.extract)
#	# remove old rtaipatch directory
	rm -fr $(KERNEL_RTAIPATCH_DIR)
	install -d $(KERNEL_RTAIPATCH_DIR)
#	# extract only the patches directory
	cd $(KERNEL_RTAIPATCH_DIR) &&					\
		tar zxvf $(RTAI_SOURCE) $(RTAI)/patches 
	touch $@

#
# xchain 
#

xchain-kernel_extract: $(STATEDIR)/xchain-kernel.extract

$(STATEDIR)/xchain-kernel.extract: $(STATEDIR)/xchain-kernel.get $(STATEDIR)/mtd.extract
	@$(call targetinfo, xchain-kernel.extract)
#	#
	rm -fr $(BUILDDIR)/xchain-kernel
	mkdir -p $(BUILDDIR)/xchain-kernel/tmp
	cd $(BUILDDIR)/xchain-kernel &&					\
		$(KERNEL_EXTRACT) $(KERNEL_SOURCE) | tar -C $(BUILDDIR)/xchain-kernel/tmp -xf -
#	#
#	# kernels before 2.4.19 extract to "linux" instead of "linux-version"
#	# 
        ifeq (y,$(PTXCONF_KERNEL_2_4_18))
	cd $(BUILDDIR)/xchain-kernel/tmp && mv linux $(KERNEL)
        endif
#	#
#	# ARM patch 
#	#
        ifeq (y,$(PTXCONF_ARCH_ARM))
	cd $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) && 						\
		$(KERNEL_RMKPATCH_EXTRACT) $(KERNEL_RMKPATCH_SOURCE) |  \
		patch -p1
        endif
#	# 
#	# XSCALE patch
#	#
        ifeq (y, $(PTXCONF_KERNEL_XSCALE))
	cd $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) && 						\
		$(KERNEL_PXAPATCH_EXTRACT) $(KERNEL_PXAPATCH_SOURCE) |  \
		patch -p1
        endif
#	#
#	# MTD patch
#	#
        ifeq (y, $(PTXCONF_KERNEL_MTD))
	echo "y" | /bin/sh $(MTD_DIR)/patches/patchin.sh -j $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL)
        endif
#	#
#	# XSCALE_PTX patch
#	# 
        ifeq (y, $(PTXCONF_KERNEL_XSCALE_PTX))
	cd $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) && 						\
		$(KERNEL_PTXPATCH_EXTRACT) $(KERNEL_PTXPATCH_SOURCE) |	\
		patch -p1
        endif
	# fake headers
	make -C $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL) include/linux/version.h
	# we are only interested in include/ here 
	cp -a $(BUILDDIR)/xchain-kernel/tmp/$(KERNEL)/include $(BUILDDIR)/xchain-kernel/
	rm -fr $(BUILDDIR)/xchain-kernel/tmp
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kernel_prepare: $(STATEDIR)/kernel.prepare

kernel_prepare_deps = $(STATEDIR)/kernel.extract
ifeq (y,$(PTXCONF_RTAI))
kernel_prepare_deps += $(STATEDIR)/rtai-patches.extract
endif

ifeq (y,$(PTXCONF_ARCH_ARM))
KERNEL_ENVIRONMENT = PATH=$(PTXCONF_PREFIX)/bin:$$PATH
kernel_prepare_deps += $(STATEDIR)/xchain-gccstage1.install
endif

$(STATEDIR)/kernel.prepare: $(kernel_prepare_deps)
	@$(call targetinfo, kernel.prepare)
        ifeq (y,$(PTXCONF_BUILD_CROSSCHAIN))
	echo -n 'Please supply root password for sudo: '
	# FIXME: wheel is not the correct group
	[ -d $(PTXCONF_PREFIX) ] || 				\
		$(SUDO) install -g wheel -m 0755 -o $(PTXUSER) 	\
				-d $(PTXCONF_PREFIX)
        endif
	install .kernelconfig $(KERNEL_DIR)/.config	
	perl -p -i -e 's/^ARCH := .*/ARCH := $(PTXCONF_ARCH)/' $(KERNEL_DIR)/Makefile
	perl -p -i -e 's/^CROSS_COMPILE .*/CROSS_COMPILE   = $(PTXCONF_GNU_TARGET)-/' $(KERNEL_DIR)/Makefile
	cd $(KERNEL_DIR) && make oldconfig
	cd $(KERNEL_DIR) && PATH=$(PTXCONF_PREFIX)/bin:$$PATH make dep
	touch $@

#
# xchain
#

xchain-kernel_prepare: $(STATEDIR)/xchain-kernel.prepare

$(STATEDIR)/xchain-kernel.prepare: $(STATEDIR)/xchain-kernel.extract
	@$(call targetinfo, xchain-kernel.prepare)
	cd $(BUILDDIR)/xchain-kernel/include && ln -s asm-$(PTXCONF_ARCH) asm
        ifeq (y, $(PTXCONF_ARCH_ARM))
	cd $(BUILDDIR)/xchain-kernel/include/asm && ln -s proc-armv proc
        ifeq (y, $(PTXCONF_ARM_ARCH_PXA))
	cd $(BUILDDIR)/xchain-kernel/include/asm && ln -s arch-pxa arch 
        endif
        endif
	touch $@


# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kernel_compile: $(STATEDIR)/kernel.compile

kernel_compile_deps = $(STATEDIR)/kernel.prepare
kernel_compile_deps = $(STATEDIR)/umkimage.install

$(STATEDIR)/kernel.compile: $(STATEDIR)/kernel.prepare 
	@$(call targetinfo, kernel.compile)
        ifneq (y, $(PTXCONF_DONT_COMPILE_KERNEL))
	$(KERNEL_ENVIRONMENT) make -C $(KERNEL_DIR) oldconfig dep clean $(KERNEL_TARGET) modules
        endif
	touch $@

xchain-kernel_compile: $(STATEDIR)/xchain-kernel.compile

$(STATEDIR)/xchain-kernel.compile:
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel_install: $(STATEDIR)/kernel.install

$(STATEDIR)/kernel.install: $(STATEDIR)/kernel.compile
	@$(call targetinfo, kernel.install)
        ifeq (y, $(PTXCONF_KERNEL_INSTALL))
	mkdir -p $(ROOTDIR)/boot
	cp $(KERNEL_TARGET_PATH) $(ROOTDIR)/boot/
        endif
	touch $@

xchain-kernel_install: $(STATEDIR)/xchain-kernel.install

$(STATEDIR)/xchain-kernel.install:
	touch $@


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

kernel_targetinstall: $(STATEDIR)/kernel.targetinstall

$(STATEDIR)/kernel.targetinstall: $(STATEDIR)/kernel.install
	@$(call targetinfo, kernel.targetinstall)
        ifneq (y, $(PTXCONF_DONT_COMPILE_KERNEL))
	mkdir -p $(ROOTDIR)/boot
        ifeq (y,$(PTXCONF_KERNEL_INSTALL))
	mkdir -p $(ROOTDIR)/boot
	install $(KERNEL_TARGET_PATH) $(ROOTDIR)/boot
	$(KERNEL_ENVIRONMENT) make -C $(KERNEL_DIR) modules_install INSTALL_MOD_PATH=$(ROOTDIR)
        endif # PTXCONF_KERNEL_INSTALL
        endif # PTXCONF_DONT_COMPILE_KERNEL
	touch $@

xchain-kernel_targetinstall: $(STATEDIR)/xchain-kernel.targetinstall

$(STATEDIR)/xchain-kernel.targetinstall:
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel_clean: rtai-patches_clean 
	rm -rf $(STATEDIR)/kernel.* $(KERNEL_DIR)

xchain-kernel_clean: 
	rm -fr $(STATEDIR)/xchain-kernel.*

rtai-patches_clean:
	rm -rf $(STATEDIR)/rtai-patches.* $(KERNEL_RTAIPATCH_DIR)

# vim: syntax=make
