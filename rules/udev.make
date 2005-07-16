# $Id: template 2680 2005-05-27 10:29:43Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_UDEV
PACKAGES += udev
endif

#
# Paths and names
#
UDEV_VERSION	= 058
UDEV		= udev-$(UDEV_VERSION)
UDEV_SUFFIX	= tar.gz
UDEV_URL	= http://www.kernel.org/pub/linux/utils/kernel/hotplug/$(UDEV).$(UDEV_SUFFIX)
UDEV_SOURCE	= $(SRCDIR)/$(UDEV).$(UDEV_SUFFIX)
UDEV_DIR	= $(BUILDDIR)/$(UDEV)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

udev_get: $(STATEDIR)/udev.get

udev_get_deps = $(UDEV_SOURCE)

$(STATEDIR)/udev.get: $(udev_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(UDEV))
	touch $@

$(UDEV_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(UDEV_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

udev_extract: $(STATEDIR)/udev.extract

udev_extract_deps = $(STATEDIR)/udev.get

$(STATEDIR)/udev.extract: $(udev_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(UDEV_DIR))
	@$(call extract, $(UDEV_SOURCE))
	@$(call patchin, $(UDEV))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

udev_prepare: $(STATEDIR)/udev.prepare

#
# dependencies
#
udev_prepare_deps = \
	$(STATEDIR)/udev.extract \
	$(STATEDIR)/virtual-xchain.install

UDEV_PATH	=  PATH=$(CROSS_PATH)
UDEV_ENV 	=  $(CROSS_ENV)
UDEV_MAKEVARS	=  CROSS=$(COMPILER_PREFIX)

$(STATEDIR)/udev.prepare: $(udev_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(UDEV_DIR)/config.cache)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

udev_compile: $(STATEDIR)/udev.compile

udev_compile_deps = $(STATEDIR)/udev.prepare

$(STATEDIR)/udev.compile: $(udev_compile_deps)
	@$(call targetinfo, $@)
	cd $(UDEV_DIR) && $(UDEV_ENV) $(UDEV_PATH) make $(UDEV_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

udev_install: $(STATEDIR)/udev.install

$(STATEDIR)/udev.install: $(STATEDIR)/udev.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

udev_targetinstall: $(STATEDIR)/udev.targetinstall

udev_targetinstall_deps = $(STATEDIR)/udev.compile

$(STATEDIR)/udev.targetinstall: $(udev_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,udev)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(UDEV_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(UDEV_DIR)/extras/start_udev, /etc/init.d/udev, n)

ifdef PTXCONF_UDEV_UDEV
	@$(call install_copy, 0, 0, 0755, $(UDEV_DIR)/udev, /sbin/udev)
endif
ifdef PTXCONF_UDEV_UDEVD
	@$(call install_copy, 0, 0, 0755, $(UDEV_DIR)/udevd, /sbin/udevd)
endif
ifdef PTXCONF_UDEV_INFO
	@$(call install_copy, 0, 0, 0755, $(UDEV_DIR)/udevinfo, /sbin/udevinfo)
endif
ifdef PTXCONF_UDEV_SEND
	@$(call install_copy, 0, 0, 0755, $(UDEV_DIR)/udevsend, /sbin/udevsend)
endif
ifdef PTXCONF_UDEV_START
	@$(call install_copy, 0, 0, 0755, $(UDEV_DIR)/udevstart, /sbin/udevstart)
endif
ifdef PTXCONF_UDEV_TEST
	@$(call install_copy, 0, 0, 0755, $(UDEV_DIR)/udevtest, /sbin/udevtest)
endif

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

udev_clean:
	rm -rf $(STATEDIR)/udev.*
	rm -rf $(IMAGEDIR)/udev_*
	rm -rf $(UDEV_DIR)

# vim: syntax=make
