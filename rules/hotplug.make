# -*-makefile-*-
# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_HOTPLUG
PACKAGES += hotplug
endif

#
# Paths and names
#
HOTPLUG_VERSION		= 2004_03_29
HOTPLUG			= hotplug-$(HOTPLUG_VERSION)
HOTPLUG_SUFFIX		= tar.gz
HOTPLUG_URL		= $(PTXCONF_SETUP_SFMIRROR)/linux-hotplug/$(HOTPLUG).$(HOTPLUG_SUFFIX)
HOTPLUG_SOURCE		= $(SRCDIR)/$(HOTPLUG).$(HOTPLUG_SUFFIX)
HOTPLUG_DIR		= $(BUILDDIR)/$(HOTPLUG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

hotplug_get: $(STATEDIR)/hotplug.get

hotplug_get_deps = $(HOTPLUG_SOURCE)

$(STATEDIR)/hotplug.get: $(hotplug_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(HOTPLUG))
	touch $@

$(HOTPLUG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(HOTPLUG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hotplug_extract: $(STATEDIR)/hotplug.extract

hotplug_extract_deps = $(STATEDIR)/hotplug.get

$(STATEDIR)/hotplug.extract: $(hotplug_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(HOTPLUG_DIR))
	@$(call extract, $(HOTPLUG_SOURCE))
	@$(call patchin, $(HOTPLUG))

	perl -i -p -e "s,/bin/bash,/bin/sh,g" $(HOTPLUG_DIR)/etc/hotplug.d/default/default.hotplug

	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hotplug_prepare: $(STATEDIR)/hotplug.prepare

hotplug_prepare_deps = $(STATEDIR)/hotplug.extract

$(STATEDIR)/hotplug.prepare: $(hotplug_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hotplug_compile: $(STATEDIR)/hotplug.compile

hotplug_compile_deps = $(STATEDIR)/hotplug.prepare

$(STATEDIR)/hotplug.compile: $(hotplug_compile_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hotplug_install: $(STATEDIR)/hotplug.install

$(STATEDIR)/hotplug.install: $(STATEDIR)/hotplug.compile
	@$(call targetinfo, $@)
	cd $(HOTPLUG_DIR) && $(HOTPLUG_ENV) $(HOTPLUG_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hotplug_targetinstall: $(STATEDIR)/hotplug.targetinstall

hotplug_targetinstall_deps = $(STATEDIR)/hotplug.compile

$(STATEDIR)/hotplug.targetinstall: $(hotplug_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/sbin
	install -d $(ROOTDIR)/etc/hotplug
	install $(HOTPLUG_DIR)/sbin/hotplug $(ROOTDIR)/sbin/hotplug
	install $(HOTPLUG_DIR)/etc/hotplug/hotplug.functions $(ROOTDIR)/etc/hotplug/hotplug.functions
	install -d $(ROOTDIR)/etc/hotplug.d/default
	install $(HOTPLUG_DIR)/etc/hotplug.d/default/default.hotplug $(ROOTDIR)/etc/hotplug.d/default/default.hotplug
ifdef PTXCONF_HOTPLUG_BLACKLIST
	install $(HOTPLUG_DIR)/etc/hotplug/blacklist $(ROOTDIR)/etc/hotplug/blacklist
endif
ifdef PTXCONF_HOTPLUG_FIRMWARE
	install $(HOTPLUG_DIR)/etc/hotplug/firmware.agent $(ROOTDIR)/etc/hotplug/firmware.agent
	install -d $(ROOTDIR)/usr/lib/hotplug/firmware
endif
ifdef PTXCONF_HOTPLUG_IEEE1394
	install $(HOTPLUG_DIR)/etc/hotplug/ieee1394.agent $(ROOTDIR)/etc/hotplug/ieee1394.agent
endif
ifdef PTXCONF_HOTPLUG_NET
	install $(HOTPLUG_DIR)/etc/hotplug/net.agent $(ROOTDIR)/etc/hotplug/net.agent
endif
ifdef PTXCONF_HOTPLUG_PCI
	install $(HOTPLUG_DIR)/etc/hotplug/pci.agent $(ROOTDIR)/etc/hotplug/pci.agent
	install $(HOTPLUG_DIR)/etc/hotplug/pci.rc $(ROOTDIR)/etc/hotplug/pci.rc
	install -d $(ROOTDIR)/etc/hotplug/pci
endif
ifdef PTXCONF_HOTPLUG_SCSI
	install $(HOTPLUG_DIR)/etc/hotplug/scsi.agent $(ROOTDIR)/etc/hotplug/scsi.agent
endif
ifdef PTXCONF_HOTPLUG_USB
	install $(HOTPLUG_DIR)/etc/hotplug/usb.agent $(ROOTDIR)/etc/hotplug/usb.agent
	install $(HOTPLUG_DIR)/etc/hotplug/usb.distmap $(ROOTDIR)/etc/hotplug/usb.distmap
	install $(HOTPLUG_DIR)/etc/hotplug/usb.handmap $(ROOTDIR)/etc/hotplug/usb.handmap
	install $(HOTPLUG_DIR)/etc/hotplug/usb.usermap $(ROOTDIR)/etc/hotplug/usb.usermap
	install $(HOTPLUG_DIR)/etc/hotplug/usb.rc $(ROOTDIR)/etc/hotplug/usb.rc
	install -d $(ROOTDIR)/etc/hotplug/usb.d
endif
ifdef PTXCONF_HOTPLUG_INPUT
	install $(HOTPLUG_DIR)/etc/hotplug/input.agent $(ROOTDIR)/etc/hotplug/input.agent
	install $(HOTPLUG_DIR)/etc/hotplug/input.rc $(ROOTDIR)/etc/hotplug/input.rc
endif
ifdef PTXCONF_HOTPLUG_DASD
	install $(HOTPLUG_DIR)/etc/hotplug/dasd.agent $(ROOTDIR)/etc/hotplug/dasd.agent
	install $(HOTPLUG_DIR)/etc/hotplug/dasd.permissions $(ROOTDIR)/etc/hotplug/dasd.permissions
endif
ifdef PTXCONF_HOTPLUG_TAPE
	install $(HOTPLUG_DIR)/etc/hotplug/tape.agent $(ROOTDIR)/etc/hotplug/tape.agent
	install $(HOTPLUG_DIR)/etc/hotplug/tape.permissions $(ROOTDIR)/etc/hotplug/tape.permissions
endif

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hotplug_clean:
	rm -rf $(STATEDIR)/hotplug.*
	rm -rf $(HOTPLUG_DIR)

# vim: syntax=make
