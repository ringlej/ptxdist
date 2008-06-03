# -*-makefile-*-
# $Id: php-apc.make,v 1.5 2005/04/29 08:40:27 michl Exp $
#
# Copyright (C) 2005 by Jiri Nesladek
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PHP_APC) += php-apc

#
# Paths and names
#
PHP_APC_VERSION	= 2.0.4
PHP_APC		= APC-$(PHP_APC_VERSION)
PHP_APC_SUFFIX	= tgz
PHP_APC_URL	= http://pecl.php.net/get/$(PHP_APC).$(PHP_APC_SUFFIX)
PHP_APC_SOURCE	= $(SRCDIR)/$(PHP_APC).$(PHP_APC_SUFFIX)
PHP_APC_DIR	= $(PHP_DIR)/ext/$(PHP_APC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

php-apc_get: $(STATEDIR)/php-apc.get

$(STATEDIR)/php-apc.get: $(php-apc_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PHP_APC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PHP_APC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

php-apc_extract: $(STATEDIR)/php-apc.extract

$(STATEDIR)/php-apc.extract: $(php-apc_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP_APC_DIR))
	@$(call extract, PHP_APC, $(PHP_DIR)/ext)
	@$(call patchin, PHP_APC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

php-apc_prepare: $(STATEDIR)/php-apc.prepare

PHP_APC_PATH = PATH=$(CROSS_PATH)
PHP_APC_ENV  = $(CROSS_ENV)

#
# autoconf
#
PHP_APC_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--enable-apc

$(STATEDIR)/php-apc.prepare: $(php-apc_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP_APC_DIR)/config.cache)
# FIXME: rsc: phpize path is definitely wrong here, needs to be a host tool
	cd $(PHP_APC_DIR) && \
		$(PHP_APC_PATH) $(PHP_APC_ENV) \
		$(PTXCONF_SYSROOT_TARGET)/bin/phpize && \
		$(PHP_APC_PATH) $(PHP_APC_ENV) \
		./configure $(PHP_APC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

php-apc_compile: $(STATEDIR)/php-apc.compile

$(STATEDIR)/php-apc.compile: $(php-apc_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PHP_APC_DIR) && $(PHP_APC_ENV) $(PHP_APC_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

php-apc_install: $(STATEDIR)/php-apc.install

$(STATEDIR)/php-apc.install: $(php-apc_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PHP_APC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

php-apc_targetinstall: $(STATEDIR)/php-apc.targetinstall

$(STATEDIR)/php-apc.targetinstall: $(php-apc_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, php-apc)
	@$(call install_fixup, php-apc,PACKAGE,php-apc)
	@$(call install_fixup, php-apc,PRIORITY,optional)
	@$(call install_fixup, php-apc,VERSION,$(PHP_APC_VERSION))
	@$(call install_fixup, php-apc,SECTION,base)
	@$(call install_fixup, php-apc,AUTHOR,"Jiri Nesladek <nesladek\@2n.cz>")
	@$(call install_fixup, php-apc,DEPENDS,)
	@$(call install_fixup, php-apc,DESCRIPTION,missing)

	@$(call install_copy, php-apc, 0, 0, 0644, $(PHP_APC_DIR)/modules/apc.so, /usr/lib/php/apc.so)

	@$(call install_finish, php-apc)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

php-apc_clean:
	rm -rf $(STATEDIR)/php-apc.*
	rm -rf $(PKGDIR)/php-apc_*
	rm -rf $(PHP_APC_DIR)

# vim: syntax=make
