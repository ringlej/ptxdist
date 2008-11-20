# -*-makefile-*-
# $Id: udev.make,v 1.15 2007/03/07 14:34:52 michl Exp $
#
# Copyright (C) 2005-2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UDEV) += udev

#
# Paths and names
#
UDEV_VERSION	:= 133
UDEV		:= udev-$(UDEV_VERSION)
UDEV_SUFFIX	:= tar.bz2
UDEV_SOURCE	:= $(SRCDIR)/$(UDEV).$(UDEV_SUFFIX)
UDEV_DIR	:= $(BUILDDIR)/$(UDEV)

UDEV_URL := \
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/$(UDEV).$(UDEV_SUFFIX) \
	http://www.eu.kernel.org/pub/linux/utils/kernel/hotplug/$(UDEV).$(UDEV_SUFFIX) \
	http://www.us.kernel.org/pub/linux/utils/kernel/hotplug/$(UDEV).$(UDEV_SUFFIX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(UDEV_SOURCE):
	@$(call targetinfo)
	@$(call get, UDEV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UDEV_PATH	:= PATH=$(CROSS_PATH)
UDEV_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
UDEV_AUTOCONF = \
	$(CROSS_AUTOCONF_ROOT) \
	--enable-shared

ifdef PTXCONF_UDEV__DEBUG
UDEV_AUTOCONF	+= --enable-debug
else
UDEV_AUTOCONF	+= --disable-debug
endif

ifdef PTXCONF_UDEV__SELINUX
UDEV_AUTOCONF	+= --enable-selinux
else
UDEV_AUTOCONF	+= --disable-selinux
endif

ifdef PTXCONF_UDEV__SYSLOG
UDEV_AUTOCONF	+= --enable-logging
else
UDEV_AUTOCONF	+= --disable-logging
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/udev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, udev)
	@$(call install_fixup, udev,PACKAGE,udev)
	@$(call install_fixup, udev,PRIORITY,optional)
	@$(call install_fixup, udev,VERSION,$(UDEV_VERSION))
	@$(call install_fixup, udev,SECTION,base)
	@$(call install_fixup, udev,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, udev,DEPENDS,)
	@$(call install_fixup, udev,DESCRIPTION,missing)

	#
	# binaries
	#

	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udev/udevd, \
		/sbin/udevd)
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udev/udevadm, \
		/sbin/udevadm)
ifdef PTXCONF_UDEV__INSTALL_TEST_UDEV
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udev/test-udev, \
		/sbin/test-udev)
endif

	#
	# default rules
	#

ifdef PTXCONF_ROOTFS_UDEV__DEFAULT_RULES
	cd $(UDEV_DIR)/rules/rules.d; \
	for file in *; do \
		$(call install_copy, udev, 0, 0, 0644, $(UDEV_DIR)/rules/rules.d/$$file, /lib/udev/rules.d/$$file, n); \
	done
	$(call install_copy, udev, 0, 0, 0644, \
		$(UDEV_DIR)/rules/packages/40-alsa.rules, \
		/lib/udev/rules.d/40-alsa.rules, n);
	$(call install_copy, udev, 0, 0, 0644, \
		$(UDEV_DIR)/rules/packages/40-isdn.rules, \
		/lib/udev/rules.d/40-isdn.rules, n);
	$(call install_copy, udev, 0, 0, 0644, \
		$(UDEV_DIR)/rules/packages/64-device-mapper.rules, \
		/lib/udev/rules.d/64-device-mapper.rules, n);
	$(call install_copy, udev, 0, 0, 0644, \
		$(UDEV_DIR)/rules/packages/64-md-raid.rules, \
		/lib/udev/rules.d/64-md-raid.rules, n);
endif


#
# startup scripts
#
ifdef PTXCONF_UDEV__INSTALL_ETC_INITD_UDEV_DEFAULT
	@$(call install_copy, udev, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/udev, \
		/etc/init.d/udev, n)
endif

ifdef PTXCONF_UDEV__INSTALL_ETC_INITD_UDEV_USER
	@$(call install_copy, udev, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/udev, \
		/etc/init.d/udev, n)
endif

ifneq ($(PTXCONF_UDEV__RC_D_LINK),"")
	@$(call install_copy, udev, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, udev, ../init.d/udev, \
		/etc/rc.d/$(PTXCONF_UDEV__RC_D_LINK))
endif


#
# Install a configuration on demand only
#
# use generic
ifdef PTXCONF_ROOTFS_ETC_UDEV__CONF_DEFAULT
	@$(call install_copy, udev, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/udev/udev.conf, \
		/etc/udev/udev.conf, n)
	@$(call install_copy, udev, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/udev/permissions.rules, \
		/etc/udev/permissions.rules, n)
endif

# user defined
ifdef PTXCONF_ROOTFS_ETC_UDEV__CONF_USER
	@$(call install_copy, udev, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/udev/udev.conf, \
		/etc/udev/udev.conf, n)
	@$(call install_copy, udev, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/udev/permissions.rules, \
		/etc/udev/permissions.rules, n)
endif

#
# utilities from extra/
#
ifdef PTXCONF_UDEV__EXTRA_ATA_ID
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/ata_id/ata_id, \
		/lib/udev/ata_id)
endif

ifdef PTXCONF_UDEV__EXTRA_CDROM_ID
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/cdrom_id/cdrom_id, \
		/lib/udev/cdrom_id)
endif

ifdef PTXCONF_UDEV__EXTRA_COLLECT
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/collect/collect, \
		/lib/udev/collect)
endif

ifdef PTXCONF_UDEV__EXTRA_EDD_ID
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/edd_id/edd_id, \
		/lib/udev/edd_id)
endif

ifdef PTXCONF_UDEV__EXTRA_FIRMWARE
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/firmware/firmware.sh, \
		/lib/udev/firmware.sh,n)
endif

ifdef PTXCONF_UDEV__EXTRA_FLOPPY
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/floppy/create_floppy_devices, \
		/lib/udev/create_floppy_devices)
endif

ifdef PTXCONF_UDEV__EXTRA_FSTAB_IMPORT
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/fstab_import/fstab_import, \
		/lib/udev/fstab_import)
endif

ifdef PTXCONF_UDEV__EXTRA_PATH_ID
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/path_id/path_id, \
		/lib/udev/path_id)
endif

ifdef PTXCONF_UDEV__EXTRA_RULE_GENERATOR
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/rule_generator/rule_generator.functions, \
		/lib/udev/rule_generator.functions)
endif

ifdef PTXCONF_UDEV__EXTRA_SCSI_ID
	@$(call install_copy, udev, 0, 0, 0644, \
		$(UDEV_DIR)/extras/scsi_id/scsi_id.config, \
		/etc/scsi_id.config, n)
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/scsi_id/scsi_id, \
		/lib/udev/scsi_id, n)
endif

ifdef PTXCONF_UDEV__EXTRA_USB_ID
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/usb_id/usb_id, \
		/lib/udev/usb_id)
endif

ifdef PTXCONF_UDEV__EXTRA_VOLUME_ID
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/volume_id/vol_id, \
		/lib/udev/vol_id)

	@$(call install_copy, udev, 0, 0, 0644, \
		$(UDEV_DIR)/extras/volume_id/lib/.libs/libvolume_id.so.1.0.5, \
		/lib/libvolume_id.so.1.0.5)
	@$(call install_link, udev, libvolume_id.so.1.0.5, /lib/libvolume_id.so.1)
	@$(call install_link, udev, libvolume_id.so.1.0.5, /lib/libvolume_id.so)
endif

	@$(call install_finish, udev)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

udev_clean:
	rm -rf $(STATEDIR)/udev.*
	rm -rf $(PKGDIR)/udev_*
	rm -rf $(UDEV_DIR)

# vim: syntax=make
