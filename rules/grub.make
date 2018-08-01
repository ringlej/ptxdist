# -*-makefile-*-
#
# Copyright (C) 2002-2009 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ARCH_X86)-$(PTXCONF_GRUB) += grub

#
# Paths and names
#
GRUB_VERSION		:= 0.97
GRUB_MD5		:= cd3f3eb54446be6003156158d51f4884
GRUB			:= grub-$(GRUB_VERSION)
GRUB_URL		:= ftp://alpha.gnu.org/gnu/grub/$(GRUB).tar.gz
GRUB_SOURCE		:= $(SRCDIR)/$(GRUB).tar.gz
GRUB_DIR		:= $(BUILDDIR)/$(GRUB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GRUB_PATH	:= PATH=$(CROSS_PATH)

# RSC: grub 0.93 decides to build without optimization when it detects
# non-standard CFLAGS. We can unset them here as grub is compiled
# standalone anyway (without Linux/glibc includes)

GRUB_ENV	:= $(CROSS_ENV) CFLAGS=''

GRUB_CFLAGS	:= -fgnu89-inline

GRUB_WRAPPER_BLACKLIST := \
	TARGET_HARDEN_STACK \
	TARGET_HARDEN_FORTIFY \
	TARGET_HARDEN_RELRO \
	TARGET_HARDEN_BINDNOW \
	TARGET_HARDEN_PIE \
	TARGET_DEBUG \
	TARGET_BUILD_ID

GRUB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-curses \
	--target=$(PTXCONF_GNU_TARGET) \
	--$(call ptx/endis, PTXCONF_GRUB_EXT2FS)-ext2fs \
	--$(call ptx/endis, PTXCONF_GRUB_FAT)-fat \
	--$(call ptx/endis, PTXCONF_GRUB_FFS)-ffs \
	--$(call ptx/endis, PTXCONF_GRUB_UFS2)-ufs2 \
	--$(call ptx/endis, PTXCONF_GRUB_MINIX)-minix \
	--$(call ptx/endis, PTXCONF_GRUB_REISERFS)-reiserfs \
	--$(call ptx/endis, PTXCONF_GRUB_VSTAFS)-vstafs \
	--$(call ptx/endis, PTXCONF_GRUB_JFS)-jfs \
	--$(call ptx/endis, PTXCONF_GRUB_XFS)-xfs \
	--$(call ptx/endis, PTXCONF_GRUB_ISO9660)-iso9660 \
	--$(call ptx/endis, PTXCONF_GRUB_GUNZIP)-gunzip \
	--$(call ptx/endis, PTXCONF_GRUB_MD5)-md5-password \
	--$(call ptx/endis, PTXCONF_GRUB_PACKET_RETRANSMISSION)-packet-retransmission \
	--$(call ptx/endis, PTXCONF_GRUB_PCI_DIRECT)-pci-direct \
	--$(call ptx/endis, PTXCONF_GRUB_3C509)-3c509 \
	--$(call ptx/endis, PTXCONF_GRUB_3C529)-3c529 \
	--$(call ptx/endis, PTXCONF_GRUB_3C595)-3c595 \
	--$(call ptx/endis, PTXCONF_GRUB_3C90X)-3c90x \
	--$(call ptx/endis, PTXCONF_GRUB_CS89X0)-cs89x0 \
	--$(call ptx/endis, PTXCONF_GRUB_DAVICOM)-davicom \
	--$(call ptx/endis, PTXCONF_GRUB_DEPCA)-depca \
	--$(call ptx/endis, PTXCONF_GRUB_EEPRO)-eepro \
	--$(call ptx/endis, PTXCONF_GRUB_EEPRO100)-eepro100 \
	--$(call ptx/endis, PTXCONF_GRUB_EPIC100)-epic100 \
	--$(call ptx/endis, PTXCONF_GRUB_3C507)-3c507 \
	--$(call ptx/endis, PTXCONF_GRUB_EXOS205)-exos205 \
	--$(call ptx/endis, PTXCONF_GRUB_NI5210)-ni5210 \
	--$(call ptx/endis, PTXCONF_GRUB_LANCE)-lance \
	--$(call ptx/endis, PTXCONF_GRUB_NE2100)-ne2100 \
	--$(call ptx/endis, PTXCONF_GRUB_NI6510)-ni6510 \
	--$(call ptx/endis, PTXCONF_GRUB_NATSEMI)-natsemi \
	--$(call ptx/endis, PTXCONF_GRUB_NI5010)-ni5010 \
	--$(call ptx/endis, PTXCONF_GRUB_3C503)-3c503 \
	--$(call ptx/endis, PTXCONF_GRUB_NE)-ne \
	--$(call ptx/endis, PTXCONF_GRUB_NS8390)-ns8390 \
	--$(call ptx/endis, PTXCONF_GRUB_WD)-wd \
	--$(call ptx/endis, PTXCONF_GRUB_OTULIP)-otulip \
	--$(call ptx/endis, PTXCONF_GRUB_RTL8139)-rtl8139 \
	--$(call ptx/endis, PTXCONF_GRUB_SIS900)-sis900 \
	--$(call ptx/endis, PTXCONF_GRUB_SK_G16)-sk-g16 \
	--$(call ptx/endis, PTXCONF_GRUB_SMC9000)-smc9000 \
	--$(call ptx/endis, PTXCONF_GRUB_TIARA)-tiara \
	--$(call ptx/endis, PTXCONF_GRUB_TULIP)-tulip \
	--$(call ptx/endis, PTXCONF_GRUB_VIA_RHINE)-via-rhine \
	--$(call ptx/endis, PTXCONF_GRUB_W89C840)-w89c840 \
	--$(call ptx/endis, PTXCONF_GRUB_3C503_SHMEM)-3c503-shmem \
	--$(call ptx/endis, PTXCONF_GRUB_3C503_AUI)-3c503-aui \
	--$(call ptx/endis, PTXCONF_GRUB_COMPEX_RL2000_FIX)-compex-rl2000-fix \
	--$(call ptx/endis, PTXCONF_GRUB_DISKLESS)-diskless \
	--$(call ptx/endis, PTXCONF_GRUB_HERCULES)-hercules \
	--$(call ptx/endis, PTXCONF_GRUB_SERIAL)-serial \
	--$(call ptx/endis, PTXCONF_GRUB_SERIAL_SPEED_SIMULATION)-serial-speed-simulation \
	--$(call ptx/endis, PTXCONF_GRUB_EXAMPLE_KERNEL)-example-kernel \
	--$(call ptx/endis, PTXCONF_GRUB_AUTO_LINUX_MEM_OPT)-auto-linux-mem-opt

ifneq ("$(PTXCONF_GRUB_SMC9000_SCAN)","")
GRUB_AUTOCONF += --enable-smc9000-scan=$(PTXCONF_GRUB_SMC9000_SCAN)
else
GRUB_AUTOCONF += --disable-smc9000-scan
endif

ifneq ($(strip $(call remove_quotes,$(PTXCONF_GRUB_NE_SCAN))),)
GRUB_AUTOCONF += --enable-ne-scan=$(PTXCONF_GRUB_NE_SCAN)
endif

ifneq ("$(PTXCONF_GRUB_WD_DEFAULT_MEM)","")
GRUB_AUTOCONF += --enable-wd-default-mem=$(PTXCONF_GRUB_WD_DEFAULT_MEM)
else
GRUB_AUTOCONF += --disable-wd-default-mem
endif

ifneq ("$(PTXCONF_GRUB_CS_SCAN)","")
GRUB_AUTOCONF += --enable-cs-scan=$(PTXCONF_GRUB_CS_SCAN)
else
GRUB_AUTOCONF += --disable-cs-scan
endif

ifneq ("$(PTXCONF_GRUB_PRESET_MENU)","")
GRUB_AUTOCONF += --enable-preset-menu=$(PTXCONF_GRUB_PRESET_MENU)
else
GRUB_AUTOCONF += --disable-preset-menu
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

_tmp := $(subst -, ,$(PTXCONF_GNU_TARGET))
GRUB_STAGE_DIR := $(GRUB_PKGDIR)/usr/lib/grub/$(patsubst i%86,i386,$(word 1,$(_tmp)))-$(word 2,$(_tmp))

GRUB_MENU_LST := $(call remove_quotes, $(PTXCONF_GRUB_MENU_LST))

$(STATEDIR)/grub.targetinstall:
	@$(call targetinfo)

	@$(call install_init, grub)
	@$(call install_fixup, grub,PRIORITY,optional)
	@$(call install_fixup, grub,SECTION,base)
	@$(call install_fixup, grub,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, grub,DESCRIPTION,missing)

	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/stage1, \
		/boot/grub/stage1, n)
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/stage2, \
		/boot/grub/stage2, n)

ifdef GRUB_MENU_LST
	@if [ -f $(PTXDIST_BOARDSETUP) ]; then \
		export ROOTDIR="$(ROOTDIR)"; \
		echo "sourcing boardsetup..."; \
		. $(PTXDIST_BOARDSETUP); \
	fi; \
	$(call install_copy, grub, 0, 0, 0644, $(GRUB_MENU_LST), \
		/boot/grub/menu.lst); \
	$(call install_replace, grub, /boot/grub/menu.lst, \
		@IPADDR@, $${PTXCONF_BOARDSETUP_TARGETIP}); \
	$(call install_replace, grub, /boot/grub/menu.lst, \
		@SERVERIP@, $${PTXCONF_BOARDSETUP_SERVERIP}); \
	$(call install_replace, grub, /boot/grub/menu.lst, \
		@NETMASK@, $${PTXCONF_BOARDSETUP_NETMASK}); \
	$(call install_replace, grub, /boot/grub/menu.lst, \
		@GATEWAY@, $${PTXCONF_BOARDSETUP_GATEWAY}); \
	$(call install_replace, grub, /boot/grub/menu.lst, \
		@TFTP_PATH@, $${PTXCONF_BOARDSETUP_TFTP_PATH}); \
	$(call install_replace, grub, /boot/grub/menu.lst, \
		@NFSROOT_PATH@, $${PTXCONF_BOARDSETUP_NFSROOT_PATH}); \
	$(call install_replace, grub, /boot/grub/menu.lst, \
		@ROOTDEV@, $(PTXCONF_GRUB_ROOTFS_DEVICE));
endif

ifdef PTXCONF_GRUB_ISO9660
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/iso9660_stage1_5, \
		/boot/grub/iso9660_stage1_5, n)
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/stage2_eltorito, \
		/boot/grub/stage2_eltorito, n)
endif

ifdef PTXCONF_GRUB_EXT2FS
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/e2fs_stage1_5, \
		/boot/grub/e2fs_stage1_5, n)
endif
ifdef PTXCONF_GRUB_FAT
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/fat_stage1_5, \
		/boot/grub/fat_stage1_5, n)
endif
ifdef PTXCONF_GRUB_FFS
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/ffs_stage1_5, \
		/boot/grub/ffs_stage1_5, n)
endif
ifdef PTXCONF_GRUB_JFS
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/jfs_stage1_5, \
		/boot/grub/jfs_stage1_5, n)
endif
ifdef PTXCONF_GRUB_MINIX
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/minix_stage1_5, \
		/boot/grub/minix_stage1_5, n)
endif
ifdef PTXCONF_GRUB_REISERFS
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/reiserfs_stage1_5, \
		/boot/grub/reiserfs_stage1_5, n)
endif
ifdef PTXCONF_GRUB_UFS2
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/ufs2_stage1_5, \
		/boot/grub/ufs2_stage1_5, n)
endif
ifdef PTXCONF_GRUB_VSTAFS
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/vstafs_stage1_5, \
		/boot/grub/vstafs_stage1_5, n)
endif
ifdef PTXCONF_GRUB_XFS
	@$(call install_copy, grub, 0, 0, 0644, \
		$(GRUB_STAGE_DIR)/xfs_stage1_5, \
		/boot/grub/xfs_stage1_5, n)
endif

	@$(call install_copy, grub, 0, 0, 0755, -, /usr/sbin/grub)
	@$(call install_copy, grub, 0, 0, 0755, -, \
		/usr/sbin/grub-set-default, n)
ifdef PTXCONF_GRUB_DISKLESS
	@$(call install_copy, grub, 0, 0, 0755, \
		$(GRUB_STAGE_DIR)/nbgrub, \
		/usr/sbin/nbgrub, n)
	@$(call install_copy, grub, 0, 0, 0755, \
		$(GRUB_STAGE_DIR)/pxegrub, \
		/usr/sbin/pxegrub, n)
endif

	@$(call install_finish, grub)

	@$(call touch)

# vim: syntax=make
