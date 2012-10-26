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
SYSTEMD_VERSION	:= 195
SYSTEMD_MD5	:= 38e8c8144e7e6e5bc3ce32eb4260e680
SYSTEMD		:= systemd-$(SYSTEMD_VERSION)
SYSTEMD_SUFFIX	:= tar.xz
SYSTEMD_URL	:= http://www.freedesktop.org/software/systemd/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_SOURCE	:= $(SRCDIR)/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_DIR	:= $(BUILDDIR)/$(SYSTEMD)
SYSTEMD_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# python is used for the journal python bindings, which are not installed
SYSTEMD_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_path_PYTHON=:

#
# autoconf
#
SYSTEMD_CONF_TOOL	:= autoconf
SYSTEMD_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-silent-rules \
	--disable-static \
	--disable-nls \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-introspection \
	--disable-ima \
	--disable-selinux \
	--$(call ptx/endis,PTXCONF_SYSTEMD_XZ)-xz \
	--$(call ptx/endis,PTXCONF_SYSTEMD_TCPWRAP)-tcpwrap \
	--disable-pam \
	--disable-acl \
	--disable-xattr \
	--disable-gcrypt \
	--disable-audit \
	--disable-libcryptsetup \
	--disable-qrencode \
	--disable-microhttpd \
	--enable-binfmt \
	--$(call ptx/endis,PTXCONF_SYSTEMD_VCONSOLE)-vconsole \
	--enable-readahead \
	--enable-quotacheck \
	--$(call ptx/disen,PTXCONF_SYSTEMD_DISABLE_RANDOM_SEED)-randomseed \
	--enable-logind \
	--enable-hostnamed \
	--enable-timedated \
	--enable-localed \
	--disable-coredump \
	--$(call ptx/endis,PTXCONF_UDEV_LIBGUDEV)-gudev \
	--$(call ptx/endis,PTXCONF_UDEV_KEYMAPS)-keymap \
	--disable-manpages \
	--enable-split-usr \
	--with-usb-ids-path=/usr/share/usb.ids \
	--with-pci-ids-path=/usr/share/pci.ids$(call ptx/ifdef, PTXCONF_PCIUTILS_COMPRESS,.gz,) \
	--with-distro=other \
	--with-sysvinit-path="" \
	--with-sysvrcd-path="" \
	--with-dbuspolicydir=/etc/dbus-1/system.d \
	--with-dbussessionservicedir=/usr/share/dbus-1/services \
	--with-dbussystemservicedir=/usr/share/dbus-1/system-services \
	--with-dbusinterfacedir=/usr/share/dbus-1/interfaces \
	--with-pamlibdir=/lib/security \
	--with-rootprefix= \
	--with-rootlibdir=/lib

# SYSTEMD_MAKEVARS	:= V=1

# FIXME kernel from systemd README:
# - devtmpfs, cgroups are mandatory.
# - autofs4, ipv6  optional but strongly recommended

# FIXME busybox tools:
# - modprobe fails
# - mount fails

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/systemd.install:
	@$(call targetinfo)
	@$(call world/install, SYSTEMD)
	@ln -sf multi-user.target "$(SYSTEMD_PKGDIR)/lib/systemd/system/default.target"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

SYSTEMD_HELPER := \
	systemd \
	systemd-ac-power \
	systemd-binfmt \
	systemd-cgroups-agent \
	systemd-fsck \
	systemd-hostnamed \
	systemd-initctl \
	systemd-journald \
	systemd-localed \
	systemd-logind \
	systemd-modules-load \
	systemd-multi-seat-x \
	systemd-quotacheck \
	systemd-readahead \
	systemd-remount-fs \
	systemd-reply-password \
	systemd-shutdown \
	systemd-shutdownd \
	systemd-sleep \
	systemd-sysctl \
	systemd-timedated \
	systemd-timestamp \
	systemd-update-utmp \
	systemd-user-sessions \
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

	@$(call install_lib, systemd, 0, 0, 0644, libsystemd-daemon)
	@$(call install_lib, systemd, 0, 0, 0644, libsystemd-id128)
	@$(call install_lib, systemd, 0, 0, 0644, libsystemd-journal)
	@$(call install_lib, systemd, 0, 0, 0644, libsystemd-login)

#	# daemon + tools
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/journalctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/loginctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-ask-password)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-inhibit)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-machine-id-setup)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-tmpfiles)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-notify)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-tty-ask-password-agent)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cat)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cgls)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cgtop)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-delta)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-detect-virt)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-nspawn)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-stdio-bridge)
ifdef PTXCONF_SYSTEMD_ANALYZE
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-analyze)
endif

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
		/etc/systemd/journald.conf)
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/logind.conf)
	@$(call install_tree, systemd, 0, 0, -, /etc/systemd/system/)
	@$(call install_tree, systemd, 0, 0, -, /usr/lib/tmpfiles.d/)
	@$(call install_copy, systemd, 0, 0, 0644, -, /lib/udev/rules.d/99-systemd.rules)
	@$(call install_tree, systemd, 0, 0, -, /etc/dbus-1/system.d/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/polkit-1/actions/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/services/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/system-services/)
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/share/systemd/kbd-model-map)

#	# units
	@$(call install_tree, systemd, 0, 0, -, /lib/systemd/system/)

	@$(call install_alternative, systemd, 0, 0, 0644, /etc/vconsole.conf)

#	# systemd expects this directory to exist.
	@$(call install_copy, systemd, 0, 0, 0755, /var/cache/man)

	@$(call install_finish, systemd)

	@$(call touch)

# vim: syntax=make
