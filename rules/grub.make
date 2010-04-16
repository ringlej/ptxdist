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
GRUB			:= grub-$(GRUB_VERSION)
GRUB_URL		:= ftp://alpha.gnu.org/gnu/grub/$(GRUB).tar.gz
GRUB_SOURCE		:= $(SRCDIR)/$(GRUB).tar.gz
GRUB_DIR		:= $(BUILDDIR)/$(GRUB)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(GRUB_SOURCE):
	@$(call targetinfo)
	@$(call get, GRUB)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

GRUB_PATH	:= PATH=$(CROSS_PATH)

# RSC: grub 0.93 decides to build without optimization when it detects
# non-standard CFLAGS. We can unset them here as grub is compiled
# standalone anyway (without Linux/glibc includes)

GRUB_ENV	:= $(CROSS_ENV) CFLAGS=''

GRUB_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--without-curses \
	--target=$(PTXCONF_GNU_TARGET)

ifdef PTXCONF_GRUB_EXT2FS
GRUB_AUTOCONF += --enable-ext2fs
else
GRUB_AUTOCONF += --disable-ext2fs
endif

ifdef PTXCONF_GRUB_FAT
GRUB_AUTOCONF += --enable-fat
else
GRUB_AUTOCONF += --disable-fat
endif

ifdef PTXCONF_GRUB_FFS
GRUB_AUTOCONF += --enable-ffs
else
GRUB_AUTOCONF += --disable-ffs
endif

ifdef PTXCONF_GRUB_UFS2
GRUB_AUTOCONF += --enable-ufs2
else
GRUB_AUTOCONF += --disable-ufs2
endif

ifdef PTXCONF_GRUB_MINIX
GRUB_AUTOCONF += --enable-minix
else
GRUB_AUTOCONF += --disable-minix
endif

ifdef PTXCONF_GRUB_REISERFS
GRUB_AUTOCONF += --enable-reiserfs
else
GRUB_AUTOCONF += --disable-reiserfs
endif

ifdef PTXCONF_GRUB_VSTAFS
GRUB_AUTOCONF += --enable-vstafs
else
GRUB_AUTOCONF += --disable-vstafs
endif

ifdef PTXCONF_GRUB_JFS
GRUB_AUTOCONF += --enable-jfs
else
GRUB_AUTOCONF += --disable-jfs
endif

ifdef PTXCONF_GRUB_XFS
GRUB_AUTOCONF += --enable-xfs
else
GRUB_AUTOCONF += --disable-xfs
endif

ifdef PTXCONF_GRUB_ISO9660
GRUB_AUTOCONF += --enable-iso9660
else
GRUB_AUTOCONF += --disable-iso9660
endif

ifdef PTXCONF_GRUB_GUNZIP
GRUB_AUTOCONF += --enable-gunzip
else
GRUB_AUTOCONF += --disable-gunzip
endif

ifdef PTXCONF_GRUB_MD5
GRUB_AUTOCONF += --enable-md5-password
else
GRUB_AUTOCONF += --disable-md5-password
endif

ifdef PTXCONF_GRUB_PACKET_RETRANSMISSION
GRUB_AUTOCONF += --enable-packet-retransmission
else
GRUB_AUTOCONF += --disable-packet-retransmission
endif

ifdef PTXCONF_GRUB_PCI_DIRECT
GRUB_AUTOCONF += --enable-pci-direct
else
GRUB_AUTOCONF += --disable-pci-direct
endif

ifdef PTXCONF_GRUB_3C509
GRUB_AUTOCONF += --enable-3c509
else
GRUB_AUTOCONF += --disable-3c509
endif

ifdef PTXCONF_GRUB_3C529
GRUB_AUTOCONF += --enable-3c529
else
GRUB_AUTOCONF += --disable-3c529
endif

ifdef PTXCONF_GRUB_3C595
GRUB_AUTOCONF += --enable-3c595
else
GRUB_AUTOCONF += --disable-3c595
endif

ifdef PTXCONF_GRUB_3C90X
GRUB_AUTOCONF += --enable-3c90x
else
GRUB_AUTOCONF += --disable-3c90x
endif

ifdef PTXCONF_GRUB_CS89X0
GRUB_AUTOCONF += --enable-cs89x0
else
GRUB_AUTOCONF += --disable-cs89x0
endif

ifdef PTXCONF_GRUB_DAVICOM
GRUB_AUTOCONF += --enable-davicom
else
GRUB_AUTOCONF += --disable-davicom
endif

ifdef PTXCONF_GRUB_DEPCA
GRUB_AUTOCONF += --enable-depca
else
GRUB_AUTOCONF += --disable-depca
endif

ifdef PTXCONF_GRUB_EEPRO
GRUB_AUTOCONF += --enable-eepro
else
GRUB_AUTOCONF += --disable-eepro
endif

ifdef PTXCONF_GRUB_EEPRO100
GRUB_AUTOCONF += --enable-eepro100
else
GRUB_AUTOCONF += --disable-eepro100
endif

ifdef PTXCONF_GRUB_EPIC100
GRUB_AUTOCONF += --enable-epic100
else
GRUB_AUTOCONF += --disable-epic100
endif

ifdef PTXCONF_GRUB_3C507
GRUB_AUTOCONF += --enable-3c507
else
GRUB_AUTOCONF += --disable-3c507
endif

ifdef PTXCONF_GRUB_EXOS205
GRUB_AUTOCONF += --enable-exos205
else
GRUB_AUTOCONF += --disable-exos205
endif

ifdef PTXCONF_GRUB_NI5210
GRUB_AUTOCONF += --enable-ni5210
else
GRUB_AUTOCONF += --disable-ni5210
endif

ifdef PTXCONF_GRUB_LANCE
GRUB_AUTOCONF += --enable-lance
else
GRUB_AUTOCONF += --disable-lance
endif

ifdef PTXCONF_GRUB_NE2100
GRUB_AUTOCONF += --enable-ne2100
else
GRUB_AUTOCONF += --disable-ne2100
endif

ifdef PTXCONF_GRUB_NI6510
GRUB_AUTOCONF += --enable-ni6510
else
GRUB_AUTOCONF += --disable-ni6510
endif

ifdef PTXCONF_GRUB_NATSEMI
GRUB_AUTOCONF += --enable-natsemi
else
GRUB_AUTOCONF += --disable-natsemi
endif

ifdef PTXCONF_GRUB_NI5010
GRUB_AUTOCONF += --enable-ni5010
else
GRUB_AUTOCONF += --disable-ni5010
endif

ifdef PTXCONF_GRUB_3C503
GRUB_AUTOCONF += --enable-3c503
else
GRUB_AUTOCONF += --disable-3c503
endif

ifdef PTXCONF_GRUB_NE
GRUB_AUTOCONF += --enable-ne
else
GRUB_AUTOCONF += --disable-ne
endif

ifdef PTXCONF_GRUB_NS8390
GRUB_AUTOCONF += --enable-ns8390
else
GRUB_AUTOCONF += --disable-ns8390
endif

ifdef PTXCONF_GRUB_WD
GRUB_AUTOCONF += --enable-wd
else
GRUB_AUTOCONF += --disable-wd
endif

ifdef PTXCONF_GRUB_OTULIP
GRUB_AUTOCONF += --enable-otulip
else
GRUB_AUTOCONF += --disable-otulip
endif

ifdef PTXCONF_GRUB_RTL8139
GRUB_AUTOCONF += --enable-rtl8139
else
GRUB_AUTOCONF += --disable-rtl8139
endif

ifdef PTXCONF_GRUB_SIS900
GRUB_AUTOCONF += --enable-sis900
else
GRUB_AUTOCONF += --disable-sis900
endif

ifdef PTXCONF_GRUB_SK_G16
GRUB_AUTOCONF += --enable-sk-g16
else
GRUB_AUTOCONF += --disable-sk-g16
endif

ifdef PTXCONF_GRUB_SMC9000
GRUB_AUTOCONF += --enable-smc9000
else
GRUB_AUTOCONF += --disable-smc9000
endif

ifdef PTXCONF_GRUB_TIARA
GRUB_AUTOCONF += --enable-tiara
else
GRUB_AUTOCONF += --disable-tiara
endif

ifdef PTXCONF_GRUB_TULIP
GRUB_AUTOCONF += --enable-tulip
else
GRUB_AUTOCONF += --disable-tulip
endif

ifdef PTXCONF_GRUB_VIA_RHINE
GRUB_AUTOCONF += --enable-via-rhine
else
GRUB_AUTOCONF += --disable-via-rhine
endif

ifdef PTXCONF_GRUB_W89C840
GRUB_AUTOCONF += --enable-w89c840
else
GRUB_AUTOCONF += --disable-w89c840
endif

ifdef PTXCONF_GRUB_3C503_SHMEM
GRUB_AUTOCONF += --enable-3c503-shmem
else
GRUB_AUTOCONF += --disable-3c503-shmem
endif

ifdef PTXCONF_GRUB_3C503_AUI
GRUB_AUTOCONF += --enable-3c503-aui
else
GRUB_AUTOCONF += --disable-3c503-aui
endif

ifdef PTXCONF_GRUB_COMPEX_RL2000_FIX
GRUB_AUTOCONF += --enable-compex-rl2000-fix
else
GRUB_AUTOCONF += --disable-compex-rl2000-fix
endif

ifneq ("$(PTXCONF_GRUB_SMC9000_SCAN)","")
GRUB_AUTOCONF += --enable-smc9000-scan=$(PTXCONF_GRUB_SMC9000_SCAN)
else
GRUB_AUTOCONF += --disable-smc9000-scan
endif

ifneq ($(strip $(call remove_quotes $(PTXCONF_GRUB_NE_SCAN))),)
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

ifdef PTXCONF_GRUB_DISKLESS
GRUB_AUTOCONF += --enable-diskless
else
GRUB_AUTOCONF += --disable-diskless
endif

ifdef PTXCONF_GRUB_HERCULES
GRUB_AUTOCONF += --enable-hercules
else
GRUB_AUTOCONF += --disable-hercules
endif

ifdef PTXCONF_GRUB_SERIAL
GRUB_AUTOCONF += --enable-serial
else
GRUB_AUTOCONF += --disable-serial
endif

ifdef PTXCONF_GRUB_SERIAL_SPEED_SIMULATION
GRUB_AUTOCONF += --enable-serial-speed-simulation
else
GRUB_AUTOCONF += --disable-serial-speed-simulation
endif

ifneq ("$(PTXCONF_GRUB_PRESET_MENU)","")
GRUB_AUTOCONF += --enable-preset-menu=$(PTXCONF_GRUB_PRESET_MENU)
else
GRUB_AUTOCONF += --disable-preset-menu
endif

ifdef PTXCONF_GRUB_EXAMPLE_KERNEL
GRUB_AUTOCONF += --enable-example-kernel
else
GRUB_AUTOCONF += --disable-example-kernel
endif

ifdef PTXCONF_GRUB_AUTO_LINUX_MEM_OPT
GRUB_AUTOCONF += --enable-auto-linux-mem-opt
else
GRUB_AUTOCONF += --disable-auto-linux-mem-opt
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
	@$(call install_fixup, grub,PACKAGE,grub)
	@$(call install_fixup, grub,PRIORITY,optional)
	@$(call install_fixup, grub,VERSION,$(GRUB_VERSION))
	@$(call install_fixup, grub,SECTION,base)
	@$(call install_fixup, grub,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, grub,DEPENDS,)
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
