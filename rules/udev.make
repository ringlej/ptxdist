# -*-makefile-*-
# $Id: template 2680 2005-05-27 10:29:43Z rsc $
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
UDEV_VERSION	:= 088
UDEV		:= udev-$(UDEV_VERSION)
UDEV_SUFFIX	:= tar.bz2
UDEV_URL	:= http://www.kernel.org/pub/linux/utils/kernel/hotplug/$(UDEV).$(UDEV_SUFFIX)
UDEV_SOURCE	:= $(SRCDIR)/$(UDEV).$(UDEV_SUFFIX)
UDEV_DIR	:= $(BUILDDIR)/$(UDEV)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

udev_get: $(STATEDIR)/udev.get

$(STATEDIR)/udev.get: $(udev_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(UDEV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, UDEV)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

udev_extract: $(STATEDIR)/udev.extract

$(STATEDIR)/udev.extract: $(udev_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UDEV_DIR))
	@$(call extract, UDEV)
	@$(call patchin, UDEV)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

udev_prepare: $(STATEDIR)/udev.prepare

UDEV_PATH	:=  PATH=$(CROSS_PATH)
UDEV_ENV 	:=  $(CROSS_ENV)
UDEV_MAKEVARS	 =  CROSS_COMPILE=$(COMPILER_PREFIX)

ifdef PTXCONF_UDEV_FW_HELPER
UDEV_MAKEVARS	+=  EXTRAS=extras/firmware
endif

$(STATEDIR)/udev.prepare: $(udev_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UDEV_DIR)/config.cache)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

udev_compile: $(STATEDIR)/udev.compile

$(STATEDIR)/udev.compile: $(udev_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(UDEV_DIR) && $(UDEV_ENV) $(UDEV_PATH) make $(UDEV_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

udev_install: $(STATEDIR)/udev.install

$(STATEDIR)/udev.install: $(udev_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

udev_targetinstall: $(STATEDIR)/udev.targetinstall

$(STATEDIR)/udev.targetinstall: $(udev_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, udev)
	@$(call install_fixup, udev,PACKAGE,udev)
	@$(call install_fixup, udev,PRIORITY,optional)
	@$(call install_fixup, udev,VERSION,$(UDEV_VERSION))
	@$(call install_fixup, udev,SECTION,base)
	@$(call install_fixup, udev,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, udev,DEPENDS,)
	@$(call install_fixup, udev,DESCRIPTION,missing)

	@$(call install_copy, udev, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/udev/udev.conf, \
		/etc/udev/udev.conf, n)

#
# Install the startup script on request only
#
ifdef PTXCONF_ROOTFS_ETC_INITD_UDEV
ifdef PTXCONF_ROOTFS_ETC_INITD_UDEV_DEFAULT
# install the generic one
	@$(call install_copy, udev, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/udev, \
		/etc/init.d/udev, n)
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_UDEV_USER
# install users one
	@$(call install_copy, udev, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/udev, \
		/etc/init.d/udev, n)
endif
endif

#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_UDEV_LINK),"")
	@$(call install_copy, udev, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, udev, ../init.d/udev, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_UDEV_LINK))
endif

ifdef PTXCONF_UDEV_UDEV
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udev, \
		/sbin/udev)
endif
ifdef PTXCONF_UDEV_UDEVD
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevd, \
		/sbin/udevd)
endif
ifdef PTXCONF_UDEV_INFO
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevinfo, \
		/sbin/udevinfo)
endif
ifdef PTXCONF_UDEV_SEND
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevsend, \
		/sbin/udevsend)
endif
ifdef PTXCONF_UDEV_START
	@$(call install_copy, udev, 0, 0, 0755, $(UDEV_DIR)/udevstart, \
		/sbin/udevstart)
endif
ifdef PTXCONF_UDEV_TEST
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/udevtest, \
		/sbin/udevtest)
endif

ifdef PTXCONF_UDEV_FW_HELPER
	@$(call install_copy, udev, 0, 0, 0755, \
		$(UDEV_DIR)/extras/firmware/firmware_helper, \
		/sbin/firmware_helper)
endif

	@$(call install_finish, udev)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

udev_clean:
	rm -rf $(STATEDIR)/udev.*
	rm -rf $(IMAGEDIR)/udev_*
	rm -rf $(UDEV_DIR)

# vim: syntax=make
