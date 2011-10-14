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
SYSTEMD_VERSION	:= 37
SYSTEMD_MD5	:= 1435f23be79c8c38d1121c6b150510f3
SYSTEMD		:= systemd-$(SYSTEMD_VERSION)
SYSTEMD_SUFFIX	:= tar.bz2
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
	--enable-silent-rules \
	--disable-selinux \
	--$(call ptx/endis,PTXCONF_SYSTEMD_TCPWRAP)-tcpwrap \
	--disable-pam \
	--disable-acl \
	--disable-audit \
	--disable-libcryptsetup \
	--enable-binfmt \
	--enable-hostnamed \
	--enable-timedated \
	--enable-localed \
	--disable-gtk \
	--disable-plymouth \
	--with-distro=other \
	--without-sysvinit-path \
	--without-sysvrcd-path \
	--with-dbuspolicydir=/etc/dbus-1/system.d \
	--with-dbussessionservicedir=/usr/share/dbus-1/services \
	--with-dbussystemservicedir=/usr/share/dbus-1/system-services \
	--with-dbusinterfacedir=/usr/share/dbus-1/interfaces \
	--with-udevrulesdir=/lib/udev/rules.d \
	--with-pamlibdir=/lib/security \
	--with-rootdir=

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

$(STATEDIR)/systemd.install:
	@$(call targetinfo)
	@$(call world/install, SYSTEMD)
ifdef PTXCONF_SYSTEMD_DISABLE_RANDOM_SEED
	@rm $(SYSTEMD_PKGDIR)/lib/systemd/system/sysinit.target.wants/systemd-random-seed-load.service
	@rm $(SYSTEMD_PKGDIR)/lib/systemd/system/shutdown.target.wants/systemd-random-seed-save.service
endif
	@$(call touch)

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
	@$(call install_lib, systemd, 0, 0, 0644, libsystemd-login)

	# daemon + tools
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-ask-password)
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
	@$(call install_link, systemd, ../bin/systemd, /sbin/init)
	@$(call install_link, systemd, ../bin/systemctl, /sbin/halt)
	@$(call install_link, systemd, ../bin/systemctl, /sbin/poweroff)
	@$(call install_link, systemd, ../bin/systemctl, /sbin/reboot)
endif

	# configuration
	@$(call install_copy, systemd, 0, 0, 0644, -, /etc/systemd/system.conf)
	@$(call install_tree, systemd, 0, 0, -, /usr/lib/tmpfiles.d/)
	@$(call install_copy, systemd, 0, 0, 0644, -, /lib/udev/rules.d/99-systemd.rules)
	@$(call install_tree, systemd, 0, 0, -, /etc/dbus-1/system.d/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/polkit-1/actions/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/services/)
	@$(call install_tree, systemd, 0, 0, -, /usr/share/dbus-1/system-services/)

	# units
	@$(call install_tree, systemd, 0, 0, -, /lib/systemd)

	@$(call install_alternative, systemd, 0, 0, 0644, /etc/vconsole.conf)

	# systemd expects this directory to exist.
	@$(call install_copy, systemd, 0, 0, 0755, /var/cache/man)

	@$(call install_finish, systemd)

	@$(call touch)

# vim: syntax=make
