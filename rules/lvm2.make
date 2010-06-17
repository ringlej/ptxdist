# -*-makefile-*-
#
# Copyright (C) 2010 by Bart vdr. Meulen <bartvdrmeulen@gmail.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LVM2) += lvm2

#
# Paths and names
#
LVM2_VERSION	:= 2.02.53
LVM2		:= LVM2.$(LVM2_VERSION)
LVM2_SUFFIX	:= tgz
LVM2_URL	:= \
	ftp://sources.redhat.com/pub/lvm2/$(LVM2).$(LVM2_SUFFIX) \
	ftp://sources.redhat.com/pub/lvm2/old/$(LVM2).$(LVM2_SUFFIX)
LVM2_SOURCE	:= $(SRCDIR)/$(LVM2).$(LVM2_SUFFIX)
LVM2_DIR	:= $(BUILDDIR)/$(LVM2)
LVM2_LICENSE	:= GPLv2

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LVM2_SOURCE):
	@$(call targetinfo)
	@$(call get, LVM2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LVM2_ENV := \
	$(CROSS_ENV) \
	CFLAGS="$(CROSS_CFLAGS) $(CROSS_CPPFLAGS)" \
	ac_cv_path_MODPROBE_CMD="/sbin/modprobe"

#
# autoconf
#
LVM2_CONF_TOOL	:= autoconf
LVM2_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--with-device-uid=$(PTXCONF_LVM2_DEVICE_UID) \
	--with-device-gid=$(PTXCONF_LVM2_DEVICE_GID) \
	--with-device-mode=$(PTXCONF_LVM2_DEVICE_MODE)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lvm2.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  lvm2)
	@$(call install_fixup, lvm2,PACKAGE,lvm2)
	@$(call install_fixup, lvm2,PRIORITY,optional)
	@$(call install_fixup, lvm2,VERSION,$(LVM2_VERSION))
	@$(call install_fixup, lvm2,SECTION,base)
	@$(call install_fixup, lvm2,AUTHOR,"Bart vdr. Meulen <bartvdrmeulen@gmail.com>")
	@$(call install_fixup, lvm2,DEPENDS,)
	@$(call install_fixup, lvm2,DESCRIPTION,missing)

	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/dmsetup)
	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/fsadm)
	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/lvmdump)
	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/vgimportclone)

	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/sbin/lvm)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvchange)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvconvert)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvcreate)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvdisplay)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvextend)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvmchange)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvmdiskscan)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvmsadc)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvmsar)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvreduce)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvremove)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvrename)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvresize)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvs)
	@$(call install_link, lvm2, lvm, /usr/sbin/lvscan)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvchange)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvck)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvcreate)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvdisplay)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvmove)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvremove)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvresize)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvs)
	@$(call install_link, lvm2, lvm, /usr/sbin/pvscan)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgcfgbackup)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgcfgrestore)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgchange)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgck)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgconvert)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgcreate)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgdisplay)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgexport)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgextend)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgimport)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgmerge)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgmknodes)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgreduce)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgremove)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgrename)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgs)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgscan)
	@$(call install_link, lvm2, lvm, /usr/sbin/vgsplit)

	@$(call install_alternative, lvm2, 0, 0, 0644, /etc/lvm/lvm.conf)

	@$(call install_copy, lvm2, 0, 0, 0755, -, /usr/lib/libdevmapper.so.1.02)
	@$(call install_link, lvm2, libdevmapper.so.1.02, /usr/lib/libdevmapper.so)

ifdef PTXCONF_LVM2_STARTSCRIPT
	@$(call install_alternative, lvm2, 0, 0, 0755, /etc/init.d/lvm2)
endif

	@$(call install_finish, lvm2)

	@$(call touch)

# vim: syntax=make
