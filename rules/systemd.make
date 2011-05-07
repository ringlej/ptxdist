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
SYSTEMD_VERSION	:= 26
SYSTEMD_MD5	:= b7c468aa400c64d02d533eba6359e283
SYSTEMD		:= systemd-$(SYSTEMD_VERSION)
SYSTEMD_SUFFIX	:= tar.bz2
SYSTEMD_URL	:= http://www.freedesktop.org/software/systemd/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_SOURCE	:= $(SRCDIR)/$(SYSTEMD).$(SYSTEMD_SUFFIX)
SYSTEMD_DIR	:= $(BUILDDIR)/$(SYSTEMD)
SYSTEMD_LICENSE	:= unknown

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(SYSTEMD_SOURCE):
	@$(call targetinfo)
	@$(call get, SYSTEMD)

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
	--disable-tcpwrap \
	--disable-pam \
	--disable-gtk \
	--with-distro=other \
	--with-sysvinit-path=/etc/init.d \
	--with-sysvrcd-path=/etc \
	--with-dbuspolicydir=/etc/dbus-1/system.d \
	--with-dbussessionservicedir=/usr/share/dbus-1/services \
	--with-dbussystemservicedir=/usr/share/dbus-1/system-services \
	--with-dbusinterfacedir=/usr/share/dbus-1/interfaces \
	--with-udevrulesdir=/lib/udev/rules.d \
	--with-pamlibdir=/lib/security \
	--with-rootdir=

# SYSTEMD_MAKEVARS	:= V=1

# FIXME do we have to create dbuspolicydir?
# - autofs4 is mandatory. Is this necessary?
# - ipv6 is mandatory. Is this necessary?

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

	#
	# Some info about the current state of systemd support in ptxdist:
	#
	# - we don't care about a user systemd yet
	#

	# daemon + tools
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemctl)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-ask-password)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-tmpfiles)
	@$(call install_copy, systemd, 0, 0, 0755, -, /bin/systemd-notify)
	@$(call install_copy, systemd, 0, 0, 0755, -, /usr/bin/systemd-cgls)

	# configuration
	@$(call install_copy, systemd, 0, 0, 0644, -, /etc/systemd/system.conf)
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/lib/tmpfiles.d/x11.conf)
	@$(call install_copy, systemd, 0, 0, 0644, -, /usr/lib/tmpfiles.d/systemd.conf)
	@$(call install_copy, systemd, 0, 0, 0644, -, /lib/udev/rules.d/99-systemd.rules)
	@$(call install_copy, systemd, 0, 0, 0644, -, /etc/dbus-1/system.d/org.freedesktop.systemd1.conf)

	# units
	@$(call install_tree, systemd, 0, 0, $(SYSTEMD_PKGDIR)/lib/systemd, /lib/systemd)

	@$(call install_alternative, systemd, 0, 0, 0644, /etc/vconsole.conf)

	# systemd expects this directory to exist.
	@$(call install_copy, systemd, 0, 0, 0755, /var/cache/man)

	@$(call install_finish, systemd)

	@$(call touch)

# vim: syntax=make
