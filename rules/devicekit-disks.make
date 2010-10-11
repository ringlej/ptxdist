# -*-makefile-*-
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DEVICEKIT_DISKS) += devicekit-disks

#
# Paths and names
#
DEVICEKIT_DISKS_VERSION	:= 009
DEVICEKIT_DISKS		:= DeviceKit-disks-$(DEVICEKIT_DISKS_VERSION)
DEVICEKIT_DISKS_SUFFIX	:= tar.gz
DEVICEKIT_DISKS_URL	:= http://hal.freedesktop.org/releases/$(DEVICEKIT_DISKS).$(DEVICEKIT_DISKS_SUFFIX)
DEVICEKIT_DISKS_SOURCE	:= $(SRCDIR)/$(DEVICEKIT_DISKS).$(DEVICEKIT_DISKS_SUFFIX)
DEVICEKIT_DISKS_DIR	:= $(BUILDDIR)/$(DEVICEKIT_DISKS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DEVICEKIT_DISKS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-shared \
	--enable-static \
	--disable-ansi \
	--disable-man-pages \
	--disable-gtk-doc \
	--with-gnu-ld \
	--disable-sgutils2 \
	--disable-libparted \
	--disable-devmapper \
	--disable-libatasmart

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/devicekit-disks.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  devicekit-disks)
	@$(call install_fixup, devicekit-disks,PRIORITY,optional)
	@$(call install_fixup, devicekit-disks,SECTION,base)
	@$(call install_fixup, devicekit-disks,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, devicekit-disks,DESCRIPTION,missing)

	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/bin/devkit-disks)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/sbin/umount.devkit)

	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/libexec/devkit-disks-daemon)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/libexec/devkit-disks-helper-change-filesystem-label)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/libexec/devkit-disks-helper-change-luks-password)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/libexec/devkit-disks-helper-drive-poll)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/libexec/devkit-disks-helper-fstab-mounter)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/libexec/devkit-disks-helper-linux-md-check)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/libexec/devkit-disks-helper-linux-md-remove-component)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, -, \
		/usr/libexec/devkit-disks-helper-mkfs)

	@$(call install_copy, devicekit-disks, 0, 0, 0644, -, \
		/lib/udev/rules.d/95-devkit-disks.rules)

	@$(call install_copy, devicekit-disks, 0, 0, 0644, -, \
		/etc/dbus-1/system.d/org.freedesktop.DeviceKit.Disks.conf)
	@$(call install_copy, devicekit-disks, 0, 0, 0644, -, \
		/usr/share/dbus-1/interfaces/org.freedesktop.DeviceKit.Disks.xml)
	@$(call install_copy, devicekit-disks, 0, 0, 0644, -, \
		/usr/share/dbus-1/interfaces/org.freedesktop.DeviceKit.Disks.Device.xml)
	@$(call install_copy, devicekit-disks, 0, 0, 0644, -, \
		/usr/share/dbus-1/system-services/org.freedesktop.DeviceKit.Disks.service)

	@$(call install_copy, devicekit-disks, 0, 0, 0644, -, \
		/usr/share/polkit-1/actions/org.freedesktop.devicekit.disks.policy)
	@$(call install_copy, devicekit-disks, 0, 0, 0644, -, \
		/usr/lib/polkit-1/extensions/libdevkit-disks-action-lookup.so)

ifdef PTXCONF_DEVICEKIT_DISKS_FAKE_OVERLAYFS
	@$(call install_copy, devicekit-disks, 0, 0, 0755, /var/tmp/media)
	@$(call install_link, devicekit-disks, var/tmp/media, /media)
	@$(call install_link, devicekit-disks, ../tmp/DeviceKit-disks, \
		/var/lib/DeviceKit-disks)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, \
		/var/tmp/DeviceKit-disks)
else
	@$(call install_copy, devicekit-disks, 0, 0, 0755, /media)
	@$(call install_copy, devicekit-disks, 0, 0, 0755, \
		/var/lib/DeviceKit-disks)
endif
	@$(call install_copy, devicekit-disks, 0, 0, 0755, \
		/var/run/DeviceKit-disks)

	@$(call install_finish, devicekit-disks)

	@$(call touch)

# vim: syntax=make
