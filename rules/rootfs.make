# -*-makefile-*-
# $Id: rootfs.make,v 1.8 2004/07/01 16:07:33 rsc Exp $
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

ifdef PTXCONF_ROOTFS_ETC
	@$(call clean, $(ROOTDIR)/etc)
	mkdir -p $(ROOTDIR)/etc
	cp -a $(TOPDIR)/etc/`ls -1 etc | grep $(PTXCONF_ETC_NAME) | sort | tail -1`/* $(ROOTDIR)/etc/

  ifdef PTXCONF_OPENSSH
	cd $(OPENSSH_DIR) && install -m 644 sshd_config.out $(ROOTDIR)/etc/ssh/sshd_config
  endif
endif

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

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean: 
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)

# vim: syntax=make
