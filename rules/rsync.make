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
RSYNC_URL	= http://samba.anu.edu.au/ftp/rsync/$(RSYNC).$(RSYNC_SUFFIX)
RSYNC_SOURCE	= $(SRCDIR)/$(RSYNC).$(RSYNC_SUFFIX)
RSYNC_DIR	= $(BUILDDIR)/$(RSYNC)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rsync_get: $(STATEDIR)/rsync.get

$(STATEDIR)/rsync.get: $(rsync_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(RSYNC_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, RSYNC)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rsync_extract: $(STATEDIR)/rsync.extract

$(STATEDIR)/rsync.extract: $(rsync_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(RSYNC_DIR))
	@$(call extract, RSYNC)
	@$(call patchin, RSYNC)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rsync_prepare: $(STATEDIR)/rsync.prepare

RSYNC_PATH	=  PATH=$(CROSS_PATH)
RSYNC_ENV 	=  rsync_cv_HAVE_GETTIMEOFDAY_TZ=yes $(CROSS_ENV)

#
# autoconf
#
RSYNC_AUTOCONF  =  $(CROSS_AUTOCONF_USR) \
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

$(STATEDIR)/rsync.prepare: $(rsync_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(RSYNC_BUILDDIR))
	cd $(RSYNC_DIR) && \
		$(RSYNC_PATH) $(RSYNC_ENV) \
		./configure $(RSYNC_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rsync_compile: $(STATEDIR)/rsync.compile

$(STATEDIR)/rsync.compile: $(rsync_compile_deps_default)
	@$(call targetinfo, $@)
	$(RSYNC_PATH) make -C $(RSYNC_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rsync_install: $(STATEDIR)/rsync.install

$(STATEDIR)/rsync.install: $(rsync_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rsync_targetinstall: $(STATEDIR)/rsync.targetinstall

$(STATEDIR)/rsync.targetinstall: $(rsync_targetinstall_deps_default)
	@$(call targetinfo, $@)

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
		$(PTXCONF_RSYNC_CONFIG_FILE) )
else
# use default
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/rsyncd.conf, \
		/etc/rsyncd.conf)
endif
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/rsyncd.secrets, \
		/etc/rsyncd.secrets )
endif

ifdef PTXCONF_RSYNC_CONFIG_FILE_USER
ifneq ($(call remove_quotes,$(PTXCONF_RSYNC_CONFIG_FILE)),)
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.conf, \
		$(PTXCONF_RSYNC_CONFIG_FILE) )
else
# use as default
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.conf, \
		/etc/rsyncd.conf)
endif
	@$(call install_copy, rsync, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/rsyncd.secrets, \
		/etc/rsyncd.secrets )
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
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_RSYNC_LINK))
endif
endif

	@$(call install_finish, rsync)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rsync_clean:
	rm -rf $(STATEDIR)/rsync.*
	rm -rf $(IMAGEDIR)/rsync_*
	rm -rf $(RSYNC_DIR)

# vim: syntax=make
