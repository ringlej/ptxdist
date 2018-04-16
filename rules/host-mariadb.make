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
HOST_PACKAGES-$(PTXCONF_HOST_MARIADB) += host-mariadb

# ----------------------------------------------------------------------------
# Prepare + Compile
# ----------------------------------------------------------------------------

#
# cmake
#
# FEATURE_SET=xsmall disables all plugins
# PLUGIN_MROONGA is enabled because otherwise cmake fails for mariadb 10.1.32
HOST_MARIADB_CONF_TOOL	:= cmake
HOST_MARIADB_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DCMAKE_INSTALL_PREFIX:PATH=/ \
	-DBUILD_CONFIG=mysql_release \
	-DIGNORE_AIO_CHECK=ON \
	-DSTACK_DIRECTION=1 \
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
	-DENABLE_GCOV=OFF \
	-DFEATURE_SET=xsmall \
	-DINSTALL_LAYOUT=STANDALONE \
	-DMYSQL_MAINTAINER_MODE=OFF \
	-DNOT_FOR_DISTRIBUTION=OFF \
	-DSECURITY_HARDENED=ON \
	-DUSE_ARIA_FOR_TMP_TABLES=ON \
	-DUSE_GCOV=OFF \
	-DWITHOUT_SERVER=OFF \
	-DWITH_ASAN=OFF \
	-DWITH_EMBEDDED_SERVER=OFF \
	-DWITH_EXTRA_CHARSETS=none \
	-DWITH_INNODB_BZIP2=OFF \
	-DWITH_INNODB_DISALLOW_WRITES=OFF \
	-DWITH_INNODB_LZ4=OFF \
	-DWITH_INNODB_LZMA=OFF \
	-DWITH_INNODB_LZO=OFF \
	-DWITH_INNODB_SNAPPY=OFF \
	-DWITH_JEMALLOC=OFF \
	-DWITH_LIBARCHIVE=OFF \
	-DWITH_LIBWRAP=OFF \
	-DWITH_PCRE=OFF \
	-DWITH_MARIABACKUP=OFF \
	-DWITH_READLINE=OFF \
	-DWITH_SAFEMALLOC=OFF \
	-DWITH_SSL=bundled \
	-DWITH_SYSTEMD=no \
	-DWITH_UNIT_TESTS=OFF \
	-DWITH_VALGRIND=OFF \
	-DWITH_WSREP=OFF \
	-DWITH_ZLIB=bundled \
	-DPLUGIN_MROONGA:FORCE=DYNAMIC \
	-DLZ4_LIBS=undefined

HOST_MARIADB_CXXFLAGS := -std=c++98

HOST_MARIADB_MAKE_OPT := \
	comp_err \
	comp_sql \
	factorial \
	gen_lex_hash \
	gen_lex_token

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mariadb.install:
	@$(call targetinfo)
	@rm -rf $(HOST_MARIADB_PKGDIR)
#	# install helper tools
	@install -vD -m 644 $(HOST_MARIADB_DIR)-build/import_executables.cmake \
		$(HOST_MARIADB_PKGDIR)/share/mariadb/import_executables.cmake
	@install -vD -m 755 $(HOST_MARIADB_DIR)-build/extra/comp_err $(HOST_MARIADB_PKGDIR)/bin/mariadb/comp_err
	@install -vD -m 755 $(HOST_MARIADB_DIR)-build/scripts/comp_sql $(HOST_MARIADB_PKGDIR)/bin/mariadb/comp_sql
	@install -vD -m 755 $(HOST_MARIADB_DIR)-build/dbug/factorial $(HOST_MARIADB_PKGDIR)/bin/mariadb/factorial
	@install -vD -m 755 $(HOST_MARIADB_DIR)-build/sql/gen_lex_hash $(HOST_MARIADB_PKGDIR)/bin/mariadb/gen_lex_hash
	@install -vD -m 755 $(HOST_MARIADB_DIR)-build/sql/gen_lex_token $(HOST_MARIADB_PKGDIR)/bin/mariadb/gen_lex_token
	@$(call touch)

$(STATEDIR)/host-mariadb.install.post:
	@$(call targetinfo)
	@$(call world/install.post, HOST_MARIADB)
#	# correct helper tool paths
	@sed -i -e "s;$(HOST_MARIADB_DIR)-build/extra/comp_err;$(PTXDIST_SYSROOT_HOST)/bin/mariadb/comp_err;"  \
		-e "s;$(HOST_MARIADB_DIR)-build/scripts/comp_sql;$(PTXDIST_SYSROOT_HOST)/bin/mariadb/comp_sql;"  \
		-e "s;$(HOST_MARIADB_DIR)-build/dbug/factorial;$(PTXDIST_SYSROOT_HOST)/bin/mariadb/factorial;"  \
		-e "s;$(HOST_MARIADB_DIR)-build/sql/gen_lex_hash;$(PTXDIST_SYSROOT_HOST)/bin/mariadb/gen_lex_hash;"  \
		-e "s;$(HOST_MARIADB_DIR)-build/sql/gen_lex_token;$(PTXDIST_SYSROOT_HOST)/bin/mariadb/gen_lex_token;" \
		$(PTXDIST_SYSROOT_HOST)/share/mariadb/import_executables.cmake
	@$(call touch)

# vim: syntax=make
