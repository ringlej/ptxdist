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
SYSTEMD_VERSION	:= 44
SYSTEMD_MD5	:= 11f44ff74c87850064e4351518bcff17
SYSTEMD		:= systemd-$(SYSTEMD_VERSION)
SYSTEMD_SUFFIX	:= tar.xz
SYSTEMD_URL	:= http://www.freedesktop.org/software/systemd/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_SOURCE	:= $(SRCDIR)/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_DIR	:= $(BUILDDIR)/$(SYSTEMD)
SYSTEMD_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
SYSTEMD_CONF_TOOL	:= autoconf
SYSTEMD_CONF_OPT += \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--enable-silent-rules \
	--disable-nls \
	--disable-static \
	--disable-selinux \
	--$(call ptx/endis,PTXCONF_SYSTEMD_XZ)-xz \
	--$(call ptx/endis,PTXCONF_SYSTEMD_TCPWRAP)-tcpwrap \
	--disable-pam \
	--disable-acl \
	--disable-audit \
	--disable-libcryptsetup \
	--enable-binfmt \
	--enable-vconsole \
	--enable-readahead \
	--enable-quotacheck \
	--$(call ptx/disen,PTXCONF_SYSTEMD_DISABLE_RANDOM_SEED)-randomseed \
	--enable-logind \
	--enable-hostnamed \
	--enable-timedated \
	--enable-localed \
	--disable-coredump \
	--disable-manpages \
	--disable-gtk \
	--disable-plymouth \
	--enable-split-usr \
	--with-distro=other \
	--with-sysvinit-path="" \
	--with-sysvrcd-path="" \
	--with-dbuspolicydir=/etc/dbus-1/system.d \
	--with-dbussessionservicedir=/usr/share/dbus-1/services \
	--with-dbussystemservicedir=/usr/share/dbus-1/system-services \
	--with-dbusinterfacedir=/usr/share/dbus-1/interfaces \
	--with-udevrulesdir=/lib/udev/rules.d \
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
# Target-Install
# ----------------------------------------------------------------------------

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
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-ask-password)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-journalctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-machine-id-setup)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-tmpfiles)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-notify)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-tty-ask-password-agent)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cgls)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-stdio-bridge)
ifdef PTXCONF_SYSTEMD_ANALYZE
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-analyze)
endif

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
		/etc/systemd/systemd-journald.conf)
	@$(call install_alternative, systemd, 0, 0, 0644, \
		/etc/systemd/systemd-logind.conf)
	@$(call install_tree, systemd, 0, 0, -, /etc/systemd/system/)
	@$(call install_tree, systemd, 0, 0, -, /usr/lib/tmpfiles.d/)
	@$(call install_copy, systemd, 0, 0, 0644, -, /lib/udev/rules.d/99-systemd.rules)
	@$(call install_tree, systemd, 0, 0, -, /etc/dbus-1/system.d/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/polkit-1/actions/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/services/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/system-services/)
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/share/systemd/kbd-model-map)

#	# units
	@$(call install_tree, systemd, 0, 0, -, /lib/systemd)

	@$(call install_alternative, systemd, 0, 0, 0644, /etc/vconsole.conf)

#	# systemd expects this directory to exist.
	@$(call install_copy, systemd, 0, 0, 0755, /var/cache/man)

	@$(call install_alternative, systemd, 0, 0, 0755, /etc/rc.once.d/machine-id)

	@$(call install_finish, systemd)

	@$(call touch)

# vim: syntax=make
