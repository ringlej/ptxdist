# -*-makefile-*- 
# $Id: bootdisk.make,v 1.10 2003/08/12 08:20:12 robert Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_GRUB_BOOTDISK))
PACKAGES += bootdisk
endif

#
# Paths and names 
#

BOOTDISK			= rayonic-bootdisk-20030808-2
BOOTDISK_SOURCE			= $(SRCDIR)/$(BOOTDISK).tar.gz
BOOTDISK_URL			= http://www.pengutronix.de/software/ptxdist/temporary-src/$(BOOTDISK).tar.gz
BOOTDISK_DIR			= $(BUILDDIR)/$(BOOTDISK)
BOOTDISK_EXTRACT		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bootdisk_get: $(STATEDIR)/bootdisk.get

$(STATEDIR)/bootdisk.get: $(BOOTDISK_SOURCE)
	@$(call targetinfo, bootdisk.get)
	touch $@

$(BOOTDISK_SOURCE):
	@$(call targetinfo, $(BOOTDISK_SOURCE))
	@$(call get, $(BOOTDISK_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bootdisk_extract: $(STATEDIR)/bootdisk.extract

$(STATEDIR)/bootdisk.extract: $(STATEDIR)/bootdisk.get
	@$(call targetinfo, bootdisk.extract)
	@$(call clean, $(BOOTDISK_DIR))
	@$(call extract, $(BOOTDISK_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bootdisk_prepare: $(STATEDIR)/bootdisk.prepare

$(STATEDIR)/bootdisk.prepare: $(STATEDIR)/bootdisk.extract
	@$(call targetinfo, bootdisk.prepare)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bootdisk_compile: $(STATEDIR)/bootdisk.compile

$(STATEDIR)/bootdisk.compile: $(STATEDIR)/bootdisk.prepare 
	@$(call targetinfo, bootdisk.compile)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bootdisk_install: $(STATEDIR)/bootdisk.install

$(STATEDIR)/bootdisk.install: $(STATEDIR)/bootdisk.compile
	@$(call targetinfo, bootdisk.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bootdisk_targetinstall: $(STATEDIR)/bootdisk.targetinstall

bootdisk_targetinstall_deps =  $(STATEDIR)/bootdisk.install
bootdisk_targetinstall_deps += $(STATEDIR)/kernel.compile
bootdisk_targetinstall_deps += $(STATEDIR)/grub.compile
bootdisk_targetinstall_deps += $(STATEDIR)/e2fsprogs.compile
bootdisk_targetinstall_deps += $(STATEDIR)/ncurses.compile

$(STATEDIR)/bootdisk.targetinstall: $(bootdisk_targetinstall_deps)
	@$(call targetinfo, bootdisk.targetinstall)
	install $(KERNEL_TARGET_PATH) $(BOOTDISK_DIR)/boot/
	install $(GRUB_DIR)/stage1/stage1 $(BOOTDISK_DIR)/boot/grub/
	install $(GRUB_DIR)/stage2/stage2 $(BOOTDISK_DIR)/boot/grub/
	install $(GRUB_DIR)/grub/grub $(BOOTDISK_DIR)/bin/
	$(CROSSSTRIP) -R .notes -R .comment $(BOOTDISK_DIR)/bin/grub
	# FIXME: make this a config option
	ln -sf menu-disk.lst $(BOOTDISK_DIR)/boot/grub/menu.lst
	ln -sf menu.lst $(BOOTDISK_DIR)/boot/grub/grub.conf
	install $(E2FSPROGS_DIR)/misc/mke2fs $(BOOTDISK_DIR)/bin/
	$(CROSSSTRIP) -R .notes -R .comment $(BOOTDISK_DIR)/bin/mke2fs
	install $(NCURSES_DIR)/lib/libncurses.so.5.2 $(BOOTDISK_DIR)/lib/
	$(CROSSSTRIP) -S -R .note -R .comment $(BOOTDISK_DIR)/lib/libncurses.so.5.2
	# FIXME: is this the correct file for this rule? 
	install $(SRCDIR)/ptxflash $(BOOTDISK_DIR)/sbin/
	rm -fr $(BUILDDIR)/tmpboot && install -d $(BUILDDIR)/tmpboot
	cd $(BOOTDISK_DIR) && tar cf $(BUILDDIR)/tmpboot/bootdisk.tar *
	$(SUDO) sh -c \
		"GRUBPATH=$(BOOTDISK_DIR)/bin/; $(BOOTDISK_DIR)/sbin/mkbimage -d $(BUILDDIR)/tmpboot -f $(BUILDDIR)/tmpboot/bootdisk.tar -s ext2 -t 1.44"
	mv $(BUILDDIR)/tmpboot/1.44.image $(TOPDIR)/boot.image
	$(SUDO) rm -rf $(BUILDDIR)/tmpboot
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bootdisk_clean: 
	rm -rf $(STATEDIR)/bootdisk.* $(BOOTDISK_DIR)

# vim: syntax=make
