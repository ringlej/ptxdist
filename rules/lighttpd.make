# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
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
LIGHTTPD_VERSION	:= 1.4.19
LIGHTTPD		:= lighttpd-$(LIGHTTPD_VERSION)
LIGHTTPD_SUFFIX		:= tar.bz2
LIGHTTPD_URL		:= http://www.lighttpd.net/download/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_SOURCE		:= $(SRCDIR)/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_DIR		:= $(BUILDDIR)/$(LIGHTTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lighttpd_get: $(STATEDIR)/lighttpd.get

$(STATEDIR)/lighttpd.get:
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIGHTTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIGHTTPD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lighttpd_extract: $(STATEDIR)/lighttpd.extract

$(STATEDIR)/lighttpd.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(LIGHTTPD_DIR))
	@$(call extract, LIGHTTPD)
	@$(call patchin, LIGHTTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

lighttpd_prepare: $(STATEDIR)/lighttpd.prepare

LIGHTTPD_PATH	=  PATH=$(CROSS_PATH)
LIGHTTPD_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIGHTTPD_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--without-valgrind \
	--prefix=/usr

ifdef PTXCONF_LIGHTTPD__ZLIB
LIGHTTPD_AUTOCONF += --with-zlib=$(SYSROOT)/usr
else
LIGHTTPD_AUTOCONF += --without-zlib
endif

ifdef PTXCONF_LIGHTTPD__BZLIB
LIGHTTPD_AUTOCONF += --with-bzip2=FIXME
else
LIGHTTPD_AUTOCONF += --without-bzip2
endif

ifdef PTXCONF_LIGHTTPD__LFS
LIGHTTPD_AUTOCONF += --enable-lfs
else
LIGHTTPD_AUTOCONF += --disable-lfs
endif

ifdef PTXCONF_LIGHTTPD__IPV6
LIGHTTPD_AUTOCONF += --enable-ipv6
else
LIGHTTPD_AUTOCONF += --disable-ipv6
endif

ifdef PTXCONF_LIGHTTPD__MYSQL
LIGHTTPD_AUTOCONF += --with-mysql=FIXME
else
LIGHTTPD_AUTOCONF += --without-mysql
endif

ifdef PTXCONF_LIGHTTPD__LDAP
LIGHTTPD_AUTOCONF += --with-ldap=FIXME
else
LIGHTTPD_AUTOCONF += --without-ldap
endif

ifdef PTXCONF_LIGHTTPD__ATTR
LIGHTTPD_AUTOCONF += --with-attr=FIXME
else
LIGHTTPD_AUTOCONF += --without-attr
endif

ifdef PTXCONF_LIGHTTPD__OPENSSL
LIGHTTPD_AUTOCONF += --with-openssl=FIXME
# --with-openssl-includes=DIR OpenSSL includes
# --with-openssl-libs=DIR OpenSSL libraries
else
LIGHTTPD_AUTOCONF += --without-openssl
endif

ifdef PTXCONF_LIGHTTPD__KERBEROS
LIGHTTPD_AUTOCONF += --with-kerberos=FIXME
else
LIGHTTPD_AUTOCONF += --without-kerberos
endif

ifdef PTXCONF_LIGHTTPD__PCRE
LIGHTTPD_AUTOCONF += --with-pcre=FIXME
else
LIGHTTPD_AUTOCONF += --without-pcre
endif

ifdef PTXCONF_LIGHTTPD__FAM
LIGHTTPD_AUTOCONF += --with-fam=FIXME
else
LIGHTTPD_AUTOCONF += --without-fam
endif

ifdef PTXCONF_LIGHTTPD__WEBDAV_PROPS
LIGHTTPD_AUTOCONF += --with-webdav-props=FIXME
else
LIGHTTPD_AUTOCONF += --without-webdav-props
endif

ifdef PTXCONF_LIGHTTPD__WEBDAV_LOCKS
LIGHTTPD_AUTOCONF += --with-webdav-locks=FIXME
else
LIGHTTPD_AUTOCONF += --without-webdav-locks
endif

ifdef PTXCONF_LIGHTTPD__GDBM
LIGHTTPD_AUTOCONF += --with-gdbm=FIXME
else
LIGHTTPD_AUTOCONF += --without-gdbm
endif

ifdef PTXCONF_LIGHTTPD__MEMCACHE
LIGHTTPD_AUTOCONF += --with-memcache=FIXME
else
LIGHTTPD_AUTOCONF += --without-memcache
endif

ifdef PTXCONF_LIGHTTPD__LUA
LIGHTTPD_AUTOCONF += --with-lua=FIXME
else
LIGHTTPD_AUTOCONF += --without-lua
endif

$(STATEDIR)/lighttpd.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(LIGHTTPD_DIR)/config.cache)
	cd $(LIGHTTPD_DIR) && \
		$(LIGHTTPD_PATH) $(LIGHTTPD_ENV) \
		./configure $(LIGHTTPD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lighttpd_compile: $(STATEDIR)/lighttpd.compile

$(STATEDIR)/lighttpd.compile:
	@$(call targetinfo, $@)
	$(LIGHTTPD_PATH) make -C $(LIGHTTPD_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lighttpd_install: $(STATEDIR)/lighttpd.install

$(STATEDIR)/lighttpd.install:
	@$(call targetinfo, $@)
	@$(call install, LIGHTTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lighttpd_targetinstall: $(STATEDIR)/lighttpd.targetinstall

$(STATEDIR)/lighttpd.targetinstall:
	@$(call targetinfo, $@)

	@$(call install_init, lighttpd)
	@$(call install_fixup, lighttpd,PACKAGE,lighttpd)
	@$(call install_fixup, lighttpd,PRIORITY,optional)
	@$(call install_fixup, lighttpd,VERSION,$(LIGHTTPD_VERSION))
	@$(call install_fixup, lighttpd,SECTION,base)
	@$(call install_fixup, lighttpd,AUTHOR,"Daniel Schnell <danielsch\@marel.com>")
	@$(call install_fixup, lighttpd,DEPENDS,)
	@$(call install_fixup, lighttpd,DESCRIPTION,missing)

	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/lighttpd, \
		/usr/sbin/lighttpd)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/lighttpd-angel, \
		/usr/sbin/lighttpd-angel)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/spawn-fcgi, \
		/usr/bin/spawn-fcgi)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_flv_streaming.so, /usr/lib/mod_flv_streaming.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_evasive.so, /usr/lib/mod_evasive.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_webdav.so, /usr/lib/mod_webdav.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_magnet.so, /usr/lib/mod_magnet.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_cml.so, /usr/lib/mod_cml.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_trigger_b4_dl.so, /usr/lib/mod_trigger_b4_dl.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_mysql_vhost.so, /usr/lib/mod_mysql_vhost.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_cgi.so, /usr/lib/mod_cgi.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_scgi.so, /usr/lib/mod_scgi.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_staticfile.so, /usr/lib/mod_staticfile.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_dirlisting.so, /usr/lib/mod_dirlisting.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_indexfile.so, /usr/lib/mod_indexfile.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_setenv.so, /usr/lib/mod_setenv.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_alias.so, /usr/lib/mod_alias.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_userdir.so, /usr/lib/mod_userdir.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_rrdtool.so, /usr/lib/mod_rrdtool.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_usertrack.so, /usr/lib/mod_usertrack.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_proxy.so, /usr/lib/mod_proxy.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_ssi.so, /usr/lib/mod_ssi.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_secdownload.so, /usr/lib/mod_secdownload.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_expire.so, /usr/lib/mod_expire.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_evhost.so, /usr/lib/mod_evhost.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_simple_vhost.so, /usr/lib/mod_simple_vhost.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_fastcgi.so, /usr/lib/mod_fastcgi.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_extforward.so, /usr/lib/mod_extforward.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_access.so, /usr/lib/mod_access.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_compress.so, /usr/lib/mod_compress.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_auth.so, /usr/lib/mod_auth.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_rewrite.so, /usr/lib/mod_rewrite.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_redirect.so, /usr/lib/mod_redirect.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_status.so, /usr/lib/mod_status.so)
	@$(call install_copy, lighttpd, 0, 0, 0755, $(LIGHTTPD_DIR)/src/.libs/mod_accesslog.so, /usr/lib/mod_accesslog.so)

	@$(call install_finish, lighttpd)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

lighttpd_clean:
	rm -rf $(STATEDIR)/lighttpd.*
	rm -rf $(PKGDIR)/lighttpd_*
	rm -rf $(LIGHTTPD_DIR)

# vim: syntax=make
