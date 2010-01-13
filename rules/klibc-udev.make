# -*-makefile-*-
#
# Copyright (C) 2009 by Jon Ringle <jon@ringle.org>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_KLIBC_UDEV) += klibc-udev

#
# Paths and names
#
KLIBC_UDEV	= klibc-$(UDEV)
KLIBC_UDEV_DIR	= $(KLIBC_BUILDDIR)/$(UDEV)

ifdef PTXCONF_KLIBC_UDEV
$(STATEDIR)/klibc.targetinstall.post: $(STATEDIR)/klibc-udev.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-udev.get: $(STATEDIR)/udev.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-udev.extract:
	@$(call targetinfo)
	@$(call clean, $(KLIBC_UDEV_DIR))
	@$(call extract, UDEV, $(KLIBC_BUILDDIR))
	@$(call patchin, KLIBC_UDEV, $(KLIBC_UDEV_DIR))
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

KLIBC_UDEV_PATH	:= PATH=$(KLIBC_PATH)
KLIBC_UDEV_ENV 	:= \
	$(KLIBC_ENV) \
	ac_cv_lib_c_inotify_init=yes

#
# autoconf
#
KLIBC_UDEV_AUTOCONF := \
	$(KLIBC_AUTOCONF) \
	--disable-dependency-tracking \
	--enable-shared

ifdef PTXCONF_KLIBC_UDEV_DEBUG
KLIBC_UDEV_AUTOCONF	+= --enable-debug
else
KLIBC_UDEV_AUTOCONF	+= --disable-debug
endif

ifdef PTXCONF_KLIBC_UDEV_SELINUX
KLIBC_UDEV_AUTOCONF	+= --with-selinux
else
KLIBC_UDEV_AUTOCONF	+= --without-selinux
endif

ifdef PTXCONF_KLIBC_UDEV_SYSLOG
KLIBC_UDEV_AUTOCONF	+= --enable-logging
else
KLIBC_UDEV_AUTOCONF	+= --disable-logging
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/klibc-udev.targetinstall:
	@$(call targetinfo)

#	#
#	# binaries
#	#
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /sbin/udevd);
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /sbin/udevadm);
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, /etc/udev);
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, /lib/udev);
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, /lib/udev/rules.d);
ifdef PTXCONF_KLIBC_UDEV_INSTALL_TEST_UDEV
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, $(KLIBC_UDEV_DIR)/udev/test-udev, \
		/sbin/test-udev);
endif

#	#
#	# default rules
#	#
# install everything apart of drivers rule.
ifdef PTXCONF_KLIBC_UDEV_DEFAULT_RULES
	@cd $(KLIBC_UDEV_DIR)/rules/rules.d; \
	for file in `find . -type f ! -name "*drivers*"`; do \
		$(call install_initramfs, klibc-udev, 0, 0, 0644, \
			$(KLIBC_UDEV_DIR)/rules/rules.d/$$file, \
			/lib/udev/rules.d/$$file); \
	done
endif

ifdef PTXCONF_KLIBC_UDEV_COMMON_RULES
#
# these rules are not installed by default
#
	@$(call install_initramfs, klibc-udev, 0, 0, 0644, \
		$(KLIBC_UDEV_DIR)/rules/packages/40-alsa.rules, \
		/lib/udev/rules.d/40-alsa.rules);
	@$(call install_initramfs, klibc-udev, 0, 0, 0644, \
		$(KLIBC_UDEV_DIR)/rules/packages/40-isdn.rules, \
		/lib/udev/rules.d/40-isdn.rules);
	@$(call install_initramfs, klibc-udev, 0, 0, 0644, \
		$(KLIBC_UDEV_DIR)/rules/packages/64-device-mapper.rules, \
		/lib/udev/rules.d/64-device-mapper.rules);
	@$(call install_initramfs, klibc-udev, 0, 0, 0644, \
		$(KLIBC_UDEV_DIR)/rules/packages/64-md-raid.rules, \
		/lib/udev/rules.d/64-md-raid.rules);
endif

ifdef PTXCONF_KLIBC_UDEV_CUST_RULES
	@if [ -d $(PTXDIST_WORKSPACE)/initramfs/lib/udev/rules.d/ ]; then \
		cd $(PTXDIST_WORKSPACE)/initramfs/lib/udev/rules.d/; \
		for file in `find . -type f`; do \
			$(call install_initramfs, klibc-udev, 0, 0, 0644, \
				$(PTXDIST_WORKSPACE)/initramfs/lib/udev/rules.d/$$file, \
				/lib/udev/rules.d/$$file); \
		done; \
	else \
		echo "KLIBC_UDEV_CUST_RULES is enabled but Directory containing" \
			"customized udev rules is missing!"; \
		exit 1; \
	fi
endif

#	#
#	# Install a configuration on demand only
#	#
ifdef PTXCONF_KLIBC_UDEV_ETC_CONF
	@$(call install_initramfs_alt, klibc-udev, 0, 0, 0644, /etc/udev/udev.conf);
endif

#	#
#	# utilities from extra/
#	#
ifdef PTXCONF_KLIBC_UDEV_EXTRA_ATA_ID
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/ata_id);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_CDROM_ID
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/cdrom_id);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_COLLECT
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/collect);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_EDD_ID
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/edd_id);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_FIRMWARE
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/firmware.sh);
	@$(call install_initramfs, klibc-udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/50-firmware.rules,n);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_FLOPPY
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, \
		/lib/udev/create_floppy_devices);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_FSTAB_IMPORT
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/fstab_import);
	@$(call install_initramfs, klibc-udev, 0, 0, 0644, -, \
		/lib/udev/rules.d/79-fstab_import.rules);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_PATH_ID
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/path_id);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_RULE_GENERATOR
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, \
		/lib/udev/rule_generator.functions);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_SCSI_ID
	@$(call install_initramfs, klibc-udev, 0, 0, 0644, -, /etc/scsi_id.config);
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/scsi_id);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_USB_ID
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/usb_id);
endif

ifdef PTXCONF_KLIBC_UDEV_EXTRA_VOLUME_ID
	@$(call install_initramfs, klibc-udev, 0, 0, 0755, -, /lib/udev/vol_id);

	@$(call install_initramfs, klibc-udev, 0, 0, 0644, -, /lib/libvolume_id.so.1.1.0);
	@$(call install_initramfs_link, klibc-udev, libvolume_id.so.1.1.0, /lib/libvolume_id.so.1);
	@$(call install_initramfs_link, klibc-udev, libvolume_id.so.1.1.0, /lib/libvolume_id.so);
endif

ifdef PTXCONF_KLIBC_UDEV_LIBUDEV
	@$(call install_initramfs, klibc-udev, 0, 0, 0644, -, /lib/libudev.so.0.1.0);
	@$(call install_initramfs_link, klibc-udev, libudev.so.0.1.0, /lib/libudev.so.0);
	@$(call install_initramfs_link, klibc-udev, libudev.so.0.1.0, /lib/libudev.so);
endif

	@$(call touch)

# vim: syntax=make
