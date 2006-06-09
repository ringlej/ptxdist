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
PACKAGES-$(PTXCONF_UTIL_LINUX) += util-linux

#
# Paths and names
#
UTIL_LINUX_VERSION	= 2.12j
UTIL_LINUX		= util-linux-$(UTIL_LINUX_VERSION)
UTIL_LINUX_SUFFIX	= tar.gz
UTIL_LINUX_URL		= http://ftp.cwi.nl/aeb/util-linux/$(UTIL_LINUX).$(UTIL_LINUX_SUFFIX)
UTIL_LINUX_SOURCE	= $(SRCDIR)/$(UTIL_LINUX).$(UTIL_LINUX_SUFFIX)
UTIL_LINUX_DIR		= $(BUILDDIR)/$(UTIL_LINUX)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

util-linux_get: $(STATEDIR)/util-linux.get

$(STATEDIR)/util-linux.get: $(util-linux_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(UTIL_LINUX_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, UTIL_LINUX)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

util-linux_extract: $(STATEDIR)/util-linux.extract

$(STATEDIR)/util-linux.extract: $(util-linux_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL_LINUX_DIR))
	@$(call extract, UTIL_LINUX)
	@$(call patchin, UTIL_LINUX)

	perl -i -p -e 's/^CPU=.*$$/CPU=$(PTXCONF_ARCH)/g' $(UTIL_LINUX_DIR)/MCONFIG
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

util-linux_prepare: $(STATEDIR)/util-linux.prepare

UTIL_LINUX_PATH	:= PATH=$(CROSS_PATH)
UTIL_LINUX_ENV 	:= $(CROSS_ENV)

$(STATEDIR)/util-linux.prepare: $(util-linux_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(UTIL_LINUX_DIR) && \
		$(UTIL_LINUX_PATH) $(UTIL_LINUX_ENV) \
		./configure
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

util-linux_compile: $(STATEDIR)/util-linux.compile

$(STATEDIR)/util-linux.compile: $(util-linux_compile_deps_default)
	@$(call targetinfo, $@)

	cd $(UTIL_LINUX_DIR)/lib && $(UTIL_LINUX_PATH) make all
ifdef PTXCONF_UTIL_LINUX_MKSWAP
	cd $(UTIL_LINUX_DIR)/disk-utils && $(UTIL_LINUX_PATH) make mkswap
endif
ifdef PTXCONF_UTIL_LINUX_SWAPON
	cd $(UTIL_LINUX_DIR)/mount && $(UTIL_LINUX_PATH) make swapon
endif
ifdef PTXCONF_UTIL_LINUX_MOUNT
	cd $(UTIL_LINUX_DIR)/mount && $(UTIL_LINUX_PATH) make mount
endif
ifdef PTXCONF_UTIL_LINUX_UMOUNT
	cd $(UTIL_LINUX_DIR)/mount && $(UTIL_LINUX_PATH) make umount
endif
ifdef PTXCONF_UTIL_LINUX_IPCS
	cd $(UTIL_LINUX_DIR)/sys-utils && $(UTIL_LINUX_PATH) make ipcs
endif
ifdef PTXCONF_UTIL_LINUX_READPROFILE
	cd $(UTIL_LINUX_DIR)/sys-utils && $(UTIL_LINUX_PATH) make readprofile
endif
ifdef PTXCONF_UTIL_LINUX_FDISK
	cd $(UTIL_LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make fdisk
endif
ifdef PTXCONF_UTIL_LINUX_SFDISK
	cd $(UTIL_LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make sfdisk
endif
ifdef PTXCONF_UTIL_LINUX_CFDISK
	cd $(UTIL_LINUX_DIR)/fdisk && $(UTIL_LINUX_PATH) make cfdisk
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

	@$(call install_init, util-linux)
	@$(call install_fixup, util-linux,PACKAGE,util-linux)
	@$(call install_fixup, util-linux,PRIORITY,optional)
	@$(call install_fixup, util-linux,VERSION,$(UTIL_LINUX_VERSION))
	@$(call install_fixup, util-linux,SECTION,base)
	@$(call install_fixup, util-linux,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, util-linux,DEPENDS,)
	@$(call install_fixup, util-linux,DESCRIPTION,missing)

ifdef PTXCONF_UTIL_LINUX_MKSWAP
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/disk-utils/mkswap, /sbin/mkswap)
endif
ifdef PTXCONF_UTIL_LINUX_SWAPON
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/mount/swapon, /sbin/swapon)
endif
ifdef PTXCONF_UTIL_LINUX_MOUNT
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/mount/mount, /bin/mount)
endif
ifdef PTXCONF_UTIL_LINUX_UMOUNT
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/mount/umount, /bin/umount)
endif
ifdef PTXCONF_UTIL_LINUX_IPCS
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/sys-utils/ipcs, /usr/bin/ipcs)
endif
ifdef PTXCONF_UTIL_LINUX_READPROFILE
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/sys-utils/readprofile, /usr/sbin/readprofile)
endif
ifdef PTXCONF_UTIL_LINUX_FDISK
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/fdisk/fdisk, /usr/sbin/fdisk)
endif
ifdef PTXCONF_UTIL_LINUX_SFDISK
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/fdisk/sfdisk, /usr/sbin/sfdisk)
endif
ifdef PTXCONF_UTIL_LINUX_CFDISK
	@$(call install_copy, util-linux, 0, 0, 0755, $(UTIL_LINUX_DIR)/fdisk/cfdisk, /usr/sbin/cfdisk)
endif
	@$(call install_finish, util-linux)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

util-linux_clean:
	rm -rf $(STATEDIR)/util-linux.*
	rm -rf $(IMAGEDIR)/util-linux_*
	rm -rf $(UTIL_LINUX_DIR)

# vim: syntax=make
