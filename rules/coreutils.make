# -*-makefile-*-
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_COREUTILS) += coreutils

#
# Paths and names
#
COREUTILS_VERSION	:= 8.5
COREUTILS		:= coreutils-$(COREUTILS_VERSION)
COREUTILS_URL		:= $(PTXCONF_SETUP_GNUMIRROR)/coreutils/$(COREUTILS).tar.gz
COREUTILS_SOURCE	:= $(SRCDIR)/$(COREUTILS).tar.gz
COREUTILS_DIR		:= $(BUILDDIR)/$(COREUTILS)
COREUTILS_LICENSE	:= GPLv3

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(COREUTILS_SOURCE):
	@$(call targetinfo)
	@$(call get, COREUTILS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#   --enable-install-program=PROG_LIST
#                           install the programs in PROG_LIST (comma-separated,
#                           default: none)
#   --enable-no-install-program=PROG_LIST
#                           do NOT install the programs in PROG_LIST
#                           (comma-separated, default: arch,hostname,su)
#   --with-libiconv-prefix[=DIR]  search for libiconv in DIR/include and DIR/lib
#   --without-libiconv-prefix     don't search for libiconv in includedir and libdir
#   --with-libpth-prefix[=DIR]  search for libpth in DIR/include and DIR/lib
#   --without-libpth-prefix     don't search for libpth in includedir and libdir
#   --without-included-regex
#                           don't compile regex; this is the default on systems
#                           with recent-enough versions of the GNU C Library
#                           (use with caution on other systems).
#   --with-packager         String identifying the packager of this software
#   --with-packager-version Packager-specific version information
#   --with-packager-bug-reports
#                           Packager info for bug reports (URL/e-mail/...)
#   --without-gmp           do not use the GNU MP library for arbitrary
#                           precision calculation (default: use it if available)
#   --with-libintl-prefix[=DIR]  search for libintl in DIR/include and DIR/lib
#   --without-libintl-prefix     don't search for libintl in includedir and libdir

COREUTILS_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-silent-rules \
	--enable-threads=posix \
	--disable-acl \
	--disable-assert \
	--disable-rpath \
	--enable-largefile \
	--disable-xattr \
	--disable-libcap \
	--disable-nls

COREUTILS_PATH	:= PATH=$(CROSS_PATH)
COREUTILS_ENV	:= $(CROSS_ENV)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/coreutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init,  coreutils)
	@$(call install_fixup, coreutils,PACKAGE,coreutils)
	@$(call install_fixup, coreutils,PRIORITY,optional)
	@$(call install_fixup, coreutils,VERSION,$(COREUTILS_VERSION))
	@$(call install_fixup, coreutils,SECTION,base)
	@$(call install_fixup, coreutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, coreutils,DEPENDS,)
	@$(call install_fixup, coreutils,DESCRIPTION,missing)

	@$(call install_copy, coreutils, 0, 0, 0644, -, /usr/lib/coreutils/libstdbuf.so)

ifdef PTXCONF_COREUTILS_ECHO
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/echo)
endif
ifdef PTXCONF_COREUTILS_STAT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/stat)
endif
ifdef PTXCONF_COREUTILS_DATE
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/date)
endif
ifdef PTXCONF_COREUTILS_HOSTID
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/hostid)
endif
ifdef PTXCONF_COREUTILS_UNAME
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/uname)
endif
ifdef PTXCONF_COREUTILS_DIRCOLORS
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/dircolors)
endif
ifdef PTXCONF_COREUTILS_SEQ
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/seq)
endif
ifdef PTXCONF_COREUTILS_NOHUP
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/nohup)
endif
ifdef PTXCONF_COREUTILS_GROUPS
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/groups)
endif
ifdef PTXCONF_COREUTILS_SHA224SUM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sha224sum)
endif
ifdef PTXCONF_COREUTILS_EXPR
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/expr)
endif
ifdef PTXCONF_COREUTILS_TRUNCATE
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/truncate)
endif
ifdef PTXCONF_COREUTILS_CHCON
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/chcon)
endif
ifdef PTXCONF_COREUTILS_PRINTF
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/printf)
endif
ifdef PTXCONF_COREUTILS_RMDIR
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/rmdir)
endif
ifdef PTXCONF_COREUTILS_PRINTENV
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/printenv)
endif
ifdef PTXCONF_COREUTILS_EXPAND
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/expand)
endif
ifdef PTXCONF_COREUTILS_CHMOD
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/chmod)
endif
ifdef PTXCONF_COREUTILS_CHOWN
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/chown)
endif
ifdef PTXCONF_COREUTILS_SHA512SUM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sha512sum)
endif
ifdef PTXCONF_COREUTILS_UNIQ
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/uniq)
endif
ifdef PTXCONF_COREUTILS_INSTALL
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/install)
endif
ifdef PTXCONF_COREUTILS_TTY
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/tty)
endif
ifdef PTXCONF_COREUTILS_SHA384SUM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sha384sum)
endif
ifdef PTXCONF_COREUTILS_CUT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/cut)
endif
ifdef PTXCONF_COREUTILS_SHRED
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/shred)
endif
ifdef PTXCONF_COREUTILS_OD
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/od)
endif
ifdef PTXCONF_COREUTILS_CHGRP
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/chgrp)
endif
ifdef PTXCONF_COREUTILS_DIR
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/dir)
endif
ifdef PTXCONF_COREUTILS_MKFIFO
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/mkfifo)
endif
ifdef PTXCONF_COREUTILS_CHROOT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/chroot)
endif
ifdef PTXCONF_COREUTILS_LN
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/ln)
endif
ifdef PTXCONF_COREUTILS_SUM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sum)
endif
ifdef PTXCONF_COREUTILS_USERS
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/users)
endif
ifdef PTXCONF_COREUTILS_TOUCH
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/touch)
endif
ifdef PTXCONF_COREUTILS_PASTE
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/paste)
endif
ifdef PTXCONF_COREUTILS_MKNOD
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/mknod)
endif
ifdef PTXCONF_COREUTILS_TSORT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/tsort)
endif
ifdef PTXCONF_COREUTILS_MKTEMP
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/mktemp)
endif
ifdef PTXCONF_COREUTILS_RUNCON
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/runcon)
endif
ifdef PTXCONF_COREUTILS_READLINK
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/readlink)
endif
ifdef PTXCONF_COREUTILS_TAC
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/tac)
endif
ifdef PTXCONF_COREUTILS_MD5SUM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/md5sum)
endif
ifdef PTXCONF_COREUTILS_DD
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/dd)
endif
ifdef PTXCONF_COREUTILS_YES
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/yes)
endif
ifdef PTXCONF_COREUTILS_FACTOR
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/factor)
endif
ifdef PTXCONF_COREUTILS_JOIN
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/join)
endif
ifdef PTXCONF_COREUTILS_PWD
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/pwd)
endif
ifdef PTXCONF_COREUTILS_SHUF
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/shuf)
endif
ifdef PTXCONF_COREUTILS_SHA1SUM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sha1sum)
endif
ifdef PTXCONF_COREUTILS_TR
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/tr)
endif
ifdef PTXCONF_COREUTILS_CSPLIT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/csplit)
endif
ifdef PTXCONF_COREUTILS_DU
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/du)
endif
ifdef PTXCONF_COREUTILS_TAIL
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/tail)
endif
ifdef PTXCONF_COREUTILS_PTX
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/ptx)
endif
ifdef PTXCONF_COREUTILS_BASE64
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/base64)
endif
ifdef PTXCONF_COREUTILS_TIMEOUT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/timeout)
endif
ifdef PTXCONF_COREUTILS_SORT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sort)
endif
ifdef PTXCONF_COREUTILS_FALSE
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/false)
endif
ifdef PTXCONF_COREUTILS_DIRNAME
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/dirname)
endif
ifdef PTXCONF_COREUTILS_TEST
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/test)
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/[)
endif
ifdef PTXCONF_COREUTILS_FMT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/fmt)
endif
ifdef PTXCONF_COREUTILS_STDBUF
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/stdbuf)
endif
ifdef PTXCONF_COREUTILS_PINKY
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/pinky)
endif
ifdef PTXCONF_COREUTILS_BASENAME
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/basename)
endif
ifdef PTXCONF_COREUTILS_ID
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/id)
endif
ifdef PTXCONF_COREUTILS_LINK
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/link)
endif
ifdef PTXCONF_COREUTILS_SLEEP
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sleep)
endif
ifdef PTXCONF_COREUTILS_SHA256SUM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sha256sum)
endif
ifdef PTXCONF_COREUTILS_ENV
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/env)
endif
ifdef PTXCONF_COREUTILS_WHO
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/who)
endif
ifdef PTXCONF_COREUTILS_LOGNAME
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/logname)
endif
ifdef PTXCONF_COREUTILS_WHOAMI
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/whoami)
endif
ifdef PTXCONF_COREUTILS_STTY
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/stty)
endif
ifdef PTXCONF_COREUTILS_PATHCHK
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/pathchk)
endif
ifdef PTXCONF_COREUTILS_NL
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/nl)
endif
ifdef PTXCONF_COREUTILS_WC
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/wc)
endif
ifdef PTXCONF_COREUTILS_UNLINK
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/unlink)
endif
ifdef PTXCONF_COREUTILS_UNEXPAND
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/unexpand)
endif
ifdef PTXCONF_COREUTILS_NPROC
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/nproc)
endif
ifdef PTXCONF_COREUTILS_VDIR
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/vdir)
endif
ifdef PTXCONF_COREUTILS_SYNC
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/sync)
endif
ifdef PTXCONF_COREUTILS_RM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/rm)
endif
ifdef PTXCONF_COREUTILS_CKSUM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/cksum)
endif
ifdef PTXCONF_COREUTILS_TEE
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/tee)
endif
ifdef PTXCONF_COREUTILS_MKDIR
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/mkdir)
endif
ifdef PTXCONF_COREUTILS_MV
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/mv)
endif
ifdef PTXCONF_COREUTILS_LS
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/ls)
endif
ifdef PTXCONF_COREUTILS_HEAD
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/head)
endif
ifdef PTXCONF_COREUTILS_TRUE
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/true)
endif
ifdef PTXCONF_COREUTILS_CAT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/cat)
endif
ifdef PTXCONF_COREUTILS_KILL
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/kill)
endif
ifdef PTXCONF_COREUTILS_CP
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/cp)
endif
ifdef PTXCONF_COREUTILS_COMM
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/comm)
endif
ifdef PTXCONF_COREUTILS_SPLIT
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/split)
endif
ifdef PTXCONF_COREUTILS_FOLD
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/fold)
endif
ifdef PTXCONF_COREUTILS_PR
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/pr)
endif
ifdef PTXCONF_COREUTILS_UPTIME
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/uptime)
endif
ifdef PTXCONF_COREUTILS_NICE
	@$(call install_copy, coreutils, 0, 0, 0755, -, /usr/bin/nice)
endif
	@$(call install_finish, coreutils)
	@$(call touch)

# vim: syntax=make
