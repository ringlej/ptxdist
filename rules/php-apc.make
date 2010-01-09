# -*-makefile-*-
#
# Copyright (C) 2005 by Jiri Nesladek
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
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
PHP_APC_VERSION	:= 2.0.4
PHP_APC		:= APC-$(PHP_APC_VERSION)
PHP_APC_SUFFIX	:= tgz
PHP_APC_URL	:= http://pecl.php.net/get/$(PHP_APC).$(PHP_APC_SUFFIX)
PHP_APC_SOURCE	:= $(SRCDIR)/$(PHP_APC).$(PHP_APC_SUFFIX)
PHP_APC_DIR	:= $(PHP_DIR)/ext/$(PHP_APC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PHP_APC_SOURCE):
	@$(call targetinfo)
	@$(call get, PHP_APC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

$(STATEDIR)/php-apc.extract:
	@$(call targetinfo)
	@$(call clean, $(PHP_APC_DIR))
	@$(call extract, PHP_APC, $(PHP_DIR)/ext)
	@$(call patchin, PHP_APC)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PHP_APC_PATH = PATH=$(CROSS_PATH)
PHP_APC_ENV  = $(CROSS_ENV)

#
# autoconf
#
PHP_APC_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--enable-apc

$(STATEDIR)/php-apc.prepare:
	@$(call targetinfo)
	@$(call clean, $(PHP_APC_DIR)/config.cache)
# FIXME: mol: phpize is a shell script so it works but a host tool may be nicer
	cd $(PHP_APC_DIR) && \
		$(PHP_APC_PATH) $(PHP_APC_ENV) \
		$(PTXCONF_SYSROOT_TARGET)/bin/phpize && \
		$(PHP_APC_PATH) $(PHP_APC_ENV) \
		./configure $(PHP_APC_AUTOCONF)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/php-apc.targetinstall:
	@$(call targetinfo)

	@$(call install_init, php-apc)
	@$(call install_fixup, php-apc,PACKAGE,php-apc)
	@$(call install_fixup, php-apc,PRIORITY,optional)
	@$(call install_fixup, php-apc,VERSION,$(PHP_APC_VERSION))
	@$(call install_fixup, php-apc,SECTION,base)
	@$(call install_fixup, php-apc,AUTHOR,"Jiri Nesladek <nesladek@2n.cz>")
	@$(call install_fixup, php-apc,DEPENDS,)
	@$(call install_fixup, php-apc,DESCRIPTION,missing)

	@$(call install_copy, php-apc, 0, 0, 0644, -, /usr/lib/php/apc.so)

	@$(call install_finish, php-apc)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

php-apc_clean:
	rm -rf $(STATEDIR)/php-apc.*
	rm -rf $(PKGDIR)/php-apc_*
	rm -rf $(PHP_APC_DIR)

# vim: syntax=make
