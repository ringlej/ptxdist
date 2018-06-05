# -*-makefile-*-
#
# Copyright (C) 2014, 2015 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_ECRYPTFS_UTILS) += ecryptfs-utils

#
# Paths and names
#
ECRYPTFS_UTILS_VERSION	:= 111
ECRYPTFS_UTILS_MD5	:= 83513228984f671930752c3518cac6fd
ECRYPTFS_UTILS		:= ecryptfs-utils_$(ECRYPTFS_UTILS_VERSION)
ECRYPTFS_UTILS_SUFFIX	:= tar.gz
ECRYPTFS_UTILS_TARBALL	:= $(ECRYPTFS_UTILS).orig.$(ECRYPTFS_UTILS_SUFFIX)
ECRYPTFS_UTILS_URL	:= https://launchpad.net/ecryptfs/trunk/$(ECRYPTFS_UTILS_VERSION)/+download/$(ECRYPTFS_UTILS_TARBALL)
ECRYPTFS_UTILS_SOURCE	:= $(SRCDIR)/$(ECRYPTFS_UTILS).$(ECRYPTFS_UTILS_SUFFIX)
ECRYPTFS_UTILS_DIR	:= $(BUILDDIR)/$(ECRYPTFS_UTILS)
ECRYPTFS_UTILS_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
ECRYPTFS_UTILS_CONF_TOOL := autoconf
ECRYPTFS_UTILS_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--disable-nss \
	--disable-pywrap \
	--disable-openssl \
	--disable-pkcs11-helper \
	--disable-tspi \
	--disable-gpg \
	--disable-pam \
	--disable-gui \
	--disable-docs \
	--disable-docs-gen \
	--$(call ptx/endis,PTXCONF_ECRYPTFS_UTILS_TESTS)-tests \
	--disable-mudflap \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-nls


ECRYPTFS_UTILS_PROGS_y :=

ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_MOUNT_ECRYPTFS)				+= /sbin/mount.ecryptfs
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_MOUNT_ECRYPTFS)				+= /sbin/mount.ecryptfs_private
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_MOUNT_ECRYPTFS)				+= /sbin/umount.ecryptfs

ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_ECRYPTFS_ADD_PASSPHRASE)			+= /usr/bin/ecryptfs-add-passphrase
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_ECRYPTFSD)				+= /usr/bin/ecryptfsd
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_ECRYPTFS_INSERT_WRAPPED_PASSPHRASE_INTO_KEYRING) += /usr/bin/ecryptfs-insert-wrapped-passphrase-into-keyring
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_ECRYPTFS_MANAGER)				+= /usr/bin/ecryptfs-manager
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_ECRYPTFS_REWRAP_PASSPHRASE)		+= /usr/bin/ecryptfs-rewrap-passphrase
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_ECRYPTFS_STAT)				+= /usr/bin/ecryptfs-stat
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_ECRYPTFS_UNWRAP_PASSPHRASE)		+= /usr/bin/ecryptfs-unwrap-passphrase
ECRYPTFS_UTILS_PROGS_$(PTXCONF_ECRYPTFS_UTILS_ECRYPTFS_WRAP_PASSPHRASE)			+= /usr/bin/ecryptfs-wrap-passphrase

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ecryptfs-utils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, ecryptfs-utils)
	@$(call install_fixup, ecryptfs-utils,PRIORITY,optional)
	@$(call install_fixup, ecryptfs-utils,SECTION,base)
	@$(call install_fixup, ecryptfs-utils,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, ecryptfs-utils,DESCRIPTION,missing)

	@$(call install_lib, ecryptfs-utils, 0, 0, 0644, ecryptfs/libecryptfs_key_mod_passphrase)
	@$(call install_lib, ecryptfs-utils, 0, 0, 0644, libecryptfs)

ifdef PTXCONF_ECRYPTFS_UTILS_TESTS
	@$(call install_glob, ecryptfs-utils, 0, 0, $(ECRYPTFS_UTILS_DIR)/tests, /usr/lib/ecryptfs/tests,, \
		*Makefile* */.deps* */.libs* */.dirstamp* *.o *.c, n)
endif

ifdef PTXCONF_ECRYPTFS_UTILS_MOUNT_ECRYPTFS
	@$(call install_link, ecryptfs-utils, mount.ecryptfs_private, /sbin/umount.ecryptfs_private)
endif

	@$(foreach prog, $(ECRYPTFS_UTILS_PROGS_y), \
		$(call install_copy, ecryptfs-utils, 0, 0, 0755, -, $(prog));)

	@$(call install_finish, ecryptfs-utils)

	@$(call touch)

# vim: syntax=make
