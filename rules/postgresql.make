# -*-makefile-*-
#
# Copyright (C) 2015 by Robert Schwebel <r.schwebel@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_POSTGRESQL) += postgresql

#
# Paths and names
#
POSTGRESQL_VERSION	:= 9.4.1
POSTGRESQL_MD5		:= 2cf30f50099ff1109d0aa517408f8eff
POSTGRESQL		:= postgresql-$(POSTGRESQL_VERSION)
POSTGRESQL_SUFFIX	:= tar.bz2
POSTGRESQL_URL		:= https://ftp.postgresql.org/pub/source/v$(POSTGRESQL_VERSION)/$(POSTGRESQL).$(POSTGRESQL_SUFFIX)
POSTGRESQL_SOURCE	:= $(SRCDIR)/$(POSTGRESQL).$(POSTGRESQL_SUFFIX)
POSTGRESQL_DIR		:= $(BUILDDIR)/$(POSTGRESQL)
POSTGRESQL_LICENSE	:= PostgreSQL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

POSTGRESQL_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
POSTGRESQL_CONF_TOOL	:= autoconf
POSTGRESQL_CONF_OPT	:= $(CROSS_AUTOCONF_USR) \
	--enable-integer-datetimes \
	--disable-nls \
	--disable-debug \
	--disable-profiling \
	--disable-coverage \
	--disable-dtrace \
	--disable-tap-tests \
	--disable-cassert \
	--enable-largefile \
	--disable-float4-byval \
	--disable-float8-byval \
	--without-tcl \
	--without-perl \
	--without-python \
	--without-gssapi \
	--without-pam \
	--without-ldap \
	--without-bonjour \
	--without-openssl \
	--without-selinux \
	--without-readline \
	--without-libedit-preferred \
	--without-libxml \
	--without-libxslt \
	--without-zlib \
	--with-system-tzdata=/usr/share/zoneinfo

#  --disable-spinlocks     do not use spinlocks
#  --enable-tap-tests      enable TAP tests (requires Perl and IPC::Run)
#  --enable-depend         turn on automatic dependency tracking
#  --disable-thread-safety disable thread-safety in client libraries
#  --with-uuid=LIB         build contrib/uuid-ossp using LIB (bsd,e2fs,ossp)
#  --with-ossp-uuid        obsolete spelling of --with-uuid=ossp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/postgresql.targetinstall:
	@$(call targetinfo)

	@$(call install_init, postgresql)
	@$(call install_fixup, postgresql,PRIORITY,optional)
	@$(call install_fixup, postgresql,SECTION,base)
	@$(call install_fixup, postgresql,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, postgresql,DESCRIPTION,missing)

#	# Libraries
	@$(call install_lib, postgresql, 0, 0, 0644, libpq)
	@$(call install_lib, postgresql, 0, 0, 0644, libecpg)
	@$(call install_lib, postgresql, 0, 0, 0644, libecpg_compat)
	@$(call install_lib, postgresql, 0, 0, 0644, libpgtypes)

#	# Binaries
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/postgres)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_receivexlog)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/postmaster)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/reindexdb)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_isready)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_dump)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/vacuumdb)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_ctl)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/dropuser)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/createdb)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/createuser)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/initdb)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_restore)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/clusterdb)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_recvlogical)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_resetxlog)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/dropdb)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/ecpg)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_dumpall)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/createlang)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_basebackup)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/psql)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_controldata)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/droplang)
	@$(call install_copy, postgresql, 0, 0, 0755, /usr/bin/pg_config)

#	# This can be further optimized
	@$(call install_tree, postgresql, 0, 0, -, /usr/lib/postgresql)
	@$(call install_tree, postgresql, 0, 0, -, /usr/share/postgresql)

	@$(call install_finish, postgresql)

	@$(call touch)

# vim: syntax=make
