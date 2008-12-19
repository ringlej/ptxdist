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
PACKAGES-$(PTXCONF_PUREFTPD) += pureftpd

#
# Paths and names
#
PUREFTPD_VERSION	:= 1.0.21
PUREFTPD		:= pure-ftpd-$(PUREFTPD_VERSION)
PUREFTPD_SUFFIX		:= tar.bz2
PUREFTPD_URL		:= http://download.pureftpd.org/pub/pure-ftpd/releases/$(PUREFTPD).$(PUREFTPD_SUFFIX) \
PUREFTPD_SOURCE		:= $(SRCDIR)/$(PUREFTPD).$(PUREFTPD_SUFFIX)
PUREFTPD_DIR		:= $(BUILDDIR)/$(PUREFTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(PUREFTPD_SOURCE):
	@$(call targetinfo)
	@$(call get, PUREFTPD)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pureftpd_prepare: $(STATEDIR)/pureftpd.prepare

PUREFTPD_PATH	:= PATH=$(CROSS_PATH)
PUREFTPD_ENV 	:= $(CROSS_ENV) \
	ac_cv_snprintf_type=8

#
# autoconf
#
PUREFTPD_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking \
	--without-ascii \
	--with-banner \
	--without-pam \
	--without-cookie \
	--without-throttling \
	--without-ratios \
	--without-quotas \
	--without-ftpwho \
	--with-largefile \
	--with-welcomemsg \
	--without-virtualchroot \
	--without-nonroot \
	--without-peruserlimits \
	--without-debug \
	--with-language=english \
	--without-ldap \
	--without-mysql \
	--without-pgsql \
	--without-privsep

#
# FIXME: configure probes host's /dev/urandom and /dev/random
# instead of target's one
#
# Can --with-probe-random-dev solve this?

ifdef PTXCONF_PUREFTPD_INETD_SERVER
PUREFTPD_AUTOCONF += --with-inetd --without-standalone
else
PUREFTPD_AUTOCONF += --without-inetd --with-standalone
endif

ifdef PTXCONF_PUREFTPD_UPLOADSCRIPT
PUREFTPD_AUTOCONF += --with-uploadscript
else
PUREFTPD_AUTOCONF += --without-uploadscript
endif

ifdef PTXCONF_PUREFTPD_VIRTUALHOSTS
PUREFTPD_AUTOCONF += --with-virtualhosts
else
PUREFTPD_AUTOCONF += --without-virtualhosts
endif

ifdef PTXCONF_PUREFTPD_DIRALIASES
PUREFTPD_AUTOCONF += --with-diraliases
else
PUREFTPD_AUTOCONF += --without-diraliases
endif

ifdef PTXCONF_PUREFTPD_MINIMAL
PUREFTPD_AUTOCONF += --with-minimal
else
PUREFTPD_AUTOCONF += --without-minimal
endif

ifdef PTXCONF_PUREFTPD_SHRINK_MORE
PUREFTPD_AUTOCONF += --without-globbing
else
PUREFTPD_AUTOCONF += --with-globbing
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/pureftpd.targetinstall:
	@$(call targetinfo)

	@$(call install_init, pureftpd)
	@$(call install_fixup,pureftpd,PACKAGE,pureftpd)
	@$(call install_fixup,pureftpd,PRIORITY,optional)
	@$(call install_fixup,pureftpd,VERSION,$(PUREFTPD_VERSION))
	@$(call install_fixup,pureftpd,SECTION,base)
	@$(call install_fixup,pureftpd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,pureftpd,DEPENDS,)
	@$(call install_fixup,pureftpd,DESCRIPTION,missing)

	@$(call install_copy, pureftpd, 0, 0, 0755, \
		$(PUREFTPD_DIR)/src/pure-ftpd, \
		/usr/sbin/pure-ftpd)

ifdef PTXCONF_PUREFTPD_UPLOADSCRIPT
	@$(call install_copy, pureftpd, 0, 0, 0755, \
		$(PUREFTPD_DIR)/src/pure-uploadscript, \
		/usr/sbin/pure-uploadscript, n)
endif


ifdef PTXCONF_ROOTFS_ETC_INITD_PUREFTPD
ifdef PTXCONF_ROOTFS_ETC_INITD_PUREFTPD_DEFAULT
# install the generic one
	@$(call install_copy, pureftpd, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/pure-ftpd, \
		/etc/init.d/pure-ftpd, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_PUREFTPD_USER
# install users one
	@$(call install_copy, pureftpd, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/pure-ftpd, \
		/etc/init.d/pure-ftpd, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_PUREFTPD_LINK),"")
	@$(call install_copy, pureftpd, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, pureftpd, ../init.d/pure-ftpd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_PUREFTPD_LINK))
endif
endif

ifdef PTXCONF_PUREFTPD_ETC_CONFIG
ifdef PTXCONF_ROOTFS_ETC_INITD_PUREFTPD_DEFAULT
	@$(call install_copy, pureftpd, 0, 0, 0644, \
		${PTXDIST_TOPDIR}/generic/etc/pure-ftpd.conf, \
		/etc/pure-ftpd.conf, n)
else
	@$(call install_copy, pureftpd, 0, 0, 0644, \
		${PTXDIST_WORKSPACE}/projectroot/etc/pure-ftpd.conf, \
		/etc/pure-ftpd.conf, n)
endif
endif

	@$(call install_finish,pureftpd)

	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pureftpd_clean:
	rm -rf $(STATEDIR)/pureftpd.*
	rm -rf $(PKGDIR)/pureftpd_*
	rm -rf $(PUREFTPD_DIR)

# vim: syntax=make
