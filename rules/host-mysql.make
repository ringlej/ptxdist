# -*-makefile-*-
# $Id$
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
# Get
# ----------------------------------------------------------------------------

host-mysql_get: $(STATEDIR)/host-mysql.get

$(STATEDIR)/host-mysql.get: $(STATEDIR)/mysql.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-mysql_extract: $(STATEDIR)/host-mysql.extract

$(STATEDIR)/host-mysql.extract: $(host-mysql_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MYSQL_DIR))
	@$(call extract, MYSQL, $(HOST_BUILDDIR))
	@$(call patchin, MYSQL, $(HOST_MYSQL_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-mysql_prepare: $(STATEDIR)/host-mysql.prepare

HOST_MYSQL_PATH	:= PATH=$(HOST_PATH)
HOST_MYSQL_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_MYSQL_AUTOCONF := $(HOST_AUTOCONF)

$(STATEDIR)/host-mysql.prepare: $(host-mysql_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_MYSQL_DIR)/config.cache)
	cd $(HOST_MYSQL_DIR) && \
		$(HOST_MYSQL_PATH) $(HOST_MYSQL_ENV) \
		./configure $(HOST_MYSQL_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-mysql_compile: $(STATEDIR)/host-mysql.compile

$(STATEDIR)/host-mysql.compile: $(host-mysql_compile_deps_default)
	@$(call targetinfo, $@)

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

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-mysql_install: $(STATEDIR)/host-mysql.install

$(STATEDIR)/host-mysql.install: $(host-mysql_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-mysql_clean:
	rm -rf $(STATEDIR)/host-mysql.*
	rm -rf $(HOST_MYSQL_DIR)

# vim: syntax=make
