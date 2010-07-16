# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
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
PACKAGES-$(PTXCONF_APACHE2) += apache2

#
# Paths and names
#
APACHE2_VERSION	:= 2.0.58
APACHE2		:= httpd-$(APACHE2_VERSION)
APACHE2_SUFFIX	:= tar.bz2
APACHE2_URL	:= http://archive.apache.org/dist/httpd/$(APACHE2).$(APACHE2_SUFFIX)
APACHE2_SOURCE	:= $(SRCDIR)/$(APACHE2).$(APACHE2_SUFFIX)
APACHE2_DIR	:= $(BUILDDIR)/$(APACHE2)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(APACHE2_SOURCE):
	@$(call targetinfo)
	@$(call get, APACHE2)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

# FIXME: find a real patch for ac_* apr_* (fix configure script)
APACHE2_CONF_ENV := \
	$(CROSS_ENV) \
	ac_cv_sizeof_ssize_t=4 \
	ac_cv_sizeof_size_t=4 \
	apr_cv_process_shared_works=yes \
	apr_cv_mutex_robust_shared=no \
	ac_cv_func_setpgrp_void=yes

APACHE2_BINCONFIG_GLOB := ""

#
# autoconf
#
# - if we don't specify expat here, apache2 finds the internal one and
#   installs it into sysroot, which overwrites our installed version
#
APACHE2_CONF_TOOL := autoconf
APACHE2_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--includedir=/usr/include/apache2
	--enable-so \
	--with-expat=$(SYSROOT)/usr

ifdef PTXCONF_APACHE2_MPM_PREFORK
APACHE2_CONF_OPT += --with-mpm=prefork
endif

ifdef PTXCONF_APACHE2_MPM_PERCHILD
APACHE2_CONF_OPT += --with-mpm=perchild
endif

ifdef PTXCONF_APACHE2_MPM_WORKER
APACHE2_CONF_OPT += --with-mpm=worker
endif

# FIXME
# --without-apxs $(CROSS_AUTOCONF_USR)
# --with-python \
# --with-python-src=$(PYTHON24_DIR) \

$(STATEDIR)/apache2.prepare:
	@$(call targetinfo)
	@$(call world/prepare, APACHE2)
#	#
#	# Tweak, Tweak ...
#	#
#	# The original object files are also used for other binaries, so
#	# we generate a dummy dependency here
#	#
	sed -i -e "s/^gen_test_char_OBJECTS =.*$$/gen_test_char_OBJECTS = dummy.lo/g" $(APACHE2_DIR)/server/Makefile

	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/apache2.compile:
	@$(call targetinfo)

#	#
#	# Tweak, tweak...
#	#
#	# These files are run during compilation, so they have to be
#	# compiled for the host, not for the target
#	#
	touch $(APACHE2_DIR)/srclib/apr-util/uri/gen_uri_delims.lo
	cp $(PTXCONF_SYSROOT_HOST)/bin/apache2/gen_uri_delims \
		$(APACHE2_DIR)/srclib/apr-util/uri/gen_uri_delims
	touch $(APACHE2_DIR)/srclib/apr-util/uri/gen_uri_delims

	touch $(APACHE2_DIR)/srclib/pcre/dftables.lo
	cp $(PTXCONF_SYSROOT_HOST)/bin/apache2/dftables \
		$(APACHE2_DIR)/srclib/pcre/dftables
	touch $(APACHE2_DIR)/srclib/pcre/dftables

	touch $(APACHE2_DIR)/server/dummy.lo
	cp $(PTXCONF_SYSROOT_HOST)/bin/apache2/gen_test_char \
		$(APACHE2_DIR)/server/gen_test_char
	touch $(APACHE2_DIR)/server/gen_test_char

	@$(call compile, APACHE2)

	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apache2.install.post:
	@$(call targetinfo)
	@$(call world/install.post, APACHE2)
	sed -i -e "s~\([ =\"]\)\(/usr\)~\1$(SYSROOT)\2~g" \
		$(SYSROOT)/usr/build/apr_rules.mk \
		$(SYSROOT)/usr/build/config.nice \
		$(SYSROOT)/usr/bin/apr-config \
		$(SYSROOT)/usr/bin/apu-config \
		$(SYSROOT)/usr/bin/apxs
	sed -i \
		-e "/AP._BINDIR/s~\([ =\"]\)\(/usr\)~\1$(SYSROOT)\2~g" \
		-e "/^includedir/s~= \(.*\)~= $(SYSROOT)\1~g" \
		$(SYSROOT)/usr/build/config_vars.mk
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apache2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, apache2)
	@$(call install_fixup, apache2,PACKAGE,apache2)
	@$(call install_fixup, apache2,PRIORITY,optional)
	@$(call install_fixup, apache2,VERSION,$(APACHE2_VERSION))
	@$(call install_fixup, apache2,SECTION,base)
	@$(call install_fixup, apache2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, apache2,DEPENDS,)
	@$(call install_fixup, apache2,DESCRIPTION,missing)

#	# the server binary
	@$(call install_copy, apache2, 0, 0, 0755, \
		$(APACHE2_PKGDIR)/usr/bin/httpd, /usr/sbin/apache2)

#	# and some needed shared libraries
	@$(call install_copy, apache2, 0, 0, 0644, -, \
		/usr/lib/libaprutil-0.so.0.9.12)
	@$(call install_link, apache2, libaprutil-0.so.0.9.12, /usr/lib/libaprutil-0.so.0.9)
	@$(call install_link, apache2, libaprutil-0.so.0.9.12, /usr/lib/libaprutil-0.so.0)

	@$(call install_copy, apache2, 0, 0, 0644, -, \
		/usr/lib/libapr-0.so.0.9.12)
	@$(call install_link, apache2, libapr-0.so.0.9.12, /usr/lib/libapr-0.so.0.9)
	@$(call install_link, apache2, libapr-0.so.0.9.12, /usr/lib/libapr-0.so.0)

ifneq ($(PTXCONF_APACHE2_SERVERROOT),"")
	@$(call install_copy, apache2, 12,102,0755,$(PTXCONF_APACHE2_SERVERROOT))

ifdef PTXCONF_APACHE2_PUBLICDOMAINICONS
#	# TODO: are all icons required?
	@$(call install_copy, apache2, 12,102,0755,$(PTXCONF_APACHE2_SERVERROOT)/icons)
	@cd $(APACHE2_PKGDIR)/usr/icons; \
	for i in *.gif *.png; do \
		$(call install_copy, apache2, 12,102,0644, $(APACHE2_PKGDIR)/usr/icons/$$i, \
			$(PTXCONF_APACHE2_SERVERROOT)/icons/$$i, n); \
	done
	@$(call install_copy, apache2, 12,102,0755,$(PTXCONF_APACHE2_SERVERROOT)/icons/small)
	@cd $(APACHE2_PKGDIR)/usr/icons/small; \
	for i in *.gif *.png; do \
		$(call install_copy, apache2, 12,102,0644, $(APACHE2_PKGDIR)/usr/icons/small/$$i, \
			$(PTXCONF_APACHE2_SERVERROOT)/icons/small/$$i, n); \
	done
endif
ifdef PTXCONF_APACHE2_CUSTOMERRORS
	@$(call install_copy, apache2, 12,102,0755,$(PTXCONF_APACHE2_SERVERROOT)/error)
	@cd $(APACHE2_PKGDIR)/usr/error; \
	for i in *.html.var; do \
		$(call install_copy, apache2, 12,102,0644, $(APACHE2_PKGDIR)/usr/error/$$i, \
			$(PTXCONF_APACHE2_SERVERROOT)/error/$$i, n); \
	done
	@$(call install_copy, apache2, 12,102,0755,$(PTXCONF_APACHE2_SERVERROOT)/error/include)
	@cd $(APACHE2_PKGDIR)/usr/error/include; \
	for i in *.html; do \
		$(call install_copy, apache2, 12,102,0644, $(APACHE2_PKGDIR)/usr/error/include/$$i, \
			$(PTXCONF_APACHE2_SERVERROOT)/error/include/$$i, n); \
	done
endif

#
# install some generic definitions into the directory where
# the server's root is
# -> mime.types: Definition of mime-type, their names and extensions
# -> magic: Definitions to detect the mime-type without extensions
#
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_SERVERROOT)/conf)
	@$(call install_copy, apache2, 12, 102, 0644, \
		$(APACHE2_PKGDIR)/etc/magic, \
		$(PTXCONF_APACHE2_SERVERROOT)/conf/magic, n)
	@$(call install_copy, apache2, 12, 102, 0644, \
		$(APACHE2_PKGDIR)/etc/mime.types, \
		$(PTXCONF_APACHE2_SERVERROOT)/conf/mime.types, n)

endif

ifneq ($(PTXCONF_APACHE2_DOCUMENTROOT),"")
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_DOCUMENTROOT))
ifdef PTXCONF_APACHE2_DEFAULT_INDEX
	@$(call install_copy, apache2, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/index.html, \
		$(PTXCONF_APACHE2_DOCUMENTROOT)/index.html, n)
endif
endif

ifneq ($(PTXCONF_APACHE2_CONFIGDIR),"")
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_CONFIGDIR))
# ---------------------------
# generate a config file
#
ifdef PTXCONF_APACHE2_INSTALL_CONFIG
ifdef PTXCONF_APACHE2_DEFAULTCONFIG
# use generic one
	@$(call install_copy, apache2, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/apache2/httpd.conf, \
		$(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, n)
endif
ifdef PTXCONF_APACHE2_USERCONFIG
# users one
	@$(call install_copy, apache2, 12, 102, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/$(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		$(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, n)
endif
# modify placeholders with data from configuration
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@SERVERROOT@, $(PTXCONF_APACHE2_SERVERROOT) )
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@DOCUMENTROOT@, $(PTXCONF_APACHE2_DOCUMENTROOT) )
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@CONFIGDIR@, $(PTXCONF_APACHE2_CONFIGDIR) )
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@LOGPATH@, $(PTXCONF_APACHE2_LOGDIR) )
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@PIDFILE@, /var/run/apache2.pid )
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@LISTEN@, $(PTXCONF_APACHE2_LISTEN) )
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@SERVERADMIN@, $(PTXCONF_APACHE2_SERVERADMIN) )
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@SERVERNAME@, $(PTXCONF_APACHE2_SERVERNAME) )
endif
endif

#	#
#	# create the log dir if enabled
#	#

ifneq ($(PTXCONF_APACHE2_LOGDIR),"")
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_LOGDIR))
endif

#	#
#	# busybox init: startscript
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_APACHE2_STARTSCRIPT
	@$(call install_alternative, apache2, 0, 0, 0755, /etc/init.d/apache2, n)

#	# replace some placeholders
	@$(call install_replace, apache2, /etc/init.d/apache2, \
		@APACHECONFIG@,  $(PTXCONF_APACHE2_CONFIGDIR) )
	@$(call install_replace, apache2, /etc/init.d/apache2, \
		@LOGPATH@,  $(PTXCONF_APACHE2_LOGDIR) )
endif
endif

ifdef PTXCONF_PRELINK
	@$(call install_alternative, apache2, 0, 0, 0644, \
		/etc/prelink.conf.d/apache2)
endif

	@$(call install_finish, apache2)

	@$(call touch)

# vim: syntax=make
