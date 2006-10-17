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
ROOTFS_VERSION=1.0.0


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

	#
	# root filesystem population
	#

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

	#
	# Files in /etc directory
	#

ifdef PTXCONF_ROOTFS_GENERIC_FSTAB
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/fstab, /etc/fstab, n)
endif

ifdef PTXCONF_ROOTFS_GENERIC_MTAB
	@$(call install_link, rootfs, /proc/mounts, /etc/mtab)
endif

ifdef PTXCONF_ROOTFS_GENERIC_GROUP
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/group,        /etc/group, n)
	@$(call install_copy, rootfs, 0, 0, 0640, $(PTXDIST_TOPDIR)/projects-example/generic/etc/gshadow,      /etc/gshadow, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_HOSTNAME
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/hostname,     /etc/hostname, n)
	@$(call install_replace, rootfs, /etc/hostname, @HOSTNAME@,  $(call remove_quotes,$(PTXCONF_ROOTFS_ETC_HOSTNAME)))
endif
ifdef PTXCONF_ROOTFS_GENERIC_HOSTS
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/hosts,        /etc/hosts, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_INITTAB
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/inittab,      /etc/inittab, n)

	@$(call install_replace, rootfs, /etc/inittab, @CONSOLE@,  $(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE)))
	@$(call install_replace, rootfs, /etc/inittab, @SPEED@,  $(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE_SPEED)))
endif
ifdef PTXCONF_ROOTFS_GENERIC_IPKG_CONF
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/ipkg.conf, /etc/ipkg.conf, n)
	@$(call install_replace, rootfs, /etc/ipkg.conf, @SRC@,  $(PTXCONF_ROOTFS_GENERIC_IPKG_CONF_URL))
	@$(call install_replace, rootfs, /etc/ipkg.conf, @ARCH@,  $(PTXCONF_ARCH))
endif
ifdef PTXCONF_ROOTFS_GENERIC_NSSWITCH
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/nsswitch.conf,/etc/nsswitch.conf, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_PASSWD
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/passwd,       /etc/passwd, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_PROFILE
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/profile,      /etc/profile, n)

	@$(call install_replace, rootfs, /etc/profile, @PS1@,  \"$(PTXCONF_ROOTFS_ETC_PS1)\" )
	@$(call install_replace, rootfs, /etc/profile, @PS2@,  \"$(PTXCONF_ROOTFS_ETC_PS2)\" )
	@$(call install_replace, rootfs, /etc/profile, @PS4@,  \"$(PTXCONF_ROOTFS_ETC_PS4)\" )

endif
ifdef PTXCONF_ROOTFS_GENERIC_PROTOCOLS
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/protocols,    /etc/protocols, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_RESOLV
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/resolv.conf,  /etc/resolv.conf, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_INETD
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/inetd.conf, /etc/inetd.conf, n);
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/projects-example/generic/etc/inetd.conf, /etc/services, n);

	@if [ "$(PTXCONF_INETUTILS_RSHD)" = "y" ]; then \
		$(call install_replace, rootfs, /etc/inetd.conf, @RSHD@, shell stream tcp nowait root /usr/sbin/rshd ) \
		$(call install_replace, rootfs, /etc/services, @RSHD@, shell 514/tcp cmd ) \
	else \
		$(call install_replace, rootfs, /etc/inetd.conf, @RSHD@, ) \
		$(call install_replace, rootfs, /etc/services, @RSHD@, ) \
	fi;
endif
ifdef PTXCONF_ROOTFS_GENERIC_SHADOW
	@$(call install_copy, rootfs, 0, 0, 0640, $(PTXDIST_TOPDIR)/projects-example/generic/etc/shadow,       /etc/shadow, n)
	@$(call install_copy, rootfs, 0, 0, 0600, $(PTXDIST_TOPDIR)/projects-example/generic/etc/shadow-,      /etc/shadow-, n)
endif
ifdef PTXCONF_ROOTFS_GENERIC_UDHCPC
	@$(call install_copy, rootfs, 0, 0, 0744, $(PTXDIST_TOPDIR)/projects-example/generic/etc/udhcpc.script,/etc/udhcpc.script, n)
	# udhcp expects the script to be called /usr/share/udhcpc/default.script, so we make a link
	@$(call install_link, rootfs, /etc/udhcpc.script, /usr/share/udhcpc/default.script)
endif

	#
	# Startup scripts in /etc/init.d
	#
ifdef PTXCONF_ROOTFS_ETC_INITD

	# Copy generic etc/init.d
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/init.d)
ifdef PTXCONF_ROOTFS_ETC_INITD_RCS
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/rcS,        /etc/init.d/rcS, n)
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_LOGROTATE
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/logrotate, /etc/init.d/logrotate, n)
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_INETD
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/inetd, /etc/init.d/inetd, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK),"")
	@$(call install_link, rootfs, ../init.d/inetd, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_MODULES
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/modules, /etc/init.d/modules, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_MODULES_LINK),"")
	@$(call install_link, rootfs, ../init.d/modules, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_MODULES_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_NETWORKING
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/networking, /etc/init.d/networking, n)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/network/if-down.d)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/network/if-up.d)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/network/if-post-down.d)
	@$(call install_copy, rootfs, 0, 0, 0755, /etc/network/if-pre-up.d)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_LINK),"")
	@$(call install_link, rootfs, ../init.d/networking, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_LINK))
endif
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_INTERFACES),"")
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXCONF_ROOTFS_ETC_INITD_NETWORKING_INTERFACES), /etc/network/interfaces, n)
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_TELNETD
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/telnetd,    /etc/init.d/telnetd, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_TELNETD_LINK),"")
	@$(call install_link, rootfs, ../init.d/telnetd, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_TELNETD_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_DROPBEAR
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/dropbear,    /etc/init.d/dropbear, n)

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_LINK),"")
	@$(call install_link, rootfs, ../init.d/dropbear, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_SSHD
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/sshd,    /etc/init.d/sshd, n)

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_SSHD_LINK),"")
	@$(call install_link, rootfs, ../init.d/sshd, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_SSHD_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/syslog-ng, /etc/init.d/syslog-ng, n)
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_LINK),"")
	@$(call install_link, rootfs, ../init.d/syslog-ng, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_STARTUP
	@$(call install_copy, rootfs, 0, 0, 0755, $(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/startup,    /etc/init.d/startup, n)
endif

	@$(call install_copy, rootfs, 0, 0, 0755, /etc/rc.d)

ifdef PTXCONF_ROOTFS_ETC_INITD_BANNER

	@$(call install_copy, rootfs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/projects-example/generic/etc/init.d/banner, \
		/etc/init.d/banner, n)

	@$(call install_replace, rootfs, /etc/init.d/banner, @VENDOR@,  $(PTXCONF_ROOTFS_ETC_VENDOR) )
	@$(call install_replace, rootfs, /etc/init.d/banner, @PROJECT@,  $(PTXCONF_PROJECT) )
	@$(call install_replace, rootfs, /etc/init.d/banner, @PRJVERSION@,  $(PTXCONF_PROJECT_VERSION) )
	@$(call install_replace, rootfs, /etc/init.d/banner, @VERSION@,  $(VERSION) )
	@$(call install_replace, rootfs, /etc/init.d/banner, @PTXDIST@,  $(PROJECT) )
	@$(call install_replace, rootfs, /etc/init.d/banner, @PATCHLEVEL@,  $(PATCHLEVEL) )
	@$(call install_replace, rootfs, /etc/init.d/banner, @SUBLEVEL@,  $(SUBLEVEL) )
	@$(call install_replace, rootfs, /etc/init.d/banner, @EXTRAVERSION@,  $(EXTRAVERSION) )
	@$(call install_replace, rootfs, /etc/init.d/banner, @DATE@, $(shell date -Iseconds) )

ifneq ($(PTXCONF_ROOTFS_ETC_INITD_BANNER_LINK),"")
	@$(call install_link, rootfs, ../init.d/banner, /etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_BANNER_LINK))
endif
endif

endif

	@$(call install_finish, rootfs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean:
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)
	rm -rf $(IMAGEDIR)/rootfs_*

# vim: syntax=make
