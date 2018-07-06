# -*-makefile-*-
#
# Copyright (C) 2017 by Bastian Stender <bst@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_MARIADB) += mariadb

#
# Paths and names
#
MARIADB_VERSION	:= 10.1.32
MARIADB_MD5	:= 389ce891cf00957748ba98b09f433c14
MARIADB		:= mariadb-$(MARIADB_VERSION)
MARIADB_SUFFIX	:= tar.gz
MARIADB_URL	:= https://downloads.mariadb.com/MariaDB/$(MARIADB)/source/$(MARIADB).$(MARIADB_SUFFIX)
MARIADB_SOURCE	:= $(SRCDIR)/$(MARIADB).$(MARIADB_SUFFIX)
MARIADB_DIR	:= $(BUILDDIR)/$(MARIADB)
MARIADB_LICENSE	:= GPL-2.0-only

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# MARIADB_PLUGINS_ENABLED-y builds plugin dynamically
# MARIADB_PLUGINS_ENABLES-y builds plugin statically
# MARIADB_PLUGINS_ENABLE- disables plugin
MARIADB_PLUGINS_ENABLE- += ARCHIVE
MARIADB_PLUGINS_ENABLE- += ARIA
MARIADB_PLUGINS_ENABLE- += AUDIT_NULL
MARIADB_PLUGINS_ENABLE- += AUTH_0X0100
MARIADB_PLUGINS_ENABLE- += AUTH_ED25519
MARIADB_PLUGINS_ENABLE- += AUTH_SOCKET
MARIADB_PLUGINS_ENABLE- += AUTH_TEST_PLUGIN
MARIADB_PLUGINS_ENABLE- += AWS_KEY_MANAGEMENT
MARIADB_PLUGINS_ENABLE- += BLACKHOLE
MARIADB_PLUGINS_ENABLE- += CLIENT_ED25519
MARIADB_PLUGINS_ENABLE- += CONNECT
MARIADB_PLUGINS_ENABLE- += DAEMON_EXAMPLE
MARIADB_PLUGINS_ENABLE- += DEBUG_KEY_MANAGEMENT
MARIADB_PLUGINS_ENABLE- += DIALOG
MARIADB_PLUGINS_ENABLE- += DIALOG_EXAMPLES
MARIADB_PLUGINS_ENABLE- += EXAMPLE
MARIADB_PLUGINS_ENABLE- += EXAMPLE_KEY_MANAGEMENT
MARIADB_PLUGINS_ENABLE- += FEDERATED
MARIADB_PLUGINS_ENABLE- += FEDERATEDX
MARIADB_PLUGINS_ENABLE- += FEEDBACK
MARIADB_PLUGINS_ENABLE- += FILE_KEY_MANAGEMENT
MARIADB_PLUGINS_ENABLE- += FTEXAMPLE
MARIADB_PLUGINS_ENABLE- += HANDLERSOCKET
MARIADB_PLUGINS_ENABLE- += INNOBASE
MARIADB_PLUGINS_ENABLE- += LOCALES
MARIADB_PLUGINS_ENABLE- += METADATA_LOCK_INFO
MARIADB_PLUGINS_ENABLE- += MROONGA
MARIADB_PLUGINS_ENABLE- += MYSQL_CLEAR_PASSWORD
# some plugins depend on static build PARTITION
MARIADB_PLUGINS_ENABLE- += PARTITION
MARIADB_PLUGINS_ENABLE- += PERFSCHEMA
MARIADB_PLUGINS_ENABLE- += QA_AUTH_CLIENT
MARIADB_PLUGINS_ENABLE- += QA_AUTH_INTERFACE
MARIADB_PLUGINS_ENABLE- += QA_AUTH_SERVER
MARIADB_PLUGINS_ENABLE- += QUERY_CACHE_INFO
MARIADB_PLUGINS_ENABLE- += QUERY_RESPONSE_TIME
MARIADB_PLUGINS_ENABLE- += SEMISYNC_MASTER
MARIADB_PLUGINS_ENABLE- += SEMISYNC_SLAVE
MARIADB_PLUGINS_ENABLE- += SEQUENCE
MARIADB_PLUGINS_ENABLE- += SERVER_AUDIT
MARIADB_PLUGINS_ENABLE- += SIMPLE_PASSWORD_CHECK
MARIADB_PLUGINS_ENABLE- += SPHINX
MARIADB_PLUGINS_ENABLE- += SPIDER
MARIADB_PLUGINS_ENABLE- += SQL_ERRLOG
MARIADB_PLUGINS_ENABLE- += TEST_SQL_DISCOVERY
MARIADB_PLUGINS_ENABLE- += TOKUDB
MARIADB_PLUGINS_ENABLE- += WSREP_INFO
MARIADB_PLUGINS_ENABLE- += XTRADB

#
# cmake
#
MARIADB_CONF_TOOL	:= cmake

MARIADB_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DBUILD_CONFIG=mysql_release \
	-DSTACK_DIRECTION=1 \
	-DIMPORT_EXECUTABLES=$(PTXDIST_SYSROOT_HOST)/share/mariadb/import_executables.cmake \
	-DHAVE_LLVM_LIBCPP_EXITCODE=no \
	-DCOMMUNITY_BUILD=ON \
	-DCONNECT_WITH_JDBC=OFF \
	-DCONNECT_WITH_LIBXML2=OFF \
	-DCONNECT_WITH_ODBC=OFF \
	-DCONNECT_WITH_VCT=OFF \
	-DCONNECT_WITH_XMAP=OFF \
	-DCONNECT_WITH_ZIP=OFF \
	-DDISABLE_SHARED=OFF \
	-DENABLED_LOCAL_INFILE=OFF \
	-DENABLED_PROFILING=OFF \
	-DENABLE_DTRACE=OFF \
	-DENABLE_GCOV=OFF \
	-DFEATURE_SET=community \
	-DINSTALL_LAYOUT=STANDALONE \
	-DMYSQL_DATADIR=/var/lib/mysql/data \
	-DMYSQL_MAINTAINER_MODE=OFF \
	-DNOT_FOR_DISTRIBUTION=OFF \
	-DSECURITY_HARDENED=ON \
	-DTMPDIR=/tmp \
	-DUSE_ARIA_FOR_TMP_TABLES=ON \
	-DUSE_GCOV=OFF \
	-DWITHOUT_SERVER=OFF \
	-DWITH_ASAN=OFF \
	-DWITH_EMBEDDED_SERVER=OFF \
	-DWITH_EXTRA_CHARSETS=all \
	-DWITH_INNODB_BZIP2=OFF \
	-DWITH_INNODB_DISALLOW_WRITES=ON \
	-DWITH_INNODB_LZ4=OFF \
	-DWITH_INNODB_LZMA=OFF \
	-DWITH_INNODB_LZO=OFF \
	-DWITH_INNODB_SNAPPY=OFF \
	-DWITH_JEMALLOC=OFF \
	-DWITH_LIBARCHIVE=OFF \
	-DWITH_LIBWRAP=OFF \
	-DWITH_PCRE=system \
	-DPCRE_STACK_SIZE_OK=1 \
	-DWITH_MARIABACKUP=OFF \
	-DWITH_READLINE=OFF \
	-DWITH_SAFEMALLOC=OFF \
	-DWITH_SSL=system \
	-DWITH_SYSTEMD=$(call ptx/yesno, PTXCONF_MARIADB_SYSTEMD) \
	-DWITH_UNIT_TESTS=OFF \
	-DWITH_VALGRIND=OFF \
	-DWITH_WSREP=OFF \
	-DWITH_ZLIB=system \
	-DSYSCONFDIR=/etc/mariadb \
	-DCOMPILATION_COMMENT=PTXdist \
	-DDEFAULT_CHARSET=latin1 \
	-DLZ4_LIBS=undefined

ifneq ($(strip $(MARIADB_PLUGINS_ENABLES-y)),)
MARIADB_CONF_OPT += $(foreach plugin,$(MARIADB_PLUGINS_ENABLES-y),$(addprefix -DPLUGIN_,$(addsuffix =STATIC, $(plugin))))
endif

ifneq ($(strip $(MARIADB_PLUGINS_ENABLED-y)),)
MARIADB_CONF_OPT += $(foreach plugin,$(MARIADB_PLUGINS_ENABLED-y),$(addprefix -DPLUGIN_,$(addsuffix =DYNAMIC, $(plugin))))
endif

ifneq ($(strip $(MARIADB_PLUGINS_ENABLE-)),)
MARIADB_CONF_OPT += $(foreach plugin,$(MARIADB_PLUGINS_ENABLE-),$(addprefix -DPLUGIN_,$(addsuffix =NO, $(plugin))))
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mariadb.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mariadb)
	@$(call install_fixup, mariadb, PRIORITY, optional)
	@$(call install_fixup, mariadb, SECTION, base)
	@$(call install_fixup, mariadb, AUTHOR, "Bastian Stender <bst@pengutronix.de>")
	@$(call install_fixup, mariadb, DESCRIPTION, "MariaDB")

#	# server stuff
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mysqld)

ifdef PTXCONF_MARIADB_SYSTEMD
	@$(call install_alternative, mariadb, 0, 0, 0644, /usr/lib/systemd/system/mariadb.service)
	@$(call install_link, mariadb, ../mariadb.service, \
		/usr/lib/systemd/system/multi-user.target.wants/mariadb.service)

	@$(call install_alternative, mariadb, 0, 0, 0644, /usr/lib/systemd/system/mariadb-init.service)
	@$(call install_link, mariadb, ../mariadb-init.service, \
		/usr/lib/systemd/system/multi-user.target.wants/mariadb-init.service)
endif
	@$(call install_alternative, mariadb, 0, 0, 0644, /etc/mariadb/my.cnf)

#	# TODO: do we need more languages?
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/english/errmsg.sys)

#	# TODO: do we need more charsets?
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/charsets/latin1.xml)

#	# client stuff
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mysql)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mysqladmin)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mysql_upgrade)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mysqlcheck)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/mysqldump)

#	# bootstrap script + dependencies
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/scripts/mysql_install_db)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/my_print_defaults)
	@$(call install_copy, mariadb, 0, 0, 0755, -, /usr/bin/resolveip)

#	# bootstrap data required for mysql_install_db
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mysql_system_tables.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mysql_system_tables_data.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/mysql_performance_tables.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/fill_help_tables.sql)
	@$(call install_copy, mariadb, 0, 0, 0644, -, /usr/share/maria_add_gis_sp_bootstrap.sql)

	@$(call install_lib, mariadb, 0, 0, 0644, libmysqlclient)

#	# create a working directory which is writeable
	@$(call install_copy, mariadb, mysql, mysql, 0755, /var/lib/mysql)

	@$(call install_finish, mariadb)

	@$(call touch)

# vim: syntax=make
