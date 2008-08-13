# -*-makefile-*-
# $Id: udev.make,v 1.15 2007/03/07 14:34:52 michl Exp $
#
# Copyright (C) 2005-2006 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UDEV) += udev

#
# Paths and names
#
UDEV_VERSION	:= 125
UDEV		:= udev-$(UDEV_VERSION)
UDEV_SUFFIX	:= tar.bz2
UDEV_URL	:= http://www.kernel.org/pub/linux/utils/kernel/hotplug/$(UDEV).$(UDEV_SUFFIX)
UDEV_SOURCE	:= $(SRCDIR)/$(UDEV).$(UDEV_SUFFIX)
UDEV_DIR	:= $(BUILDDIR)/$(UDEV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(UDEV_SOURCE):
	@$(call targetinfo)
	@$(call get, UDEV)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UDEV_OPTIONS	:=

# compile options

ifdef PTXCONF_UDEV_OPT_DEBUG
UDEV_OPTIONS	+= DEBUG=true
else
UDEV_OPTIONS	+= DEBUG=false
endif

ifdef PTXCONF_UDEV_OPT_GCOV
UDEV_OPTIONS	+= USE_GCOV=true
else
UDEV_OPTIONS	+= USE_GCOV=false
endif

UDEV_OPTIONS	+= USE_SELINUX=false

ifdef PTXCONF_UDEV_OPT_SYSLOG
UDEV_OPTIONS	+= USE_LOG=true
else
UDEV_OPTIONS	+= USE_LOG=false
endif


# extras

ifdef PTXCONF_UDEV_EXTRA_ATA_ID
UDEV_EXTRAS	+= extras/ata_id
endif

ifdef PTXCONF_UDEV_EXTRA_CDROM_ID
UDEV_EXTRAS	+= extras/cdrom_id
endif

ifdef PTXCONF_UDEV_EXTRA_COLLECT
UDEV_EXTRAS	+= extras/collect
endif

ifdef PTXCONF_UDEV_EXTRA_EDD_ID
UDEV_EXTRAS	+= extras/edd_id
endif

ifdef PTXCONF_UDEV_EXTRA_FIRMWARE
UDEV_EXTRAS	+= extras/firmware
endif

ifdef PTXCONF_UDEV_EXTRA_FLOPPY
UDEV_EXTRAS	+= extras/floppy
endif

ifdef PTXCONF_UDEV_EXTRA_FSTAB_IMPORT
UDEV_EXTRAS	+= extras/fstab_import
endif

ifdef PTXCONF_UDEV_EXTRA_PATH_ID
UDEV_EXTRAS	+= extras/path_id
endif

ifdef PTXCONF_UDEV_EXTRA_RULE_GENERATOR
UDEV_EXTRAS	+= extras/rule_generator
endif

ifdef PTXCONF_UDEV_EXTRA_SCSI_ID
UDEV_EXTRAS	+= extras/scsi_id
endif

ifdef PTXCONF_UDEV_EXTRA_USB_ID
UDEV_EXTRAS	+= extras/usb_id
endif

ifdef PTXCONF_UDEV_EXTRA_VOLUME_ID
UDEV_EXTRAS	+= extras/volume_id
endif

# specify configuration

UDEV_PATH	:=  PATH=$(CROSS_PATH)
UDEV_ENV 	:=  $(CROSS_ENV)
UDEV_MAKEVARS	:= \
	CROSS_COMPILE=$(COMPILER_PREFIX) \
	$(UDEV_OPTIONS) \
	EXTRAS="$(UDEV_EXTRAS)" 

$(STATEDIR)/udev.prepare:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/udev.compile:
	@$(call targetinfo)
	cd $(UDEV_DIR) && \
		$(UDEV_ENV) $(UDEV_PATH) \
		$(MAKE) $(PARALLELMFLAGS) $(UDEV_MAKEVARS)
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/udev.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/udev.targetinstall:
	@$(call targetinfo)

	@$(call install_init, udev)
	@$(call install_fixup, udev,PACKAGE,udev)
	@$(call install_fixup, udev,PRIORITY,optional)
	@$(call install_fixup, udev,VERSION,$(UDEV_VERSION))
	@$(call install_fixup, udev,SECTION,base)
	@$(call install_fixup, udev,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, udev,DEPENDS,)
	@$(call install_fixup, udev,DESCRIPTION,missing)

	#
	# binaries
	#

ifdef PTXCONF_UDEV_INSTALL_UDEVD
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevd, \
		/sbin/udevd)
endif
ifdef PTXCONF_UDEV_INSTALL_UDEVADM
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevadm, \
		/sbin/udevadm)
endif
ifdef PTXCONF_UDEV_INSTALL_TEST_UDEV
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/test-udev, \
		/sbin/test-udev)
endif

	#
	# on-board configuration: this part is mandatory and was made
	# by the upstream maintainers in a way that it can be exchanged
	# by distro packets without interfering with local changes
	#

	cd $(UDEV_DIR)/rules/rules.d; \
	for file in *; do \
		$(call install_copy, udev, 0, 0, 0644, $(UDEV_DIR)/rules/rules.d/$$file, /lib/udev/rules.d/$$file, n); \
	done

ifdef PTXCONF_UDEV_EXTRA_SCSI_ID
	@$(call install_copy, udev, 0, 0, 0644, \
		$(UDEV_DIR)/extras/scsi_id/scsi_id.config, \
		/etc/scsi_id.config, n)
endif

	#
	# startup scripts
	#

ifdef PTXCONF_UDEV_INSTALL_ETC_INITD_UDEV
ifdef PTXCONF_UDEV_INSTALL_ETC_INITD_UDEV_DEFAULT
	@$(call install_copy, udev, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/udev, \
		/etc/init.d/udev, n)
endif
ifdef PTXCONF_UDEV_INSTALL_ETC_INITD_UDEV_USER
	@$(call install_copy, udev, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/udev, \
		/etc/init.d/udev, n)
endif
# FIXME: Is this packet the right location for the link?
ifneq ($(PTXCONF_UDEV_RC_D_LINK),"")
	@$(call install_copy, udev, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, udev, ../init.d/udev, \
		/etc/rc.d/$(PTXCONF_UDEV_RC_D_LINK))
endif
endif


##
## Install a configuration on demand only
##
#ifdef PTXCONF_ROOTFS_ETC_UDEV_CONF
#ifdef PTXCONF_ROOTFS_ETC_UDEV_CONF_DEFAULT
## use generic
#	@$(call install_copy, udev, 0, 0, 0644, \
#		$(PTXDIST_TOPDIR)/generic/etc/udev/udev.conf, \
#		/etc/udev/udev.conf, n)
#	@$(call install_copy, udev, 0, 0, 0644, \
#		$(PTXDIST_TOPDIR)/generic/etc/udev/permissions.rules, \
#		/etc/udev/permissions.rules, n)
#endif
#ifdef PTXCONF_ROOTFS_ETC_UDEV_CONF_USER
## user defined
#	@$(call install_copy, udev, 0, 0, 0644, \
#		$(PTXDIST_WORKSPACE)/projectroot/etc/udev/udev.conf, \
#		/etc/udev/udev.conf, n)
#	@$(call install_copy, udev, 0, 0, 0644, \
#		$(PTXDIST_WORKSPACE)/projectroot/etc/udev/permissions.rules, \
#		/etc/udev/permissions.rules, n)
#endif
#endif
##
## install all user defined rule files
##
#ifdef PTXCONF_ROOTFS_ETC_UDEV_USER_RULES
## create the rules directory as currently stated in the generic config
## FIXME: if the user defines a different directory in his own udev.conf
##        this will fail!
##
#	@$(call install_copy, udev, 0, 0, 0755, \
#		/etc/udev/rules.d)
## copy *all* *.rules files into targets rule directory
##
#	@cd $(PTXDIST_WORKSPACE)/projectroot/etc/udev/rules.d; \
#	for i in *.rules; do \
#		$(call install_copy, udev, 0, 0, 0644, $$i, \
#			/etc/udev/rules.d/$$i,n); \
#	done;
#endif
#ifdef PTXCONF_ROOTFS_ETC_UDEV_DEFAULT_RULES
#	@$(call install_copy, udev, 0, 0, 0644, \
#		$(PTXDIST_TOPDIR)/generic/etc/udev/rules.d/udev.rules, \
#		/etc/udev/rules.d/udev.rules, n)
#endif
#ifdef PTXCONF_UDEV_INFO
#	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevinfo, \
#		/sbin/udevinfo)
#endif
#ifdef PTXCONF_UDEV_START
#	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevstart, \
#		/sbin/udevstart)
#endif
#ifdef PTXCONF_UDEV_TEST
#	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevtest, \
#		/sbin/udevtest)
#endif
#ifdef PTXCONF_UDEV_TRIGGER
#	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevtrigger, \
#		/sbin/udevtrigger)
#endif
#ifdef PTXCONF_UDEV_SETTLE
#	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevsettle, \
#		/sbin/udevsettle)
#endif
#ifdef PTXCONF_UDEV_CONTROL
#	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevcontrol, \
#		/sbin/udevcontrol)
#endif
#ifdef PTXCONF_UDEV_MONITOR
#	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevmonitor, \
#		/sbin/udevmonitor)
#endif
#ifdef PTXCONF_UDEV_USB_ID
#	@$(call install_copy, udev, 0, 0, 0755, \
#		$(UDEV_DIR)/extras/usb_id/usb_id, \
#		/sbin/usbid)
#endif
#ifdef PTXCONF_UDEV_FW_HELPER
#	@$(call install_copy, udev, 0, 0, 0755, \
#		$(UDEV_DIR)/extras/firmware/firmware.sh, \
#		/sbin/firmware.sh,n)
#endif
#
	@$(call install_finish, udev)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

udev_clean:
	rm -rf $(STATEDIR)/udev.*
	rm -rf $(PKGDIR)/udev_*
	rm -rf $(UDEV_DIR)

# vim: syntax=make
