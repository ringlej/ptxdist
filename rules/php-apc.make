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
ifdef PTXCONF_PHP_APC
PACKAGES += php-apc
endif

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

php-apc_get_deps = $(PHP_APC_SOURCE)

$(STATEDIR)/php-apc.get: $(php-apc_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PHP_APC))
	touch $@

$(PHP_APC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PHP_APC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

php-apc_extract: $(STATEDIR)/php-apc.extract

php-apc_extract_deps = $(STATEDIR)/php-apc.get \
	$(STATEDIR)/php.extract

$(STATEDIR)/php-apc.extract: $(php-apc_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP_APC_DIR))
	@$(call extract, $(PHP_APC_SOURCE), $(PHP_DIR)/ext)
	@$(call patchin, $(PHP_APC))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

php-apc_prepare: $(STATEDIR)/php-apc.prepare

#
# dependencies
#
php-apc_prepare_deps = \
	$(STATEDIR)/php-apc.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/php.install

PHP_APC_PATH = PATH=$(CROSS_PATH)
PHP_APC_ENV  = $(CROSS_ENV)

#
# autoconf
#
PHP_APC_AUTOCONF = \
	$(CROSS_AUTOCONF) \
	--prefix=$(CROSS_LIB_DIR) \
	--enable-apc

$(STATEDIR)/php-apc.prepare: $(php-apc_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP_APC_DIR)/config.cache)
	cd $(PHP_APC_DIR) && \
		$(PHP_APC_PATH) $(PHP_APC_ENV) \
		$(CROSS_LIB_DIR)/bin/phpize && \
		$(PHP_APC_PATH) $(PHP_APC_ENV) \
		./configure $(PHP_APC_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

php-apc_compile: $(STATEDIR)/php-apc.compile

php-apc_compile_deps = $(STATEDIR)/php-apc.prepare

$(STATEDIR)/php-apc.compile: $(php-apc_compile_deps)
	@$(call targetinfo, $@)
	cd $(PHP_APC_DIR) && $(PHP_APC_ENV) $(PHP_APC_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

php-apc_install: $(STATEDIR)/php-apc.install

$(STATEDIR)/php-apc.install: $(STATEDIR)/php-apc.compile
	@$(call targetinfo, $@)
	cd $(PHP_APC_DIR) && $(PHP_APC_ENV) $(PHP_APC_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

php-apc_targetinstall: $(STATEDIR)/php-apc.targetinstall

php-apc_targetinstall_deps = $(STATEDIR)/php-apc.compile

$(STATEDIR)/php-apc.targetinstall: $(php-apc_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,php-apc)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PHP_APC_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Jiri Nesladek <nesladek\@2n.cz>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(PHP_APC_DIR)/modules/apc.so, /usr/lib/php/apc.so)

	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

php-apc_clean:
	rm -rf $(STATEDIR)/php-apc.*
	rm -rf $(IMAGEDIR)/php-apc_*
	rm -rf $(PHP_APC_DIR)

# vim: syntax=make
