# -*-makefile-*-
# $Id: rootfs.make,v 1.6 2003/10/23 15:01:19 mkl Exp $
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
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
ROOTFS_EXTRACT 		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rootfs_get: $(STATEDIR)/rootfs.get

$(STATEDIR)/rootfs.get: $(ROOTFS_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(ROOTFS_SOURCE):
	@$(call targetinfo, $@)
	wget -P $(SRCDIR) $(PASSIVEFTP) $(ROOTFS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rootfs_extract: $(STATEDIR)/rootfs.extract

$(STATEDIR)/rootfs.extract: $(STATEDIR)/rootfs.get
	@$(call targetinfo, $@)
	$(ROOTFS_EXTRACT) $(ROOTFS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
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
        ifeq (y, $(PTXCONF_ROOTFS_PROC))
	mkdir -p $(ROOTDIR)/proc
        endif
        ifeq (y, $(PTXCONF_ROOTFS_DEV))
	mkdir -p $(ROOTDIR)/dev
        endif
        ifeq (y, $(PTXCONF_ROOTFS_MNT))
	mkdir -p $(ROOTDIR)/mnt
        endif
        ifeq (y, $(PTXCONF_ROOTFS_FLOPPY))
	mkdir -p $(ROOTDIR)/floppy
        endif
        ifeq (y, $(PTXCONF_ROOTFS_ETC))
	rm -fr $(ROOTDIR)/etc
	mkdir -p $(ROOTDIR)/etc
	cp -a $(TOPDIR)/etc/`ls -1 etc | grep $(PTXCONF_ETC_NAME) | \
	sort | tail -1`/* $(ROOTDIR)/etc/
        ifeq (y,$(PTXCONF_OPENSSH))
	cd $(OPENSSH_DIR) && install -m 644 sshd_config.out $(ROOTDIR)/etc/sshd_config
        endif
        endif
        ifeq (y, $(PTXCONF_ROOTFS_TMP))
	rm -fr $(ROOTDIR)/tmp || true
        ifeq (y, $(PTXCONF_ROOTFS_TMP_DATALINK))
#	# FIXME: can we do this with 'test'?
	ln -s /data/tmp $(ROOTDIR)/tmp
        else
	mkdir -p $(ROOTDIR)/tmp
        endif
        endif
        ifeq (y, $(PTXCONF_ROOTFS_VAR))
	mkdir -p $(ROOTDIR)/var
	mkdir -p $(ROOTDIR)/var/log
        endif
        ifeq (y, $(PTXCONF_ROOTFS_VAR_LOG_DATALINK))
	mkdir -p $(ROOTDIR)/var
#	# FIXME: can we do this with 'test'? 
	rm -fr $(ROOTDIR)/var/log
	ln -s /data/log $(ROOTDIR)/var/log
        endif	
        ifeq (y, $(PTXCONF_ROOTFS_DATA))
	mkdir -p $(ROOTDIR)/data
        endif
        ifeq (y, $(PTXCONF_ROOTFS_HOME))
	mkdir -p $(ROOTDIR)/home
        endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rootfs_clean: 
	rm -rf $(STATEDIR)/rootfs.* $(ROOTFS_DIR)

# vim: syntax=make
