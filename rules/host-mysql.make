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
HOST_PACKAGES-$(PTXCONF_HOST_MYSQL) += host-mysql

#
# Paths and names
#
HOST_MYSQL_BOOST		= $(MYSQL_BOOST)
HOST_MYSQL_BOOST_SOURCE		= $(MYSQL_BOOST_SOURCE)
HOST_MYSQL_BOOST_DIR		= $(HOST_MYSQL_DIR)
HOST_BOOST_LICENSE		:= BSL-1.0

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mysql.extract:
	@$(call targetinfo)
	@$(call clean, $(HOST_MYSQL_DIR))
	@$(call extract, HOST_MYSQL)
	@$(call extract, HOST_MYSQL_BOOST)
	@$(call patchin, HOST_MYSQL)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare + Compile
# ----------------------------------------------------------------------------

#
# cmake
#
HOST_MYSQL_CONF_TOOL	:= cmake
HOST_MYSQL_CONF_OPT	:= \
	$(HOST_CMAKE_OPT) \
	-DBUILD_CONFIG=mysql_release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr \
	-DSTACK_DIRECTION=1 \
	-DBOOST_INCLUDE_DIR=$(HOST_MYSQL_BOOST_DIR) \
	-DLOCAL_BOOST_DIR=$(HOST_MYSQL_BOOST_DIR) \
	-DHAVE_LLVM_LIBCPP_EXITCODE=no \
	-DHAVE_FALLOC_PUNCH_HOLE_AND_KEEP_SIZE_EXITCODE=no \
	-DWITH_ZLIB="bundled"

HOST_MYSQL_CXXFLAGS := -std=c++98

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mysql.install:
	@$(call targetinfo)
	@$(call world/install, HOST_MYSQL)
#	# prefix != /usr is broken, but only sysroot-host/bin is in $PATH
	@mv -v $(HOST_MYSQL_PKGDIR)/usr/bin $(HOST_MYSQL_PKGDIR)
	@install -v -m755  $(HOST_MYSQL_DIR)-build/sql/gen_lex_hash $(HOST_MYSQL_PKGDIR)/bin/
	@install -v -m755  $(HOST_MYSQL_DIR)-build/sql/gen_lex_token $(HOST_MYSQL_PKGDIR)/bin/
	@install -v -m755  $(HOST_MYSQL_DIR)-build/extra/comp_err $(HOST_MYSQL_PKGDIR)/bin/
	@install -v -m755  $(HOST_MYSQL_DIR)-build/scripts/comp_sql $(HOST_MYSQL_PKGDIR)/bin/
	@$(call touch)

# vim: syntax=make
