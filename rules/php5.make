# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
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
PACKAGES-$(PTXCONF_PHP5) += php5

#
# Paths and names
#
PHP5_VERSION	:= 5.1.6
PHP5		:= php-$(PHP5_VERSION)
PHP5_SUFFIX	:= tar.bz2
#PHP5_URL	:= http://de2.php.net/get/$(PHP5).$(PHP5_SUFFIX)/from/de.php.net/mirror/
PHP5_URL	:= http://de2.php.net/get/$(PHP5).$(PHP5_SUFFIX)
PHP5_SOURCE	:= $(SRCDIR)/$(PHP5).$(PHP5_SUFFIX)
PHP5_DIR	:= $(BUILDDIR)/$(PHP5)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

php5_get: $(STATEDIR)/php5.get

$(STATEDIR)/php5.get: $(php5_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PHP5_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PHP5)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

php5_extract: $(STATEDIR)/php5.extract

$(STATEDIR)/php5.extract: $(php5_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP5_DIR))
	@$(call extract, PHP5)
	@$(call patchin, PHP5)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

php5_prepare: $(STATEDIR)/php5.prepare

PHP5_PATH	:= PATH=$(CROSS_PATH)
PHP5_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
PHP5_AUTOCONF := $(CROSS_AUTOCONF_USR)
PHP5_AUTOCONF += --with-config-file-path=/etc/php5/
# FIXME: php5 doesn't interprete "with_foo=no" correctly, so we cannot
# give --without-foo options. Should be fixed in php5's configure.in.

# ------------
# SAPI Modules
# ------------

ifdef PTXCONF_PHP5_SAPI_AOLSERVER
PHP5_AUTOCONF += --with-aolserver=FIXME
else
PHP5_AUTOCONF += --without-aolserver
endif

# default off, we don't support apache1 any more
# PHP5_AUTOCONF += --without-apxs
# PHP5_AUTOCONF += --without-apache

ifdef PTXCONF_PHP5_SAPI_MOD_CHARSET
PHP5_AUTOCONF += --with-mod_charset
else
PHP5_AUTOCONF += --without-mod_charset
endif

ifdef PTXCONF_PHP5_SAPI_APXS2FILTER
PHP5_AUTOCONF += --with-apxs2filter
else
#PHP5_AUTOCONF += --without-apxs2filter
endif

ifdef PTXCONF_PHP5_SAPI_APXS2
PHP5_AUTOCONF += --with-apxs2=$(SYSROOT)/usr/bin/apxs
else
# PHP5_AUTOCONF += --without-apxs2
endif

# default off, we don't support apache1 any more
# PHP5_AUTOCONF += --without-apache-hooks
# PHP5_AUTOCONF += --without-apache-hooks-static

ifdef PTXCONF_PHP5_SAPI_CAUDIUM
PHP5_AUTOCONF += --with-caudium
else
# PHP5_AUTOCONF += --without-caudium
endif

ifdef PTXCONF_PHP5_SAPI_CLI
PHP5_AUTOCONF += --enable-cli
else
PHP5_AUTOCONF += --disable-cli
endif

ifdef PTXCONF_PHP5_SAPI_CONTINUITY
PHP5_AUTOCONF += --with-continuity
else
#PHP5_AUTOCONF += --without-continuity
endif

ifdef PTXCONF_PHP5_SAPI_EMBEDDED
PHP5_AUTOCONF += --enable-embedded
else
#PHP5_AUTOCONF += --disable-embedded
endif

ifdef PTXCONF_PHP5_SAPI_ISAPI
PHP5_AUTOCONF += --with-isapi
else
#PHP5_AUTOCONF += --without-isapi
endif

ifdef PTXCONF_PHP5_SAPI_MILTER
PHP5_AUTOCONF += --with-milter
else
#PHP5_AUTOCONF += --without-milter
endif

ifdef PTXCONF_PHP5_SAPI_NSAPI
PHP5_AUTOCONF += --with-nsapi
else
#PHP5_AUTOCONF += --without-nsapi
endif

ifdef PTXCONF_PHP5_SAPI_PHTTPD
PHP5_AUTOCONF += --with-phttpd
else
#PHP5_AUTOCONF += --without-phttpd
endif

ifdef PTXCONF_PHP5_SAPI_PI3WEB
PHP5_AUTOCONF += --with-pi3web
else
#PHP5_AUTOCONF += --without-pi3web
endif

ifdef PTXCONF_PHP5_SAPI_ROXEN
PHP5_AUTOCONF += --with-roxen
else
#PHP5_AUTOCONF += --without-roxen
endif

ifdef PTXCONF_PHP5_SAPI_ROXEN_ZTS
PHP5_AUTOCONF += --with-roxen-zts
else
#PHP5_AUTOCONF += --without-roxen-zts
endif

ifdef PTXCONF_PHP5_SAPI_THTTPD
PHP5_AUTOCONF += --with-thttpd
else
#PHP5_AUTOCONF += --without-thttpd
endif

ifdef PTXCONF_PHP5_SAPI_TUX
PHP5_AUTOCONF += --with-tux
else
#PHP5_AUTOCONF += --without-tux
endif

ifdef PTXCONF_PHP5_SAPI_CGI
PHP5_AUTOCONF += --enable-cgi
else
PHP5_AUTOCONF += --disable-cgi
endif

ifdef PTXCONF_PHP5_SAPI_FORCE_CGI_REDIRECT
PHP5_AUTOCONF += --enable-force-cgi-redirect
else
PHP5_AUTOCONF += --disable-force-cgi-redirect
endif

ifdef PTXCONF_PHP5_SAPI_DISCARD_PATH
PHP5_AUTOCONF += --enable-discard-path
else
PHP5_AUTOCONF += --disable-discard-path
endif

ifdef PTXCONF_PHP5_SAPI_FASTCGI
PHP5_AUTOCONF += --enable-fastcgi
else
#PHP5_AUTOCONF += --disable-fastcgi
endif

ifdef PTXCONF_PHP5_SAPI_PATH_INFO_CHECK
PHP5_AUTOCONF += --enable-path-info-check
else
PHP5_AUTOCONF += --disable-path-info-check
endif

# ---------------
# General Options
# ---------------

ifdef PTXCONF_PHP5_XML
PHP5_AUTOCONF += --enable-xml
else
PHP5_AUTOCONF += --disable-xml
endif

ifdef PTXCONF_PHP5_XML_LIBXML2
PHP5_AUTOCONF += --enable-libxml
PHP5_AUTOCONF += --with-libxml-dir=$(SYSROOT)/usr
else
PHP5_AUTOCONF += --disable-libxml
endif

ifdef PTXCONF_PHP5_XML_LIBXML2_READER
PHP5_AUTOCONF += --enable-xmlreader
else
PHP5_AUTOCONF += --disable-xmlreader
endif

ifdef PTXCONF_PHP5_XML_LIBXML2_WRITER
PHP5_AUTOCONF += --enable-xmlwriter
else
PHP5_AUTOCONF += --disable-xmlwriter
endif

ifdef PTXCONF_PHP5_XML_LIBXML2_DOM
PHP5_AUTOCONF += --enable-dom
else
PHP5_AUTOCONF += --disable-dom
endif

ifdef PTXCONF_PHP5_XML_LIBXML2_XSLT
PHP5_AUTOCONF += --with-xsl=$(SYSROOT)/usr
else
PHP5_AUTOCONF += --without-xsl
endif

ifdef PTXCONF_PHP5_XML_LIBXML2_SIMPLEXML
PHP5_AUTOCONF += --enable-simplexml
else
PHP5_AUTOCONF += --disable-simplexml
endif

ifdef PTXCONF_PHP5_EXT_ICONV
PHP5_AUTOCONF += --with-iconv=$(SYSROOT)/usr
else
PHP5_AUTOCONF += --without-iconv
endif

ifdef PTXCONF_PHP5_EXT_MYSQL
PHP5_AUTOCONF += --with-mysql=$(SYSROOT)/usr
else
PHP5_AUTOCONF += --without-mysql
endif

ifdef PTXCONF_PHP5_EXT_PEAR
PHP5_AUTOCONF += --with-pear=FIXME
else
PHP5_AUTOCONF += --without-pear
endif

$(STATEDIR)/php5.prepare: $(php5_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PHP5_DIR)/config.cache)
	cd $(PHP5_DIR) && \
		$(PHP5_PATH) $(PHP5_ENV) \
		./configure $(PHP5_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

php5_compile: $(STATEDIR)/php5.compile

$(STATEDIR)/php5.compile: $(php5_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PHP5_DIR) && $(PHP5_PATH) $(MAKE) CC=$(CROSS_CC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

php5_install: $(STATEDIR)/php5.install

$(STATEDIR)/php5.install: $(php5_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	cd $(PHP5_DIR) && \
		$(PHP5_ENV) $(PHP5_PATH) \
		make install-build install-headers install-programs \
		INSTALL_ROOT=$(SYSROOT)
		install -m 755 -D $(PHP5_DIR)/scripts/php-config $(SYSROOT)/bin/php-config
		install -m 755 -D $(PHP5_DIR)/scripts/phpize $(SYSROOT)/bin/phpize
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

php5_targetinstall: $(STATEDIR)/php5.targetinstall

$(STATEDIR)/php5.targetinstall: $(php5_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, php5)
	@$(call install_fixup,php5,PACKAGE,php5)
	@$(call install_fixup,php5,PRIORITY,optional)
	@$(call install_fixup,php5,VERSION,$(PHP5_VERSION))
	@$(call install_fixup,php5,SECTION,base)
	@$(call install_fixup,php5,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,php5,DEPENDS,)
	@$(call install_fixup,php5,DESCRIPTION,missing)

ifdef PTXCONF_PHP5_SAPI_APXS2
	@$(call install_copy, php5, 0, 0, 0644, $(PHP5_DIR)/libs/libphp5.so, /usr/lib/apache2/libphp5.so)
endif

ifdef PTXCONF_PHP5_CLI
	@$(call install_copy, php5, 0, 0, 0755, $(PHP5_DIR)/sapi/cli/php, /usr/bin/php5)
endif

ifdef PTXCONF_ROOTFS_GENERIC_PHP5_INI
	@$(call install_copy, php5, 0, 0, 0644, $(PHP5_DIR)/php.ini-recommended, \
		/etc/php5/php.ini,n)
endif

ifdef PTXCONF_ROOTFS_USER_PHP5_INI
	@$(call install_copy, php5, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/php5/php.ini, \
		/etc/php5/php.ini,n)
endif

	@$(call install_finish,php5)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

php5_clean:
	rm -rf $(STATEDIR)/php5.*
	rm -rf $(PKGDIR)/php5_*
	rm -rf $(PHP5_DIR)

# vim: syntax=make
