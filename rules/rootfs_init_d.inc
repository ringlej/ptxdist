# -*-makefile-*-
# $Id:$
#
# Copyright (C) 2006 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
# Note: This file will be included by rootfs.make
#
# TODO: If you want to add a general startupscript to /etc/init.d, add it here.
# Do not forget to give the user a chance to use its own file!
#
# Purpose: Populate startup scripts into /etc/init.d that do not belong to any
# packets.
#
# "populate_init.d_scripts" is a subtarget. See rootfs.make for use
#
$(STATEDIR)/rootfs.sub_populate_init_d_scripts:

# generate the directories first
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/init.d)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/rc.d)

# FIXME provide also a user defined file!
ifdef PTXCONF_ROOTFS_ETC_INITD_RCS
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/rcS, \
		/etc/init.d/rcS, n)
endif

# FIXME provide also a user defined file!
ifdef PTXCONF_ROOTFS_ETC_INITD_LOGROTATE
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/logrotate,
		/etc/init.d/logrotate, n)
endif

#
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

ifdef PTXCONF_ROOTFS_ETC_INITD_MODULES
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/modules, \
		/etc/init.d/modules, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_MODULES_LINK),"")
	@$(call install_link, rootfs, ../init.d/modules, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_MODULES_LINK))
endif
endif

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

#
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

#
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

#
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
	@$(call install_link, rootfs, ../init.d/crondd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_CROND_LINK))
endif
endif

# FIXME: Move this into dropbear's packet!
ifdef PTXCONF_ROOTFS_ETC_INITD_DROPBEAR
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/dropbear, \
		/etc/init.d/dropbear, n)

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_LINK),"")
	@$(call install_link, rootfs, ../init.d/dropbear, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_LINK))
endif
endif

# FIXME: Move this into SSH's packet!
ifdef PTXCONF_ROOTFS_ETC_INITD_SSHD
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/sshd, \
		/etc/init.d/sshd, n)

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_SSHD_LINK),"")
	@$(call install_link, rootfs, ../init.d/sshd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_SSHD_LINK))
endif
endif

# FIXME: Move this into syslogng's packet!
ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/syslog-ng, \
		/etc/init.d/syslog-ng, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_LINK),"")
	@$(call install_link, rootfs, ../init.d/syslog-ng, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_STARTUP
	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/startup, \
		/etc/init.d/startup, n)
endif


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

# vim: syntax=make
