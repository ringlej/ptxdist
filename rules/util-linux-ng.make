# -*-makefile-*-
#
# Copyright (C) 2008 by Robert Schwebel
#               2010 by Marc Kleine-Budde <mkl@penutronix.de>
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
UTIL_LINUX_NG_VERSION	:= 2.19.1
UTIL_LINUX_NG_MD5	:= 3eab06f05163dfa65479c44e5231932c
UTIL_LINUX_NG		:= util-linux-$(UTIL_LINUX_NG_VERSION)
UTIL_LINUX_NG_SUFFIX	:= tar.bz2
UTIL_LINUX_NG_URL	:= $(PTXCONF_SETUP_KERNELMIRROR)/utils/util-linux/v2.19/$(UTIL_LINUX_NG).$(UTIL_LINUX_NG_SUFFIX)
UTIL_LINUX_NG_SOURCE	:= $(SRCDIR)/$(UTIL_LINUX_NG).$(UTIL_LINUX_NG_SUFFIX)
UTIL_LINUX_NG_DIR	:= $(BUILDDIR)/$(UTIL_LINUX_NG)
UTIL_LINUX_NG_LICENSE	:= GPLv2+

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(UTIL_LINUX_NG_SOURCE):
	@$(call targetinfo)
	@$(call get, UTIL_LINUX_NG)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

UTIL_LINUX_NG_PATH	:= PATH=$(CROSS_PATH)
UTIL_LINUX_NG_ENV 	:= \
	$(CROSS_ENV) \
	$(call ptx/ncurses, PTXCONF_UTIL_LINUX_NG_USES_NCURSES) \
	ac_cv_lib_termcap_tgetnum=no \
	ac_cv_path_BLKID=no \
	ac_cv_path_PERL=no \
	ac_cv_path_VOLID=no

#
# autoconf
#
UTIL_LINUX_NG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/wwo, PTXCONF_UTIL_LINUX_NG_USES_NCURSES)-ncurses \
	--enable-shared \
	--enable-static \
	--disable-nls \
	--disable-rpath \
	--disable-arch \
	--disable-cramfs \
	--disable-elvtune \
	--disable-fallocate \
	--disable-init \
	--disable-kill \
	--disable-last \
	--disable-mesg \
	--disable-partx \
	--disable-raw \
	--disable-rename \
	--disable-reset \
	--enable-schedutils \
	--disable-login-utils \
	--disable-wall \
	--disable-write \
	--disable-chsh-only-listed \
	--disable-login-chown-vcs \
	--disable-login-stat-mail \
	--disable-makeinstall-chown \
	--disable-pg-bell \
	--disable-require-password \
	--disable-use-tty-group \
	--without-pam \
	--without-slang \
	--without-selinux \
	--without-audit \
	--without-utempter

ifdef PTXCONF_UTIL_LINUX_NG_FSCK
UTIL_LINUX_NG_AUTOCONF += --enable-fsck
else
UTIL_LINUX_NG_AUTOCONF += --disable-fsck
endif

ifdef PTXCONF_UTIL_LINUX_NG_AGETTY
UTIL_LINUX_NG_AUTOCONF += --enable-agetty
else
UTIL_LINUX_NG_AUTOCONF += --disable-agetty
endif

ifdef PTXCONF_UTIL_LINUX_NG_LIBUUID
UTIL_LINUX_NG_AUTOCONF += --enable-libuuid
else
UTIL_LINUX_NG_AUTOCONF += --disable-libuuid
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/util-linux-ng.targetinstall:
	@$(call targetinfo)

	@$(call install_init, util-linux-ng)
	@$(call install_fixup, util-linux-ng,PRIORITY,optional)
	@$(call install_fixup, util-linux-ng,SECTION,base)
	@$(call install_fixup, util-linux-ng,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, util-linux-ng,DESCRIPTION,missing)

ifdef PTXCONF_UTIL_LINUX_NG_AGETTY
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/agetty)
endif
ifdef PTXCONF_UTIL_LINUX_NG_MKSWAP
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/mkswap)
endif
ifdef PTXCONF_UTIL_LINUX_NG_SWAPON
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/swapon)
	@$(call install_link, util-linux-ng, swapon, /sbin/swapoff)
endif
ifdef PTXCONF_UTIL_LINUX_NG_MOUNT
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /bin/mount)
endif
ifdef PTXCONF_UTIL_LINUX_NG_UMOUNT
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /bin/umount)
endif
ifdef PTXCONF_UTIL_LINUX_NG_FSCK
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/fsck)
endif
ifdef PTXCONF_UTIL_LINUX_NG_IPCS
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /usr/bin/ipcs)
endif
ifdef PTXCONF_UTIL_LINUX_NG_READPROFILE
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /usr/sbin/readprofile)
endif
ifdef PTXCONF_UTIL_LINUX_NG_FDISK
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/fdisk)
endif
ifdef PTXCONF_UTIL_LINUX_NG_SFDISK
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/sfdisk)
endif
ifdef PTXCONF_UTIL_LINUX_NG_CFDISK
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/cfdisk)
endif
ifdef PTXCONF_UTIL_LINUX_NG_SETTERM
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /usr/bin/setterm)
endif
ifdef PTXCONF_UTIL_LINUX_NG_CHRT
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /usr/bin/chrt)
endif
ifdef PTXCONF_UTIL_LINUX_NG_HWCLOCK
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/hwclock)
endif
ifdef PTXCONF_UTIL_LINUX_NG_IONICE
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /usr/bin/ionice)
endif
ifdef PTXCONF_UTIL_LINUX_NG_TASKSET
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /usr/bin/taskset)
endif
ifdef PTXCONF_UTIL_LINUX_NG_MCOOKIE
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /usr/bin/mcookie)
endif

ifdef PTXCONF_UTIL_LINUX_NG_LIBBLKID
	@$(call install_lib, util-linux-ng, 0, 0, 0644, libblkid)
endif

ifdef PTXCONF_UTIL_LINUX_NG_BLKID
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/blkid)
endif

ifdef PTXCONF_UTIL_LINUX_NG_LIBUUID
	@$(call install_lib, util-linux-ng, 0, 0, 0644, libuuid)
endif

ifdef PTXCONF_UTIL_LINUX_NG_LIBMOUNT
	# FIXME - no user yet
endif

ifdef PTXCONF_UTIL_LINUX_NG_UUIDGEN
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /usr/bin/uuidgen)
endif

ifdef PTXCONF_UTIL_LINUX_NG_FINDFS
	@$(call install_copy, util-linux-ng, 0, 0, 0755, -, /sbin/findfs)
endif

	@$(call install_finish, util-linux-ng)

	@$(call touch)

# vim: syntax=make
