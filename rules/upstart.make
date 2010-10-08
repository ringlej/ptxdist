# -*-makefile-*-
#
# Copyright (C) 2009 by Robert Schwebel <r.schwebel@pengutronix.de>
#               2010 by Tim Sander <tim.sander@hbm.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UPSTART) += upstart

#
# Paths and names
#
UPSTART_VERSION	:= 0.6.6
UPSTART_MD5	:= 5a2e9962a4cea719fbe07c33e2591b06
UPSTART		:= upstart-$(UPSTART_VERSION)
UPSTART_SUFFIX	:= tar.gz
UPSTART_URL	:= http://upstart.ubuntu.com/download/0.6/$(UPSTART).$(UPSTART_SUFFIX)
UPSTART_SOURCE	:= $(SRCDIR)/$(UPSTART).$(UPSTART_SUFFIX)
UPSTART_DIR	:= $(BUILDDIR)/$(UPSTART)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(UPSTART_SOURCE):
	@$(call targetinfo)
	@$(call get, UPSTART)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UPSTART_PATH	:= PATH=$(CROSS_PATH)
UPSTART_ENV 	:= $(CROSS_ENV)

#
# autoconf
#

UPSTART_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-compiler-coverage \
	--disable-nls \
	--enable-threads=posix \
	--disable-rpath \
	--enable-shared \
	--enable-static \
	--enable-threading \
	--enable-compiler-warnings \
	--enable-compiler-optimisations \
	--enable-linker-optimisations \
	--with-gnu-ld \
	--without-libpth-prefix \
	--without-libiconv-prefix \
	--with-included-gettext \
	--without-libintl-prefix

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/upstart.targetinstall:
	@$(call targetinfo)

	@$(call install_init, upstart)
	@$(call install_fixup, upstart,PRIORITY,optional)
	@$(call install_fixup, upstart,SECTION,base)
	@$(call install_fixup, upstart,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, upstart,DESCRIPTION,missing)

	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/init)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/initctl)
	@$(call install_link, upstart, initctl, /usr/sbin/reload)
	@$(call install_link, upstart, initctl, /usr/sbin/restart)
	@$(call install_link, upstart, initctl, /usr/sbin/start)
	@$(call install_link, upstart, initctl, /usr/sbin/stop)
	@$(call install_link, upstart, initctl, /usr/sbin/status)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/reboot)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/shutdown)
	@$(call install_link, upstart, reboot, /usr/sbin/halt)
	@$(call install_link, upstart, reboot, /usr/sbin/poweroff)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/runlevel)
	@$(call install_copy, upstart, 0, 0, 0755, -, /usr/sbin/telinit)

	@$(call install_copy, upstart, 0, 0, 0755, /etc/init.d/conf.d)
	@$(call install_copy, upstart, 0, 0, 0755, /etc/init.d/jobs.d)

	@$(call install_copy, upstart, 0, 0, 0644, -, /etc/dbus-1/system.d/Upstart.conf)

	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/rcS.conf)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/rc.conf)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/mount.conf)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/networking.conf)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/network-interface.conf)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/hostname.conf)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/ttyS.conf)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/syslogd.conf)

	@$(call install_alternative, upstart, 0, 0, 0755, /etc/network/interfaces)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/init/loadmodules.conf)
	@$(call install_alternative, upstart, 0, 0, 0644, /etc/modules)
	@$(call install_finish, upstart)

	@$(call touch)

# vim: syntax=make
