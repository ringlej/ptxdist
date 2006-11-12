# -*-makefile-*-
# $Id: template 6001 2006-08-12 10:15:00Z mkl $
#
# Copyright (C) 2006 by Juergen Beisert
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_FAM) += fam

#
# Paths and names
#
FAM_VERSION	:= 2.7.0
FAM		:= fam-$(FAM_VERSION)
FAM_SUFFIX	:= tar.gz
FAM_URL		:= ftp://oss.sgi.com/projects/fam/download/stable//$(FAM).$(FAM_SUFFIX)
FAM_SOURCE	:= $(SRCDIR)/$(FAM).$(FAM_SUFFIX)
FAM_DIR		:= $(BUILDDIR)/$(FAM)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fam_get: $(STATEDIR)/fam.get

$(STATEDIR)/fam.get: $(fam_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(FAM_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, FAM)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fam_extract: $(STATEDIR)/fam.extract

$(STATEDIR)/fam.extract: $(fam_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FAM_DIR))
	@$(call extract, FAM)
	@$(call patchin, FAM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fam_prepare: $(STATEDIR)/fam.prepare

FAM_PATH	:= PATH=$(CROSS_PATH)
FAM_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
FAM_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--disable-dependency-tracking

$(STATEDIR)/fam.prepare: $(fam_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(FAM_DIR)/config.cache)
	cd $(FAM_DIR) && \
		$(FAM_PATH) $(FAM_ENV) \
		./configure $(FAM_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fam_compile: $(STATEDIR)/fam.compile

$(STATEDIR)/fam.compile: $(fam_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(FAM_DIR) && $(FAM_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fam_install: $(STATEDIR)/fam.install

$(STATEDIR)/fam.install: $(fam_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, FAM)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fam_targetinstall: $(STATEDIR)/fam.targetinstall

$(STATEDIR)/fam.targetinstall: $(fam_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, fam)
	@$(call install_fixup,fam,PACKAGE,fam)
	@$(call install_fixup,fam,PRIORITY,optional)
	@$(call install_fixup,fam,VERSION,$(FAM_VERSION))
	@$(call install_fixup,fam,SECTION,base)
	@$(call install_fixup,fam,AUTHOR,"Juergen Beisert <j.beisert\@pengutronix.de>")
	@$(call install_fixup,fam,DEPENDS,)
	@$(call install_fixup,fam,DESCRIPTION,missing)

	@$(call install_copy, fam, 0, 0, 0755, $(FAM_DIR)/src/famd, \
		/usr/sbin/famd)
ifdef PTXCONF_FAM_DEFAULT_CONF
	@$(call install_copy, fam, 0, 0, 0755, $(FAM_DIR)/conf/fam.conf, \
		/etc/fam.conf, n)
endif
ifdef PTXCONF_FAM_LIBRARY
	@$(call install_copy, fam, 0, 0, 0644, \
		$(FAM_DIR)/lib/.libs/libfam.so.0.0.0, \
		/usr/lib/libfam.so.0.0.0)
	@$(call install_link, fam, /usr/lib/libfam.so.0.0.0, \
		/usr/lib/libfam.so.0)
	@$(call install_link, fam, /usr/lib/libfam.so.0.0.0, \
		/usr/lib/libfam.so)
endif

ifdef PTXCONF_FAM_STARTUP_TYPE_STANDALONE
# provide everything for standalone mode
ifdef PTXCONF_ROOTFS_ETC_INITD_FAM_DEFAULT
# install the generic one
	@$(call install_copy, fam, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/famd, \
		/etc/init.d/famd, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_FAM_USER
# install users one
	@$(call install_copy, fam, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/famd, \
		/etc/init.d/famd, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_FAM_LINK),"")
	@$(call install_copy, portmap, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, portmap, ../init.d/famd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_FAM_LINK))
endif
endif

	@$(call install_finish,fam)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fam_clean:
	rm -rf $(STATEDIR)/fam.*
	rm -rf $(IMAGEDIR)/fam_*
	rm -rf $(FAM_DIR)

# vim: syntax=make
