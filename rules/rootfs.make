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

	#
	# install directories in rootfs
	#

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

	#
	# install files in rootfs
	#

ifdef PTXCONF_ROOTFS_PASSWD
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/passwd, n)
endif
ifdef PTXCONF_ROOTFS_SHADOW
	@$(call install_alternative, rootfs, 0, 0, 0640, /etc/shadow, n)
	@$(call install_alternative, rootfs, 0, 0, 0600, /etc/shadow-, n)
endif
ifdef PTXCONF_ROOTFS_GROUP
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/group, n)
endif
ifdef PTXCONF_ROOTFS_GSHADOW
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/gshadow, n)
endif
ifdef PTXCONF_ROOTFS_FSTAB
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/fstab, n)
endif
ifdef PTXCONF_ROOTFS_MTAB
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/mtab, n)
endif
ifdef PTXCONF_ROOTFS_HOSTNAME
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/hostname, n)
	@$(call install_replace, rootfs, /etc/hostname, \
		@HOSTNAME@, \
		$(call remove_quotes,$(PTXCONF_ROOTFS_ETC_HOSTNAME)))
endif
ifdef PTXCONF_ROOTFS_HOSTS
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/hosts, n)
endif
ifdef PTXCONF_ROOTFS_NSSWITCH
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/nsswitch.conf, n)
endif
ifdef PTXCONF_ROOTFS_PROFILE
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/profile, n)
endif
ifdef PTXCONF_ROOTFS_PROTOCOLS
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/protocols, n)
endif
ifdef PTXCONF_ROOTFS_RESOLV
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/resolv.conf, n)
ifneq ($(PTXCONF_BOARDSETUP_GATEWAY),)
	@$(call install_replace, rootfs, /etc/resolv.conf, \
		@NAMESERVER@, \
		"nameserver $(PTXCONF_BOARDSETUP_GATEWAY)")
endif
endif
ifdef PTXCONF_ROOTFS_SERVICES
	@$(call install_alternative, rootfs, 0, 0, 0644, /etc/services, n)
endif

	@$(call install_finish, rootfs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean:
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)
	rm -rf $(PKGDIR)/rootfs_*

# vim: syntax=make
