# -*-makefile-*-
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
ifndef PTXCONF_UDEV_EXPERIMENTAL
UDEV_VERSION	:= 162
else
UDEV_VERSION	:= 167
endif
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

#
# autoconf
#
UDEV_AUTOCONF := \
	$(CROSS_AUTOCONF_ROOT) \
	--libexecdir=/lib/udev \
	\
	--disable-introspection \
	--enable-shared

ifdef PTXCONF_PCIUTILS_COMPRESS
UDEV_AUTOCONF += --with-pci-ids-path=/usr/share/pci.ids.gz
else
UDEV_AUTOCONF += --with-pci-ids-path=/usr/share/pci.ids
endif

ifdef PTXCONF_UDEV_DEBUG
UDEV_AUTOCONF	+= --enable-debug
else
UDEV_AUTOCONF	+= --disable-debug
endif

ifdef PTXCONF_UDEV_LIBGUDEV
UDEV_AUTOCONF	+= --enable-gudev
else
UDEV_AUTOCONF	+= --disable-gudev
endif

ifeq ($(PTXCONF_ARCH_ARM)-$(PTXCONF_UDEV_EXTRA_HID2HCI),-y)
UDEV_AUTOCONF	+= --enable-bluetooth
else
UDEV_AUTOCONF	+= --disable-bluetooth
endif

ifdef PTXCONF_UDEV_EXTRA_KEYMAP
UDEV_AUTOCONF	+= --enable-keymap
else
UDEV_AUTOCONF	+= --disable-keymap
endif

ifdef PTXCONF_UDEV_EXTRA_UDEV_ACL
UDEV_AUTOCONF	+= --enable-acl
else
UDEV_AUTOCONF	+= --disable-acl
endif

ifdef PTXCONF_UDEV_EXTRA_USB_DB
UDEV_AUTOCONF	+= --enable-usbdb
else
UDEV_AUTOCONF	+= --disable-usbdb
endif

ifdef PTXCONF_UDEV_EXTRA_PCI_DB
UDEV_AUTOCONF	+= --enable-pcidb
else
UDEV_AUTOCONF	+= --disable-pcidb
endif

ifdef PTXCONF_UDEV_EXTRA_MOBILE_ACTION_MODESWITCH
UDEV_AUTOCONF	+= --enable-mobile-action-modeswitch
else
UDEV_AUTOCONF	+= --disable-mobile-action-modeswitch
endif

ifdef PTXCONF_UDEV_SELINUX
UDEV_AUTOCONF	+= --with-selinux
else
UDEV_AUTOCONF	+= --without-selinux
endif

ifdef PTXCONF_UDEV_SYSLOG
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
	@$(call install_fixup, udev,PRIORITY,optional)
	@$(call install_fixup, udev,SECTION,base)
	@$(call install_fixup, udev,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, udev,DESCRIPTION,missing)

#	#
#	# binaries
#	#

	@$(call install_copy, udev, 0, 0, 0755, -, /sbin/udevd)
	@$(call install_copy, udev, 0, 0, 0755, -, /sbin/udevadm)

#	#
#	# default rules
#	#

# install everything apart of drivers rule.
ifdef PTXCONF_UDEV_DEFAULT_RULES
	@for rule in \
			50-udev-default.rules \
			60-persistent-alsa.rules \
			60-persistent-input.rules \
			60-persistent-serial.rules \
			60-persistent-storage-tape.rules \
			60-persistent-storage.rules \
			95-udev-late.rules; \
			do \
		$(call install_copy, udev, 0, 0, 0644, -, \
			/lib/udev/rules.d/$$rule); \
	done
ifdef PTXCONF_UDEV_EXTRA_USB_DB
ifdef PTXCONF_UDEV_EXTRA_PCI_DB
	@for rule in \
			75-net-description.rules \
			75-tty-description.rules \
			78-sound-card.rules; \
			do \
		$(call install_copy, udev, 0, 0, 0644, -, \
			/lib/udev/rules.d/$$rule); \
	done
endif
endif
endif

# install drivers rules.
ifdef PTXCONF_UDEV_DEFAULT_DRIVERS_RULES
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/80-drivers.rules)
endif

# install default keymaps.
ifdef PTXCONF_UDEV_DEFAULT_KEYMAPS
	@cd $(UDEV_PKGDIR)/lib/udev/keymaps; \
	for file in `find . -type f`; do \
		$(call install_copy, udev, 0, 0, 0644, \
			$(UDEV_PKGDIR)/lib/udev/keymaps/$$file, \
			/lib/udev/keymaps/$$file, n); \
	done
endif

ifdef PTXCONF_UDEV_CUST_RULES
	@if [ -d $(PTXDIST_WORKSPACE)/projectroot/lib/udev/rules.d/ ]; then \
		cd $(PTXDIST_WORKSPACE)/projectroot/lib/udev/rules.d/; \
		for file in `find . -type f`; do \
			$(call install_copy, udev, 0, 0, 0644, \
				$(PTXDIST_WORKSPACE)/projectroot/lib/udev/rules.d/$$file, \
				/lib/udev/rules.d/$$file, n); \
		done; \
	else \
		echo "UDEV_CUST_RULES is enabled but Directory containing" \
			"customized udev rules is missing!"; \
		exit 1; \
	fi
endif

#	#
#	# startup script
#	#
ifdef PTXCONF_UDEV_STARTSCRIPT
ifdef PTXCONF_INITMETHOD_BBINIT
	@$(call install_alternative, udev, 0, 0, 0755, /etc/init.d/udev)

ifneq ($(call remove_quotes,$(PTXCONF_UDEV_BBINIT_LINK)),)
	@$(call install_link, udev, \
		../init.d/udev, \
		/etc/rc.d/$(PTXCONF_UDEV_BBINIT_LINK))
endif
endif
ifdef PTXCONF_INITMETHOD_UPSTART
	@$(call install_alternative, udev, 0, 0, 0644, /etc/init/udev.conf)
	@$(call install_alternative, udev, 0, 0, 0644, /etc/init/udevmonitor.conf)
	@$(call install_alternative, udev, 0, 0, 0644, /etc/init/udevtrigger.conf)
	@$(call install_alternative, udev, 0, 0, 0644, /etc/init/udev-finish.conf)
endif
endif


#	#
#	# Install a configuration on demand only
#	#
ifdef PTXCONF_UDEV_ETC_CONF
	@$(call install_alternative, udev, 0, 0, 0644, /etc/udev/udev.conf)
endif

#	#
#	# utilities from extra/
#	#
ifdef PTXCONF_UDEV_EXTRA_ATA_ID
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/ata_id)
endif

ifdef PTXCONF_UDEV_EXTRA_CDROM_ID
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/cdrom_id)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/60-cdrom_id.rules,n)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/75-cd-aliases-generator.rules,n)
endif

ifdef PTXCONF_UDEV_EXTRA_COLLECT
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/collect)
endif

ifdef PTXCONF_UDEV_EXTRA_EDD_ID
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/edd_id)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/61-persistent-storage-edd.rules,n)
endif

ifdef PTXCONF_UDEV_EXTRA_FINDKEYBOARDS
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/findkeyboards)
endif

ifdef PTXCONF_UDEV_EXTRA_FIRMWARE
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/firmware)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/50-firmware.rules,n)
endif

ifdef PTXCONF_UDEV_EXTRA_FLOPPY
	@$(call install_copy, udev, 0, 0, 0755, -, \
		/lib/udev/create_floppy_devices)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/60-floppy.rules)
endif

ifdef PTXCONF_UDEV_EXTRA_FSTAB_IMPORT
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/fstab_import)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/79-fstab_import.rules)
endif

ifndef PTXCONF_ARCH_ARM
ifdef PTXCONF_UDEV_EXTRA_HID2HCI
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/hid2hci)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/70-hid2hci.rules,n)
endif
endif

ifdef PTXCONF_UDEV_EXTRA_INPUT_ID
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/input_id)
endif

ifdef PTXCONF_UDEV_EXTRA_KEYBOARD_FORCE_RELEASE
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/keyboard-force-release.sh, n)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/95-keyboard-force-release.rules,n)
endif

ifdef PTXCONF_UDEV_EXTRA_KEYMAP
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/keymap)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/95-keymap.rules,n)
endif

ifdef PTXCONF_UDEV_EXTRA_MOBILE_ACTION_MODESWITCH
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/mobile-action-modeswitch)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/61-mobile-action.rules)
endif

ifdef PTXCONF_UDEV_EXTRA_PATH_ID
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/path_id)
endif

ifdef PTXCONF_UDEV_EXTRA_PCI_DB
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/pci-db)
endif

ifdef PTXCONF_UDEV_EXTRA_RULE_GENERATOR
	@$(call install_copy, udev, 0, 0, 0755, -, \
		/lib/udev/rule_generator.functions)
endif

ifdef PTXCONF_UDEV_EXTRA_SCSI_ID
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/scsi_id)
endif

ifdef PTXCONF_UDEV_EXTRA_UDEV_ACL
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/udev-acl)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/70-acl.rules,n)
	@$(call install_link, udev, ../../udev/udev-acl, \
		/lib/ConsoleKit/run-seat.d/udev-acl.ck)
endif

ifdef PTXCONF_UDEV_EXTRA_USB_DB
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/usb-db)
endif

ifdef PTXCONF_UDEV_EXTRA_USB_ID
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/usb_id)
endif

ifdef PTXCONF_UDEV_EXTRA_V4L_ID
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev/v4l_id)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/60-persistent-v4l.rules,n)
endif

ifdef PTXCONF_UDEV_EXTRA_WRITE_CD_RULES
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev//write_cd_rules)
endif

ifdef PTXCONF_UDEV_EXTRA_WRITE_NET_RULES
	@$(call install_copy, udev, 0, 0, 0755, -, /lib/udev//write_net_rules)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/75-net-description.rules,n)
	@$(call install_copy, udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/75-persistent-net-generator.rules,n)
endif

ifdef PTXCONF_UDEV_LIBUDEV
	@$(call install_lib, udev, 0, 0, 0644, libudev)
endif

ifdef PTXCONF_UDEV_LIBGUDEV
	@$(call install_lib, udev, 0, 0, 0644, libgudev-1.0)
endif
	@$(call install_finish, udev)

	@$(call touch)

# vim: syntax=make
