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
PACKAGES-$(PTXCONF_DNSMASQ) += dnsmasq

#
# Paths and names
#
DNSMASQ_VERSION		= 2.24
DNSMASQ			= dnsmasq-$(DNSMASQ_VERSION)
DNSMASQ_SUFFIX		= tar.gz
DNSMASQ_URL		= http://www.thekelleys.org.uk/dnsmasq/$(DNSMASQ).$(DNSMASQ_SUFFIX)
DNSMASQ_SOURCE		= $(SRCDIR)/$(DNSMASQ).$(DNSMASQ_SUFFIX)
DNSMASQ_DIR		= $(BUILDDIR)/$(DNSMASQ)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dnsmasq_get: $(STATEDIR)/dnsmasq.get

$(STATEDIR)/dnsmasq.get: $(dnsmasq_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(DNSMASQ_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, DNSMASQ)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dnsmasq_extract: $(STATEDIR)/dnsmasq.extract

$(STATEDIR)/dnsmasq.extract: $(dnsmasq_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(DNSMASQ_DIR))
	@$(call extract, DNSMASQ)
	@$(call patchin, DNSMASQ)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dnsmasq_prepare: $(STATEDIR)/dnsmasq.prepare

DNSMASQ_PATH	=  PATH=$(CROSS_PATH)
DNSMASQ_ENV 	=  $(CROSS_ENV)

#
# FIXME: Probably a source of problems while cross compiling:
# dnsmasq does not use autotools.
#
$(STATEDIR)/dnsmasq.prepare: $(dnsmasq_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

#
# install dnsmasq into /sbin (default is /usr/local/sbin)
#
DNSMASQ_MAKEVARS=PREFIX=/

dnsmasq_compile: $(STATEDIR)/dnsmasq.compile

$(STATEDIR)/dnsmasq.compile: $(dnsmasq_compile_deps_default)
	@$(call targetinfo, $@)
#
# Target "all" builds a non i18n aware dnsmasq, "all-i18n" a
# i18n aware dnsmasq. Currently the non i18n aware version is built
#

	cd $(DNSMASQ_DIR) && $(DNSMASQ_PATH) $(DNSMASQ_ENV) make $(DNSMASQ_MAKEVARS) all
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dnsmasq_install: $(STATEDIR)/dnsmasq.install

$(STATEDIR)/dnsmasq.install: $(dnsmasq_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, DNSMASQ)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dnsmasq_targetinstall: $(STATEDIR)/dnsmasq.targetinstall

$(STATEDIR)/dnsmasq.targetinstall: $(dnsmasq_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, dnsmasq)
	@$(call install_fixup, dnsmasq,PACKAGE,dnsmasq)
	@$(call install_fixup, dnsmasq,PRIORITY,optional)
	@$(call install_fixup, dnsmasq,VERSION,$(DNSMASQ_VERSION))
	@$(call install_fixup, dnsmasq,SECTION,base)
	@$(call install_fixup, dnsmasq,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, dnsmasq,DEPENDS,)
	@$(call install_fixup, dnsmasq,DESCRIPTION,missing)

	@$(call install_copy, dnsmasq, 0, 0, 0755, \
		$(DNSMASQ_DIR)/src/dnsmasq, \
		/sbin/dnsmasq)
#
# Install the startup script on request only
#

ifdef PTXCONF_ROOTFS_ETC_INITD_DNSMASQ_DEFAULT
# install the generic one
	@$(call install_copy, dnsmasq, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/dnsmasq, \
		/etc/init.d/dnsmasq, n)
endif

ifdef PTXCONF_ROOTFS_ETC_INITD_DNSMASQ_USER
# install users one
	@$(call install_copy, dnsmasq, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/dnsmasq, \
		/etc/init.d/dnsmasq, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_DNSMASQ_LINK),"")
	@$(call install_copy, dnsmasq, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, dnsmasq, ../init.d/dnsmasq, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_DNSMASQ_LINK))
endif

ifdef PTXCONF_DNSMASQ_ETC_DEFAULT
	@$(call install_copy, dnsmasq, 0, 0, 0644, \
		$(DNSMASQ_DIR)/dnsmasq.conf.example, \
		/etc/dnsmasq.conf)
endif
ifdef PTXCONF_DNSMASQ_ETC_USER
	@$(call install_copy, dnsmasq, 0, 0, 0644, \
		${PTXDIST_WORKSPACE}/projectroot/etc/dnsmasq.conf, \
		/etc/dnsmasq.conf)
endif

	@$(call install_finish, dnsmasq)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dnsmasq_clean:
	rm -rf $(STATEDIR)/dnsmasq.*
	rm -rf $(IMAGEDIR)/dnsmasq_*
	rm -rf $(DNSMASQ_DIR)

# vim: syntax=make
