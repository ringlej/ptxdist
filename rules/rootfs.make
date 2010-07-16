# -*-makefile-*-
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
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
ROOTFS_VERSION	:= 1.0.0

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/rootfs.get:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/rootfs.extract:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

$(STATEDIR)/rootfs.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/rootfs.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rootfs.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rootfs.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  rootfs)
	@$(call install_fixup, rootfs,PRIORITY,optional)
	@$(call install_fixup, rootfs,SECTION,base)
	@$(call install_fixup, rootfs,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, rootfs,DESCRIPTION,missing)

#	#
#	# install directories in rootfs
#	#
ifdef PTXCONF_ROOTFS_DEV
	@$(call install_copy, rootfs, 0, 0, 0755, /dev)
endif
ifdef PTXCONF_ROOTFS_DEV_INITIAL
	@$(call install_node, rootfs, 0, 0, 0644, c, 1, 3, /dev/null)
	@$(call install_node, rootfs, 0, 0, 0644, c, 1, 5, /dev/zero)
	@$(call install_node, rootfs, 0, 0, 0600, c, 5, 1, /dev/console)
endif
ifdef PTXCONF_ROOTFS_HOME
	@$(call install_copy, rootfs, 0, 0, 2775, /home)
endif
ifdef PTXCONF_ROOTFS_HOME_ROOT
	@$(call install_copy, rootfs, 0, 0, 0700, /root)
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
ifdef PTXCONF_ROOTFS_VAR_CACHE
	@$(call install_copy, rootfs, 0, 0, 0755, /var/cache)
endif
ifdef PTXCONF_ROOTFS_VAR_SPOOL
	@$(call install_copy, rootfs, 0, 0, 0755, /var/spool)
endif
ifdef PTXCONF_ROOTFS_VAR_SPOOL_CRON
	@$(call install_copy, rootfs, 0, 0, 0755, /var/spool/cron)
endif
ifdef PTXCONF_ROOTFS_VAR_TMP
	@$(call install_copy, rootfs, 0, 0, 0755, /var/tmp)
endif


#	#
#	# install files in rootfs
#	#
ifdef PTXCONF_ROOTFS_PASSWD
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/passwd)
endif
ifdef PTXCONF_ROOTFS_SHADOW
	@$(call install_alternative, rootfs, 0, 0, 0640, /etc/shadow)
endif
ifdef PTXCONF_ROOTFS_GROUP
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/group)
endif
ifdef PTXCONF_ROOTFS_GSHADOW
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/gshadow)
endif
ifdef PTXCONF_ROOTFS_FSTAB
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/fstab)
endif
ifdef PTXCONF_ROOTFS_MTAB_FILE
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/mtab)
endif
ifdef PTXCONF_ROOTFS_MTAB_LINK_MOUNTS
	@$(call install_link, rootfs, ../proc/mounts, /etc/mtab)
endif
ifdef PTXCONF_ROOTFS_MTAB_LINK_VAR
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/mtab, /var/tmp/mtab)
	@$(call install_link, rootfs, ../var/tmp/mtab, /etc/mtab)
endif
ifdef PTXCONF_ROOTFS_HOSTNAME
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/hostname)
	@$(call install_replace, rootfs, /etc/hostname, \
		@HOSTNAME@, \
		$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_HOSTNAME)))
endif
ifdef PTXCONF_ROOTFS_HOSTS
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/hosts)
endif
ifdef PTXCONF_ROOTFS_NSSWITCH_CONF
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/nsswitch.conf)
endif
ifdef PTXCONF_ROOTFS_PROFILE
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/profile)
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/profile.environment)
endif
ifdef PTXCONF_ROOTFS_PROTOCOLS
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/protocols)
endif
ifdef PTXCONF_ROOTFS_RESOLV
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/resolv.conf)
#	# replace either by PTXCONF_BOARDSETUP_GATEWAY or nothing if not defined
ifneq ($(PTXCONF_BOARDSETUP_GATEWAY),)
	@$(call install_replace, rootfs, /etc/resolv.conf, \
		@NAMESERVER_LINE@, \
		"nameserver $(PTXCONF_BOARDSETUP_GATEWAY)")
else
	@$(call install_replace, rootfs, /etc/resolv.conf, @NAMESERVER_LINE@, "")
endif
endif
ifdef PTXCONF_ROOTFS_SERVICES
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/services)
endif

	@$(call install_finish, rootfs)

	@$(call touch)

# vim: syntax=make
