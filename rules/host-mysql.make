# -*-makefile-*-
#
# Copyright (C) 2006 by Robert Schwebel
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
HOST_MYSQL		= $(MYSQL)
HOST_MYSQL_DIR		= $(HOST_BUILDDIR)/$(HOST_MYSQL)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_MYSQL_PATH	:= PATH=$(HOST_PATH)
HOST_MYSQL_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_MYSQL_AUTOCONF := $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mysql.compile:
	@$(call targetinfo)

	# we need a comp_err tool
	cd $(HOST_MYSQL_DIR)/include && $(HOST_MYSQL_PATH) $(MAKE)
	cd $(HOST_MYSQL_DIR)/mysys && $(HOST_MYSQL_PATH) $(MAKE) libmysys.a
	cd $(HOST_MYSQL_DIR)/dbug && $(HOST_MYSQL_PATH) $(MAKE) libdbug.a
	cd $(HOST_MYSQL_DIR)/strings && $(HOST_MYSQL_PATH) $(MAKE) libmystrings.a
	cd $(HOST_MYSQL_DIR)/extra && $(HOST_MYSQL_PATH) $(MAKE) comp_err

	# we need sql/gen_lex_hash
	cd $(HOST_MYSQL_DIR)/storage/myisam && $(HOST_MYSQL_PATH) $(MAKE) libmyisam.a
	cd $(HOST_MYSQL_DIR)/storage/myisammrg && $(HOST_MYSQL_PATH) $(MAKE) libmyisammrg.a
	cd $(HOST_MYSQL_DIR)/storage/heap && $(HOST_MYSQL_PATH) $(MAKE) libheap.a
	cd $(HOST_MYSQL_DIR)/vio && $(HOST_MYSQL_PATH) $(MAKE) libvio.a
	cd $(HOST_MYSQL_DIR)/regex && $(HOST_MYSQL_PATH) $(MAKE) libregex.a
	cd $(HOST_MYSQL_DIR)/sql && $(HOST_MYSQL_PATH) $(MAKE) gen_lex_hash

	# we need dbug/factorial
	cd $(HOST_MYSQL_DIR)/dbug && $(HOST_MYSQL_PATH) $(MAKE) factorial

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/host-mysql.install:
	@$(call targetinfo)
	@$(call touch)

# vim: syntax=make
