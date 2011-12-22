# -*-makefile-*-
#
# Copyright (C) 2007 by Daniel Schnell
#		2008, 2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LIGHTTPD) += lighttpd

#
# Paths and names
#
LIGHTTPD_VERSION	:= 1.4.30
LIGHTTPD_MD5		:= 63f9df52dcae0ab5689a95c99c54e48a
LIGHTTPD		:= lighttpd-$(LIGHTTPD_VERSION)
LIGHTTPD_SUFFIX		:= tar.bz2
LIGHTTPD_URL		:= http://download.lighttpd.net/lighttpd/releases-1.4.x/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_SOURCE		:= $(SRCDIR)/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_DIR		:= $(BUILDDIR)/$(LIGHTTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(LIGHTTPD_SOURCE):
	@$(call targetinfo)
	@$(call get, LIGHTTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIGHTTPD_PATH	:= PATH=$(CROSS_PATH)
LIGHTTPD_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
LIGHTTPD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--libdir=/usr/lib/lighttpd \
	--$(call ptx/endis, PTXCONF_GLOBAL_LARGE_FILE)-lfs \
	$(GLOBAL_IPV6_OPTION) \
	--without-libev \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_MYSQL)-mysql \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_LDAP)-ldap \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_ATTR)-attr \
	--without-valgrind \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_OPENSSL)-openssl \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_KERBEROS)-kerberos5 \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_PCRE)-pcre \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_ZLIB)-zlib \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_BZ2LIB)-bzip2 \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_FAM)-fam \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_WEBDAV_PROPS)-webdav-props \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_WEBDAV_LOCKS)-webdav-locks \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_GDBM)-gdbm \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_MEMCACHE)-memcache \
	--$(call ptx/wwo, PTXCONF_LIGHTTPD_LUA)-lua

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/lighttpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, lighttpd)
	@$(call install_fixup, lighttpd,PRIORITY,optional)
	@$(call install_fixup, lighttpd,SECTION,base)
	@$(call install_fixup, lighttpd,AUTHOR,"Daniel Schnell <danielsch@marel.com>")
	@$(call install_fixup, lighttpd,DESCRIPTION,missing)

	@$(call install_copy, lighttpd, 0, 0, 0755, -, \
		/usr/sbin/lighttpd)
	@$(call install_copy, lighttpd, 0, 0, 0755, -, \
		/usr/sbin/lighttpd-angel)

	@cd $(LIGHTTPD_PKGDIR) && \
		find ./usr/lib -name "*.so" | \
		while read file; do \
		$(call install_copy, lighttpd, 0, 0, 0644, -, \
			$${file##.}) \
	done

#	#
#	# configs
#	#
	@$(call install_alternative, lighttpd, 0, 0, 0644, /etc/lighttpd/lighttpd.conf)

	@$(call install_replace, lighttpd, /etc/lighttpd/lighttpd.conf, \
		@CGI@, $(call ptx/ifdef, PTXCONF_PHP5_SAPI_CGI,,#))

	@$(call install_replace, lighttpd, /etc/lighttpd/lighttpd.conf, \
		@NOCGI@, $(call ptx/ifdef, PTXCONF_PHP5_SAPI_CGI,#,))

ifdef PTXCONF_PHP5_SAPI_CGI
	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/lighttpd/mod_fastcgi.conf, \
		/etc/lighttpd/mod_fastcgi.conf)
endif

#	#
#	# busybox init: start script
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_LIGHTTPD_STARTSCRIPT
	@$(call install_alternative, lighttpd, 0, 0, 0755, /etc/init.d/lighttpd)

ifneq ($(call remove_quotes, $(PTXCONF_LIGHTTPD_BBINIT_LINK)),)
	@$(call install_link, lighttpd, \
		../init.d/lighttpd, \
		/etc/rc.d/$(PTXCONF_LIGHTTPD_BBINIT_LINK))
endif
endif
endif

ifdef PTXCONF_INITMETHOD_UPSTART
	@$(call install_alternative, lighttpd, 0, 0, 0755, /etc/init/lighttpd.conf)
endif

ifdef PTXCONF_LIGHTTPD_SYSTEMD_UNIT
	@$(call install_alternative, lighttpd, 0, 0, 0644, \
		/lib/systemd/system/lighttpd.service)
	@$(call install_link, lighttpd, ../lighttpd.service, \
		/lib/systemd/system/multi-user.target.wants/lighttpd.service)
	@$(call install_alternative, lighttpd, 0, 0, 0644, \
		/usr/lib/tmpfiles.d/lighttpd.conf)
endif

ifdef PTXCONF_LIGHTTPD_GENERIC_SITE
ifdef PTXCONF_PHP5_SAPI_CGI
	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/lighttpd.html, \
		/var/www/index.html)

	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/bottles.php, \
		/var/www/bottles.php)

	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/more_bottles.php, \
		/var/www/more_bottles.php)
else
	@$(call install_copy, lighttpd, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/httpd.html, \
		/var/www/index.html)
endif
endif

	@$(call install_finish, lighttpd)
	@$(call touch)

# vim: syntax=make
