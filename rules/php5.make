# -*-makefile-*-
#
# Copyright (C) 2006-2008 by Robert Schwebel
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
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
PHP5_VERSION	:= 5.2.9
PHP5		:= php-$(PHP5_VERSION)
PHP5_SUFFIX	:= tar.bz2
PHP5_SOURCE	:= $(SRCDIR)/$(PHP5).$(PHP5_SUFFIX)
PHP5_DIR	:= $(BUILDDIR)/$(PHP5)

PHP5_URL	:= \
	http://museum.php.net/php5/$(PHP5).$(PHP5_SUFFIX)

# This is the primary URL, but they remove old revisions from there :-(
#	http://de.php.net/distributions/$(PHP5).$(PHP5_SUFFIX)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PHP5_SOURCE):
	@$(call targetinfo)
	@$(call get, PHP5)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

PHP5_PATH	:= PATH=$(CROSS_PATH)
PHP5_ENV 	:= $(CROSS_ENV)
PHP5_BINCONFIG_GLOB := ""

#
# autoconf
#
PHP5_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-config-file-path=/etc/php5 \
	--without-pdo-sqlite \
	--without-iconv


# FIXME: configure is broken beyond repair for glibc-libiconv

# FIXME: PHP Data Objects -> sqlite doesn't link correctly

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
PHP5_AUTOCONF += \
	--enable-libxml \
	--with-libxml-dir=$(SYSROOT)/usr
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

ifdef PTXCONF_PHP5_EXT_MYSQL
PHP5_AUTOCONF += \
	--with-mysql=$(SYSROOT)/usr \
	--with-pdo-mysql=$(SYSROOT)/usr
else
PHP5_AUTOCONF += --without-mysql
endif

ifdef PTXCONF_PHP5_EXT_SOAP
PHP5_AUTOCONF += --enable-soap
else
PHP5_AUTOCONF += --disable-soap
endif

ifdef PTXCONF_PHP5_EXT_SOCKETS
PHP5_AUTOCONF += --enable-sockets
else
PHP5_AUTOCONF += --disable-sockets
endif

ifdef PTXCONF_PHP5_EXT_PEAR
PHP5_AUTOCONF += --with-pear=FIXME
else
PHP5_AUTOCONF += --without-pear
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/php5.install:
	@$(call targetinfo)

	@$(call clean, $(PHP5_PKGDIR))
	@mkdir -p -- "$(PHP5_PKGDIR)/etc"

ifdef PTXCONF_PHP5_SAPI_APXS2
	cp "$(SYSROOT)/etc/httpd.conf" "$(PHP5_PKGDIR)/etc"
endif
	cd $(PHP5_DIR) && \
		$(PHP5_PATH) \
		$(PHP5_ENV) \
		make install \
		INSTALL_ROOT=$(PHP5_PKGDIR)
	install -m 755 -D "$(PHP5_DIR)/scripts/php-config" "$(PHP5_PKGDIR)/bin/php-config"
	install -m 755 -D "$(PHP5_DIR)/scripts/phpize" "$(PHP5_PKGDIR)/bin/phpize"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/php5.targetinstall:
	@$(call targetinfo)

	@$(call install_init, php5)
	@$(call install_fixup,php5,PACKAGE,php5)
	@$(call install_fixup,php5,PRIORITY,optional)
	@$(call install_fixup,php5,VERSION,$(PHP5_VERSION))
	@$(call install_fixup,php5,SECTION,base)
	@$(call install_fixup,php5,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup,php5,DEPENDS,)
	@$(call install_fixup,php5,DESCRIPTION,missing)

ifdef PTXCONF_PHP5_SAPI_APXS2
	@$(call install_copy, php5, 0, 0, 0644, -, \
		/usr/modules/libphp5.so)
endif

ifdef PTXCONF_PHP5_SAPI_CLI
	@$(call install_copy, php5, 0, 0, 0755, $(PHP5_PKGDIR)/usr/bin/php, \
		/usr/bin/php5)
endif

ifdef PTXCONF_PHP5_SAPI_CGI
	@$(call install_copy, php5, 0, 0, 0755, -, /usr/bin/php5-cgi)
endif

ifdef PTXCONF_PHP5_INI
	@$(call install_alternative, php5, 0, 0, 0644, /etc/php5/php.ini)
endif

	@$(call install_finish,php5)

	@$(call touch)

# vim: syntax=make
