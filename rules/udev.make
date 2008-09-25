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
UDEV_VERSION	:= 128
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

udev_prepare: $(STATEDIR)/udev.prepare

UDEV_PATH	=  PATH=$(CROSS_PATH)
UDEV_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
UDEV_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--enable-shared

ifdef PTXCONF_UDEV__DEBUG
UDEV_AUTOCONF	+= --enable-debug
else
UDEV_AUTOCONF	+= --disable-debug
endif

ifdef PTXCONF_UDEV__SELINUX
UDEV_AUTOCONF	+= --enable-selinux
else
UDEV_AUTOCONF	+= --disable-selinux
endif

ifdef PTXCONF_UDEV__SYSLOG
UDEV_AUTOCONF	+= --enable-logging
else
UDEV_AUTOCONF	+= --disable-logging
endif

$(STATEDIR)/udev.prepare: $(udev_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UDEV_DIR)/config.cache)
	cd $(UDEV_DIR) && \
		$(UDEV_PATH) $(UDEV_ENV) \
		./configure $(UDEV_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/udev.compile:
	@$(call targetinfo)
	cd $(UDEV_DIR) && \
		$(UDEV_ENV) $(UDEV_PATH) $(MAKE) $(PARALLELMFLAGS)
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

	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udev/udevd, \
		/sbin/udevd)
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udev/udevadm, \
		/sbin/udevadm)
ifdef PTXCONF_UDEV__INSTALL_TEST_UDEV
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udev/test-udev, \
		/sbin/test-udev)
endif

	#
	# default rules
	#

ifdef PTXCONF_ROOTFS_UDEV__DEFAULT_RULES
	cd $(UDEV_DIR)/rules/rules.d; \
	for file in *; do \
		$(call install_copy, udev, 0, 0, 0644, $(UDEV_DIR)/rules/rules.d/$$file, /lib/udev/rules.d/$$file, n); \
	done
endif

	#
	# startup scripts
	#

ifdef PTXCONF_UDEV__INSTALL_ETC_INITD_UDEV
ifdef PTXCONF_UDEV__INSTALL_ETC_INITD_UDEV__DEFAULT
	@$(call install_copy, udev, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/udev, \
		/etc/init.d/udev, n)
endif
ifdef PTXCONF_UDEV__INSTALL_ETC_INITD_UDEV__USER
	@$(call install_copy, udev, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/udev, \
		/etc/init.d/udev, n)
endif
# FIXME: Is this packet the right location for the link?
ifneq ($(PTXCONF_UDEV__RC_D_LINK),"")
	@$(call install_copy, udev, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, udev, ../init.d/udev, \
		/etc/rc.d/$(PTXCONF_UDEV__RC_D_LINK))
endif
endif


#
# Install a configuration on demand only
#
ifdef PTXCONF_ROOTFS_ETC_UDEV__CONF
ifdef PTXCONF_ROOTFS_ETC_UDEV__CONF_DEFAULT
# use generic
	@$(call install_copy, udev, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/udev/udev.conf, \
		/etc/udev/udev.conf, n)
	@$(call install_copy, udev, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/udev/permissions.rules, \
		/etc/udev/permissions.rules, n)
endif
ifdef PTXCONF_ROOTFS_ETC_UDEV__CONF_USER
# user defined
	@$(call install_copy, udev, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/udev/udev.conf, \
		/etc/udev/udev.conf, n)
	@$(call install_copy, udev, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/udev/permissions.rules, \
		/etc/udev/permissions.rules, n)
endif
endif

	#
	# utilities from extra/
	#

ifdef PTXCONF_UDEV__EXTRA_USB_ID
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/usb_id/usb_id, \
		/lib/udev/usbid)
endif
ifdef PTXCONF_UDEV__EXTRA_FIRMWARE
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/firmware/firmware.sh, \
		/lib/udev/firmware.sh,n)
endif

ifdef PTXCONF_UDEV__EXTRA_SCSI_ID
	@$(call install_copy, udev, 0, 0, 0644, \
		$(UDEV_DIR)/extras/scsi_id/scsi_id.config, \
		/etc/scsi_id.config, n)
endif

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
