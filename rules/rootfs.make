# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ROOTFS) += rootfs

# dummy to make ipkg happy
ROOTFS_VERSION	= 1.0.0
ROOTFS_DIR	= $(BUILDDIR)/rootfs

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rootfs_get: $(STATEDIR)/rootfs.get

$(STATEDIR)/rootfs.get: $(rootfs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rootfs_extract: $(STATEDIR)/rootfs.extract

$(STATEDIR)/rootfs.extract: $(rootfs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rootfs_prepare: $(STATEDIR)/rootfs.prepare

$(STATEDIR)/rootfs.prepare: $(rootfs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rootfs_compile: $(STATEDIR)/rootfs.compile

$(STATEDIR)/rootfs.compile: $(rootfs_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rootfs_install: $(STATEDIR)/rootfs.install

$(STATEDIR)/rootfs.install: $(rootfs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rootfs_targetinstall: $(STATEDIR)/rootfs.targetinstall

$(STATEDIR)/rootfs.targetinstall: $(rootfs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,  rootfs)
	@$(call install_fixup, rootfs,PACKAGE,rootfs)
	@$(call install_fixup, rootfs,PRIORITY,optional)
	@$(call install_fixup, rootfs,VERSION,$(ROOTFS_VERSION))
	@$(call install_fixup, rootfs,SECTION,base)
	@$(call install_fixup, rootfs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, rootfs,DEPENDS,)
	@$(call install_fixup, rootfs,DESCRIPTION,missing)

# -----------------------------------------------------------------------------
# This part generates root filesystem's structure
# -----------------------------------------------------------------------------

ifdef PTXCONF_ROOTFS_DEV
	@$(call install_copy, rootfs, 0, 0, 0755, /dev)
endif
ifdef PTXCONF_ROOTFS_DEV_PTS
	@$(call install_copy, rootfs, 0, 0, 0755, /dev/pts)
endif
ifdef PTXCONF_ROOTFS_DEV_INITIAL
	@$(call install_node, rootfs, 0, 0, 0644, c, 1, 3, /dev/null)
	@$(call install_node, rootfs, 0, 0, 0644, c, 1, 5, /dev/zero)
	@$(call install_node, rootfs, 0, 0, 0600, c, 5, 1, /dev/console)
endif
ifdef PTXCONF_ROOTFS_HOME
	@$(call install_copy, rootfs, 0, 0, 2775, /home)
endif
ifdef PTXCONF_ROOTFS_MEDIA
ifneq ($(PTXCONF_ROOTFS_MEDIA1),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA1))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA2),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA2))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA3),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA3))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA4),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA4))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA5),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA5))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA6),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA6))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA7),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA7))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA8),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA8))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA9),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA9))
endif
ifneq ($(PTXCONF_ROOTFS_MEDIA10),"")
	@$(call install_copy, rootfs, 0, 0, 0777, /media/$(PTXCONF_ROOTFS_MEDIA10))
endif
endif
ifdef PTXCONF_ROOTFS_MNT
	@$(call install_copy, rootfs, 0, 0, 0755, /mnt)
endif
ifdef PTXCONF_ROOTFS_PROC
	@$(call install_copy, rootfs, 0, 0, 0555, /proc)
endif
ifdef PTXCONF_ROOTFS_SYS
	@$(call install_copy, rootfs, 0, 0, 0755, /sys)
endif
ifdef PTXCONF_ROOTFS_TMP
	@$(call install_copy, rootfs, 0, 0, 1777, /tmp)
endif
ifdef PTXCONF_ROOTFS_VAR
	@$(call install_copy, rootfs, 0, 0, 0755, /var)
endif
ifdef PTXCONF_ROOTFS_VAR_LOG
	@$(call install_copy, rootfs, 0, 0, 0755, /var/log)
endif
ifdef PTXCONF_ROOTFS_VAR_RUN
	@$(call install_copy, rootfs, 0, 0, 0755, /var/run)
endif
ifdef PTXCONF_ROOTFS_VAR_LOCK
	@$(call install_copy, rootfs, 0, 0, 0755, /var/lock)
endif
ifdef PTXCONF_ROOTFS_VAR_LIB
	@$(call install_copy, rootfs, 0, 0, 0755, /var/lib)
endif
# -----------------------------------------------------------------------------
# This part installs startscrips into /etc/init.d and links into /etc/rc.d
# -----------------------------------------------------------------------------

# First of all: generate the required directories

	@$(call install_copy, rootfs, 0, 0, 0755, /etc/init.d)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/rc.d)

# -----------------------------------------------------------------------------
# FIXME provide also a user defined file!
ifdef PTXCONF_ROOTFS_ETC_INITD_RCS
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/rcS, \
		/etc/init.d/rcS, n)
endif

# -----------------------------------------------------------------------------
# FIXME provide also a user defined file!
ifdef PTXCONF_ROOTFS_ETC_INITD_LOGROTATE
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/logrotate, \
		/etc/init.d/logrotate, n)
endif

# -----------------------------------------------------------------------------
# initd's script is here, because the busybox entry does not provide it
# initd from inetutils package uses its own startscript
#
ifdef PTXCONF_ROOTFS_ETC_INITD_INETD
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/inetd, \
		/etc/init.d/inetd, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK),"")
	@$(call install_link, rootfs, ../init.d/inetd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK))
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_ETC_INITD_MODULES
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/modules, \
		/etc/init.d/modules, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_MODULES_LINK),"")
	@$(call install_link, rootfs, ../init.d/modules, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_MODULES_LINK))
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_ETC_INITD_NETWORKING
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/networking, \
		/etc/init.d/networking, n)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/network/if-down.d)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/network/if-up.d)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/network/if-post-down.d)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/network/if-pre-up.d)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_LINK),"")
	@$(call install_link, rootfs, ../init.d/networking, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_LINK))
endif
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_INTERFACES),"")
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_INTERFACES), \
		/etc/network/interfaces, n)
endif
endif

# -----------------------------------------------------------------------------
# telnetd's script is here, because the busybox entry does not provide it
# telnetd from other packets are useing their own startscript
#
ifdef PTXCONF_ROOTFS_ETC_INITD_TELNETD
# provide everything for standalone mode
ifdef PTXCONF_ROOTFS_ETC_INITD_TELNETD_DEFAULT
# use the generic one
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/telnetd, \
		/etc/init.d/telnetd, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_TELNETD_USER
# user defined one
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/telnetd, \
		/etc/init.d/telnetd, n)
endif

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_TELNETD_LINK),"")
	@$(call install_link, rootfs, ../init.d/telnetd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_TELNETD_LINK))
endif
endif

# -----------------------------------------------------------------------------
# syslogd/klogd's script is here, because the busybox entry does not provide it
# syslogd/klogd from other packets are useing their own startscript
#
ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGD_KLOGD
# provide everything for standalone mode
ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGD_KLOGD_DEFAULT
# use the generic one
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/syslogd, \
		/etc/init.d/syslogd, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGD_KLOGD_USER
# user defined one
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/syslogd, \
		/etc/init.d/syslogd, n)
endif

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_SYSLOGD_KLOGD_LINK),"")
	@$(call install_link, rootfs, ../init.d/syslogd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_SYSLOGD_KLOGD_LINK))
endif
endif

# -----------------------------------------------------------------------------
# crond's script is here, because the busybox entry does not provide it
#
ifdef PTXCONF_ROOTFS_ETC_INITD_CROND
# provide everything for standalone mode
ifdef PTXCONF_ROOTFS_ETC_INITD_CROND_DEFAULT
# use the generic one
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/crond, \
		/etc/init.d/crond, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_CROND_USER
# user defined one
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/crond, \
		/etc/init.d/crond, n)
endif

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_CROND_LINK),"")
	@$(call install_link, rootfs, ../init.d/crond, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_CROND_LINK))
endif
endif

# -----------------------------------------------------------------------------
# timekeepers script is here, because the busybox entry does not provide it
#
ifdef PTXCONF_ROOTFS_ETC_INITD_HWCLOCK
ifdef PTXCONF_ROOTFS_ETC_INITD_HWCLOCK_DEFAULT
# use the generic one
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/timekeeping, \
		/etc/init.d/timekeeping, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_HWCLOCK_USER
# user defined one
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/timekeeping, \
		/etc/init.d/timekeeping, n)
endif

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_TIMEKEEPER_LINK),"")
	@$(call install_link, rootfs, ../init.d/timekeeping, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_TIMEKEEPER_LINK))
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_ETC_INITD_STARTUP
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/startup, \
		/etc/init.d/startup, n)
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_ETC_INITD_BANNER
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/banner, \
		/etc/init.d/banner, n)

	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@VENDOR@,  $(PTXCONF_ROOTFS_ETC_VENDOR) )
	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@PROJECT@,  $(PTXCONF_PROJECT) )
	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@PRJVERSION@,  $(PTXCONF_PROJECT_VERSION) )
	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@VERSION@,  $(VERSION) )
	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@PTXDIST@,  $(PROJECT) )
	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@PATCHLEVEL@,  $(PATCHLEVEL) )
	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@SUBLEVEL@,  $(SUBLEVEL) )
	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@EXTRAVERSION@,  $(EXTRAVERSION) )
	@$(call install_replace, rootfs, /etc/init.d/banner, \
		@DATE@, $(shell date -Iseconds) )

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_BANNER_LINK),"")
	@$(call install_link, rootfs, ../init.d/banner, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_BANNER_LINK))
endif
endif

# -----------------------------------------------------------------------------
# This part installs configuration files into /etc
# -----------------------------------------------------------------------------

ifdef PTXCONF_ROOTFS_PASSWD
# /etc/passwd
ifdef PTXCONF_ROOTFS_GENERIC_PASSWD
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/passwd, \
		/etc/passwd, n)
endif
ifdef PTXCONF_ROOTFS_USER_PASSWD
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/passwd, \
		/etc/passwd, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_SHADOW
# /etc/shadow, /etc/shadow-
ifdef PTXCONF_ROOTFS_GENERIC_SHADOW
	@$(call install_copy, rootfs, 0, 0, 0640, \
		$(PTXDIST_TOPDIR)/generic/etc/shadow, \
		/etc/shadow, n)
	@$(call install_copy, rootfs, 0, 0, 0600, \
		$(PTXDIST_TOPDIR)/generic/etc/shadow-, \
		/etc/shadow-, n)
endif
ifdef PTXCONF_ROOTFS_USER_SHADOW
	@$(call install_copy, rootfs, 0, 0, 0640, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/shadow, \
		/etc/shadow, n)
	@$(call install_copy, rootfs, 0, 0, 0600, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/shadow-, \
		/etc/shadow-, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_GROUP
# /etc/group, /etc/gshadow
ifdef PTXCONF_ROOTFS_GENERIC_GROUP
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/group, \
		/etc/group, n)
	@$(call install_copy, rootfs, 0, 0, 0640, \
		$(PTXDIST_TOPDIR)/generic/etc/gshadow, \
		/etc/gshadow, n)
endif
ifdef PTXCONF_ROOTFS_USER_GROUP
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/group, \
		/etc/group, n)
	@$(call install_copy, rootfs, 0, 0, 0640, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/gshadow, \
		/etc/gshadow, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_FSTAB
# /etc/fstab
ifdef PTXCONF_ROOTFS_GENERIC_FSTAB
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/fstab, \
		/etc/fstab, n)
endif
ifdef PTXCONF_ROOTFS_USER_FSTAB
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/fstab, \
		/etc/fstab, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_MTAB
# /etc/mtab
ifdef PTXCONF_ROOTFS_GENERIC_MTAB
	@$(call install_link, rootfs, /proc/mounts, /etc/mtab)
endif
ifdef PTXCONF_ROOTFS_USER_MTAB
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/mtab, \
		/etc/mtab, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_HOSTNAME
# /etc/hostname
ifdef PTXCONF_ROOTFS_GENERIC_HOSTNAME
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/hostname, \
		/etc/hostname, n)
	@$(call install_replace, rootfs, /etc/hostname, \
		@HOSTNAME@, \
		$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_HOSTNAME)))
endif
ifdef PTXCONF_ROOTFS_USER_HOSTNAME
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/hostname, \
		/etc/hostname, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_HOSTS
# /etc/hosts
ifdef PTXCONF_ROOTFS_GENERIC_HOSTS
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/hosts, \
		/etc/hosts, n)
endif
ifdef PTXCONF_ROOTFS_USER_HOSTS
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/hosts, \
		/etc/hosts, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_INITTAB
# /etc/inittab
ifdef PTXCONF_ROOTFS_GENERIC_INITTAB
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/inittab, \
		/etc/inittab, n)
endif
ifdef PTXCONF_ROOTFS_USER_INITTAB
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/inittab, \
		/etc/inittab, n)
endif
	@$(call install_replace, rootfs, /etc/inittab, \
		@CONSOLE@, \
		$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE)))
	@$(call install_replace, rootfs, /etc/inittab, \
		@SPEED@, \
		$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE_SPEED)))
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_NSSWITCH
# /etc/nsswitch
ifdef PTXCONF_ROOTFS_GENERIC_NSSWITCH
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/nsswitch.conf, \
		/etc/nsswitch.conf, n)
endif
ifdef PTXCONF_ROOTFS_USER_NSSWITCH
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/nsswitch.conf, \
		/etc/nsswitch.conf, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_PROFILE
# /etc/profile
ifdef PTXCONF_ROOTFS_GENERIC_PROFILE
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/profile, \
		/etc/profile, n)
endif
ifdef PTXCONF_ROOTFS_USER_PROFILE
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/profile, \
		/etc/profile, n)
endif
	@$(call install_replace, rootfs, /etc/profile, \
		@PS1@, \
		\"$(PTXCONF_ROOTFS_ETC_PS1)\" )
	@$(call install_replace, rootfs, /etc/profile, \
		@PS2@, \
		\"$(PTXCONF_ROOTFS_ETC_PS2)\" )
	@$(call install_replace, rootfs, /etc/profile, \
		@PS4@, \
		\"$(PTXCONF_ROOTFS_ETC_PS4)\" )
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_PROTOCOLS
# /etc/protocols
ifdef PTXCONF_ROOTFS_GENERIC_PROTOCOLS
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/protocols, \
		/etc/protocols, n)
endif
ifdef PTXCONF_ROOTFS_USER_PROTOCOLS
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/protocols, \
		/etc/protocols, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_RESOLV
# /etc/resolv
ifdef PTXCONF_ROOTFS_GENERIC_RESOLV
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/resolv.conf, \
		/etc/resolv.conf, n)
endif
ifdef PTXCONF_ROOTFS_USER_RESOLV
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/resolv.conf, \
		/etc/resolv.conf, n)
endif
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_ETC_MODULES
# /etc/modules
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/modules, \
		/etc/modules, n)
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_GENERIC_IPKG_CONF
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/ipkg.conf, /etc/ipkg.conf, n)
	@$(call install_replace, rootfs, /etc/ipkg.conf, @SRC@, \
		$(PTXCONF_ROOTFS_GENERIC_IPKG_CONF_URL))
	@$(call install_replace, rootfs, /etc/ipkg.conf, @ARCH@, \
  		$(PTXCONF_ARCH))
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_GENERIC_UDHCPC
	@$(call install_copy, rootfs, 0, 0, 0754, \
		$(PTXDIST_TOPDIR)/generic/etc/udhcpc.script, \
		/etc/udhcpc.script, n)
# udhcp expects the script to be called /usr/share/udhcpc/default.script,
# so we make a link
	@$(call install_link, rootfs, /etc/udhcpc.script, \
		/usr/share/udhcpc/default.script)
endif

# -----------------------------------------------------------------------------
ifdef PTXCONF_ROOTFS_USER_CROND_CONF
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/cron)
	@$(call install_copy, rootfs, 0, 0, 0755, /var/spool/cron/crontabs/)

	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/crond/root, \
		/var/spool/cron/crontabs/root, n)

	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/crond/daily, \
		/etc/cron/daily, n)
endif

# -----------------------------------------------------------------------------
# This part creates /etc/inetd.conf and /etc/services on demand
# -----------------------------------------------------------------------------

ifdef PTXCONF_ROOTFS_INETD
# /etc/inetd.conf
ifdef PTXCONF_ROOTFS_GENERIC_INETD
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/inetd.conf, \
		/etc/inetd.conf, n )
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/services, \
		/etc/services, n )
endif
ifdef PTXCONF_ROOTFS_USER_INETD
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/inetd.conf, \
		/etc/inetd.conf, n )
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/services, \
		/etc/services, n )
endif

#
# Replace all markers if service is enabled
# or delete markers if service is disabled
# -----------------------------------------------------------------------------
# add rshd if enabled
#
ifdef PTXCONF_INETUTILS_RSHD
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@RSHD@, shell stream tcp nowait root /usr/sbin/rshd )
	@$(call install_replace, rootfs, /etc/services, \
		@RSHD@, \
		"shell 514/tcp cmd" )
else
	@$(call install_replace, rootfs, /etc/inetd.conf, @RSHD@, )
	@$(call install_replace, rootfs, /etc/services, @RSHD@, )
endif

# -----------------------------------------------------------------------------
# add NTP if enabled
#
ifdef PTXCONF_INETUTILS_NTP
# FIXME: Whats needed to start ntpd with inted?
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@NTP@, "" )
	@$(call install_replace, rootfs, /etc/services, \
		@NTP@, \
		"ntp 123/tcp\nntp 123/udp" )
else
	@$(call install_replace, rootfs, /etc/inetd.conf, @NTP@, )
	@$(call install_replace, rootfs, /etc/services, @NTP@, )
endif

# -----------------------------------------------------------------------------
# add cvs if enabled
#
ifdef PTXCONF_CVS_INETD_SERVER
ifneq ($(PTXCONF_CVS_INETD_STRING),"")
# add user defined string to start the cvs server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@CVSD@, $(PTXCONF_CVS_INETD_STRING) )
else
# add default string to start the cvs server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@CVSD@, \
		"cvspserver stream tcp nowait root /usr/bin/cvs cvsd -f @ROOT@ pserver" )
endif
ifneq ($(PTXCONF_CVS_SERVER_REPOSITORY),"")
# add info about repository's root
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@ROOT@, \
		"--allow-root=$(PTXCONF_CVS_SERVER_REPOSITORY)" )
else
# use cvs' default if not otherwise specified
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@ROOT@, )
endif
# add cvs service
	@$(call install_replace, rootfs, \
		/etc/services, \
		@CVSD@, \
		"cvspserver 2401/tcp\ncvspserver 2401/udp")
else
# remove all cvs entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @CVSD@, )
	@$(call install_replace, rootfs, /etc/services, @CVSD@, )
endif

# -----------------------------------------------------------------------------
# add rsync if enabled
#
ifdef PTXCONF_RSYNC_INETD_SERVER
ifneq ($(PTXCONF_RSYNC_INETD_STRING),"")
# add user defined string to start rsync server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@RSYNCD@, $(PTXCONF_RSYNC_INETD_STRING) )
else
# add default string to start the rsync server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@RSYNCD@, \
		"rsync stream tcp nowait root /usr/bin/rsync rsyncd --daemon @CONFIG@" )
endif
ifneq ($(PTXCONF_RSYNC_CONFIG_FILE),"")
# add path and name of config file
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@CONFIG@, "--config=$(PTXCONF_RSYNC_CONFIG_FILE)" )
else
# use rpath' default if not otherwise specified
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@CONFIG@, )
endif
# add rsync service
	@$(call install_replace, rootfs, \
		/etc/services, \
		@RSYNCD@, \
		"rsync 873/tcp\nrsync 873/udp" )
else
# remove all cvs entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @RSYNCD@, )
	@$(call install_replace, rootfs, /etc/services, @RSYNCD@, )
endif

# -----------------------------------------------------------------------------
# add famd if enabled
#
ifdef PTXCONF_FAM_INETD_SERVER
ifneq ($(PTXCONF_FAM_INETD_STRING),"")
# add user defined string to start famd server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@FAMD@, $(PTXCONF_FAM_INETD_STRING) )
else
# add default string to start the rsync server into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@FAMD@, \
		"sgi_fam/1-2 stream  rpc/tcp wait root /usr/sbin/famd famd -c /etc/fam.conf" )
endif
else
# remove all famd entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @FAMD@, )
endif

# -----------------------------------------------------------------------------
# add telnetd if enabled
#
ifdef PTXCONF_BB_CONFIG_FEATURE_TELNETD_INETD
# for busybox only!
# add default string to start the telnetd from busybox into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@TELNETD@, \
		"telnet stream  tcp wait root /usr/sbin/telnetd" )

	@$(call install_replace, rootfs, \
		/etc/services, \
		@TELNETD@, \
		"telnet 23/tcp\ntelnet 23/udp" )
else
# remove all telnetd entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @TELNETD@, )
	@$(call install_replace, rootfs, /etc/services, @TELNETD@, )
endif

# -----------------------------------------------------------------------------
# add portmap if enabled
#
ifdef PTXCONF_PORTMAP_INETD_SERVER
ifneq ($(PTXCONF_PORTMAP_INETD_STRING),"")
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@PORTMAPD@, $(PTXCONF_PORTMAP_INETD_STRING) )
else
# add default string to start the portmap into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@PORTMAPD@, \
		"sunrpc stream tcp nowait root /sbin/portmap portmap" )
endif
	@$(call install_replace, rootfs, \
		/etc/services, \
		@PORTMAPD@, \
		"sunrpc 111/tcp\nsunrpc 111/udp" )
else
# remove all portmapd entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @PORTMAPD@, )
	@$(call install_replace, rootfs, /etc/services, @PORTMAPD@, )

endif

# -----------------------------------------------------------------------------
# add dnsmasq if enabled
#
ifdef PTXCONF_DNSMASQ_INETD_SERVER
ifneq ($(PTXCONF_DNSMASQ_INETD_STRING),"")
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@DNSD@, \
		$(PTXCONF_DNSMASQ_INETD_STRING) )
else
# add default string to start the dnsmasq into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@DNSD@, \
		"domain stream tcp nowait root /sbin/dnsmasq domain" )
endif
# add dns service
	@$(call install_replace, rootfs, \
		/etc/services, \
		@DNSD@, \
		"domain 53/tcp\ndomain 53/udp" )
else
# remove all dnsmasq entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @DNSD@, )
	@$(call install_replace, rootfs, /etc/services, @DNSD@, )
endif
# -----------------------------------------------------------------------------
# add tftpd if enabled
#
ifdef PTXCONF_INETUTILS_TFTPD
ifneq ($(PTXCONF_INETUTILS_TFTPD_STRING),"")
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@TFTPD@, \
		$(PTXCONF_INETUTILS_TFTPD_STRING) )
else
# add default string to start the tftpd into inetd.conf
	@$(call install_replace, rootfs, /etc/inetd.conf, \
		@TFTPD@, \
		"tftp dgram udp wait nobody /sbin/tftpd tftpd -l @ROOT@" )
endif
# replace the base dir on demand
ifneq ($(PTXCONF_INETUTILS_TFTPD_BASE_DIR),"")
	@$(call install_replace, rootfs, \
		/etc/inetd.conf, \
		@ROOT@, \
		$(PTXCONF_INETUTILS_TFTPD_BASE_DIR) )
endif
# add tftp service
	@$(call install_replace, rootfs, \
		/etc/services, \
		@TFTPD@, \
		"tftp 69/udp" )
else
# remove all tftp entries if this service is not enabled
	@$(call install_replace, rootfs, /etc/inetd.conf, @TFTPD@, )
	@$(call install_replace, rootfs, /etc/services, @TFTPD@, )
endif
endif
# -----------------------------------------------------------------------------
	@$(call install_finish, rootfs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean:
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)
	rm -rf $(IMAGEDIR)/rootfs_*

# vim: syntax=make
