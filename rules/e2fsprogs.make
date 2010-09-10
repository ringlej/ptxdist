# -*-makefile-*-
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_E2FSPROGS) += e2fsprogs

#
# Paths and names
#
E2FSPROGS_VERSION	:= 1.41.12
E2FSPROGS		:= e2fsprogs-$(E2FSPROGS_VERSION)
E2FSPROGS_SUFFIX	:= tar.gz
E2FSPROGS_URL		:= $(PTXCONF_SETUP_SFMIRROR)/e2fsprogs/$(E2FSPROGS).$(E2FSPROGS_SUFFIX)
E2FSPROGS_SOURCE	:= $(SRCDIR)/$(E2FSPROGS).$(E2FSPROGS_SUFFIX)
E2FSPROGS_DIR		:= $(BUILDDIR)/$(E2FSPROGS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(E2FSPROGS_SOURCE):
	@$(call targetinfo)
	@$(call get, E2FSPROGS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

E2FSPROGS_PATH	:= PATH=$(CROSS_PATH)
E2FSPROGS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
E2FSPROGS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-symlink-install \
	--disable-symlink-build \
	--disable-verbose-makecmds \
	--enable-htree \
	--enable-elf-shlibs \
	--disable-bsd-shlibs \
	--disable-profile \
	--disable-checker \
	--disable-jbd-debug \
	--disable-blkid-debug \
	--disable-testio-debug \
	--disable-libuuid \
	--disable-libblkid \
	--disable-debugfs \
	--disable-e2initrd-helper \
	--disable-tls \
	--disable-nls \
	--disable-rpath \
	--without-diet-libc

ifdef PTXCONF_E2FSPROGS_COMPRESSION
E2FSPROGS_AUTOCONF += --enable-compression
else
E2FSPROGS_AUTOCONF += --disable-compression
endif

ifdef PTXCONF_E2FSPROGS_IMAGER
E2FSPROGS_AUTOCONF += --enable-imager
else
E2FSPROGS_AUTOCONF += --disable-imager
endif

ifdef PTXCONF_E2FSPROGS_RESIZER
E2FSPROGS_AUTOCONF += --enable-resizer
else
E2FSPROGS_AUTOCONF += --disable-resizer
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_E2FSCK
E2FSPROGS_AUTOCONF += --enable-fsck
else
E2FSPROGS_AUTOCONF += --disable-fsck
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_UUIDD
E2FSPROGS_AUTOCONF += --enable-uuidd
else
E2FSPROGS_AUTOCONF += --disable-uuidd
endif

E2FSPROGS_INSTALL_OPT := install install-libs

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/e2fsprogs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, e2fsprogs)
	@$(call install_fixup, e2fsprogs,PRIORITY,optional)
	@$(call install_fixup, e2fsprogs,SECTION,base)
	@$(call install_fixup, e2fsprogs,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, e2fsprogs,DESCRIPTION,missing)

#	#
#	# libraries
#	#

ifdef PTXCONF_E2FSPROGS_LIBCOM_ERR
	@$(call install_lib, e2fsprogs, 0, 0, 0644, libcom_err)
endif
ifdef PTXCONF_E2FSPROGS_LIBE2P
	@$(call install_lib, e2fsprogs, 0, 0, 0644, libe2p)
endif
ifdef PTXCONF_E2FSPROGS_LIBEXT2FS
	@$(call install_lib, e2fsprogs, 0, 0, 0644, libext2fs)
endif
ifdef PTXCONF_E2FSPROGS_LIBSS
	@$(call install_lib, e2fsprogs, 0, 0, 0644, libss)
endif

#	#
#	# binaries in /usr/bin
#	#
ifdef PTXCONF_E2FSPROGS_INSTALL_CHATTR
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/bin/chattr)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_LSATTR
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/bin/lsattr)
endif


#	#
#	# binaries in /usr/sbin
#	#
ifdef PTXCONF_E2FSPROGS_INSTALL_BADBLOCKS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/badblocks)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_DUMPE2FS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/dumpe2fs)
endif


ifdef PTXCONF_E2FSPROGS_INSTALL_E2FSCK
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/e2fsck)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_FSCK_EXT2
	@$(call install_link, e2fsprogs, e2fsck, /usr/sbin/fsck.ext2)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_FSCK_EXT3
	@$(call install_link, e2fsprogs, e2fsck, /usr/sbin/fsck.ext3)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_FSCK_EXT4
	@$(call install_link, e2fsprogs, e2fsck, /usr/sbin/fsck.ext4)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_FSCK_EXT4DEV
	@$(call install_link, e2fsprogs, e2fsck, /usr/sbin/fsck.ext4dev)
endif


ifdef PTXCONF_E2FSPROGS_INSTALL_E2IMAGE
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/e2image)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_E2LABEL
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/e2label)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_E2UNDO
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/e2undo)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_FILEFRAG
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/filefrag)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_LOGSAVE
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/logsave)
endif


ifdef PTXCONF_E2FSPROGS_INSTALL_MKE2FS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/mke2fs)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_MKFS_EXT2
	@$(call install_link, e2fsprogs, mke2fs, /usr/sbin/mkfs.ext2)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_MKFS_EXT3
	@$(call install_link, e2fsprogs, mke2fs, /usr/sbin/mkfs.ext3)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_MKFS_EXT4
	@$(call install_link, e2fsprogs, mke2fs, /usr/sbin/mkfs.ext4)
endif
ifdef PTXCONF_E2FSPROGS_INSTALL_MKFS_EXT4DEV
	@$(call install_link, e2fsprogs, mke2fs, /usr/sbin/mkfs.ext4dev)
endif


ifdef PTXCONF_E2FSPROGS_INSTALL_MKLOSTANDFOUND
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/mklost+found)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_RESIZE2FS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/resize2fs)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_TUNE2FS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/tune2fs)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_UUIDD
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/uuidd)
endif

	@$(call install_alternative, e2fsprogs, 0, 0, 0644, /etc/mke2fs.conf, n)

	@$(call install_finish, e2fsprogs)

	@$(call touch)

# vim: syntax=make
