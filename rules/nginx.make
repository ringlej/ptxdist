# -*-makefile-*-
#
# Copyright (C) 2015 by Marc Kleine-Budde <mkl@pengutronix.de>
# Copyright (C) 2016 by Clemens Gruber <clemens.gruber@pqgruber.com>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_NGINX) += nginx

#
# Paths and names
#
NGINX_VERSION	:= 1.12.2
NGINX_MD5	:= 4d2fc76211435f029271f1cf6d7eeae3
NGINX		:= nginx-$(NGINX_VERSION)
NGINX_SUFFIX	:= tar.gz
NGINX_URL	:= https://nginx.org/download/$(NGINX).$(NGINX_SUFFIX)
NGINX_SOURCE	:= $(SRCDIR)/$(NGINX).$(NGINX_SUFFIX)
NGINX_DIR	:= $(BUILDDIR)/$(NGINX)
NGINX_LICENSE	:= BSD-2-Clause
NGINX_LICENSE_FILES	:= file://LICENSE;md5=903753de5f86a1ee0341fd2f9491b282

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

NGINX_CONF_ENV := \
	ngx_force_c_compiler=yes \
	ngx_force_c99_have_variadic_macros=yes \
	ngx_force_gcc_have_variadic_macros=yes \
	ngx_force_gcc_have_atomic=yes \
	ngx_force_have_libatomic=no \
	ngx_force_have_epoll=yes \
	ngx_force_have_sendfile=yes \
	ngx_force_have_sendfile64=yes \
	ngx_force_have_pr_set_dumpable=yes \
	ngx_force_have_timer_event=yes \
	ngx_force_have_map_anon=yes \
	ngx_force_have_map_devzero=yes \
	ngx_force_have_sysvshm=yes \
	ngx_force_have_posix_sem=yes \
	ngx_force_ipv6=$(call ptx/yesno, PTXCONF_GLOBAL_IPV6)

ifdef PTXCONF_ENDIAN_LITTLE
NGINX_CONF_ENV += ngx_force_have_little_endian=yes
endif

NGINX_CONF_TOOL := autoconf
NGINX_CONF_OPT := \
	--crossbuild=Linux::$(PTXCONF_ARCH_STRING) \
	--with-cc=$(CROSS_CC) \
	--with-cpp=$(CROSS_CC) \
	--with-cc-opt="-O2 -Wno-error" \
	--prefix=/usr/share/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--sbin-path=/usr/sbin/nginx \
	--pid-path=/run/nginx.pid \
	--lock-path=/var/lock/nginx.lock \
	--user=www \
	--group=www \
	--error-log-path=stderr \
	--http-log-path=/var/log/nginx \
	--http-client-body-temp-path=/var/tmp/nginx/client-body \
	--http-proxy-temp-path=/var/tmp/nginx/proxy \
	--http-fastcgi-temp-path=/var/tmp/nginx/fastcgi \
	--http-scgi-temp-path=/var/tmp/nginx/scgi \
	--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
	--$(call ptx/wwo, PTXCONF_NGINX_PCRE)-pcre \
	--without-http_browser_module \
	--without-http_charset_module \
	--without-http_empty_gif_module \
	--without-http_geo_module \
	--without-http_limit_conn_module \
	--without-http_limit_req_module \
	--without-http_map_module \
	--without-http_memcached_module \
	--without-http_referer_module \
	--without-http_split_clients_module \
	--without-http_ssi_module \
	--without-http_upstream_hash_module \
	--without-http_upstream_ip_hash_module \
	--without-http_upstream_keepalive_module \
	--without-http_upstream_least_conn_module \
	--without-http_upstream_zone_module \
	--without-http_userid_module \
	--without-mail_imap_module \
	--without-mail_pop3_module \
	--without-mail_smtp_module \
	--without-stream_access_module \
	--without-stream_limit_conn_module \
	--without-stream_upstream_hash_module \
	--without-stream_upstream_least_conn_module \
	--without-stream_upstream_zone_module

# Note: Settings and module options are *not* symmetric.
#       If a module is on by default, a without option exists.
#       If it is off by default, a with option exists.

# Opt-in
NGINX_CONF_OPTIN-$(PTXCONF_NGINX_HTTP_GZIP_STATIC_MODULE)	:= http_gzip_static_module
NGINX_CONF_OPTIN-$(PTXCONF_NGINX_HTTP_SSL_MODULE)		+= http_ssl_module
NGINX_CONF_OPTIN-$(PTXCONF_NGINX_HTTP_V2_MODULE)		+= http_v2_module
NGINX_CONF_OPTIN-$(PTXCONF_NGINX_PCRE_JIT)			+= pcre-jit
NGINX_CONF_OPTIN-$(PTXCONF_NGINX_THREADS)			+= threads

# Opt-out
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_ACCESS_MODULE)		:= http_access_module
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_AUTH_BASIC_MODULE)	+= http_auth_basic_module
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_AUTOINDEX_MODULE)	+= http_autoindex_module
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_FASTCGI_MODULE)		+= http_fastcgi_module
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_GZIP_MODULE)		+= http_gzip_module
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_PROXY_MODULE)		+= http_proxy_module
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_REWRITE_MODULE)		+= http_rewrite_module
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_SCGI_MODULE)		+= http_scgi_module
NGINX_CONF_OPTOUT-$(PTXCONF_NGINX_HTTP_UWSGI_MODULE)		+= http_uwsgi_module

NGINX_CONF_OPT += \
	$(addprefix --with-,$(NGINX_CONF_OPTIN-y)) \
	$(addprefix --without-,$(NGINX_CONF_OPTOUT-))

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/nginx.targetinstall:
	@$(call targetinfo)

	@$(call install_init, nginx)
	@$(call install_fixup, nginx,PRIORITY,optional)
	@$(call install_fixup, nginx,SECTION,base)
	@$(call install_fixup, nginx,AUTHOR,"Clemens Gruber <clemens.gruber@pqgruber.com>")
	@$(call install_fixup, nginx,DESCRIPTION,missing)

	@$(call install_copy, nginx, 0, 0, 0755, -, /usr/sbin/nginx)

	@$(call install_alternative, nginx, 0, 0, 0644, /etc/nginx/nginx.conf)
	@$(call install_alternative, nginx, 0, 0, 0644, /etc/nginx/mime.types)

ifdef PTXCONF_NGINX_POPULATE_TEST_WEBSITE
	@$(call install_alternative, nginx, www, www, 0644, \
		/var/www/httpd.html, n, /var/www/index.html)
endif

ifdef PTXCONF_NGINX_SYSTEMD_UNIT
	@$(call install_alternative, nginx, 0, 0, 0644, /usr/lib/systemd/system/nginx.service)
	@$(call install_link, nginx, ../nginx.service, \
		/usr/lib/systemd/system/multi-user.target.wants/nginx.service)
endif
	@$(call install_alternative, nginx, 0, 0, 0644, /usr/lib/tmpfiles.d/nginx.conf)

	@$(call install_finish, nginx)

	@$(call touch)

# vim: syntax=make
