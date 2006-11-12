# -*-makefile-*-
# $Id:$
#
# Copyright (C) 2006 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
# Note: This file will included by rootfs.make
#
# TODO: If you want to add a general configfile that does not belongs to a
# specific packet, add it here. Do not forget to give the user a chance to
# use its own file instead of the generic one!
#
# Purpose: Populate configuration files into etc/
# These files are generic or user defined on demand
#
# "populate_config_files" is a subtarget. See rootfs.make for use
#
populate_config_files:

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

# ----------------------------------

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

# ----------------------------------

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

# ----------------------------------

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

# ----------------------------------

ifdef PTXCONF_ROOTFS_GENERIC_MTAB
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

# ----------------------------------

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

# ----------------------------------

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

# ----------------------------------

ifdef PTXCONF_ROOTFS_INITTAB
# /etc/inittab
ifdef PTXCONF_ROOTFS_GENERIC_INITTAB
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/inittab, \
		/etc/inittab, n)
	@$(call install_replace, rootfs, /etc/inittab, \
		@CONSOLE@, \
		$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE)))
	@$(call install_replace, rootfs, /etc/inittab, \
		@SPEED@, \
		$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_CONSOLE_SPEED)))
endif
ifdef PTXCONF_ROOTFS_USER_INITTAB
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/inittab, \
		/etc/inittab, n)
endif
endif

# ----------------------------------

ifdef PTXCONF_ROOTFS_NSSWITCH
# /etc/nsswitch
ifdef PTXCONF_ROOTFS_GENERIC_NSSWITCH
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/nsswitch.conf, \
		/etc/nsswitch.conf, n)
endif
ifdef PTXCONF_ROOTFS_USERS_NSSWITCH
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/nsswitch.conf, \
		/etc/nsswitch.conf, n)
endif
endif

# ----------------------------------

ifdef PTXCONF_ROOTFS_PROFILE
# /etc/profile
ifdef PTXCONF_ROOTFS_GENERIC_PROFILE
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/profile, \
		/etc/profile, n)
endif
ifdef PTXCONF_ROOTFS_USERS_PROFILE
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

# ----------------------------------

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

# ----------------------------------

ifdef PTXCONF_ROOTFS_RESOLV
# /etc/resolv
ifdef PTXCONF_ROOTFS_GENERIC_RESOLV
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/resolv.conf, \
		/etc/resolv.conf, n)
endif
ifdef PTXCONF_ROOTFS_USERS_RESOLV
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/resolv.conf, \
		/etc/resolv.conf, n)
endif
endif

# ----------------------------------

ifdef PTXCONF_ROOTFS_ETC_MODULES
# /etc/modules
	@$(call install_copy, rootfs, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/modules, \
		/etc/modules, n)
endif

# ----------------------------------

ifdef PTXCONF_ROOTFS_GENERIC_IPKG_CONF
	@$(call install_copy, rootfs, 0, 0, 0644, $(PTXDIST_TOPDIR)/generic/etc/ipkg.conf, /etc/ipkg.conf, n)
	@$(call install_replace, rootfs, /etc/ipkg.conf, @SRC@,  $(PTXCONF_ROOTFS_GENERIC_IPKG_CONF_URL))
	@$(call install_replace, rootfs, /etc/ipkg.conf, @ARCH@,  $(PTXCONF_ARCH))
endif
ifdef PTXCONF_ROOTFS_GENERIC_UDHCPC
	@$(call install_copy, rootfs, 0, 0, 0744, $(PTXDIST_TOPDIR)/generic/etc/udhcpc.script,/etc/udhcpc.script, n)
	# udhcp expects the script to be called /usr/share/udhcpc/default.script, so we make a link
	@$(call install_link, rootfs, /etc/udhcpc.script, /usr/share/udhcpc/default.script)
endif

# vim: syntax=make

