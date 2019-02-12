# -*-makefile-*-
#
# Copyright (C) 2003 by Werner Schmitt <mail2ws@gmx.de>
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
PACKAGES-$(PTXCONF_DB) += db

#
# Paths and names
#

DB_VERSION	:= 5.3.28
DB_MD5		:= b99454564d5b4479750567031d66fe24
DB_LIBVERSION	:= $(basename $(DB_VERSION))
DB		:= db-$(DB_VERSION)
DB_SUFFIX	:= tar.gz
DB_URL		:= http://download.oracle.com/berkeley-db/$(DB).$(DB_SUFFIX)
DB_SOURCE	:= $(SRCDIR)/$(DB).$(DB_SUFFIX)
DB_DIR		:= $(BUILDDIR)/$(DB)
DB_SUBDIR	:= dist
DB_BUILDDIR	:= $(DB_DIR)/build_unix
DB_LICENCE	:= Sleepycat

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DB_CONF_TOOL := autoconf
DB_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-smallbuild \
	--enable-atomicsupport \
	--enable-compression \
	--enable-hash \
	--enable-heap \
	--enable-mutexsupport \
	--enable-log_checksum \
	--enable-partition \
	--disable-queue \
	--disable-replication \
	--disable-statistics \
	--disable-verify \
	--enable-compat185 \
	--disable-cxx \
	--disable-debug \
	--disable-debug_rop \
	--disable-debug_wop \
	--disable-diagnostic \
	--disable-dump185 \
	--disable-java \
	--disable-mingw \
	--enable-o_direct \
	--disable-posixmutexes \
	--disable-sql \
	--disable-sql_compat \
	--disable-jdbc \
	--disable-amalgamation \
	--disable-sql_codegen \
	--disable-stl \
	--disable-tcl \
	--disable-test \
	--disable-localization \
	--disable-stripped_messages \
	--enable-dbm \
	--disable-dtrace \
	--disable-systemtap \
	--disable-perfmon-statistics \
	--disable-uimutexes \
	--disable-umrw \
	--disable-atomicfileread \
	--enable-shared \
	--disable-static \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--disable-cryptography \
	--with-mutex=POSIX/pthreads/private

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/db.targetinstall:
	@$(call targetinfo)

	@$(call install_init, db)
	@$(call install_fixup, db,PRIORITY,optional)
	@$(call install_fixup, db,SECTION,base)
	@$(call install_fixup, db,AUTHOR,"Marc Kleine-Budde <mkl@pengutronix.de>")
	@$(call install_fixup, db,DESCRIPTION,missing)

	@$(call install_lib, db, 0, 0, 0644, libdb-$(DB_LIBVERSION))

ifdef PTXCONF_DB_UTIL
	@$(call install_tree, db, 0, 0, -, /usr/bin)
endif

	@$(call install_finish, db)

	@$(call touch)

# vim: syntax=make
