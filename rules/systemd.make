# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2011-2017 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSTEMD) += systemd

#
# Paths and names
#
SYSTEMD_VERSION	:= 239
SYSTEMD_MD5	:= 6137e3f50390391cf34521d071a1a078
SYSTEMD		:= systemd-$(SYSTEMD_VERSION)
SYSTEMD_SUFFIX	:= tar.gz
SYSTEMD_URL	:= https://github.com/systemd/systemd/archive/v$(SYSTEMD_VERSION).$(SYSTEMD_SUFFIX)
SYSTEMD_SOURCE	:= $(SRCDIR)/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_DIR	:= $(BUILDDIR)/$(SYSTEMD)
SYSTEMD_LICENSE	:= GPL-2.0-or-later AND LGPL-2.1-only
SYSTEMD_LICENSE_FILES := \
	file://LICENSE.GPL2;md5=751419260aa954499f7abaabaa882bbe \
	file://LICENSE.LGPL2.1;md5=4fbd65380cdd255951079008b364516c

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# x86: systemd segfaults at startup when built with PIE
# PPC: compiling fails when building with PIE
ifneq ($(PTXCONF_ARCH_X86)$(PTXCONF_ARCH_PPC),)
SYSTEMD_WRAPPER_BLACKLIST := TARGET_HARDEN_PIE
endif

ifdef PTXCONF_KERNEL_HEADER
SYSTEMD_CPPFLAGS	:= \
	-isystem $(KERNEL_HEADERS_INCLUDE_DIR)
endif

SYSTEMD_CONF_TOOL	:= meson
SYSTEMD_CONF_OPT	:= \
	$(CROSS_MESON_USR) \
	-Dacl=false \
	-Dadm-group=true \
	-Dapparmor=false \
	-Daudit=false \
	-Dbacklight=false \
	-Dbinfmt=false \
	-Dblkid=true \
	-Dbzip2=false \
	-Dcertificate-root=/etc/ssl \
	-Dcompat-gateway-hostname=false \
	-Dcoredump=$(call ptx/truefalse,PTXCONF_SYSTEMD_COREDUMP) \
	-Ddbus=false \
	-Ddbuspolicydir=/usr/share/dbus-1/system.d \
	-Ddbussessionservicedir=/usr/share/dbus-1/services \
	-Ddbussystemservicedir=/usr/share/dbus-1/system-services \
	-Ddefault-dns-over-tls=no \
	-Ddefault-dnssec=no \
	-Ddefault-hierarchy=hybrid \
	-Ddefault-kill-user-processes=true \
	-Ddev-kvm-mode=0660 \
	-Ddns-over-tls=false \
	-Ddns-servers= \
	-Defi=false \
	-Delfutils=$(call ptx/truefalse,PTXCONF_SYSTEMD_COREDUMP) \
	-Denvironment-d=false \
	-Dfallback-hostname=$(call ptx/ifdef,PTXCONF_ROOTFS_ETC_HOSTNAME,$(PTXCONF_ROOTFS_ETC_HOSTNAME),ptxdist) \
	-Dfirstboot=false \
	-Dgcrypt=false \
	-Dglib=false \
	-Dgnutls=false \
	-Dgroup-render-mode=0666 \
	-Dgshadow=false \
	-Dhibernate=false \
	-Dhostnamed=true \
	-Dhtml=false \
	-Dhwdb=$(call ptx/truefalse,PTXCONF_SYSTEMD_UDEV_HWDB) \
	-Didn=false \
	-Dima=false \
	-Dimportd=false \
	-Dinstall-tests=false \
	-Dkexec-path=/usr/sbin/kexec \
	-Dkill-path=/usr/bin/kill \
	-Dkmod=true \
	-Dkmod-path=/usr/bin/kmod \
	-Dldconfig=false \
	-Dlibcryptsetup=false \
	-Dlibcurl=false \
	-Dlibidn=false \
	-Dlibidn2=false \
	-Dlibiptc=$(call ptx/truefalse,PTXCONF_SYSTEMD_IPMASQUERADE) \
	-Dlink-systemctl-shared=true \
	-Dlink-udev-shared=true \
	-Dllvm-fuzz=false \
	-Dloadkeys-path=/usr/bin/loadkeys \
	-Dlocaled=$(call ptx/truefalse,PTXCONF_SYSTEMD_LOCALES) \
	-Dlogind=$(call ptx/truefalse,PTXCONF_SYSTEMD_LOGIND) \
	-Dlz4=$(call ptx/truefalse,PTXCONF_SYSTEMD_LZ4) \
	-Dmachined=false \
	-Dman=false \
	-Dmemory-accounting-default=true \
	-Dmicrohttpd=$(call ptx/truefalse,PTXCONF_SYSTEMD_MICROHTTPD) \
	-Dmount-path=/usr/bin/mount \
	-Dmyhostname=true \
	-Dnetworkd=$(call ptx/truefalse,PTXCONF_SYSTEMD_NETWORK) \
	-Dnobody-group=nogroup \
	-Dnobody-user=nobody \
	-Dnss-systemd=true \
	-Dntp-servers= \
	-Dok-color=green \
	-Doss-fuzz=false \
	-Dpam=false \
	-Dpcre2=false \
	-Dpolkit=$(call ptx/truefalse,PTXCONF_SYSTEMD_POLKIT) \
	-Dportabled=false \
	-Dqrencode=false \
	-Dquotacheck=true \
	-Dquotacheck-path=/usr/sbin/quotacheck \
	-Dquotaon-path=/usr/sbin/quotaon \
	-Drandomseed=$(call ptx/falsetrue,PTXCONF_SYSTEMD_DISABLE_RANDOM_SEED) \
	-Dremote=$(call ptx/ifdef,PTXCONF_SYSTEMD_JOURNAL_REMOTE,auto,false) \
	-Dresolve=$(call ptx/truefalse,PTXCONF_SYSTEMD_NETWORK) \
	-Drfkill=false \
	-Dseccomp=$(call ptx/truefalse,PTXCONF_SYSTEMD_SECCOMP) \
	-Dselinux=$(call ptx/truefalse,PTXCONF_GLOBAL_SELINUX) \
	-Dsetfont-path=/usr/bin/setfont \
	-Dslow-tests=false \
	-Dsmack=false \
	-Dsplit-bin=true \
	-Dstatic-libsystemd=false \
	-Dstatic-libudev=false \
	-Dsplit-usr=false \
	-Dsulogin-path=/sbin/sulogin \
	-Dsystem-gid-max=999 \
	-Dsystem-uid-max=999 \
	-Dsysusers=false \
	-Dsysvinit-path= \
	-Dsysvrcnd-path= \
	-Dtelinit-path=/usr/bin/telinit \
	-Dtests=false \
	-Dtime-epoch=$(SOURCE_DATE_EPOCH) \
	-Dtimedated=$(call ptx/truefalse,PTXCONF_SYSTEMD_TIMEDATE) \
	-Dtimesyncd=$(call ptx/truefalse,PTXCONF_SYSTEMD_TIMEDATE) \
	-Dtmpfiles=true \
	-Dtpm=false \
	-Dtty-gid=112 \
	-Dumount-path=/usr/bin/umount \
	-Dusers-gid= \
	-Dutmp=false \
	-Dvalgrind=false \
	-Dvconsole=$(call ptx/truefalse,PTXCONF_SYSTEMD_VCONSOLE) \
	-Dwheel-group=false \
	-Dxkbcommon=false \
	-Dxz=$(call ptx/truefalse,PTXCONF_SYSTEMD_XZ) \
	-Dzlib=false

# FIXME kernel from systemd README:
# - devtmpfs, cgroups are mandatory.
# - autofs4, ipv6  optional but strongly recommended

# FIXME busybox tools:
# - mount fails

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/systemd.install:
	@$(call targetinfo)
	@$(call world/install, SYSTEMD)
ifdef PTXCONF_SYSTEMD_UDEV_HWDB
	@$(PTXDIST_SYSROOT_HOST)/bin/systemd-hwdb update --usr --root $(SYSTEMD_PKGDIR)
endif
ifndef PTXCONF_SYSTEMD_VCONSOLE
	@rm -v $(SYSTEMD_PKGDIR)/etc/systemd/system/getty.target.wants/getty@tty1.service
endif
#	# don't touch /etc and /home
	@rm -v $(SYSTEMD_PKGDIR)/usr/lib/tmpfiles.d/etc.conf
	@rm -v $(SYSTEMD_PKGDIR)/usr/lib/tmpfiles.d/home.conf
#	# the upstream default (graphical.target) wants display-manager.service
	@ln -sf multi-user.target $(SYSTEMD_PKGDIR)/usr/lib/systemd/system/default.target
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

SYSTEMD_HELPER := \
	systemd \
	systemd-ac-power \
	systemd-cgroups-agent \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_COREDUMP,systemd-coredump) \
	systemd-fsck \
	systemd-growfs \
	systemd-hostnamed \
	systemd-initctl \
	systemd-journald \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_JOURNAL_REMOTE,systemd-journal-remote) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_LOCALES,systemd-localed) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_LOGIND,systemd-logind) \
	systemd-makefs \
	systemd-modules-load \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_NETWORK,systemd-networkd) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_NETWORK,systemd-networkd-wait-online) \
	systemd-quotacheck \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_DISABLE_RANDOM_SEED,,systemd-random-seed) \
	systemd-remount-fs \
	systemd-reply-password \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_NETWORK,systemd-resolved) \
	systemd-shutdown \
	systemd-sleep \
	systemd-socket-proxyd \
	systemd-sysctl \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_TIMEDATE,systemd-time-wait-sync) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_TIMEDATE,systemd-timedated) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_TIMEDATE,systemd-timesyncd) \
	systemd-udevd \
	systemd-update-done \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_UNITS_USER,systemd-user-runtime-dir) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_VCONSOLE,systemd-vconsole-setup)

SYSTEMD_UDEV_HELPER-y :=

SYSTEMD_UDEV_HELPER-$(PTXCONF_SYSTEMD_UDEV_PERSISTENT_ATA)	+= ata_id
SYSTEMD_UDEV_HELPER-$(PTXCONF_SYSTEMD_UDEV_PERSISTENT_CDROM)	+= cdrom_id
SYSTEMD_UDEV_HELPER-$(PTXCONF_SYSTEMD_UDEV_PERSISTENT_SCSI)	+= scsi_id
SYSTEMD_UDEV_HELPER-$(PTXCONF_SYSTEMD_UDEV_PERSISTENT_V4L)	+= v4l_id
SYSTEMD_UDEV_HELPER-$(PTXCONF_SYSTEMD_UDEV_COLLECT)		+= collect
SYSTEMD_UDEV_HELPER-$(PTXCONF_SYSTEMD_UDEV_MTD_PROBE)		+= mtd_probe

SYSTEMD_UDEV_RULES-y := \
	50-udev-default.rules \
	60-input-id.rules \
	60-persistent-alsa.rules \
	60-persistent-input.rules \
	60-persistent-storage-tape.rules \
	60-persistent-storage.rules \
	60-block.rules \
	60-drm.rules \
	60-sensor.rules \
	60-serial.rules \
	64-btrfs.rules \
	70-mouse.rules \
	75-net-description.rules \
	78-sound-card.rules \
	80-net-setup-link.rules

SYSTEMD_UDEV_RULES-$(PTXCONF_SYSTEMD_LOGIND) += \
	70-power-switch.rules \
	71-seat.rules \
	73-seat-late.rules

SYSTEMD_UDEV_RULES-$(PTXCONF_SYSTEMD_VCONSOLE) += \
	90-vconsole.rules

SYSTEMD_UDEV_RULES-$(PTXCONF_SYSTEMD_UDEV_PERSISTENT_CDROM)	+= 60-cdrom_id.rules
SYSTEMD_UDEV_RULES-$(PTXCONF_SYSTEMD_UDEV_HWDB)			+= 60-evdev.rules
SYSTEMD_UDEV_RULES-$(PTXCONF_SYSTEMD_UDEV_PERSISTENT_V4L)	+= 60-persistent-v4l.rules
SYSTEMD_UDEV_RULES-$(PTXCONF_SYSTEMD_UDEV_MTD_PROBE)		+= 75-probe_mtd.rules
SYSTEMD_UDEV_RULES-$(PTXCONF_SYSTEMD_UDEV_DRIVERS_RULES)	+= 80-drivers.rules

$(STATEDIR)/systemd.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  systemd)
	@$(call install_fixup, systemd,PRIORITY,optional)
	@$(call install_fixup, systemd,SECTION,base)
	@$(call install_fixup, systemd,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, systemd,DESCRIPTION,missing)

#	#
#	# Some info about the current state of systemd support in ptxdist:
#	#
#	# - we don't care about a user systemd yet
#	#

	@$(call install_lib, systemd, 0, 0, 0644, libsystemd)
	@$(call install_lib, systemd, 0, 0, 0644, systemd/libsystemd-shared-$(SYSTEMD_VERSION))

	@$(call install_lib, systemd, 0, 0, 0644, libnss_myhostname)
	@$(call install_lib, systemd, 0, 0, 0644, libnss_systemd)
ifdef PTXCONF_SYSTEMD_NETWORK
	@$(call install_lib, systemd, 0, 0, 0644, libnss_resolve)
endif

#	# daemon + tools
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/journalctl)
ifdef PTXCONF_SYSTEMD_LOGIND
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/loginctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-inhibit)
endif
ifdef PTXCONF_SYSTEMD_NETWORK
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/networkctl)
endif
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-escape)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-machine-id-setup)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-notify)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-tmpfiles)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/busctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/hostnamectl)
ifdef PTXCONF_SYSTEMD_LOCALES
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/localectl)
endif
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-analyze)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cat)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cgls)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cgtop)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-delta)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-detect-virt)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-mount)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-path)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-run)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-socket-activate)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-stdio-bridge)
	@$(call install_link, systemd, systemd-mount, /usr/bin/systemd-umount)
ifdef PTXCONF_SYSTEMD_TIMEDATE
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/timedatectl)
endif

	@$(call install_tree, systemd, 0, 0, -, /usr/lib/systemd/system-generators/)
	@$(foreach helper, $(SYSTEMD_HELPER), \
		$(call install_copy, systemd, 0, 0, 755, -, \
			/usr/lib/systemd/$(helper));)


ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_link, systemd, ../lib/systemd/systemd, /usr/sbin/init)
	@$(call install_link, systemd, ../bin/systemctl, /usr/sbin/halt)
	@$(call install_link, systemd, ../bin/systemctl, /usr/sbin/poweroff)
	@$(call install_link, systemd, ../bin/systemctl, /usr/sbin/reboot)
endif

#	# configuration
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/system.conf)
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/journald.conf)
ifdef PTXCONF_SYSTEMD_LOGIND
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/logind.conf)
endif
ifdef PTXCONF_SYSTEMD_TIMEDATE
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/timesyncd.conf)
endif
ifdef PTXCONF_SYSTEMD_NETWORK
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-resolve)
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/lib/systemd/resolv.conf)
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/resolved.conf)
endif
ifdef PTXCONF_SYSTEMD_JOURNAL_REMOTE
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/journal-remote.conf)
endif
	@$(call install_tree, systemd, 0, 0, -, /etc/systemd/system/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/system.d/)

	@$(call install_tree, systemd, 0, 0, -, /usr/lib/tmpfiles.d/)
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/lib/sysctl.d/50-default.conf)

ifdef PTXCONF_SYSTEMD_COREDUMP
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/lib/sysctl.d/50-coredump.conf)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/coredumpctl)
	@$(call install_alternative, systemd, 0, 0, 0644, /etc/systemd/coredump.conf)
endif

	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/services/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/system-services/)
ifdef PTXCONF_SYSTEMD_LOCALES
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/share/systemd/kbd-model-map)
endif

	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/lib/udev/rules.d/99-systemd.rules)
ifdef PTXCONF_SYSTEMD_NETWORK
	@$(call install_tree, systemd, 0, 0, -, /usr/lib/systemd/network)
	@$(call install_alternative_tree, systemd, 0, 0, /usr/lib/systemd/network)
endif
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/usr/lib/systemd/network/99-default.link)

#	# units
	@$(call install_tree, systemd, 0, 0, -, /usr/lib/systemd/system/)
ifdef PTXCONF_SYSTEMD_UNITS_USER
	@$(call install_tree, systemd, 0, 0, -, /usr/lib/systemd/user/)
endif

ifdef PTXCONF_SYSTEMD_VCONSOLE
	@$(call install_alternative, systemd, 0, 0, 0644, /etc/vconsole.conf)
endif

	@$(call install_copy, systemd, 0, 0, 0755, /var/lib/systemd)
	@$(call install_copy, systemd, 0, 0, 0700, /var/lib/private)

#	# systemd expects this directory to exist.
	@$(call install_copy, systemd, 0, 0, 0755, /var/lib/systemd/coredump)
	@$(call install_copy, systemd, 0, 0, 0700, /var/lib/machines)
ifdef PTXCONF_SYSTEMD_TIMEDATE
	@$(call install_link, systemd, ../private/systemd/timesync, \
		/var/lib/systemd/timesync)
endif

	@$(call install_alternative, systemd, 0, 0, 0644, /etc/profile.d/systemd.sh)

	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/udevadm)
	@$(call install_lib, systemd, 0, 0, 0644, libudev)

	@$(foreach helper, $(SYSTEMD_UDEV_HELPER-y), \
		$(call install_copy, systemd, 0, 0, 0755, -, \
			/usr/lib/udev/$(helper));)

	@$(foreach rule, $(SYSTEMD_UDEV_RULES-y), \
		$(call install_copy, systemd, 0, 0, 0644, -, \
			/usr/lib/udev/rules.d/$(rule));)

ifdef PTXCONF_SYSTEMD_UDEV_HWDB
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/lib/udev/hwdb.bin)
endif

ifdef PTXCONF_SYSTEMD_UDEV_CUST_RULES
	@$(call install_alternative_tree, systemd, 0, 0, /usr/lib/udev/rules.d)
endif

	@$(call install_finish, systemd)

	@$(call touch)

# vim: syntax=make
