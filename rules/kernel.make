# -*-makefile-*-
# $Id: kernel.make,v 1.7 2003/09/19 14:43:27 robert Exp $
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
ifndef PTXCONF_DONT_COMPILE_KERNEL
PACKAGES += kernel
endif

#
# Paths and names 
#
# FIXME: make extraversion configurable and add this into a predefined
# scheme!
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
KERNEL_RMKPATCH_EXTRACT	= bzip2 -dc

KERNEL_PXAPATCH 	= diff-2.4.18-rmk7-pxa3
KERNEL_PXAPATCH_URL 	= ftp://ftp.arm.linux.org.uk/pub/armlinux/people/nico/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_EXTRACT = gzip -dc

KERNEL_PTXPATCH		= patch-2.4.18-rmk7-ptx3
KERNEL_PTXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_URL	= http://www.pengutronix.de/software/dnp/patch-2.4.18-rmk7-ptx3
KERNEL_PTXPATCH_EXTRACT	= cat

ifeq (y, $(PTXCONF_RTAI_ALLSOFT))
KERNEL_RTAIPATCH	= patch-2.4.18-allsoft
endif
ifeq (y, $(PTXCONF_RTAI_RTHAL))
KERNEL_RTAIPATCH	= patch-2.4.18-rthal5g
endif
KERNEL_RTAIPATCH_DIR	= $(BUILDDIR)/rtai-patches
endif

# -----

ifeq (y,$(PTXCONF_KERNEL_2_4_19))
KERNEL			= linux-2.4.19
KERNEL_URL		= ftp://ftp.rfc822.org/pub/linux/kernel/v2.4/$(KERNEL).tar.bz2 
KERNEL_SOURCE		= $(SRCDIR)/$(KERNEL).tar.bz2
KERNEL_DIR		= $(BUILDDIR)/$(KERNEL)
KERNEL_EXTRACT 		= bzip2 -dc

KERNEL_RMKPATCH		= patch-2.4.19-rmk7
KERNEL_RMKPATCH_URL	= ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/v2.4/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_EXTRACT	= bzip2 -dc

KERNEL_PXAPATCH 	= diff-2.4.19-rmk7-pxa2
KERNEL_PXAPATCH_URL 	= ftp://ftp.arm.linux.org.uk/pub/armlinux/people/nico/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_EXTRACT = gzip -dc

KERNEL_MTDPATCH		= linux-2.4.19-rmk7-pxa2-mtd20030728.diff
KERNEL_MTDPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_MTDPATCH).bz2
KERNEL_MTDPATCH_URL	= http://www.pengutronix.de/software/linux-arm/$(KERNEL_MTDPATCH).bz2
KERNEL_MTDPATCH_DIR	= $(BUILDDIR)/$(KERNEL)
KERNEL_MTDPATCH_EXTRACT	= bzip2 -cd

KERNEL_PTXPATCH		= linux-2.4.19-rmk7-pxa2-ptx7.diff
KERNEL_PTXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_URL	= http://www.pengutronix.de/software/linux-arm/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_EXTRACT	= cat

KERNEL_LTTPATCH		= linux-2.4.19-rmk7-pxa2-ptx7-ltt1.diff
KERNEL_LTTPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_LTTPATCH)
KERNEL_LTTPATCH_URL	= http://www.pengutronix.de/software/ltt/$(KERNEL_LTTPATCH)
KERNEL_LTTPATCH_EXTRACT = cat

ifeq (y, $(PTXCONF_RTAI_ALLSOFT))
KERNEL_RTAIPATCH	= patch-2.4.19-allsoft
endif
ifeq (y, $(PTXCONF_RTAI_RTHAL))
KERNEL_RTAIPATCH	= patch-2.4.19-rthal5g
endif
KERNEL_RTAIPATCH_DIR	= $(BUILDDIR)/rtai-patches
endif

# -----

ifeq (y,$(PTXCONF_KERNEL_2_4_20))
KERNEL			= linux-2.4.20
KERNEL_URL		= ftp://ftp.rfc822.org/pub/linux/kernel/v2.4/$(KERNEL).tar.bz2 
KERNEL_SOURCE		= $(SRCDIR)/$(KERNEL).tar.bz2
KERNEL_DIR		= $(BUILDDIR)/$(KERNEL)
KERNEL_EXTRACT 		= bzip2 -dc

#FIXME: find right patch // not yet available
KERNEL_RMKPATCH		= patch-2.4.19-rmk4
KERNEL_RMKPATCH_URL	= ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/v2.4/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_EXTRACT	= bzip2 -dc

#FIXME: find right patch // not yet available
KERNEL_PXAPATCH 	= diff-2.4.19-rmk4-pxa1
KERNEL_PXAPATCH_URL 	= ftp://ftp.arm.linux.org.uk/pub/armlinux/people/nico/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_SOURCE	= $(SRCDIR22)/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_EXTRACT = gzip -dc

#FIXME: find right patch // not yet available
KERNEL_PTXPATCH		= linux-2.4.19-rmk4-pxa1-ptx10.diff
KERNEL_PTXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_URL	= http://www.pengutronix.de/software/linux-arm/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_EXTRACT	= cat

ifeq (y, $(PTXCONF_RTAI_ALLSOFT))
KERNEL_RTAIPATCH	= patch-2.4.20-allsoft
endif
ifeq (y, $(PTXCONF_RTAI_RTHAL))
KERNEL_RTAIPATCH	= patch-2.4.20-rthal5g
endif
KERNEL_RTAIPATCH_DIR	= $(BUILDDIR)/rtai-patches
endif

# -----

ifeq (y,$(PTXCONF_KERNEL_2_4_21))
KERNEL			= linux-2.4.21
KERNEL_URL		= ftp://ftp.rfc822.org/pub/linux/kernel/v2.4/$(KERNEL).tar.bz2 
KERNEL_SOURCE		= $(SRCDIR)/$(KERNEL).tar.bz2
KERNEL_DIR		= $(BUILDDIR)/$(KERNEL)
KERNEL_EXTRACT 		= bzip2 -dc

#FIXME: find right patch // not yet available
KERNEL_RMKPATCH		= patch-2.4.19-rmk4
KERNEL_RMKPATCH_URL	= ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/v2.4/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_EXTRACT	= bzip2 -dc

#FIXME: find right patch // not yet available
KERNEL_PXAPATCH 	= diff-2.4.19-rmk4-pxa1
KERNEL_PXAPATCH_URL 	= ftp://ftp.arm.linux.org.uk/pub/armlinux/people/nico/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_EXTRACT = gzip -dc

#FIXME: find right patch // not yet available
KERNEL_PTXPATCH		= linux-2.4.19-rmk4-pxa1-ptx10.diff
KERNEL_PTXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_URL	= http://www.pengutronix.de/software/linux-arm/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_EXTRACT	= cat

KERNEL_UCLINUXPATCH		= uClinux-2.4.21-uc0.diff.gz
KERNEL_UCLINUXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_UCLINUXPATCH)
KERNEL_UCLINUXPATCH_URL		= http://www.uclinux.org/pub/uClinux/uClinux-2.4.x/$(KERNEL_UCLINUXPATCH)
KERNEL_UCLINUXPATCH_EXTRACT	= zcat

ifeq (y, $(PTXCONF_RTAI_ALLSOFT))
KERNEL_RTAIPATCH	= patch-2.4.21-allsoft
endif
ifeq (y, $(PTXCONF_RTAI_RTHAL))
KERNEL_RTAIPATCH	= patch-2.4.21-rthal5g
endif
KERNEL_RTAIPATCH_DIR	= $(BUILDDIR)/rtai-patches
endif

# -----

ifeq (y,$(PTXCONF_KERNEL_2_4_22))
KERNEL			= linux-2.4.22
KERNEL_URL		= ftp://ftp.rfc822.org/pub/linux/kernel/v2.4/$(KERNEL).tar.bz2 
KERNEL_SOURCE		= $(SRCDIR)/$(KERNEL).tar.bz2
KERNEL_DIR		= $(BUILDDIR)/$(KERNEL)
KERNEL_EXTRACT 		= bzip2 -dc

#FIXME: find right patch // not yet available
KERNEL_RMKPATCH		= patch-2.4.19-rmk4
KERNEL_RMKPATCH_URL	= ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/v2.4/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_RMKPATCH).bz2
KERNEL_RMKPATCH_EXTRACT	= bzip2 -dc

#FIXME: find right patch // not yet available
KERNEL_PXAPATCH 	= diff-2.4.19-rmk4-pxa1
KERNEL_PXAPATCH_URL 	= ftp://ftp.arm.linux.org.uk/pub/armlinux/people/nico/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PXAPATCH).gz
KERNEL_PXAPATCH_EXTRACT = gzip -dc

#FIXME: find right patch // not yet available
KERNEL_PTXPATCH		= linux-2.4.19-rmk4-pxa1-ptx10.diff
KERNEL_PTXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_URL	= http://www.pengutronix.de/software/linux-arm/$(KERNEL_PTXPATCH)
KERNEL_PTXPATCH_EXTRACT	= cat

#FIXME: find right patch // not yet available
KERNEL_UCLINUXPATCH		= uClinux-2.4.21-uc0.diff.gz
KERNEL_UCLINUXPATCH_SOURCE	= $(SRCDIR)/$(KERNEL_UCLINUXPATCH)
KERNEL_UCLINUXPATCH_URL		= http://www.uclinux.org/pub/uClinux/uClinux-2.4.x/$(KERNEL_UCLINUXPATCH)
KERNEL_UCLINUXPATCH_EXTRACT	= zcat

ifeq (y, $(PTXCONF_RTAI_ALLSOFT))
KERNEL_RTAIPATCH	= patch-2.4.22-allsoft
endif
ifeq (y, $(PTXCONF_RTAI_RTHAL))
KERNEL_RTAIPATCH	= patch-2.4.22-rthal5g
endif
KERNEL_RTAIPATCH_DIR	= $(BUILDDIR)/rtai-patches
endif

# -----

ifeq (y, $(PTXCONF_KERNEL_IMAGE_Z))
KERNEL_TARGET		= zImage
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/zImage
endif
ifeq (y, $(PTXCONF_KERNEL_IMAGE_BZ))
KERNEL_TARGET		= bzImage
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/arch/$(PTXCONF_ARCH)/boot/bzImage
endif
ifeq (y, $(PTXCONF_KERNEL_IMAGE_U))
KERNEL_TARGET		= uImage
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/uImage
endif
ifeq (y, $(PTXCONF_KERNEL_IMAGE_VMLINUX))
KERNEL_TARGET		= vmlinux
KERNEL_TARGET_PATH	= $(KERNEL_DIR)/vmlinux
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

kernel_get: $(STATEDIR)/kernel.get

kernel_get_deps =  $(KERNEL_SOURCE)

ifdef PTXCONF_ARCH_NOMMU
kernel_get_deps += $(KERNEL_UCLINUXPATCH_SOURCE)
endif
ifdef PTXCONF_ARCH_ARM
kernel_get_deps += $(KERNEL_RMKPATCH_SOURCE)
endif
ifdef PTXCONF_KERNEL_XSCALE
kernel_get_deps += $(KERNEL_PXAPATCH_SOURCE)
endif
ifdef PTXCONF_KERNEL_XSCALE_PTX
kernel_get_deps += $(KERNEL_MTDPATCH_SOURCE)
kernel_get_deps += $(KERNEL_PTXPATCH_SOURCE)
endif
ifdef PTXCONF_LTT
kernel_get_deps += $(KERNEL_LTTPATCH_SOURCE)
endif

$(STATEDIR)/kernel.get: $(kernel_get_deps)
	@$(call targetinfo, kernel.get)
	touch $@

$(KERNEL_SOURCE):
	@$(call targetinfo, $(KERNEL_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_URL)

$(KERNEL_RMKPATCH_SOURCE):
	@$(call targetinfo, $(KERNEL_RMKPATCH_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_RMKPATCH_URL)

$(KERNEL_PXAPATCH_SOURCE):
	@$(call targetinfo, $(KERNEL_PXAPATCH_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_PXAPATCH_URL)

$(KERNEL_MTDPATCH_SOURCE):
	@$(call targetinfo, $(KERNEL_MTDPATCH_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_MTDPATCH_URL)

$(KERNEL_PTXPATCH_SOURCE):
	@$(call targetinfo, $(KERNEL_PTXPATCH_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_PTXPATCH_URL)

$(KERNEL_LTTPATCH_SOURCE):
	@$(call targetinfo, $(KERNEL_LTTPATCH_SOURCE))
	wget -P $(SRCDIR) $(PASSIVEFTP) $(KERNEL_LTTPATCH_URL)

$(KERNEL_UCLINUXPATCH_SOURCE):
	@$(call targetinfo, $(KERNEL_UCLINUXPATCH_SOURCE))
	@$(call get, $(KERNEL_UCLINUXPATCH_URL)

#
# RTAI patches are included in the normal RTAI packet
# 
rtai-patches_get: $(STATEDIR)/rtai-patches.get

$(STATEDIR)/rtai-patches.get: $(STATEDIR)/rtai.get
	@$(call targetinfo, rtai-patches.get)
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
	@$(call clean, $(KERNEL_DIR))
	@$(call extract, $(KERNEL_SOURCE))
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
	cd $(KERNEL_DIR) &&                                             \
		$(KERNEL_MTDPATCH_EXTRACT) $(KERNEL_MTDPATCH_SOURCE) |	\
		patch -p1
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
# 	# patch for mmu-less architectures
#	#
        ifdef PTXCONF_ARCH_NOMMU
	cd $(KERNEL_DIR) && \
		$(KERNEL_UCLINUXPATCH_EXTRACT) $(KERNEL_UCLINUXPATCH_SOURCE) | \
		patch -p1 || true
        endif
#	#
#	# patches for all architectures
#	#
        ifeq (y, $(PTXCONF_RTAI))
	cd $(KERNEL_DIR) && 						 \
		patch -p1 < $(KERNEL_RTAIPATCH_DIR)/$(RTAI)/patches/$(KERNEL_RTAIPATCH)
        endif
#	#
#	# LTT patch
#	#
        ifeq (y, $(PTXCONF_LTT))
	cd $(KERNEL_DIR) &&						\
		$(KERNEL_LTTPATCH_EXTRACT) $(KERNEL_LTTPATCH_SOURCE) |	\
		patch -p1 
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

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

kernel_prepare: $(STATEDIR)/kernel.prepare

kernel_prepare_deps =  $(STATEDIR)/kernel.extract
kernel_prepare_deps += $(STATEDIR)/virtual-xchain.install
ifdef PTXCONF_RTAI
kernel_prepare_deps += $(STATEDIR)/rtai-patches.extract
endif

KERNEL_PATH	= PATH=$(CROSS_PATH)
KERNEL_MAKEVARS	= ARCH=$(PTXCONF_ARCH) CROSS_COMPILE=$(PTXCONF_GNU_TARGET)- HOSTCC=$(HOSTCC)

$(STATEDIR)/kernel.prepare: $(kernel_prepare_deps)
	@$(call targetinfo, kernel.prepare)

	test -f $(TOPDIR)/config/kernel/$(PTXCONF_KERNEL_CONFIG) && \
		install -m 644 $(TOPDIR)/config/kernel/$(PTXCONF_KERNEL_CONFIG) \
		$(KERNEL_DIR)/.config

	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		oldconfig
	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		dep

	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

kernel_compile: $(STATEDIR)/kernel.compile

kernel_compile_deps =  $(STATEDIR)/kernel.prepare
ifdef PTXCONF_KERNEL_IMAGE_U
kernel_compile_deps += $(STATEDIR)/umkimage.install
endif

$(STATEDIR)/kernel.compile: $(kernel_compile_deps)
	@$(call targetinfo, kernel.compile)
	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		$(KERNEL_TARGET) modules
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

kernel_install: $(STATEDIR)/kernel.install

$(STATEDIR)/kernel.install: $(STATEDIR)/kernel.compile
	@$(call targetinfo, kernel.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

kernel_targetinstall: $(STATEDIR)/kernel.targetinstall

$(STATEDIR)/kernel.targetinstall: $(STATEDIR)/kernel.install
	@$(call targetinfo, kernel.targetinstall)
        ifeq (y,$(PTXCONF_KERNEL_INSTALL))
	mkdir -p $(ROOTDIR)/boot
	install $(KERNEL_TARGET_PATH) $(ROOTDIR)/boot
	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		modules_install INSTALL_MOD_PATH=$(ROOTDIR)
        endif # PTXCONF_KERNEL_INSTALL
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

kernel_clean: rtai-patches_clean 
	rm -rf $(STATEDIR)/kernel.* $(KERNEL_DIR)

rtai-patches_clean:
	rm -rf $(STATEDIR)/rtai-patches.* $(KERNEL_RTAIPATCH_DIR)

kernel_menuconfig: $(STATEDIR)/kernel.extract
	if test -f $(TOPDIR)/config/kernel/$(PTXCONF_KERNEL_CONFIG) ; then \
		install -m 644 $(TOPDIR)/config/kernel/$(PTXCONF_KERNEL_CONFIG) \
			$(KERNEL_DIR)/.config ; \
	fi

	$(KERNEL_PATH) make -C $(KERNEL_DIR) $(KERNEL_MAKEVARS) \
		menuconfig

	install -m 644 $(KERNEL_DIR)/.config \
		$(TOPDIR)/config/kernel/$(PTXCONF_KERNEL_CONFIG) ; \
	[ -f $(STATEDIR)/kernel.compile ] && rm $(STATEDIR)/kernel.compile

# vim: syntax=make
