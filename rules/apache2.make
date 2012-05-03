# -*-makefile-*-
#
# Copyright (C) 2005 by Robert Schwebel
#               2009, 2012 by Marc Kleine-Budde <mkl@pengutronix.de>
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
APACHE2_VERSION	:= 2.0.64
APACHE2_MD5	:= 762e250a3b981ce666bc10e6748a1ac1
APACHE2		:= httpd-$(APACHE2_VERSION)
APACHE2_SUFFIX	:= tar.bz2
APACHE2_URL	:= http://archive.apache.org/dist/httpd/$(APACHE2).$(APACHE2_SUFFIX)
APACHE2_SOURCE	:= $(SRCDIR)/$(APACHE2).$(APACHE2_SUFFIX)
APACHE2_DIR	:= $(BUILDDIR)/$(APACHE2)
APACHE2_LICENSE	:= APLv2

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
APACHE2_CONF_TOOL := autoconf
APACHE2_CONF_OPT := \
	$(CROSS_AUTOCONF_USR) \
	--includedir=/usr/include/apache2 \
	--enable-so \
	--with-apr=$(PTXDIST_SYSROOT_CROSS)/bin/apr-config \
	--with-apr-util=$(PTXDIST_SYSROOT_CROSS)/bin/apu-config

ifdef PTXCONF_APACHE2_MPM_PREFORK
APACHE2_CONF_OPT += --with-mpm=prefork
endif

ifdef PTXCONF_APACHE2_MPM_PERCHILD
APACHE2_CONF_OPT += --with-mpm=perchild
endif

ifdef PTXCONF_APACHE2_MPM_WORKER
APACHE2_CONF_OPT += --with-mpm=worker
endif

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apache2.install.post:
	@$(call targetinfo)
	@$(call world/install.post, APACHE2)
	sed -i -e "s~\([ =\"]\)\(/usr\)~\1$(PTXDIST_SYSROOT_TARGET)\2~g" \
		$(PTXDIST_SYSROOT_TARGET)/usr/build/config.nice \
		$(PTXDIST_SYSROOT_TARGET)/usr/bin/apxs
	sed -i \
		-e "/AP._BINDIR/s~\([ =\"]\)\(/usr\)~\1$(PTXDIST_SYSROOT_TARGET)\2~g" \
		-e "/^includedir/s~= \(.*\)~= $(PTXDIST_SYSROOT_TARGET)\1~g" \
		$(PTXDIST_SYSROOT_TARGET)/usr/build/config_vars.mk
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/apache2.targetinstall:
	@$(call targetinfo)

	@$(call install_init, apache2)
	@$(call install_fixup, apache2,PRIORITY,optional)
	@$(call install_fixup, apache2,SECTION,base)
	@$(call install_fixup, apache2,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, apache2,DESCRIPTION,missing)

	@$(call install_copy, apache2, 0, 0, 0755, \
		$(APACHE2_PKGDIR)/usr/bin/httpd, /usr/sbin/apache2)

ifneq ($(PTXCONF_APACHE2_SERVERROOT),"")
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_SERVERROOT))

ifdef PTXCONF_APACHE2_PUBLICDOMAINICONS
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_SERVERROOT)/icons)
	@cd $(APACHE2_PKGDIR)/usr/icons; \
	for i in *.gif *.png; do \
		$(call install_copy, apache2, 12, 102, 0644, $(APACHE2_PKGDIR)/usr/icons/$$i, \
			$(PTXCONF_APACHE2_SERVERROOT)/icons/$$i); \
	done
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_SERVERROOT)/icons/small)
	@cd $(APACHE2_PKGDIR)/usr/icons/small; \
	for i in *.gif *.png; do \
		$(call install_copy, apache2, 12, 102, 0644, $(APACHE2_PKGDIR)/usr/icons/small/$$i, \
			$(PTXCONF_APACHE2_SERVERROOT)/icons/small/$$i); \
	done
endif

ifdef PTXCONF_APACHE2_CUSTOMERRORS
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_SERVERROOT)/error)
	@cd $(APACHE2_PKGDIR)/usr/error; \
	for i in *.html.var; do \
		$(call install_copy, apache2, 12, 102, 0644, $(APACHE2_PKGDIR)/usr/error/$$i, \
			$(PTXCONF_APACHE2_SERVERROOT)/error/$$i); \
	done
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_SERVERROOT)/error/include)
	@cd $(APACHE2_PKGDIR)/usr/error/include; \
	for i in *.html; do \
		$(call install_copy, apache2, 12, 102, 0644, $(APACHE2_PKGDIR)/usr/error/include/$$i, \
			$(PTXCONF_APACHE2_SERVERROOT)/error/include/$$i); \
	done
endif

#
# install some generic definitions into the directory where
# the server's root is
# -> mime.types: Definition of mime-type, their names and extensions
# -> magic: Definitions to detect the mime-type without extensions
#
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_SERVERROOT)/conf)
	@$(call install_copy, apache2, 12, 102, 0644, $(APACHE2_PKGDIR)/etc/magic, \
		$(PTXCONF_APACHE2_SERVERROOT)/conf/magic)
	@$(call install_copy, apache2, 12, 102, 0644, $(APACHE2_PKGDIR)/etc/mime.types, \
		$(PTXCONF_APACHE2_SERVERROOT)/conf/mime.types)

endif

ifdef PTXCONF_APACHE2_DEFAULT_INDEX
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_DOCUMENTROOT))
	@$(call install_copy, apache2, 12, 102, 0644, \
		$(PTXDIST_TOPDIR)/generic/var/www/index.html, \
		$(PTXCONF_APACHE2_DOCUMENTROOT)/index.html)
endif

ifneq ($(PTXCONF_APACHE2_CONFIGDIR), "")
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_CONFIGDIR))

ifdef PTXCONF_APACHE2_INSTALL_CONFIG
	@$(call install_alternative, apache2, 12, 102, 0644, \
		/etc/apache2/httpd.conf,, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf)
endif
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@SERVERROOT@, $(PTXCONF_APACHE2_SERVERROOT))
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@DOCUMENTROOT@, $(PTXCONF_APACHE2_DOCUMENTROOT))
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@CONFIGDIR@, $(PTXCONF_APACHE2_CONFIGDIR))
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@LOGPATH@, $(PTXCONF_APACHE2_LOGDIR))
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@PIDFILE@, /var/run/apache2.pid)
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@LISTEN@, $(PTXCONF_APACHE2_LISTEN))
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@SERVERADMIN@, $(PTXCONF_APACHE2_SERVERADMIN))
	@$(call install_replace, apache2, $(PTXCONF_APACHE2_CONFIGDIR)/httpd.conf, \
		@SERVERNAME@, $(PTXCONF_APACHE2_SERVERNAME))
endif

#	#
#	# create the log dir if enabled
#	#
ifneq ($(PTXCONF_APACHE2_LOGDIR), "")
	@$(call install_copy, apache2, 12, 102, 0755, $(PTXCONF_APACHE2_LOGDIR))
endif

#	#
#	# busybox init: startscript
#	#
ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_APACHE2_STARTSCRIPT
	@$(call install_alternative, apache2, 0, 0, 0755, /etc/init.d/apache2)

	@$(call install_replace, apache2, /etc/init.d/apache2, \
		@APACHECONFIG@, $(PTXCONF_APACHE2_CONFIGDIR))
	@$(call install_replace, apache2, /etc/init.d/apache2, \
		@LOGPATH@, $(PTXCONF_APACHE2_LOGDIR))

ifneq ($(call remove_quotes, $(PTXCONF_APACHE2_BBINIT_LINK)),)
	@$(call install_link, apache2, \
		../init.d/apache2, \
		/etc/rc.d/$(PTXCONF_APACHE2_BBINIT_LINK))
endif
endif
endif

ifdef PTXCONF_PRELINK
	@$(call install_alternative, apache2, 0, 0, 0644, \
		/etc/prelink.conf.d/apache2)
endif

	@$(call install_finish, apache2)

	@$(call touch)

# vim: syntax=make
