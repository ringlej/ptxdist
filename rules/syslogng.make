# -*-makefile-*-
# $Id: template 4453 2006-01-29 13:28:16Z rsc $
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
PACKAGES-$(PTXCONF_SYSLOGNG) += syslogng

#
# Paths and names
#
SYSLOGNG_VERSION	:= 1.9.11
SYSLOGNG		:= syslog-ng-$(SYSLOGNG_VERSION)
SYSLOGNG_SUFFIX		:= tar.gz
SYSLOGNG_URL		:= http://www.balabit.com/downloads/syslog-ng/1.9/src/$(SYSLOGNG).$(SYSLOGNG_SUFFIX)
SYSLOGNG_SOURCE		:= $(SRCDIR)/$(SYSLOGNG).$(SYSLOGNG_SUFFIX)
SYSLOGNG_DIR		:= $(BUILDDIR)/$(SYSLOGNG)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

syslogng_get: $(STATEDIR)/syslogng.get

$(STATEDIR)/syslogng.get: $(syslogng_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SYSLOGNG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, SYSLOGNG)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

syslogng_extract: $(STATEDIR)/syslogng.extract

$(STATEDIR)/syslogng.extract: $(syslogng_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSLOGNG_DIR))
	@$(call extract, SYSLOGNG)
	@$(call patchin, SYSLOGNG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

syslogng_prepare: $(STATEDIR)/syslogng.prepare

SYSLOGNG_PATH	:= PATH=$(CROSS_PATH)
SYSLOGNG_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
SYSLOGNG_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--enable-dynamic-linking

ifdef PTXCONF_SYSLOGNG_SUNSTREAMS
SYSLOGNG_AUTOCONF += --enable-sun-streams
else
SYSLOGNG_AUTOCONF += --disable-sun-streams
endif

ifdef PTXCONF_SYSLOGNG_SUNDOOR
SYSLOGNG_AUTOCONF += --enable-sun-door
else
SYSLOGNG_AUTOCONF += --disable-sun-door
endif

ifdef PTXCONF_SYSLOGNG_TCPWRAPPER
SYSLOGNG_AUTOCONF += --enable-tcp-wrapper
else
SYSLOGNG_AUTOCONF += --disable-tcp-wrapper
endif

ifdef PTXCONF_SYSLOGNG_SPOOF_SOURCE
SYSLOGNG_AUTOCONF += --enable-spoof-source
else
SYSLOGNG_AUTOCONF += --disable-spoof-source
endif

$(STATEDIR)/syslogng.prepare: $(syslogng_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSLOGNG_DIR)/config.cache)
	cd $(SYSLOGNG_DIR) && \
		$(SYSLOGNG_PATH) $(SYSLOGNG_ENV) \
		./configure $(SYSLOGNG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

syslogng_compile: $(STATEDIR)/syslogng.compile

$(STATEDIR)/syslogng.compile: $(syslogng_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SYSLOGNG_DIR) && $(SYSLOGNG_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

syslogng_install: $(STATEDIR)/syslogng.install

$(STATEDIR)/syslogng.install: $(syslogng_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, SYSLOGNG)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

syslogng_targetinstall: $(STATEDIR)/syslogng.targetinstall

$(STATEDIR)/syslogng.targetinstall: $(syslogng_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, syslogng)
	@$(call install_fixup, syslogng,PACKAGE,syslogng)
	@$(call install_fixup, syslogng,PRIORITY,optional)
	@$(call install_fixup, syslogng,VERSION,$(SYSLOGNG_VERSION))
	@$(call install_fixup, syslogng,SECTION,base)
	@$(call install_fixup, syslogng,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, syslogng,DEPENDS,)
	@$(call install_fixup, syslogng,DESCRIPTION,missing)

	@$(call install_copy, syslogng, 0, 0, 0755, \
		$(SYSLOGNG_DIR)/src/syslog-ng, /sbin/syslog-ng)

ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_STARTSCRIPT
ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_DEFAULT
# install the generic one
	@$(call install_copy, syslogng, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/syslog-ng, \
		/etc/init.d/syslog-ng, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_SYSLOGNG_USER
# install users one
	@$(call install_copy, syslogng, 0, 0, 0755, \
		$(PTXDIST_WORKSPACE)/projectroot/etc/init.d/syslog-ng, \
		/etc/init.d/syslog-ng, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_LINK),"")
	@$(call install_copy, syslogng, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, syslogng, ../init.d/syslog-ng, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_DROPBEAR_LINK))
endif
endif

ifdef PTXCONF_ROOTFS_ETC_SYSLOGNG_CONFIG
ifdef PTXCONF_ROOTFS_ETC_SYSLOGNG_CONFIG_DEFAULT
# install the generic one
	@$(call install_copy, syslogng, 0, 0, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/syslog-ng.conf, \
		/etc/syslog-ng.conf)
endif
ifdef PTXCONF_ROOTFS_ETC_SYSLOGNG_CONFIG_USER
# install users one
	@$(call install_copy, syslogng, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/generic/etc/syslog-ng.conf, \
		/etc/syslog-ng.conf)
endif
endif
	@$(call install_finish, syslogng)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

syslogng_clean:
	rm -rf $(STATEDIR)/syslogng.*
	rm -rf $(IMAGEDIR)/syslogng_*
	rm -rf $(SYSLOGNG_DIR)

# vim: syntax=make
