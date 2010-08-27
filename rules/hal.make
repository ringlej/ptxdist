# -*-makefile-*-
#
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
PACKAGES-$(PTXCONF_HAL) += hal

#
# Paths and names
#
HAL_VERSION	:= 0.5.14
HAL		:= hal-$(HAL_VERSION)
HAL_SUFFIX	:= tar.bz2
HAL_URL		:= http://hal.freedesktop.org/releases/$(HAL).$(HAL_SUFFIX)
HAL_SOURCE	:= $(SRCDIR)/$(HAL).$(HAL_SUFFIX)
HAL_DIR		:= $(BUILDDIR)/$(HAL)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(HAL_SOURCE):
	@$(call targetinfo)
	@$(call get, HAL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HAL_PATH	:= PATH=$(CROSS_PATH)

# hack alert ... we set the policy validator to always-ok
HAL_ENV 	:= \
	$(CROSS_ENV) \
	ac_cv_prog_POLKIT_POLICY_FILE_VALIDATE=/bin/true

#
# autoconf
#
HAL_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared \
	--enable-static \
	--disable-pci-ids \
	--disable-usb-ids \
	--disable-pnp-ids \
	--disable-ansi \
	--disable-verbose-mode \
	--disable-docbook-docs \
	--disable-man-pages \
	--disable-gtk-doc \
	--disable-acpi-acpid \
	--disable-acpi-proc \
	--disable-acpi-ibm \
	--disable-acpi-toshiba \
	--disable-parted \
	--disable-usb \
	--disable-smbios \
	--disable-acl-management \
	--disable-umount-helper \
	--disable-acpi \
	--disable-apm \
	--disable-pmu \
	--disable-pci \
	--disable-sonypic \
	--without-keymaps \
	--without-imac \
	--with-hal-user=haldaemon \
	--with-hal-group=haldaemon

ifdef PTXCONF_HAL_POLKIT
HAL_AUTOCONF += --enable-policy-kit --enable-console-kit
else
HAL_AUTOCONF += --disable-policy-kit --disable-console-kit
endif

#  --with-os-type=<os>     Distribution or OS (redhat)
#  --with-pid-file=<file>  PID file for HAL daemon
#  --with-hwdata=<dir>     Where PCI and USB IDs are found
#  --with-pci-ids=<dir>    Where PCI IDs are found (overrides --with-hwdata)
#  --with-usb-ids=<dir>    Where USB IDs are found (overrides --with-hwdata)
#  --with-socket-dir=<dir> Location of the HAL D-BUS listening sockets (auto)
#  --with-eject=<path>     Specify eject program. (default /usr/bin/eject)
#  --with-html-dir=PATH    path to installed docs
#  --with-expat=<dir>      Use expat from here
#  --without-libpci        Compile without pci support
#  --with-backend=<name>   backend to use (linux/solaris/freebsd/dummy)
#  --with-deprecated-keys  Add fdi-file to support deprecated/removed keys
#  --with-dbus-sys=<dir>   where D-BUS system.d directory is
#  --with-macbookpro       Whether to build Macbook Pro utils (auto)
#  --with-macbook          Include support for Macbook backlight (auto)
#  --with-omap             Whether to build OMAP utils (auto)
#  --with-cpufreq          Whether to build cpufreq utils (auto)
#  --with-usb-csr          Whether to build addon for wireless USB mice (auto)
#  --with-dell-backlight   Whether to build Dell backlight support (auto)
#  --with-linux-input-header=<path>
#  --with-socket-dir=<dir> Location of the HAL D-BUS listening sockets (auto)
#                          Use an given Linux input.h rather than that
#                          installed on the system (<linux/input.h>)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/hal.targetinstall:
	@$(call targetinfo)

	@$(call install_init, hal)
	@$(call install_fixup, hal,PRIORITY,optional)
	@$(call install_fixup, hal,SECTION,base)
	@$(call install_fixup, hal,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, hal,DESCRIPTION,missing)

#	# binaries
	@for i in \
		/usr/bin/hal-is-caller-locked-out \
		/usr/bin/hal-is-caller-privileged \
		/usr/bin/hal-set-property \
		/usr/bin/hal-device \
		/usr/bin/hal-find-by-capability \
		/usr/bin/hal-disable-polling \
		/usr/bin/hal-lock \
		/usr/bin/hal-find-by-property \
		/usr/bin/hal-get-property \
		/usr/bin/lshal \
		/usr/sbin/hald \
		/usr/libexec/hald-probe-net-bluetooth \
		/usr/libexec/hal-storage-unmount \
		/usr/libexec/hal-system-power-pm-is-supported \
		/usr/libexec/hald-probe-video4linux \
		/usr/libexec/hald-probe-storage \
		/usr/libexec/hald-probe-volume \
		/usr/libexec/hal-storage-closetray \
		/usr/libexec/hald-generate-fdi-cache \
		/usr/libexec/hald-probe-pc-floppy \
		/usr/libexec/hal-storage-cleanup-all-mountpoints \
		/usr/libexec/hald-probe-smbios \
		/usr/libexec/hald-probe-ieee1394-unit \
		/usr/libexec/hald-probe-serial \
		/usr/libexec/hald-addon-hid-ups \
		/usr/libexec/hald-addon-rfkill-killswitch \
		/usr/libexec/hald-addon-input \
		/usr/libexec/hald-probe-hiddev \
		/usr/libexec/hald-addon-ipw-killswitch \
		/usr/libexec/hald-probe-input \
		/usr/libexec/hal-storage-mount \
		/usr/libexec/hal-storage-eject \
		/usr/libexec/hald-probe-printer \
		/usr/libexec/hald-addon-storage \
		/usr/libexec/hald-addon-cpufreq \
		/usr/libexec/hal-system-setserial \
		/usr/libexec/hald-runner \
		/usr/libexec/hald-addon-generic-backlight \
		/usr/libexec/hal-storage-cleanup-mountpoint \
		/usr/libexec/hald-addon-leds \
	; do \
		$(call install_copy, hal, 0, 0, 0755, -, $$i); \
	done

#	# non-binaries
	@for i in \
		/usr/share/hal/fdi/fdi.dtd \
		/usr/share/hal/fdi/policy/10osvendor/30-wol.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-laptop-panel-mgmt-policy.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-dockstation.fdi \
		/usr/share/hal/fdi/policy/10osvendor/20-storage-methods.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-input-policy.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-rfkill-switch.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-x11-input.fdi \
		/usr/share/hal/fdi/policy/10osvendor/15-storage-luks.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-cpufreq.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-tabletPCs.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-power-mgmt-policy.fdi \
		/usr/share/hal/fdi/policy/10osvendor/10-leds.fdi \
	; do \
		$(call install_copy, hal, 0, 0, 0644, -, $$i); \
	done

ifdef PTXCONF_HAL_POLKIT
	@for i in \
		/usr/share/PolicyKit/policy/org.freedesktop.hal.policy \
		/usr/share/PolicyKit/policy/org.freedesktop.hal.power-management.policy \
		/usr/share/PolicyKit/policy/org.freedesktop.hal.storage.policy \
		/usr/share/PolicyKit/policy/org.freedesktop.hal.wol.policy \
		/usr/share/PolicyKit/policy/org.freedesktop.hal.leds.policy \
		/usr/share/PolicyKit/policy/org.freedesktop.hal.dockstation.policy \
		/usr/share/PolicyKit/policy/org.freedesktop.hal.killswitch.policy \
	; do \
		$(call install_copy, hal, 0, 0, 0644, -, $$i); \
	done
endif

#	# libs
	@$(call install_copy, hal, 0, 0, 0644, -, /usr/lib/libhal.so.1.0.0)
	@$(call install_link, hal, libhal.so.1.0.0, /usr/lib/libhal.so.1)
	@$(call install_link, hal, libhal.so.1.0.0, /usr/lib/libhal.so)

	@$(call install_copy, hal, 0, 0, 0644, -, /usr/lib/libhal-storage.so.1.0.0)
	@$(call install_link, hal, libhal-storage.so.1.0.0, /usr/lib/libhal-storage.so.1)
	@$(call install_link, hal, libhal-storage.so.1.0.0, /usr/lib/libhal-storage.so)

#	# scripts
	@for i in \
		/usr/libexec/scripts/hal-dockstation-undock \
		/usr/libexec/scripts/hal-system-lcd-get-brightness \
		/usr/libexec/scripts/hal-system-killswitch-set-power \
		/usr/libexec/scripts/hal-system-lcd-set-brightness \
		/usr/libexec/scripts/hal-system-power-suspend-hybrid \
		/usr/libexec/scripts/hal-system-power-shutdown \
		/usr/libexec/scripts/hal-system-power-set-power-save \
		/usr/libexec/scripts/linux/hal-system-killswitch-set-power-linux \
		/usr/libexec/scripts/linux/hal-system-killswitch-get-power-linux \
		/usr/libexec/scripts/linux/hal-system-power-set-power-save-linux \
		/usr/libexec/scripts/linux/hal-luks-setup-linux \
		/usr/libexec/scripts/linux/hal-system-wol-linux \
		/usr/libexec/scripts/linux/hal-system-lcd-set-brightness-linux \
		/usr/libexec/scripts/linux/hal-system-power-suspend-hybrid-linux \
		/usr/libexec/scripts/linux/hal-system-lcd-get-brightness-linux \
		/usr/libexec/scripts/linux/hal-system-wol-enable-linux \
		/usr/libexec/scripts/linux/hal-luks-teardown-linux \
		/usr/libexec/scripts/linux/hal-dockstation-undock-linux \
		/usr/libexec/scripts/linux/hal-luks-remove-linux \
		/usr/libexec/scripts/linux/hal-system-power-reboot-linux \
		/usr/libexec/scripts/linux/hal-system-wol-enabled-linux \
		/usr/libexec/scripts/linux/hal-system-power-shutdown-linux \
		/usr/libexec/scripts/linux/hal-system-power-suspend-linux \
		/usr/libexec/scripts/linux/hal-system-wol-supported-linux \
		/usr/libexec/scripts/linux/hal-system-power-hibernate-linux \
		/usr/libexec/scripts/hal-functions \
		/usr/libexec/scripts/hal-system-power-suspend \
		/usr/libexec/scripts/hal-luks-teardown \
		/usr/libexec/scripts/hal-system-wol-enable \
		/usr/libexec/scripts/hal-system-power-hibernate \
		/usr/libexec/scripts/hal-system-wol-enabled \
		/usr/libexec/scripts/hal-system-killswitch-get-power \
		/usr/libexec/scripts/hal-system-wol-supported \
		/usr/libexec/scripts/hal-luks-remove \
		/usr/libexec/scripts/hal-luks-setup \
		/usr/libexec/scripts/hal-system-power-reboot \
	; do \
		$(call install_copy, hal, 0, 0, 0644, -, $$i); \
	done

#	# directories
	@$(call install_copy, hal, 0, 0, 0755, /usr/share/hal/fdi/information/20thirdparty)
	@$(call install_copy, hal, 0, 0, 0755, /usr/share/hal/fdi/preprobe/10osvendor)
	@$(call install_copy, hal, 0, 0, 0755, /usr/share/hal/fdi/preprobe/20thirdparty)
	@$(call install_copy, hal, 0, 0, 0755, /usr/share/hal/fdi/information/10freedesktop)
	@$(call install_copy, hal, 0, 0, 0755, /usr/share/hal/fdi/policy/20thirdparty)
	@$(call install_copy, hal, 0, 0, 0755, /usr/var/run/hald/hald-local)
	@$(call install_copy, hal, 0, 0, 0755, /usr/var/run/hald/hald-runner)
	@$(call install_copy, hal, 0, 0, 0755, /usr/var/cache/hald)
	@$(call install_copy, hal, 0, 0, 0755, /etc/hal/fdi/policy)
	@$(call install_copy, hal, 0, 0, 0755, /etc/hal/fdi/information)
	@$(call install_copy, hal, 0, 0, 0755, /etc/hal/fdi/preprobe)

#	# config files
	@$(call install_copy, hal, 0, 0, 0644, -, /usr/lib/udev/rules.d/90-hal.rules)
	@$(call install_copy, hal, 0, 0, 0644, -, /etc/dbus-1/system.d/hal.conf)

	@$(call install_finish, hal)

	@$(call touch)

# vim: syntax=make
