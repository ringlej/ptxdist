# -*-makefile-*-
# $Id: rootfs.make,v 1.9 2004/08/24 13:07:38 rsc Exp $
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
PACKAGES += rootfs

#
# Paths and names 
#
ROOTFS			= root-0.1.1
ROOTFS_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(ROOTFS).tgz
ROOTFS_SOURCE		= $(SRCDIR)/$(ROOTFS).tgz
ROOTFS_DIR		= $(BUILDDIR)/$(ROOTFS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rootfs_get: $(STATEDIR)/rootfs.get

$(STATEDIR)/rootfs.get: $(ROOTFS_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(ROOTFS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(ROOTFS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rootfs_extract: $(STATEDIR)/rootfs.extract

$(STATEDIR)/rootfs.extract: $(STATEDIR)/rootfs.get
	@$(call targetinfo, $@)
	@$(call extract, $(ROOTFS_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rootfs_prepare: $(STATEDIR)/rootfs.prepare

$(STATEDIR)/rootfs.prepare: $(STATEDIR)/rootfs.extract
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rootfs_compile: $(STATEDIR)/rootfs.compile

$(STATEDIR)/rootfs.compile: $(STATEDIR)/rootfs.prepare 
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rootfs_install: $(STATEDIR)/rootfs.install

$(STATEDIR)/rootfs.install: $(STATEDIR)/rootfs.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rootfs_targetinstall: $(STATEDIR)/rootfs.targetinstall

$(STATEDIR)/rootfs.targetinstall: $(STATEDIR)/rootfs.install
	@$(call targetinfo, $@)

ifdef PTXCONF_ROOTFS_PROC
	mkdir -p $(ROOTDIR)/proc
endif

ifdef PTXCONF_ROOTFS_DEV
	mkdir -p $(ROOTDIR)/dev
endif

ifdef PTXCONF_ROOTFS_MNT
	mkdir -p $(ROOTDIR)/mnt
endif

ifdef PTXCONF_ROOTFS_FLOPPY
	mkdir -p $(ROOTDIR)/floppy
endif

#	# FIXME: code rot...
#ifdef PTXCONF_OPENSSH
#	cd $(OPENSSH_DIR) && install -m 644 sshd_config.out $(ROOTDIR)/etc/ssh/sshd_config
#endif

ifdef PTXCONF_ROOTFS_TMP
	@$(call clean, $(ROOTDIR)/tmp)
  ifdef PTXCONF_ROOTFS_TMP_DATALINK
	ln -s /data/tmp $(ROOTDIR)/tmp
  else
	mkdir -p $(ROOTDIR)/tmp
  endif
endif

ifdef PTXCONF_ROOTFS_VAR
	mkdir -p $(ROOTDIR)/var
	mkdir -p $(ROOTDIR)/var/log
endif

ifdef PTXCONF_ROOTFS_SYS
	mkdir -p $(ROOTDIR)/sys
endif

ifdef PTXCONF_ROOTFS_VAR_LOG_DATALINK
	mkdir -p $(ROOTDIR)/var
	@$(call clean, $(ROOTDIR)/var/log)
	ln -s /data/log $(ROOTDIR)/var/log
endif	

ifdef PTXCONF_ROOTFS_DATA
	mkdir -p $(ROOTDIR)/data
endif

ifdef PTXCONF_ROOTFS_HOME
	mkdir -p $(ROOTDIR)/home
endif

ifdef PTXCONF_ROOTFS_ETC

	# Copy generic etc
	# FIXME: some parts of this have to be put into the packet make files!

	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/fstab,        /etc/fstab)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/group,        /etc/group)
	$(call copy_root, 0, 0, 0640, $(TOPDIR)/etc/generic/gshadow,      /etc/gshadow)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/hostname,     /etc/hostname)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/hosts,        /etc/hosts)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/inittab,      /etc/inittab)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/passwd,       /etc/passwd)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/profile,      /etc/profile)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/proftpd.conf, /etc/proftpd.conf)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/protocols,    /etc/protocols)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/resolv.conf,  /etc/resolv.conf)
	$(call copy_root, 0, 0, 0640, $(TOPDIR)/etc/generic/shadow,       /etc/shadow)
	$(call copy_root, 0, 0, 0600, $(TOPDIR)/etc/generic/shadow-,      /etc/shadow-)
	$(call copy_root, 0, 0, 0644, $(TOPDIR)/etc/generic/udhcpc.script,/etc/udhcpc.script)
	$(call copy_root, 0, 0, 0755, /etc/init.d)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/etc/generic/init.d/banner,     /etc/init.d/banner)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/etc/generic/init.d/networking, /etc/init.d/banner)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/etc/generic/init.d/rcS,        /etc/init.d/banner)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/etc/generic/init.d/utelnetd,   /etc/init.d/banner)
	$(call copy_root, 0, 0, 0755, $(TOPDIR)/etc/generic/init.d/banner,     /etc/init.d/banner)
	$(call copy_root, 0, 0, 0755, /etc/rc.d)

endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean: 
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)

# vim: syntax=make
