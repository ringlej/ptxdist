# -*-makefile-*-
# $Id: template-make 7626 2007-11-26 10:27:03Z mkl $
#
# Copyright (C) 2008 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_UTIL_LINUX_NG) += util-linux-ng

#
# Paths and names
#
UTIL_LINUX_NG_VERSION	:= 2.13.1-rc2
UTIL_LINUX_NG		:= util-linux-ng-$(UTIL_LINUX_NG_VERSION)
UTIL_LINUX_NG_SUFFIX	:= tar.bz2
UTIL_LINUX_NG_URL	:= ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.13/$(UTIL_LINUX_NG).$(UTIL_LINUX_NG_SUFFIX)
UTIL_LINUX_NG_SOURCE	:= $(SRCDIR)/$(UTIL_LINUX_NG).$(UTIL_LINUX_NG_SUFFIX)
UTIL_LINUX_NG_DIR	:= $(BUILDDIR)/$(UTIL_LINUX_NG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

util-linux-ng_get: $(STATEDIR)/util-linux-ng.get

$(STATEDIR)/util-linux-ng.get: $(util-linux-ng_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(UTIL_LINUX_NG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, UTIL_LINUX_NG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

util-linux-ng_extract: $(STATEDIR)/util-linux-ng.extract

$(STATEDIR)/util-linux-ng.extract: $(util-linux-ng_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL_LINUX_NG_DIR))
	@$(call extract, UTIL_LINUX_NG)
	@$(call patchin, UTIL_LINUX_NG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

util-linux-ng_prepare: $(STATEDIR)/util-linux-ng.prepare

UTIL_LINUX_NG_PATH	:= PATH=$(CROSS_PATH)
UTIL_LINUX_NG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
UTIL_LINUX_NG_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/util-linux-ng.prepare: $(util-linux-ng_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(UTIL_LINUX_NG_DIR)/config.cache)
	cd $(UTIL_LINUX_NG_DIR) && \
		$(UTIL_LINUX_NG_PATH) $(UTIL_LINUX_NG_ENV) \
		./configure $(UTIL_LINUX_NG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

util-linux-ng_compile: $(STATEDIR)/util-linux-ng.compile

$(STATEDIR)/util-linux-ng.compile: $(util-linux-ng_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(UTIL_LINUX_NG_DIR) && $(UTIL_LINUX_NG_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

util-linux-ng_install: $(STATEDIR)/util-linux-ng.install

$(STATEDIR)/util-linux-ng.install: $(util-linux-ng_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, UTIL_LINUX_NG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

util-linux-ng_targetinstall: $(STATEDIR)/util-linux-ng.targetinstall

$(STATEDIR)/util-linux-ng.targetinstall: $(util-linux-ng_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, util-linux-ng)
	@$(call install_fixup, util-linux-ng,PACKAGE,util-linux-ng)
	@$(call install_fixup, util-linux-ng,PRIORITY,optional)
	@$(call install_fixup, util-linux-ng,VERSION,$(UTIL_LINUX_NG_VERSION))
	@$(call install_fixup, util-linux-ng,SECTION,base)
	@$(call install_fixup, util-linux-ng,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, util-linux-ng,DEPENDS,)
	@$(call install_fixup, util-linux-ng,DESCRIPTION,missing)

ifdef PTXCONF_UTIL_LINUX_NG_MKSWAP
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/disk-utils/mkswap, /sbin/mkswap)
endif
ifdef PTXCONF_UTIL_LINUX_NG_SWAPON
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/mount/swapon, /sbin/swapon)
endif
ifdef PTXCONF_UTIL_LINUX_NG_MOUNT
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/mount/mount, /bin/mount)
endif
ifdef PTXCONF_UTIL_LINUX_NG_UMOUNT
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/mount/umount, /bin/umount)
endif
ifdef PTXCONF_UTIL_LINUX_NG_IPCS
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/sys-utils/ipcs, /usr/bin/ipcs)
endif
ifdef PTXCONF_UTIL_LINUX_NG_READPROFILE
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/sys-utils/readprofile, /usr/sbin/readprofile)
endif
ifdef PTXCONF_UTIL_LINUX_NG_FDISK
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/fdisk/fdisk, /usr/sbin/fdisk)
endif
ifdef PTXCONF_UTIL_LINUX_NG_SFDISK
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/fdisk/sfdisk, /usr/sbin/sfdisk)
endif
ifdef PTXCONF_UTIL_LINUX_NG_CFDISK
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/fdisk/cfdisk, /usr/sbin/cfdisk)
endif
ifdef PTXCONF_UTIL_LINUX_NG_SETTERM
	@$(call install_copy, util-linux-ng, 0, 0, 0755, $(UTIL_LINUX_NG_DIR)/misc-utils/setterm, /usr/bin/setterm)
endif

	@$(call install_finish, util-linux-ng)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

util-linux-ng_clean:
	rm -rf $(STATEDIR)/util-linux-ng.*
	rm -rf $(PKGDIR)/util-linux-ng_*
	rm -rf $(UTIL_LINUX_NG_DIR)

# vim: syntax=make
