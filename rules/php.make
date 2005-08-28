# -*-makefile-*-
# $Id: php.make,v 1.6 2005/04/29 08:40:27 michl Exp $
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
ifdef PTXCONF_PHP
PACKAGES += php
endif

#
# Paths and names
#
PHP_VERSION	= 4.3.11
PHP		= php-$(PHP_VERSION)
PHP_SUFFIX	= tar.bz2
PHP_URL		= http://cz.php.net/get/$(PHP).$(PHP_SUFFIX)/from/this/mirror
PHP_SOURCE	= $(SRCDIR)/$(PHP).$(PHP_SUFFIX)
PHP_DIR		= $(BUILDDIR)/$(PHP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

php_get: $(STATEDIR)/php.get

php_get_deps = $(PHP_SOURCE)

$(STATEDIR)/php.get: $(php_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PHP))
	$(call touch, $@)

$(PHP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PHP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

php_extract: $(STATEDIR)/php.extract

php_extract_deps = $(STATEDIR)/php.get

$(STATEDIR)/php.extract: $(php_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP_DIR))
	@$(call extract, $(PHP_SOURCE))
	@$(call patchin, $(PHP))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

php_prepare: $(STATEDIR)/php.prepare

#
# dependencies
#
php_prepare_deps = \
	$(STATEDIR)/php.extract \
	$(STATEDIR)/virtual-xchain.install

ifdef PTXCONF_PHP_APACHE
php_prepare_deps += $(STATEDIR)/apache.install
endif

PHP_PATH = PATH=$(CROSS_PATH)
PHP_ENV = \
	$(CROSS_ENV) \
	ac_cv_func_fopencookie=no \
	ac_cv_func_getaddrinfo=yes \
	LIBS=-ldl

#
# autoconf
#
PHP_AUTOCONF = \
	$(CROSS_AUTOCONF) \
	--prefix=$(CROSS_LIB_DIR) \
	--with-config-file-path=/etc \
	--disable-all

ifndef PTXCONF_PHP_CLI
PHP_AUTOCONF += --disable-cli
endif
ifdef PTXCONF_PHP_APACHE
PHP_AUTOCONF += --with-apxs=$(CROSS_LIB_DIR)/bin/apxs
endif

ifdef PTXCONF_VOICEBLUE_PHP_MODULE
PHP_AUTOCONF += VOICEBLUE_DIR=$(VOICEBLUE_DIR) --with-vblue_cnf=shared
endif
ifdef PTXCONF_NS_PHP_MODULE
PHP_AUTOCONF += NS_DIR=$(NS_DIR) --with-netstar_cfg=shared
endif

$(STATEDIR)/php.prepare: $(php_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP_DIR)/config.cache)
	cd $(PHP_DIR) && \
 		$(PHP_PATH) $(PHP_ENV) \
		./configure $(PHP_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

php_compile: $(STATEDIR)/php.compile

php_compile_deps = $(STATEDIR)/php.prepare

$(STATEDIR)/php.compile: $(php_compile_deps)
	@$(call targetinfo, $@)
	cd $(PHP_DIR) && $(PHP_ENV) $(PHP_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

php_install: $(STATEDIR)/php.install

$(STATEDIR)/php.install: $(STATEDIR)/php.compile
	@$(call targetinfo, $@)
	cd $(PHP_DIR) && $(PHP_ENV) $(PHP_PATH) make install-build install-headers install-programs
	install -m 755 -D $(PHP_DIR)/scripts/php-config $(PTXCONF_PREFIX)/bin/php-config
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

php_targetinstall: $(STATEDIR)/php.targetinstall

php_targetinstall_deps = $(STATEDIR)/php.compile \
	$(STATEDIR)/apache.targetinstall

$(STATEDIR)/php.targetinstall: $(php_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,php)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PHP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Jiri Nesladek <nesladek\@2n.cz>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, /usr/lib/php)

ifdef PTXCONF_PHP_APACHE
	@$(call install_copy, 0, 0, 0644, $(PHP_DIR)/libs/libphp4.so, /usr/lib/apache/libphp4.so)
endif
ifdef PTXCONF_PHP_CLI
	@$(call install_copy, 0, 0, 0755, $(PHP_DIR)/sapi/cli/php, /usr/bin/php)
endif

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

php_clean:
	rm -rf $(STATEDIR)/php.*
	rm -rf $(IMAGEDIR)/php_*
	rm -rf $(PHP_DIR)

# vim: syntax=make
