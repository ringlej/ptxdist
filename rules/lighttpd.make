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
LIGHTTPD_VERSION= 1.4.18
LIGHTTPD	= lighttpd-$(LIGHTTPD_VERSION)
LIGHTTPD_SUFFIX	= tar.bz2
LIGHTTPD_URL	= http://www.lighttpd.net/download/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_SOURCE	= $(SRCDIR)/$(LIGHTTPD).$(LIGHTTPD_SUFFIX)
LIGHTTPD_DIR	= $(BUILDDIR)/$(LIGHTTPD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

lighttpd_get: $(STATEDIR)/lighttpd.get

$(STATEDIR)/lighttpd.get: $(lighttpd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(LIGHTTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, LIGHTTPD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

lighttpd_extract: $(STATEDIR)/lighttpd.extract

$(STATEDIR)/lighttpd.extract: $(lighttpd_extract_deps_default)
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
LIGHTTPD_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/lighttpd.prepare: $(lighttpd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(LIGHTTPD_DIR)/config.cache)
	cd $(LIGHTTPD_DIR) && \
		$(LIGHTTPD_PATH) $(LIGHTTPD_ENV) \
		./configure $(LIGHTTPD_AUTOCONF) --with-openssl --with-pcre --prefix=/usr
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

lighttpd_compile: $(STATEDIR)/lighttpd.compile

$(STATEDIR)/lighttpd.compile: $(lighttpd_compile_deps_default)
	@$(call targetinfo, $@)
	$(LIGHTTPD_PATH) make -C $(LIGHTTPD_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

lighttpd_install: $(STATEDIR)/lighttpd.install

$(STATEDIR)/lighttpd.install: $(lighttpd_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, LIGHTTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

lighttpd_targetinstall: $(STATEDIR)/lighttpd.targetinstall

$(STATEDIR)/lighttpd.targetinstall: $(lighttpd_targetinstall_deps_default)
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
	rm -rf $(IMAGEDIR)/lighttpd_*
	rm -rf $(LIGHTTPD_DIR)

# vim: syntax=make
