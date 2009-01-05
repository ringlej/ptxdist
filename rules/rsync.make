# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by wschmitt@envicomp.de
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_RSYNC) += rsync

#
# Paths and names
#
RSYNC_VERSION	= 2.6.8
RSYNC		= rsync-$(RSYNC_VERSION)
RSYNC_SUFFIX	= tar.gz
RSYNC_URL	= http://samba.org/ftp/rsync/src/$(RSYNC).$(RSYNC_SUFFIX)
RSYNC_SOURCE	= $(SRCDIR)/$(RSYNC).$(RSYNC_SUFFIX)
RSYNC_DIR	= $(BUILDDIR)/$(RSYNC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(RSYNC_SOURCE):
	@$(call targetinfo)
	@$(call get, RSYNC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rsync_prepare: $(STATEDIR)/rsync.prepare

RSYNC_PATH	:= PATH=$(CROSS_PATH)
RSYNC_ENV 	:= \
	$(CROSS_ENV) \
	rsync_cv_HAVE_GETTIMEOFDAY_TZ=yes 

#
# autoconf
#
RSYNC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--target=$(PTXCONF_GNU_TARGET) \
	--with-included-popt \
	--disable-debug \
	--disable-locale

ifdef PTXCONF_RSYNC_LARGE_FILE
RSYNC_AUTOCONF += --enable-largefile
else
RSYNC_AUTOCONF += --disable-largefile
endif

ifdef PTXCONF_RSYNC_IPV6
RSYNC_AUTOCONF += --enable-ipv6
else
RSYNC_AUTOCONF += --disable-ipv6
endif

ifneq ($(call remove_quotes,$(PTXCONF_RSYNC_CONFIG_FILE)),)
RSYNC_AUTOCONF += --with-rsyncd-conf=$(PTXCONF_RSYNC_CONFIG_FILE)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rsync.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rsync)
	@$(call install_fixup, rsync,PACKAGE,rsync)
	@$(call install_fixup, rsync,PRIORITY,optional)
	@$(call install_fixup, rsync,VERSION,$(RSYNC_VERSION))
	@$(call install_fixup, rsync,SECTION,base)
	@$(call install_fixup, rsync,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, rsync,DEPENDS,)
	@$(call install_fixup, rsync,DESCRIPTION,missing)

	@$(call install_copy, rsync, 0, 0, 0755, \
		$(RSYNC_DIR)/rsync, \
		/usr/bin/rsync)

ifdef PTXCONF_RSYNC_CONFIG_FILE_DEFAULT
ifneq ($(call remove_quotes,$(PTXCONF_RSYNC_CONFIG_FILE)),)
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/rsyncd.conf, \
		$(call remove_quotes,$(PTXCONF_RSYNC_CONFIG_FILE)), n )
else
# use default
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/rsyncd.conf, \
		/etc/rsyncd.conf, n)
endif
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/rsyncd.secrets, \
		/etc/rsyncd.secrets, n)
endif

ifdef PTXCONF_RSYNC_CONFIG_FILE_USER
ifneq ($(call remove_quotes,$(PTXCONF_RSYNC_CONFIG_FILE)),)
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.conf, \
		$(call remove_quotes,$(PTXCONF_RSYNC_CONFIG_FILE)), n )
else
# use as default
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.conf, \
		/etc/rsyncd.conf, n)
endif
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.secrets, \
		/etc/rsyncd.secrets, n)
endif

ifdef PTXCONF_RSYNC_STARTUP_TYPE_STANDALONE
# provide everything for standalone mode
ifdef PTXCONF_ROOTFS_ETC_INITD_RSYNC_DEFAULT
# install generic one
	@$(call install_copy, rsync, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/rsyncd, \
		/etc/init.d/rsyncd, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_RSYNC_USER
# install users one
	@$(call install_copy, rsync, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/rsyncd, \
		/etc/init.d/rsyncd, n)
endif
# replace the @CONFIG@ with path and name of the configfile
ifneq ($(PTXCONF_RSYNC_CONFIG_FILE),"")
	@$(call install_replace, rsync, /etc/init.d/rsyncd, \
		@CONFIG@, \
		"--config=$(PTXCONF_RSYNC_CONFIG_FILE)" )
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_RSYNC_LINK),"")
	@$(call install_copy, rsync, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, rsync, ../init.d/rsyncd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_RSYNC_LINK), n)
endif
endif

	@$(call install_finish, rsync)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rsync_clean:
	rm -rf $(STATEDIR)/rsync.*
	rm -rf $(PKGDIR)/rsync_*
	rm -rf $(RSYNC_DIR)

# vim: syntax=make
