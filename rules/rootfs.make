# $Id: rootfs.make,v 1.1 2003/04/24 08:06:33 jst Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
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
	touch $@

$(ROOTFS_SOURCE):
	@echo
	@echo ------------------
	@echo target: rootfs.get
	@echo ------------------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(ROOTFS_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rootfs_extract: $(STATEDIR)/rootfs.extract

$(STATEDIR)/rootfs.extract: $(STATEDIR)/rootfs.get
	@echo
	@echo ----------------------
	@echo target: rootfs.extract
	@echo ----------------------
	@echo
	$(ROOTFS_EXTRACT) $(ROOTFS_SOURCE) | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rootfs_prepare: $(STATEDIR)/rootfs.prepare

$(STATEDIR)/rootfs.prepare: $(STATEDIR)/rootfs.extract
	@echo
	@echo ----------------------
	@echo target: rootfs.prepare
	@echo ----------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rootfs_compile: $(STATEDIR)/rootfs.compile

$(STATEDIR)/rootfs.compile: $(STATEDIR)/rootfs.prepare 
	@echo
	@echo ----------------------
	@echo target: rootfs.compile
	@echo ----------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rootfs_install: $(STATEDIR)/rootfs.install

$(STATEDIR)/rootfs.install: $(STATEDIR)/rootfs.compile
	@echo
	@echo ----------------------
	@echo target: rootfs.install
	@echo ----------------------
	@echo
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rootfs_targetinstall: $(STATEDIR)/rootfs.targetinstall

$(STATEDIR)/rootfs.targetinstall: $(STATEDIR)/rootfs.install
	@echo
	@echo ----------------------------
	@echo target: rootfs.targetinstall
	@echo ----------------------------
	@echo
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
	cp -a $(TOPDIR)/etc/$(PTXCONF_ETC_NAME)/* $(ROOTDIR)/etc/
        endif
        ifeq (y, $(PTXCONF_ROOTFS_TMP))
        ifeq (y, $(PTXCONF_ROOTFS_TMP_DATALINK))
#	# FIXME: can we do this with 'test'?
	rm -fr $(ROOTDIR)/tmp
	ln -s /data/tmp $(ROOTDIR)/tmp
        else
	mkdir -p $(ROOTDIR)/tmp
        endif
        endif
        ifeq (y, $(PTXCONF_ROOTFS_VAR))
	mkdir -p $(ROOTDIR)/var
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
