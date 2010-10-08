# -*-makefile-*-
#
# Copyright (C) 2003-2010 by Pengutronix e.K., Hildesheim, Germany
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
COREUTILS_MD5		:= c1ffe586d001e87d66cd80c4536ee823
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
	$(GLOBAL_LARGE_FILE_OPTION) \
	--target=$(PTXCONF_GNU_TARGET) \
	--disable-silent-rules \
	--enable-threads=posix \
	--disable-acl \
	--disable-assert \
	--disable-rpath \
	--disable-xattr \
	--disable-libcap \
	--disable-nls \
	--without-gmp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

COREUTILS_INST-y =
COREUTILS_INST-m =
COREUTILS_INST-$(PTXCONF_COREUTILS_ECHO) += /usr/bin/echo
COREUTILS_INST-$(PTXCONF_COREUTILS_STAT) += /usr/bin/stat
COREUTILS_INST-$(PTXCONF_COREUTILS_DATE) += /usr/bin/date
COREUTILS_INST-$(PTXCONF_COREUTILS_HOSTIOD) += /usr/bin/hostid
COREUTILS_INST-$(PTXCONF_COREUTILS_UNAME) += /usr/bin/uname
COREUTILS_INST-$(PTXCONF_COREUTILS_DIRCOLORS) += /usr/bin/dircolors
COREUTILS_INST-$(PTXCONF_COREUTILS_SEQ) += /usr/bin/seq
COREUTILS_INST-$(PTXCONF_COREUTILS_NOHUP) += /usr/bin/nohup
COREUTILS_INST-$(PTXCONF_COREUTILS_GROUPS) += /usr/bin/groups
COREUTILS_INST-$(PTXCONF_COREUTILS_SHA224SUM) += /usr/bin/sha224sum
COREUTILS_INST-$(PTXCONF_COREUTILS_EXPR) += /usr/bin/expr
COREUTILS_INST-$(PTXCONF_COREUTILS_TRUNCATE) += /usr/bin/truncate
COREUTILS_INST-$(PTXCONF_COREUTILS_CHCON) += /usr/bin/chcon
COREUTILS_INST-$(PTXCONF_COREUTILS_PRINTF) += /usr/bin/printf
COREUTILS_INST-$(PTXCONF_COREUTILS_RMDIR) += /usr/bin/rmdir
COREUTILS_INST-$(PTXCONF_COREUTILS_PRINTENV) += /usr/bin/printenv
COREUTILS_INST-$(PTXCONF_COREUTILS_EXPANd) += /usr/bin/expand
COREUTILS_INST-$(PTXCONF_COREUTILS_CHMOD) += /usr/bin/chmod
COREUTILS_INST-$(PTXCONF_COREUTILS_CHOWN) += /usr/bin/chown
COREUTILS_INST-$(PTXCONF_COREUTILS_SHA512SUM) += /usr/bin/sha512sum
COREUTILS_INST-$(PTXCONF_COREUTILS_UNIQ) += /usr/bin/uniq
COREUTILS_INST-$(PTXCONF_COREUTILS_INSTALL) += /usr/bin/install
COREUTILS_INST-$(PTXCONF_COREUTILS_TTY) += /usr/bin/tty
COREUTILS_INST-$(PTXCONF_COREUTILS_SHA384SUM) += /usr/bin/sha384sum
COREUTILS_INST-$(PTXCONF_COREUTILS_CUT) += /usr/bin/cut
COREUTILS_INST-$(PTXCONF_COREUTILS_SHRED) += /usr/bin/shred
COREUTILS_INST-$(PTXCONF_COREUTILS_OD) += /usr/bin/od
COREUTILS_INST-$(PTXCONF_COREUTILS_CHGRP) += /usr/bin/chgrp
COREUTILS_INST-$(PTXCONF_COREUTILS_DIR) += /usr/bin/dir
COREUTILS_INST-$(PTXCONF_COREUTILS_MKFIFO) += /usr/bin/mkfifo
COREUTILS_INST-$(PTXCONF_COREUTILS_CHROOT) += /usr/bin/chroot
COREUTILS_INST-$(PTXCONF_COREUTILS_LN) += /usr/bin/ln
COREUTILS_INST-$(PTXCONF_COREUTILS_SUM) += /usr/bin/sum
COREUTILS_INST-$(PTXCONF_COREUTILS_USERS) += /usr/bin/users
COREUTILS_INST-$(PTXCONF_COREUTILS_TOUCH) += /usr/bin/touch
COREUTILS_INST-$(PTXCONF_COREUTILS_PASTE) += /usr/bin/paste
COREUTILS_INST-$(PTXCONF_COREUTILS_MKNOD) += /usr/bin/mknod
COREUTILS_INST-$(PTXCONF_COREUTILS_TSORT) += /usr/bin/tsort
COREUTILS_INST-$(PTXCONF_COREUTILS_MKTEMP) += /usr/bin/mktemp
COREUTILS_INST-$(PTXCONF_COREUTILS_RUNCON) += /usr/bin/runcon
COREUTILS_INST-$(PTXCONF_COREUTILS_READLINK) += /usr/bin/readlink
COREUTILS_INST-$(PTXCONF_COREUTILS_TAC) += /usr/bin/tac
COREUTILS_INST-$(PTXCONF_COREUTILS_MD5SUM) += /usr/bin/md5sum
COREUTILS_INST-$(PTXCONF_COREUTILS_DD) += /usr/bin/dd
COREUTILS_INST-$(PTXCONF_COREUTILS_YES) += /usr/bin/yes
COREUTILS_INST-$(PTXCONF_COREUTILS_FACTOR) += /usr/bin/factor
COREUTILS_INST-$(PTXCONF_COREUTILS_JOIN) += /usr/bin/join
COREUTILS_INST-$(PTXCONF_COREUTILS_PWD) += /usr/bin/pwd
COREUTILS_INST-$(PTXCONF_COREUTILS_SHUF) += /usr/bin/shuf
COREUTILS_INST-$(PTXCONF_COREUTILS_SHA1SUM) += /usr/bin/sha1sum
COREUTILS_INST-$(PTXCONF_COREUTILS_TR) += /usr/bin/tr
COREUTILS_INST-$(PTXCONF_COREUTILS_CSPLIT) += /usr/bin/csplit
COREUTILS_INST-$(PTXCONF_COREUTILS_DU) += /usr/bin/du
COREUTILS_INST-$(PTXCONF_COREUTILS_TAIL) += /usr/bin/tail
COREUTILS_INST-$(PTXCONF_COREUTILS_PTX) += /usr/bin/ptx
COREUTILS_INST-$(PTXCONF_COREUTILS_BASE64) += /usr/bin/base64
COREUTILS_INST-$(PTXCONF_COREUTILS_TIMEOUT) += /usr/bin/timeout
COREUTILS_INST-$(PTXCONF_COREUTILS_SORT) += /usr/bin/sort
COREUTILS_INST-$(PTXCONF_COREUTILS_FALSE) += /usr/bin/false
COREUTILS_INST-$(PTXCONF_COREUTILS_DIRNAME) += /usr/bin/dirname
COREUTILS_INST-$(PTXCONF_COREUTILS_TEST) += /usr/bin/test
COREUTILS_INST-$(PTXCONF_COREUTILS_TEST) += /usr/bin/[
COREUTILS_INST-$(PTXCONF_COREUTILS_FMT) += /usr/bin/fmt
COREUTILS_INST-$(PTXCONF_COREUTILS_STDBUF) += /usr/bin/stdbuf
COREUTILS_INST-$(PTXCONF_COREUTILS_PINKY) += /usr/bin/pinky
COREUTILS_INST-$(PTXCONF_COREUTILS_BASENAME) += /usr/bin/basename
COREUTILS_INST-$(PTXCONF_COREUTILS_ID) += /usr/bin/id
COREUTILS_INST-$(PTXCONF_COREUTILS_LINK) += /usr/bin/link
COREUTILS_INST-$(PTXCONF_COREUTILS_SLEEP) += /usr/bin/sleep
COREUTILS_INST-$(PTXCONF_COREUTILS_SHA256SUM) += /usr/bin/sha256sum
COREUTILS_INST-$(PTXCONF_COREUTILS_ENV) += /usr/bin/env
COREUTILS_INST-$(PTXCONF_COREUTILS_WHO) += /usr/bin/who
COREUTILS_INST-$(PTXCONF_COREUTILS_LOGNAME) += /usr/bin/logname
COREUTILS_INST-$(PTXCONF_COREUTILS_WHOAMI) += /usr/bin/whoami
COREUTILS_INST-$(PTXCONF_COREUTILS_STTY) += /usr/bin/stty
COREUTILS_INST-$(PTXCONF_COREUTILS_PATHCHK) += /usr/bin/pathchk
COREUTILS_INST-$(PTXCONF_COREUTILS_NL) += /usr/bin/nl
COREUTILS_INST-$(PTXCONF_COREUTILS_WC) += /usr/bin/wc
COREUTILS_INST-$(PTXCONF_COREUTILS_UNLINK) += /usr/bin/unlink
COREUTILS_INST-$(PTXCONF_COREUTILS_UNEXPAND) += /usr/bin/unexpand
COREUTILS_INST-$(PTXCONF_COREUTILS_NPROC) += /usr/bin/nproc
COREUTILS_INST-$(PTXCONF_COREUTILS_VDIR) += /usr/bin/vdir
COREUTILS_INST-$(PTXCONF_COREUTILS_SYNC) += /usr/bin/sync
COREUTILS_INST-$(PTXCONF_COREUTILS_RM) += /usr/bin/rm
COREUTILS_INST-$(PTXCONF_COREUTILS_CKSUM) += /usr/bin/cksum
COREUTILS_INST-$(PTXCONF_COREUTILS_TEE) += /usr/bin/tee
COREUTILS_INST-$(PTXCONF_COREUTILS_MKDIR) += /usr/bin/mkdir
COREUTILS_INST-$(PTXCONF_COREUTILS_MV) += /usr/bin/mv
COREUTILS_INST-$(PTXCONF_COREUTILS_LS) += /usr/bin/ls
COREUTILS_INST-$(PTXCONF_COREUTILS_HEAD) += /usr/bin/head
COREUTILS_INST-$(PTXCONF_COREUTILS_TRUE) += /usr/bin/true
COREUTILS_INST-$(PTXCONF_COREUTILS_CAT) += /usr/bin/cat
COREUTILS_INST-$(PTXCONF_COREUTILS_KILL) += /usr/bin/kill
COREUTILS_INST-$(PTXCONF_COREUTILS_CP) += /usr/bin/cp
COREUTILS_INST-$(PTXCONF_COREUTILS_COMM) += /usr/bin/comm
COREUTILS_INST-$(PTXCONF_COREUTILS_SPLIT) += /usr/bin/split
COREUTILS_INST-$(PTXCONF_COREUTILS_FOLD) += /usr/bin/fold
COREUTILS_INST-$(PTXCONF_COREUTILS_PR) += /usr/bin/pr
COREUTILS_INST-$(PTXCONF_COREUTILS_UPTIME) += /usr/bin/uptime
COREUTILS_INST-$(PTXCONF_COREUTILS_NICE) += /usr/bin/nice
COREUTILS_INST-$(PTXCONF_COREUTILS_) += /usr/bin/
COREUTILS_INST-$(PTXCONF_COREUTILS_) += /usr/bin/

$(STATEDIR)/coreutils.targetinstall:
	@$(call targetinfo)

	@$(call install_init, coreutils)
	@$(call install_fixup, coreutils,PRIORITY,optional)
	@$(call install_fixup, coreutils,SECTION,base)
	@$(call install_fixup, coreutils,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, coreutils,DESCRIPTION,missing)

ifdef PTXCONF_COREUTILS_STDBUF
	@$(call install_copy, coreutils, 0, 0, 0644, -, /usr/lib/coreutils/libstdbuf.so)
endif

	@for i in $(COREUTILS_INST-y) $(COREUTILS_INST-m); do \
		$(call install_copy, coreutils, 0, 0, 0755, -, $$i) \
	done

	@$(call install_finish, coreutils)

	@$(call touch)

# vim: syntax=make
