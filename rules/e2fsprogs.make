# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002-2008 by Pengutronix e.K., Hildesheim, Germany
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
E2FSPROGS_VERSION	:= 1.41.9
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

E2FSPROGS_PATH	:=  PATH=$(CROSS_PATH)
E2FSPROGS_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
E2FSPROGS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-blkid-debug \
	--disable-bsd-shlibs \
	--disable-checker \
	--disable-debugfs \
	--disable-e2initrd-helper \
	--disable-jbd-debug \
	--disable-nls \
	--disable-profile \
	--disable-rpath \
	--disable-testio-debug \
	--disable-tls \
	--enable-elf-shlibs \
	--enable-htree

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

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/e2fsprogs.install:
	@$(call targetinfo)
	@$(call install, E2FSPROGS,,,install-libs)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/e2fsprogs.targetinstall:
	@$(call targetinfo)

	@$(call install_init, e2fsprogs)
	@$(call install_fixup,e2fsprogs,PACKAGE,e2fsprogs)
	@$(call install_fixup,e2fsprogs,PRIORITY,optional)
	@$(call install_fixup,e2fsprogs,VERSION,$(E2FSPROGS_VERSION))
	@$(call install_fixup,e2fsprogs,SECTION,base)
	@$(call install_fixup,e2fsprogs,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,e2fsprogs,DEPENDS,)
	@$(call install_fixup,e2fsprogs,DESCRIPTION,missing)

#	#
#	# libraries
#	#

ifdef PTXCONF_E2FSPROGS_LIBBLKID
	@$(call install_copy, e2fsprogs, 0, 0, 0644, $(E2FSPROGS_DIR)/lib/libblkid.so.1.0, /usr/lib/libblkid.so.1.0)
	@$(call install_link, e2fsprogs, libblkid.so.1.0, /usr/lib/libblkid.so.1)
	@$(call install_link, e2fsprogs, libblkid.so.1.0, /usr/lib/libblkid.so)
endif

ifdef PTXCONF_E2FSPROGS_LIBCOM_ERR
	@$(call install_copy, e2fsprogs, 0, 0, 0644, $(E2FSPROGS_DIR)/lib/libcom_err.so.2.1, /usr/lib/libcom_err.so.2.1)
	@$(call install_link, e2fsprogs, libcom_err.so.2.1, /usr/lib/libcom_err.so.2)
	@$(call install_link, e2fsprogs, libcom_err.so.2.1, /usr/lib/libcom_err.so)
endif

ifdef PTXCONF_E2FSPROGS_LIBE2P
	@$(call install_copy, e2fsprogs, 0, 0, 0644, $(E2FSPROGS_DIR)/lib/libe2p.so.2.3, /usr/lib/libe2p.so.2.3)
	@$(call install_link, e2fsprogs, libe2p.so.2.3, /usr/lib/libe2p.so.2)
	@$(call install_link, e2fsprogs, libe2p.so.2.3, /usr/lib/libe2p.so)
endif

ifdef PTXCONF_E2FSPROGS_LIBEXT2FS
	@$(call install_copy, e2fsprogs, 0, 0, 0644, $(E2FSPROGS_DIR)/lib/libext2fs.so.2.4, /usr/lib/libext2fs.so.2.4)
	@$(call install_link, e2fsprogs, libext2fs.so.2.4, /usr/lib/libext2fs.so.2)
	@$(call install_link, e2fsprogs, libext2fs.so.2.4, /usr/lib/libext2fs.so)
endif

ifdef PTXCONF_E2FSPROGS_LIBSS
	@$(call install_copy, e2fsprogs, 0, 0, 0644, $(E2FSPROGS_DIR)/lib/libss.so.2.0, /usr/lib/libss.so.2.0)
	@$(call install_link, e2fsprogs, libss.so.2.0, /usr/lib/libss.so.2)
	@$(call install_link, e2fsprogs, libss.so.2.0, /usr/lib/libss.so)
endif

ifdef PTXCONF_E2FSPROGS_LIBUUID
	@$(call install_copy, e2fsprogs, 0, 0, 0644, $(E2FSPROGS_DIR)/lib/libuuid.so.1.2, /usr/lib/libuuid.so.1.2)
	@$(call install_link, e2fsprogs, libuuid.so.1.2, /usr/lib/libuuid.so.1)
	@$(call install_link, e2fsprogs, libuuid.so.1.2, /usr/lib/libuuid.so)
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
ifdef PTXCONF_E2FSPROGS_INSTALL_UUIDGEN
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/bin/uuidgen)
endif


#	#
#	# binaries in /usr/sbin
#	#
ifdef PTXCONF_E2FSPROGS_INSTALL_BADBLOCKS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/badblocks)
endif

ifdef PTXCONF_E2FSPROGS_INSTALL_BLKID
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/blkid)
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

ifdef PTXCONF_E2FSPROGS_INSTALL_FINDFS
	@$(call install_copy, e2fsprogs, 0, 0, 0755, -, /usr/sbin/findfs)
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

	@$(call install_finish,e2fsprogs)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

e2fsprogs_clean:
	rm -rf $(STATEDIR)/e2fsprogs.*
	rm -rf $(PKGDIR)/e2fsprogs_*
	rm -rf $(E2FSPROGS_DIR)

# vim: syntax=make
