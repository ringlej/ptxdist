# -*-makefile-*-
# $Id: php4.make,v 1.7 2007/01/10 09:32:53 michl Exp $
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
PACKAGES-$(PTXCONF_PHP4) += php4

#
# Paths and names
#
PHP4_VERSION	:= 4.4.4
PHP4		:= php-$(PHP4_VERSION)
PHP4_SUFFIX	:= tar.bz2
PHP4_URL	:= http://de.php.net/get/$(PHP4).$(PHP4_SUFFIX)/from/this/mirror
PHP4_SOURCE	:= $(SRCDIR)/$(PHP4).$(PHP4_SUFFIX)
PHP4_DIR	:= $(BUILDDIR)/$(PHP4)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

php4_get: $(STATEDIR)/php4.get

$(STATEDIR)/php4.get: $(php4_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PHP4_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PHP4)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

php4_extract: $(STATEDIR)/php4.extract

$(STATEDIR)/php4.extract: $(php4_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP4_DIR))
	@$(call extract, PHP4)
	@$(call patchin, PHP4)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

php4_prepare: $(STATEDIR)/php4.prepare

PHP4_PATH := PATH=$(CROSS_PATH)
PHP4_ENV := \
	$(CROSS_ENV) \
	ac_cv_func_fopencookie=no \
	ac_cv_func_getaddrinfo=yes \
	LIBS=-ldl

#
# autoconf
#
PHP4_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-config-file-path=/etc \
	--with-expat-dir=$(SYSROOT) \
	--disable-all \
	--disable-cgi \
	--with-pcre-regex

ifndef PTXCONF_PHP4_CLI
PHP4_AUTOCONF += --disable-cli
endif

ifdef PTXCONF_PHP4_ZTS
PHP4_AUTOCONF += --enable-experimental-zts
endif

ifdef PTXCONF_PHP4_MOD_APACHE2
PHP4_AUTOCONF += --with-apxs2=$(SYSROOT)/usr/bin/apxs
endif

$(STATEDIR)/php4.prepare: $(php4_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP4_DIR)/config.cache)
	cd $(PHP4_DIR) && \
		$(PHP4_PATH) $(PHP4_ENV) \
		./configure $(PHP4_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

php4_compile: $(STATEDIR)/php4.compile

$(STATEDIR)/php4.compile: $(php4_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PHP4_DIR) && $(PHP4_ENV) $(PHP4_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

php4_install: $(STATEDIR)/php4.install

$(STATEDIR)/php4.install: $(php4_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, PHP4,,,INSTALL_ROOT=$(SYSROOT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

php4_targetinstall: $(STATEDIR)/php4.targetinstall

$(STATEDIR)/php4.targetinstall: $(php4_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, php4)
	@$(call install_fixup, php4,PACKAGE,php4)
	@$(call install_fixup, php4,PRIORITY,optional)
	@$(call install_fixup, php4,VERSION,$(PHP4_VERSION))
	@$(call install_fixup, php4,SECTION,base)
	@$(call install_fixup, php4,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, php4,DEPENDS,)
	@$(call install_fixup, php4,DESCRIPTION,missing)

	@$(call install_copy, php4, 0, 0, 0755, /usr/lib/php4)

ifdef PTXCONF_PHP4_MOD_APACHE2
	@$(call install_copy, php4, 0, 0, 0644, $(PHP4_DIR)/libs/libphp4.so, /usr/lib/apache2/libphp4.so)
endif
ifdef PTXCONF_PHP4_CLI
	@$(call install_copy, php4, 0, 0, 0755, $(PHP4_DIR)/sapi/cli/php, /usr/bin/php)
endif

	@$(call install_finish, php4)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

php4_clean:
	rm -rf $(STATEDIR)/php4.*
	rm -rf $(IMAGEDIR)/php4_*
	rm -rf $(PHP4_DIR)

# vim: syntax=make
