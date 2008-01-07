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
PACKAGES-$(PTXCONF_HOTPLUG) += hotplug

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

$(STATEDIR)/hotplug.get: $(hotplug_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(HOTPLUG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, HOTPLUG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

hotplug_extract: $(STATEDIR)/hotplug.extract

$(STATEDIR)/hotplug.extract: $(hotplug_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOTPLUG_DIR))
	@$(call extract, HOTPLUG)
	@$(call patchin, HOTPLUG)

	perl -i -p -e "s,/bin/bash,/bin/sh,g" $(HOTPLUG_DIR)/etc/hotplug.d/default/default.hotplug

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

hotplug_prepare: $(STATEDIR)/hotplug.prepare

$(STATEDIR)/hotplug.prepare: $(hotplug_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

hotplug_compile: $(STATEDIR)/hotplug.compile

$(STATEDIR)/hotplug.compile: $(hotplug_compile_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

hotplug_install: $(STATEDIR)/hotplug.install

$(STATEDIR)/hotplug.install: $(hotplug_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, HOTPLUG,,,prefix=$(SYSROOT) SHELL=/bin/bash)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

hotplug_targetinstall: $(STATEDIR)/hotplug.targetinstall

$(STATEDIR)/hotplug.targetinstall: $(hotplug_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, hotplug)
	@$(call install_fixup, hotplug,PACKAGE,hotplug)
	@$(call install_fixup, hotplug,PRIORITY,optional)
	@$(call install_fixup, hotplug,VERSION,$(subst _,,$(HOTPLUG_VERSION)))
	@$(call install_fixup, hotplug,SECTION,base)
	@$(call install_fixup, hotplug,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, hotplug,DEPENDS,)
	@$(call install_fixup, hotplug,DESCRIPTION,missing)

	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/sbin/hotplug, /sbin/hotplug, n)
	@$(call install_copy, hotplug, 0, 0, 0644, $(HOTPLUG_DIR)/etc/hotplug/hotplug.functions, /etc/hotplug/hotplug.functions, n)
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug.d/default/default.hotplug, /etc/hotplug.d/default/default.hotplug, n)

ifdef PTXCONF_HOTPLUG_BLACKLIST
	@$(call install_copy, hotplug, 0, 0, 0644, $(HOTPLUG_DIR)/etc/hotplug/blacklist, /etc/hotplug/blacklist, n)
endif
ifdef PTXCONF_HOTPLUG_FIRMWARE
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/firmware.agent, /etc/hotplug/firmware.agent, n)
	@$(call install_copy, hotplug, 0, 0, 0755, /usr/lib/hotplug/firmware)
endif
ifdef PTXCONF_HOTPLUG_IEEE1394
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/ieee1394.agent, /etc/hotplug/ieee1394.agent, n)
endif
ifdef PTXCONF_HOTPLUG_NET
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/net.agent, /etc/hotplug/net.agent, n)
endif
ifdef PTXCONF_HOTPLUG_PCI
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/pci.agent, /etc/hotplug/pci.agent, n)
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/pci.rc, /etc/hotplug/pci.rc, n)
	@$(call install_copy, hotplug, 0, 0, 0755, /etc/hotplug/pci)
endif
ifdef PTXCONF_HOTPLUG_SCSI
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/scsi.agent, /etc/hotplug/scsi.agent, n)
endif
ifdef PTXCONF_HOTPLUG_USB
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/usb.agent, /etc/hotplug/usb.agent, n)
	@$(call install_copy, hotplug, 0, 0, 0644, $(HOTPLUG_DIR)/etc/hotplug/usb.distmap, /etc/hotplug/usb.distmap, n)
	@$(call install_copy, hotplug, 0, 0, 0644, $(HOTPLUG_DIR)/etc/hotplug/usb.handmap, /etc/hotplug/usb.handmap, n)
	@$(call install_copy, hotplug, 0, 0, 0644, $(HOTPLUG_DIR)/etc/hotplug/usb.usermap, /etc/hotplug/usb.usermap, n)
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/usb.rc, /etc/hotplug/usb.rc, n)
	@$(call install_copy, hotplug, 0, 0, 0755, /etc/hotplug/usb.d)
endif
ifdef PTXCONF_HOTPLUG_INPUT
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/input.agent, /etc/hotplug/input.agent, n)
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/input.rc, /etc/hotplug/input.rc, n)
endif
ifdef PTXCONF_HOTPLUG_DASD
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/dasd.agent, /etc/hotplug/dasd.agent, n)
	@$(call install_copy, hotplug, 0, 0, 0644, $(HOTPLUG_DIR)/etc/hotplug/dasd.permissions, /etc/hotplug/dasd.permissions, n)
endif
ifdef PTXCONF_HOTPLUG_TAPE
	@$(call install_copy, hotplug, 0, 0, 0755, $(HOTPLUG_DIR)/etc/hotplug/tape.agent, /etc/hotplug/tape.agent, n)
	@$(call install_copy, hotplug, 0, 0, 0644, $(HOTPLUG_DIR)/etc/hotplug/tape.permissions, /etc/hotplug/tape.permissions, n)
endif

	@$(call install_finish, hotplug)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

hotplug_clean:
	rm -rf $(STATEDIR)/hotplug.*
	rm -rf $(IMAGEDIR)/hotplug_*
	rm -rf $(HOTPLUG_DIR)

# vim: syntax=make
