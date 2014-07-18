# -*-makefile-*-
#
# Copyright (C) 2010 by Robert Schwebel <r.schwebel@pengutronix.de>
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
SYSTEMD_VERSION	:= 215
SYSTEMD_MD5	:= d2603e9fffd8b18d242543e36f2e7d31
SYSTEMD		:= systemd-$(SYSTEMD_VERSION)
SYSTEMD_SUFFIX	:= tar.xz
SYSTEMD_URL	:= http://www.freedesktop.org/software/systemd/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_SOURCE	:= $(SRCDIR)/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_DIR	:= $(BUILDDIR)/$(SYSTEMD)
SYSTEMD_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# x86: systemd segfaults at startup when built with PIE
# PPC: compiling fails when building with PIE
ifneq ($(PTXCONF_ARCH_X86)$(PTXCONF_ARCH_PPC),)
SYSTEMD_WRAPPER_BLACKLIST := TARGET_HARDEN_PIE
endif
SYSTEMD_CONF_ENV	:= \
	$(CROSS_ENV) \
	CFLAGS="-I$(KERNEL_HEADERS_INCLUDE_DIR)" \
	ac_cv_path_INTLTOOL_MERGE=: \
	ac_cv_path_KMOD=/bin/kmod

#
# autoconf
#
SYSTEMD_CONF_TOOL	:= autoconf
SYSTEMD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-silent-rules \
	--disable-static \
	--disable-nls \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-introspection \
	--disable-address-sanitizer \
	--disable-undefined-sanitizer \
	--disable-python-devel \
	--disable-dbus \
	--enable-compat-libs \
	--disable-coverage \
	--enable-kmod \
	--enable-blkid \
	--disable-seccomp \
	--disable-ima \
	--disable-chkconfig \
	$(GLOBAL_SELINUX_OPTION) \
	--disable-apparmor \
	--$(call ptx/endis,PTXCONF_SYSTEMD_XZ)-xz \
	--disable-pam \
	--disable-acl \
	--disable-smack \
	--disable-gcrypt \
	--disable-audit \
	--disable-elfutils \
	--disable-libcryptsetup \
	--disable-qrencode \
	--disable-microhttpd \
	--disable-gnutls \
	--disable-binfmt \
	--$(call ptx/endis,PTXCONF_SYSTEMD_VCONSOLE)-vconsole \
	--enable-readahead \
	--enable-bootchart \
	--enable-quotacheck \
	--enable-tmpfiles \
	--disable-sysusers \
	--$(call ptx/disen,PTXCONF_SYSTEMD_DISABLE_RANDOM_SEED)-randomseed \
	--disable-backlight \
	--disable-rfkill \
	--$(call ptx/endis,PTXCONF_SYSTEMD_LOGIND)-logind \
	--disable-machined \
	--enable-hostnamed \
	--$(call ptx/endis,PTXCONF_SYSTEMD_TIMEDATE)-timedated \
	--$(call ptx/endis,PTXCONF_SYSTEMD_TIMEDATE)-timesyncd \
	--$(call ptx/endis,PTXCONF_SYSTEMD_LOCALES)-localed \
	--disable-coredump \
	--enable-polkit \
	--$(call ptx/endis,PTXCONF_SYSTEMD_NETWORK)-resolved \
	--$(call ptx/endis,PTXCONF_SYSTEMD_NETWORK)-networkd \
	--disable-efi \
	--disable-multi-seat-x \
	--disable-kdbus \
	--enable-myhostname \
	--$(call ptx/endis,PTXCONF_UDEV_LIBGUDEV)-gudev \
	--disable-manpages \
	--enable-split-usr \
	--disable-tests \
	--without-python \
	--with-ntp-servers= \
	--with-time-epoch=`date --date "$(PTXDIST_VERSION_YEAR)-$(PTXDIST_VERSION_MONTH)-01" +%s` \
	--with-system-uid-max=999 \
	--with-system-gid-max=999 \
	--with-dns-servers= \
	--with-firmware-path=/lib/firmware \
	--with-sysvinit-path="" \
	--with-sysvrcnd-path="" \
	--with-tty-gid=112 \
	--with-dbuspolicydir=/etc/dbus-1/system.d \
	--with-dbussessionservicedir=/usr/share/dbus-1/services \
	--with-dbussystemservicedir=/usr/share/dbus-1/system-services \
	--with-dbusinterfacedir=/usr/share/dbus-1/interfaces \
	--with-rootprefix= \
	--with-rootlibdir=/lib

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
ifdef PTXCONF_UDEV_HWDB
	@udevadm hwdb --update --root $(SYSTEMD_PKGDIR)
endif
ifndef PTXCONF_SYSTEMD_VCONSOLE
	@rm -v $(SYSTEMD_PKGDIR)/etc/systemd/system/getty.target.wants/getty@tty1.service
endif
#	# ldconfig is not installed
	@rm -v $(SYSTEMD_PKGDIR)/lib/systemd/system/sysinit.target.wants/ldconfig.service
#	# the upstream default (graphical.target) wants display-manager.service
	@ln -sf multi-user.target $(SYSTEMD_PKGDIR)/lib/systemd/system/default.target
ifdef PTXCONF_SYSTEMD_TIMEDATE
	@install -d $(SYSTEMD_PKGDIR)/etc/systemd/system/sysinit.target.wants/
	@mv $(SYSTEMD_PKGDIR)/etc/systemd/system/multi-user.target.wants/systemd-timesyncd.service \
		$(SYSTEMD_PKGDIR)/etc/systemd/system/sysinit.target.wants/
endif
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

SYSTEMD_HELPER := \
	systemd \
	systemd-ac-power \
	systemd-activate \
	systemd-bootchart \
	systemd-bus-proxyd \
	systemd-cgroups-agent \
	systemd-fsck \
	systemd-hostnamed \
	systemd-initctl \
	systemd-journald \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_LOCALES,systemd-localed,) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_LOGIND,systemd-logind,) \
	systemd-modules-load \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_NETWORK,systemd-resolved,) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_NETWORK,systemd-networkd,) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_NETWORK,systemd-networkd-wait-online,) \
	systemd-quotacheck \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_DISABLE_RANDOM_SEED,,systemd-random-seed) \
	systemd-readahead \
	systemd-remount-fs \
	systemd-reply-password \
	systemd-shutdown \
	systemd-shutdownd \
	systemd-sleep \
	systemd-socket-proxyd \
	systemd-sysctl \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_TIMEDATE,systemd-timedated,) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_TIMEDATE,systemd-timesyncd,) \
	systemd-update-done \
	systemd-update-utmp \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_LOGIND,systemd-user-sessions,) \
	$(call ptx/ifdef, PTXCONF_SYSTEMD_VCONSOLE,systemd-vconsole-setup,)

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

	@$(call install_lib, systemd, 0, 0, 0644, libnss_myhostname)

#	# daemon + tools
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/journalctl)
ifdef PTXCONF_SYSTEMD_LOGIND
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/loginctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-inhibit)
endif
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-machine-id-setup)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-tmpfiles)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-notify)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/busctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/hostnamectl)
ifdef PTXCONF_SYSTEMD_LOCALES
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/localectl)
endif
ifdef PTXCONF_SYSTEMD_TIMEDATE
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/timedatectl)
endif
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cat)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cgls)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cgtop)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-delta)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-path)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-run)
	@$(call install_link, systemd, ../../lib/systemd/systemd-bus-proxyd, \
		/usr/bin/systemd-stdio-bridge)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-analyze)

	@$(call install_tree, systemd, 0, 0, -, /lib/systemd/system-generators/)
	@$(foreach helper, $(SYSTEMD_HELPER), \
		$(call install_copy, systemd, 0, 0, 755, -, \
			/lib/systemd/$(helper));)


ifdef PTXCONF_INITMETHOD_SYSTEMD
	@$(call install_link, systemd, ../lib/systemd/systemd, /sbin/init)
	@$(call install_link, systemd, ../bin/systemctl, /sbin/halt)
	@$(call install_link, systemd, ../bin/systemctl, /sbin/poweroff)
	@$(call install_link, systemd, ../bin/systemctl, /sbin/reboot)
endif

#	# configuration
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/system.conf)
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/bootchart.conf)
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
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/resolved.conf)
endif
	@$(call install_tree, systemd, 0, 0, -, /etc/systemd/system/)
	@$(call install_tree, systemd, 0, 0, -, /etc/dbus-1/system.d/)

	@$(call install_tree, systemd, 0, 0, -, /usr/lib/tmpfiles.d/)
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/lib/sysctl.d/50-default.conf)

	@$(call install_tree, systemd, 0, 0, -, /usr/share/polkit-1/actions/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/services/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/system-services/)
ifdef PTXCONF_SYSTEMD_LOCALES
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/share/systemd/kbd-model-map)
endif

	@$(call install_copy, systemd, 0, 0, 0644, -, /lib/udev/rules.d/99-systemd.rules)
ifdef PTXCONF_SYSTEMD_NETWORK
	@$(call install_tree, systemd, 0, 0, -, /lib/systemd/network)
	@$(call install_alternative_tree, systemd, 0, 0, /lib/systemd/network)
endif
ifdef PTXCONF_SYSTEMD_TIMEDATE
	@$(call install_tree, systemd, 0, 0, -, /usr/lib/systemd/ntp-units.d/)
endif

#	# units
	@$(call install_tree, systemd, 0, 0, -, /lib/systemd/system/)

	@$(call install_alternative, systemd, 0, 0, 0644, /etc/vconsole.conf)

	@$(call install_copy, systemd, 0, 0, 0755, /var/lib/systemd)

	@$(call install_alternative, systemd, 0, 0, 0644, /etc/profile.d/systemd.sh)

	@$(call install_finish, systemd)

	@$(call touch)

# vim: syntax=make
