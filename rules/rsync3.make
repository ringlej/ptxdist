# -*-makefile-*-
# $Id: rsync3.make 7270 2007-09-03 07:15:35Z rsc $
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
PACKAGES-$(PTXCONF_RSYNC3) += rsync3

#
# Paths and names
#
RSYNC3_VERSION	:= 3.0.3
RSYNC3		:= rsync-$(RSYNC3_VERSION)
RSYNC3_SUFFIX	:= tar.gz
RSYNC3_URL	:= http://rsync.samba.org/ftp/rsync/src/$(RSYNC3).$(RSYNC3_SUFFIX)
RSYNC3_SOURCE	:= $(SRCDIR)/$(RSYNC3).$(RSYNC3_SUFFIX)
RSYNC3_DIR	:= $(BUILDDIR)/$(RSYNC3)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(RSYNC3_SOURCE):
	@$(call targetinfo)
	@$(call get, RSYNC3)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rsync3_prepare: $(STATEDIR)/rsync3.prepare

RSYNC3_PATH	:=  PATH=$(CROSS_PATH)
RSYNC3_ENV 	:=  rsync3_cv_HAVE_GETTIMEOFDAY_TZ=yes $(CROSS_ENV)

#
# autoconf
#
RSYNC3_AUTOCONF  := \
	 $(CROSS_AUTOCONF_USR) \
	--with-included-popt \
	--disable-debug \
	--disable-locale

ifdef PTXCONF_RSYNC3_LARGE_FILE
RSYNC3_AUTOCONF += --enable-largefile
else
RSYNC3_AUTOCONF += --disable-largefile
endif

ifdef PTXCONF_RSYNC3_IPV6
RSYNC3_AUTOCONF += --enable-ipv6
else
RSYNC3_AUTOCONF += --disable-ipv6
endif

ifneq ($(call remove_quotes,$(PTXCONF_RSYNC3_CONFIG_FILE)),)
RSYNC3_AUTOCONF += --with-rsync3d-conf=$(PTXCONF_RSYNC3_CONFIG_FILE)
endif

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/rsync3.targetinstall:
	@$(call targetinfo)

	@$(call install_init, rsync3)
	@$(call install_fixup, rsync3,PACKAGE,rsync3)
	@$(call install_fixup, rsync3,PRIORITY,optional)
	@$(call install_fixup, rsync3,VERSION,$(RSYNC3_VERSION))
	@$(call install_fixup, rsync3,SECTION,base)
	@$(call install_fixup, rsync3,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, rsync3,DEPENDS,)
	@$(call install_fixup, rsync3,DESCRIPTION,missing)

	@$(call install_copy, rsync3, 0, 0, 0755, \
		$(RSYNC3_DIR)/rsync, \
		/usr/bin/rsync)

ifdef PTXCONF_RSYNC3_CONFIG_FILE_DEFAULT
ifneq ($(call remove_quotes,$(PTXCONF_RSYNC3_CONFIG_FILE)),)
	@$(call install_copy, rsync3, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/rsyncd.conf, \
		$(PTXCONF_RSYNC3_CONFIG_FILE), n)
else
# use default
	@$(call install_copy, rsync3, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/rsyncd.conf, \
		/etc/rsyncd.conf, n)
endif
	@$(call install_copy, rsync3, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/rsyncd.secrets, \
		/etc/rsyncd.secrets, n)
endif

ifdef PTXCONF_RSYNC3_CONFIG_FILE_USER
ifneq ($(call remove_quotes,$(PTXCONF_RSYNC3_CONFIG_FILE)),)
	@$(call install_copy, rsync3, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.conf, \
		$(PTXCONF_RSYNC3_CONFIG_FILE), n)
else
# use as default
	@$(call install_copy, rsync3, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.conf, \
		/etc/rsyncd.conf, n)
endif
	@$(call install_copy, rsync3, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.secrets, \
		/etc/rsyncd.secrets, n)
endif

ifdef PTXCONF_RSYNC3_STARTUP_TYPE_STANDALONE
# provide everything for standalone mode
ifdef PTXCONF_ROOTFS_ETC_INITD_RSYNC3_DEFAULT
# install generic one
	@$(call install_copy, rsync3, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/rsyncd, \
		/etc/init.d/rsyncd, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_RSYNC3_USER
# install users one
	@$(call install_copy, rsync3, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/rsyncd, \
		/etc/init.d/rsyncd, n)
endif
# replace the @CONFIG@ with path and name of the configfile
ifneq ($(PTXCONF_RSYNC3_CONFIG_FILE),"")
	@$(call install_replace, rsync3, /etc/init.d/rsyncd, \
		@CONFIG@, \
		"--config=$(PTXCONF_RSYNC3_CONFIG_FILE)" )
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_RSYNC3_LINK),)
	@$(call install_copy, rsync3, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, rsync3, ../init.d/rsyncd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_RSYNC3_LINK), n)
endif
endif

	@$(call install_finish, rsync3)
	@$(call touch)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rsync3_clean:
	rm -rf $(STATEDIR)/rsync3.*
	rm -rf $(PKGDIR)/rsync3_*
	rm -rf $(RSYNC3_DIR)

# vim: syntax=make
