# -*-makefile-*-
#
# Copyright (C) 2016 by Juergen Borleis <jbe@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifndef PTXCONF_ARCH_PPC
PACKAGES-$(PTXCONF_MYSQL) += mysql
endif

#
# Paths and names
#
MYSQL_VERSION	:= 5.7.11
MYSQL_MD5	:= f84d945a40ed876d10f8d5a7f4ccba32
MYSQL		:= mysql-$(MYSQL_VERSION)
MYSQL_SUFFIX	:= tar.gz
MYSQL_URL	:= https://dev.mysql.com/get/Downloads/MySQL-5.7/$(MYSQL).tar.gz
MYSQL_SOURCE	:= $(SRCDIR)/$(MYSQL).$(MYSQL_SUFFIX)
MYSQL_DIR	:= $(BUILDDIR)/$(MYSQL)
MYSQL_LICENSE	:= GPL-2.0-only

# mySQL has a hard dependency to boost_1_59_0. Deal with it

MYSQL_BOOST_VERSION	:= 1_59_0
MYSQL_BOOST_MD5		:= 6aa9a5c6a4ca1016edd0ed1178e3cb87
MYSQL_BOOST		:= boost_$(MYSQL_BOOST_VERSION)
MYSQL_BOOST_SUFFIX	:= tar.bz2
MYSQL_BOOST_URL		:= $(call ptx/mirror, SF, boost/$(MYSQL_BOOST).$(MYSQL_BOOST_SUFFIX))
MYSQL_BOOST_SOURCE	:= $(SRCDIR)/$(MYSQL_BOOST).$(MYSQL_BOOST_SUFFIX)
$(MYSQL_BOOST_SOURCE)	:= MYSQL_BOOST
MYSQL_BOOST_DIR		:= $(MYSQL_DIR)

# we need more than one archive to download
MYSQL_SOURCES		:= $(MYSQL_SOURCE) $(MYSQL_BOOST_SOURCE)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/mysql.extract:
	@$(call targetinfo)
	@$(call clean, $(MYSQL_DIR))
	@$(call extract, MYSQL)
	@$(call extract, MYSQL_BOOST)
	@$(call patchin, MYSQL)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# cmake
#
MYSQL_CONF_TOOL	:= cmake
MYSQL_CONF_OPT	:= \
	$(CROSS_CMAKE_USR) \
	-DINSTALL_LAYOUT=TARGZ \
	-DBUILD_CONFIG=mysql_release \
	-DSTACK_DIRECTION=1 \
	-DHAVE_LLVM_LIBCPP_EXITCODE=no \
	-DWITH_ZLIB=system \
	-DWITH_LZ4=bundled \
	-DWITH_SSL=bundled \
	-DCOMMUNITY_BUILD=ON \
	-DBOOST_INCLUDE_DIR=$(MYSQL_BOOST_DIR) \
	-DLOCAL_BOOST_DIR=$(MYSQL_BOOST_DIR) \
	-DMYSQL_DATADIR=/usr/local/mysql/data \
	-DMYSQL_KEYRINGDIR=/usr/local/mysql/keyring \
	-DSYSCONFDIR=/etc/mysql \
	-DSYSTEMD_PID_DIR=/run/mysql \
	-DTMPDIR=/tmp \
	-DWITH_EXTRA_CHARSETS=all \
	-DWITH_UNIT_TESTS=OFF \
	-DWITH_VALGRIND=OFF \
	-DWITH_SYSTEMD=$(call ptx/onoff, PTXCONF_MYSQL_SYSTEMD) \
	-DCOMPILATION_COMMENT=PTXdist \
	-DDEFAULT_CHARSET=latin1 \
	-DENABLE_DTRACE=OFF

MYSQL_CXXFLAGS := -std=c++98

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/mysql.compile:
	@$(call targetinfo)
	# we must copy it twice: once for the buildsystem, once for runtime
	cp $(HOST_MYSQL_DIR)-build/sql/gen_lex_hash $(PTXDIST_SYSROOT_HOST)/bin
	cp $(HOST_MYSQL_DIR)-build/sql/gen_lex_hash $(MYSQL_DIR)/sql
	cp $(HOST_MYSQL_DIR)-build/sql/gen_lex_token $(PTXDIST_SYSROOT_HOST)/bin
	cp $(HOST_MYSQL_DIR)-build/sql/gen_lex_token $(MYSQL_DIR)/sql
	cp $(HOST_MYSQL_DIR)-build/extra/lz4_decompress $(PTXDIST_SYSROOT_HOST)/bin
	cp $(HOST_MYSQL_DIR)-build/extra/lz4_decompress $(MYSQL_DIR)/extra
	cp $(HOST_MYSQL_DIR)-build/extra/zlib_decompress $(PTXDIST_SYSROOT_HOST)/bin
	cp $(HOST_MYSQL_DIR)-build/extra/zlib_decompress $(MYSQL_DIR)/extra
	cp $(HOST_MYSQL_DIR)-build/extra/comp_err $(PTXDIST_SYSROOT_HOST)/bin
	cp $(HOST_MYSQL_DIR)-build/extra/comp_err $(MYSQL_DIR)/extra
	cp $(HOST_MYSQL_DIR)-build/scripts/comp_sql $(PTXDIST_SYSROOT_HOST)/bin
	cp $(HOST_MYSQL_DIR)-build/scripts/comp_sql $(MYSQL_DIR)/scripts

	@$(call world/compile, MYSQL)
	@$(call touch)


# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mysql.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mysql)
	@$(call install_fixup, mysql,PRIORITY,optional)
	@$(call install_fixup, mysql,SECTION,base)
	@$(call install_fixup, mysql,AUTHOR,"Juergen Borleis <jbe@pengutronix.de>")
	@$(call install_fixup, mysql,DESCRIPTION,"mySQL service")

#	# server stuff
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqld)

	@$(call install_alternative, mysql, 0, 0, 0755, /usr/sbin/mysqlinit)
ifdef PTXCONF_MYSQL_SYSTEMD
	@$(call install_alternative, mysql, 0, 0, 0644, /usr/lib/systemd/system/mysqldinit.service)
	@$(call install_link, mysql, ../mysqldinit.service, \
		/usr/lib/systemd/system/multi-user.target.wants/mysqldinit.service)
	@$(call install_alternative, mysql, 0, 0, 0644, /usr/lib/systemd/system/mysqld.service)
	@$(call install_link, mysql, ../mysqld.service, \
		/usr/lib/systemd/system/multi-user.target.wants/mysqld.service)
endif
	@$(call install_alternative, mysql, 0, 0, 0644, /etc/mysql/my.cnf)
	@$(call install_copy, mysql, 0, 0, 0644, -, /usr/lib/plugin/keyring_file.so)

#	# TODO: do we need more languages?
	@$(call install_copy, mysql, 0, 0, 0644, -, /usr/share/english/errmsg.sys)

#	# TODO: do we need more charsets?
	@$(call install_copy, mysql, 0, 0, 0644, -, /usr/share/charsets/latin1.xml)

#	# client stuff
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqladmin)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysql_upgrade)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqlcheck)
	@$(call install_copy, mysql, 0, 0, 0755, -, /usr/bin/mysqldump)

	@$(call install_lib, mysql, 0, 0, 0644, libmysqlclient)

#	# create a working directory which is writeable
	@$(call install_copy, mysql, mysql, mysql, 0755, /var/lib/mysql)

	@$(call install_finish, mysql)

	@$(call touch)

# vim: syntax=make
