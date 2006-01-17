# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UTLNX) += util-linux

#
# Paths and names
#
UTIL-LINUX_VERSION	= 2.12j
UTIL-LINUX		= util-linux-$(UTIL-LINUX_VERSION)
UTIL-LINUX_SUFFIX	= tar.gz
UTIL-LINUX_URL		= http://ftp.cwi.nl/aeb/util-linux/$(UTIL-LINUX).$(UTIL-LINUX_SUFFIX)
UTLNX_SOURCE	= $(SRCDIR)/$(UTIL-LINUX).$(UTIL-LINUX_SUFFIX)
UTIL-LINUX_DIR		= $(BUILDDIR)/$(UTIL-LINUX)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

util-linux_get: $(STATEDIR)/util-linux.get

$(STATEDIR)/util-linux.get: $(util-linux_get_deps_default)
	@$(call targetinfo, $@)
	@$(call get_patches, $(UTIL-LINUX))
	@$(call touch, $@)

$(UTLNX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(UTIL-LINUX_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

util-linux_extract: $(STATEDIR)/util-linux.extract

$(STATEDIR)/util-linux.extract: $(util-linux_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL-LINUX_DIR))
	@$(call extract, $(UTLNX_SOURCE))
	@$(call patchin, $(UTIL-LINUX))

	perl -i -p -e 's/^CPU=.*$$/CPU=$(PTXCONF_ARCH)/g' $(UTIL-LINUX_DIR)/MCONFIG
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

util-linux_prepare: $(STATEDIR)/util-linux.prepare

UTIL-LINUX_PATH	=  PATH=$(CROSS_PATH)
UTIL-LINUX_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/util-linux.prepare: $(util-linux_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(UTIL-LINUX_DIR) && \
		$(UTIL-LINUX_PATH) $(UTIL-LINUX_ENV) \
		./configure
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

util-linux_compile: $(STATEDIR)/util-linux.compile

$(STATEDIR)/util-linux.compile: $(util-linux_compile_deps_default)
	@$(call targetinfo, $@)

	cd $(UTIL-LINUX_DIR)/lib && $(UTIL-LINUX_PATH) make all
ifdef PTXCONF_UTLNX_MKSWAP
	cd $(UTIL-LINUX_DIR)/disk-utils && $(UTIL-LINUX_PATH) make mkswap
endif
ifdef PTXCONF_UTLNX_SWAPON
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) make swapon
endif
ifdef PTXCONF_UTLNX_MOUNT
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) make mount
endif
ifdef PTXCONF_UTLNX_UMOUNT
	cd $(UTIL-LINUX_DIR)/mount && $(UTIL-LINUX_PATH) make umount
endif
ifdef PTXCONF_UTLNX_IPCS
	cd $(UTIL-LINUX_DIR)/sys-utils && $(UTIL-LINUX_PATH) make ipcs
endif
ifdef PTXCONF_UTLNX_READPROFILE
	cd $(UTIL-LINUX_DIR)/sys-utils && $(UTIL-LINUX_PATH) make readprofile
endif
ifdef PTXCONF_UTLNX_FDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make fdisk
endif
ifdef PTXCONF_UTLNX_SFDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make sfdisk
endif
ifdef PTXCONF_UTLNX_CFDISK
	cd $(UTIL-LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make cfdisk
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

util-linux_install: $(STATEDIR)/util-linux.install

$(STATEDIR)/util-linux.install: $(util-linux_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

util-linux_targetinstall: $(STATEDIR)/util-linux.targetinstall

$(STATEDIR)/util-linux.targetinstall: $(util-linux_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,util-linux)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(UTIL-LINUX_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_UTLNX_MKSWAP
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/disk-utils/mkswap, /sbin/mkswap)
endif
ifdef PTXCONF_UTLNX_SWAPON
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/mount/swapon, /sbin/swapon)
endif
ifdef PTXCONF_UTLNX_MOUNT
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/mount/mount, /sbin/mount)
endif
ifdef PTXCONF_UTLNX_UMOUNT
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/mount/umount, /sbin/umount)
endif
ifdef PTXCONF_UTLNX_IPCS
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/sys-utils/ipcs, /usr/bin/ipcs)
endif
ifdef PTXCONF_UTLNX_READPROFILE
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/sys-utils/readprofile, /usr/sbin/readprofile)
endif
ifdef PTXCONF_UTLNX_FDISK
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/fdisk, /usr/sbin/fdisk)
endif
ifdef PTXCONF_UTLNX_SFDISK
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/sfdisk, /usr/sbin/sfdisk)
endif
ifdef PTXCONF_UTLNX_CFDISK
	@$(call install_copy, 0, 0, 0755, $(UTIL-LINUX_DIR)/fdisk/cfdisk, /usr/sbin/cfdisk)
endif
	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

util-linux_clean:
	rm -rf $(STATEDIR)/util-linux.*
	rm -rf $(IMAGEDIR)/util-linux_*
	rm -rf $(UTIL-LINUX_DIR)

# vim: syntax=make
