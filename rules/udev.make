# -*-makefile-*-
#
# Copyright (C) 2005-2008 by Robert Schwebel
#               2012 by Michael Olbrich <m.olbrich@pengutronix.de>
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
ifdef PTXCONF_SYSTEMD
UDEV_VERSION	= $(SYSTEMD_VERSION)
UDEV		= $(SYSTEMD)
UDEV_LICENSE	= $(SYSTEMD_LICENSE)
else
ifdef PTXCONF_UDEV_LEGACY
UDEV_VERSION	:= 172
UDEV_MD5	:= bd122d04cf758441f498aad0169a454f
else
UDEV_VERSION	:= 182
UDEV_MD5	:= e31c83159b017e8ab0fa2f4bca758a41
endif
UDEV		:= udev-$(UDEV_VERSION)
UDEV_SUFFIX	:= tar.bz2
UDEV_URL	:= $(call ptx/mirror, KERNEL, utils/kernel/hotplug/$(UDEV).$(UDEV_SUFFIX))
UDEV_SOURCE	:= $(SRCDIR)/$(UDEV).$(UDEV_SUFFIX)
UDEV_DIR	:= $(BUILDDIR)/$(UDEV)
UDEV_LICENSE	:= GPL-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
UDEV_CONF_ENV := \
	$(CROSS_ENV) \
	CPPFLAGS="-I$(KERNEL_HEADERS_INCLUDE_DIR) $(CROSS_CPPFLAGS)"

UDEV_CONF_TOOL	:= autoconf
UDEV_CONF_OPT	:= \
	$(CROSS_AUTOCONF_ROOT) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-static \
	--enable-shared \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--$(call ptx/endis,PTXCONF_UDEV_DEBUG)-debug \
	--$(call ptx/endis,PTXCONF_UDEV_SYSLOG)-logging \
	--$(call ptx/endis,PTXCONF_UDEV_LIBGUDEV)-gudev \
	--disable-introspection \
	--$(call ptx/endis,PTXCONF_UDEV_KEYMAPS)-keymap \
	--$(call ptx/endis,PTXCONF_UDEV_PERSISTENT_GENERATOR)-rule_generator \
	--disable-floppy \
	--without-selinux \
	--with-usb-ids-path=/usr/share/usb.ids \
	--with-pci-ids-path=/usr/share/pci.ids$(call ptx/ifdef, PTXCONF_PCIUTILS_COMPRESS,.gz,) \
	--with-systemdsystemunitdir=/lib/systemd/system

ifdef PTXCONF_UDEV_LEGACY
UDEV_CONF_OPT += \
	--$(call ptx/endis,PTXCONF_UDEV_ACL)-udev_acl \
	--$(call ptx/endis,PTXCONF_UDEV_PERSISTENT_EDD)-edd \
	--libexecdir=/lib/udev \
	--enable-hwdb
else
UDEV_CONF_OPT += \
	--disable-manpages \
	--libexecdir=/lib \
	--with-rootprefix= \
	--with-rootlibdir=/lib \
	--$(call ptx/endis,PTXCONF_UDEV_MTD_PROBE)-mtd_probe
endif

endif # PTXCONF_SYSTEMD

UDEV_RULES-y := \
	50-udev-default.rules \
	60-persistent-alsa.rules \
	60-persistent-input.rules \
	60-persistent-storage-tape.rules \
	60-persistent-storage.rules \
	75-net-description.rules \
	78-sound-card.rules

UDEV_RULES-$(PTXCONF_UDEV_LEGACY) += \
	50-firmware.rules

ifndef PTXCONF_SYSTEMD
UDEV_RULES-y += \
	60-persistent-serial.rules \
	75-tty-description.rules \
	95-udev-late.rules
endif

UDEV_RULES-$(PTXCONF_SYSTEMD) += \
	60-block.rules \
	60-drm.rules \
	60-serial.rules \
	64-btrfs.rules \
	70-mouse.rules \
	80-net-setup-link.rules

UDEV_RULES-$(PTXCONF_SYSTEMD_LOGIND) += \
	70-power-switch.rules \
	70-uaccess.rules \
	71-seat.rules \
	73-seat-late.rules

UDEV_RULES-$(PTXCONF_SYSTEMD_VCONSOLE) += \
	90-vconsole.rules

UDEV_RULES-$(PTXCONF_UDEV_ACCELEROMETER)	+= 61-accelerometer.rules
ifdef PTXCONF_UDEV_LEGACY
UDEV_RULES-$(PTXCONF_UDEV_ACL)			+= 70-acl.rules
else
UDEV_RULES-$(PTXCONF_UDEV_ACL)			+= 70-udev-acl.rules
endif
UDEV_RULES-$(PTXCONF_UDEV_DRIVERS_RULES)	+= 80-drivers.rules
UDEV_RULES-$(PTXCONF_UDEV_HWDB)			+= 60-evdev.rules
UDEV_RULES-$(PTXCONF_UDEV_KEYMAPS)		+= 95-keyboard-force-release.rules
UDEV_RULES-$(PTXCONF_UDEV_KEYMAPS)		+= 95-keymap.rules
UDEV_RULES-$(PTXCONF_UDEV_MTD_PROBE)		+= 75-probe_mtd.rules
UDEV_RULES-$(PTXCONF_UDEV_PERSISTENT_CDROM)	+= 60-cdrom_id.rules
UDEV_RULES-$(PTXCONF_UDEV_PERSISTENT_EDD)	+= 61-persistent-storage-edd.rules
UDEV_RULES-$(PTXCONF_UDEV_PERSISTENT_GENERATOR)	+= 75-cd-aliases-generator.rules
UDEV_RULES-$(PTXCONF_UDEV_PERSISTENT_GENERATOR)	+= 75-persistent-net-generator.rules
UDEV_RULES-$(PTXCONF_UDEV_PERSISTENT_V4L)	+= 60-persistent-v4l.rules

UDEV_HELPER-$(PTXCONF_UDEV_ACCELEROMETER)		+= accelerometer
UDEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_ATA)		+= ata_id
UDEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_CDROM)		+= cdrom_id
UDEV_HELPER-$(PTXCONF_UDEV_COLLECT)			+= collect
UDEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_EDD)		+= edd_id
UDEV_HELPER-$(PTXCONF_UDEV_KEYMAPS)			+= findkeyboards
UDEV_HELPER-$(PTXCONF_UDEV_KEYMAPS)			+= keyboard-force-release.sh
UDEV_HELPER-$(PTXCONF_UDEV_KEYMAPS)			+= keymap
UDEV_HELPER-$(PTXCONF_UDEV_MTD_PROBE)			+= mtd_probe
UDEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_GENERATOR)	+= rule_generator.functions
UDEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_SCSI)		+= scsi_id
UDEV_HELPER-$(PTXCONF_UDEV_ACL)				+= udev-acl
UDEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_V4L)		+= v4l_id
UDEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_GENERATOR)	+= write_cd_rules
UDEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_GENERATOR)	+= write_net_rules

ifdef PTXCONF_UDEV_LEGACY
DEV_HELPER-$(PTXCONF_UDEV_LEGACY)			+= firmware
DEV_HELPER-$(PTXCONF_UDEV_LEGACY)			+= input_id
DEV_HELPER-$(PTXCONF_UDEV_LEGACY)			+= path_id
DEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_PCI)		+= pci-db
DEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_USB)		+= usb-db
DEV_HELPER-$(PTXCONF_UDEV_PERSISTENT_USB)		+= usb_id
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ifdef PTXCONF_SYSTEMD
$(STATEDIR)/systemd.prepare: $(STATEDIR)/udev.prepare
$(STATEDIR)/udev.install: $(STATEDIR)/systemd.install.post
$(STATEDIR)/udev.install.unpack: $(STATEDIR)/systemd.install.post
endif

$(STATEDIR)/udev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, udev)
	@$(call install_fixup, udev,PRIORITY,optional)
	@$(call install_fixup, udev,SECTION,base)
	@$(call install_fixup, udev,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, udev,DESCRIPTION,missing)

ifdef PTXCONF_UDEV_ETC_CONF
	@$(call install_alternative, udev, 0, 0, 0644, /etc/udev/udev.conf)
endif
ifdef PTXCONF_UDEV_HWDB
	@$(call install_copy, udev, 0, 0, 0644, -, /etc/udev/hwdb.bin)
endif

ifdef PTXCONF_UDEV_LEGACY
	@$(call install_copy, udev, 0, 0, 0755, -, /sbin/udevd)
	@$(call install_copy, udev, 0, 0, 0755, -, /sbin/udevadm)
else
ifdef PTXCONF_SYSTEMD
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/systemd/systemd-udevd)
	@$(call install_copy, udev, 0, 0, 0755, -, /bin/udevadm)
else
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/udevd)
	@$(call install_copy, udev, 0, 0, 0755, -, /bin/udevadm)
endif
endif

	@$(foreach rule, $(UDEV_RULES-y), \
		$(call install_copy, udev, 0, 0, 0644, -, \
			/lib/udev/rules.d/$(rule));)

ifdef PTXCONF_UDEV_KEYMAPS
	@cd $(UDEV_PKGDIR) && \
	for keymap in `find lib/udev/keymaps/ -type f`; do \
		$(call install_copy, udev, 0, 0, 0644, -, /$$keymap); \
	done
endif

ifdef PTXCONF_UDEV_CUST_RULES
	$(call install_alternative_tree, udev, 0, 0, /lib/udev/rules.d)
endif

	@$(foreach helper, $(UDEV_HELPER-y), \
		$(call install_copy, udev, 0, 0, 0755, -, \
			/lib/udev//$(helper));)

ifdef PTXCONF_UDEV_ACL
	@$(call install_link, udev, ../../udev/udev-acl, \
		/lib/ConsoleKit/run-seat.d/udev-acl.ck)
endif

ifdef PTXCONF_UDEV_LIBUDEV
	@$(call install_lib, udev, 0, 0, 0644, libudev)
endif

ifdef PTXCONF_UDEV_LIBGUDEV
	@$(call install_lib, udev, 0, 0, 0644, libgudev-1.0)
endif

ifdef PTXCONF_UDEV_STARTSCRIPT
ifdef PTXCONF_INITMETHOD_BBINIT
	@$(call install_alternative, udev, 0, 0, 0755, /etc/init.d/udev)

ifneq ($(call remove_quotes,$(PTXCONF_UDEV_BBINIT_LINK)),)
	@$(call install_link, udev, \
		../init.d/udev, \
		/etc/rc.d/$(PTXCONF_UDEV_BBINIT_LINK))
endif
endif
endif
	@$(call install_finish, udev)

	@$(call touch)

# vim: syntax=make
