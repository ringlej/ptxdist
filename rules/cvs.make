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
PACKAGES-$(PTXCONF_CVS) += cvs

#
# Paths and names
#
CVS_VERSION	:= 1.11.22
CVS		:= cvs-$(CVS_VERSION)
CVS_SUFFIX	:= tar.bz2
CVS_URL		:= ftp://ftp.gnu.org/non-gnu/cvs/source/stable/$(CVS_VERSION)/$(CVS).$(CVS_SUFFIX)
CVS_SOURCE	:= $(SRCDIR)/$(CVS).$(CVS_SUFFIX)
CVS_DIR		:= $(BUILDDIR)/$(CVS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

cvs_get: $(STATEDIR)/cvs.get

$(STATEDIR)/cvs.get: $(cvs_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(CVS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, CVS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

cvs_extract: $(STATEDIR)/cvs.extract

$(STATEDIR)/cvs.extract: $(cvs_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CVS_DIR))
	@$(call extract, CVS)
	@$(call patchin, CVS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

cvs_prepare: $(STATEDIR)/cvs.prepare

CVS_PATH	:= PATH=$(CROSS_PATH)
CVS_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
CVS_AUTOCONF := $(CROSS_AUTOCONF_USR) \
	--prefix=/usr \
	--disable-dependency-tracking \
	--enable-case-sensitivity

ifdef PTXCONF_CVS_NDBM
	CVS_AUTOCONF += --enable-cvs-ndbm
else
	CVS_AUTOCONF += --disable-cvs-ndbm
endif

ifdef PTXCONF_CVS_CLIENT
	CVS_AUTOCONF += --enable-client
else
	CVS_AUTOCONF += --disable-client
endif

ifdef PTXCONF_CVS_PSSWRD_CLIENT
	CVS_AUTOCONF += --enable-password-authenticated-client
else
	CVS_AUTOCONF += --disable-password-authenticated-client
endif

ifdef PTXCONF_CVS_SERVER
	CVS_AUTOCONF += --enable-server
else
	CVS_AUTOCONF += --disable-server
endif

ifdef PTXCONF_CVS_FLOW_CONTROL
	CVS_AUTOCONF += --enable-server-flow-control=1M,2M
else
	CVS_AUTOCONF += --disable-server-flow-control
endif

ifdef PTXCONF_CVS_ENCRYPTION
	CVS_AUTOCONF += --enable-encryption
else
	CVS_AUTOCONF += --disable-encryption
endif

ifdef PTXCONF_CVS_ROOTCOMMIT
	CVS_AUTOCONF += --enable-rootcommit
else
	CVS_AUTOCONF += --disable-rootcommit
endif

#
# if we are sure we have a tmp/ directory we
# forward cvs to use it
# If not, cvs probes at runtime
#
ifdef PTXCONF_ROOTFS_TMP
	CVS_AUTOCONF += --with-tmpdir=/tmp
endif

# missing switches yet
# --with-rsh
# --with-umask
# --with-cvs-admin-group=GROUP
#
$(STATEDIR)/cvs.prepare: $(cvs_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(CVS_DIR)/config.cache)
	cd $(CVS_DIR) && \
		$(CVS_PATH) $(CVS_ENV) \
		./configure $(CVS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

cvs_compile: $(STATEDIR)/cvs.compile

$(STATEDIR)/cvs.compile: $(cvs_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(CVS_DIR) && $(CVS_PATH) $(MAKE)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

cvs_install: $(STATEDIR)/cvs.install

$(STATEDIR)/cvs.install: $(cvs_install_deps_default)
	@$(call targetinfo, $@)
	@$(call install, CVS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

#
# This is a list of files cvs will call
# when specific actions occure
#
CVS_CVSROOT_FILES := commitinfo cvsignore cvswrappers editinfo history loginfo \
	modules rcsinfo taginfo

cvs_targetinstall: $(STATEDIR)/cvs.targetinstall

$(STATEDIR)/cvs.targetinstall: $(cvs_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, cvs)
	@$(call install_fixup,cvs,PACKAGE,cvs)
	@$(call install_fixup,cvs,PRIORITY,optional)
	@$(call install_fixup,cvs,VERSION,$(CVS_VERSION))
	@$(call install_fixup,cvs,SECTION,base)
	@$(call install_fixup,cvs,AUTHOR,"Juergen Beisert <j.beisert\@pengutronix.de>")
	@$(call install_fixup,cvs,DEPENDS,)
	@$(call install_fixup,cvs,DESCRIPTION,missing)

ifdef PTXCONF_CVS_INETD_SERVER
ifneq ($(call remove_quotes,$(PTXCONF_CVS_SERVER_REPOSITORY)),)
	@$(call install_copy, cvs, 0, 0, 0755, $(PTXCONF_CVS_SERVER_REPOSITORY))

#
# install only existing files
#
ifdef PTXCONF_CVS_SERVER_POPULATE_CVSROOT
	@$(call install_copy, cvs, 0, 0, 0750, \
		$(PTXCONF_CVS_SERVER_REPOSITORY)/CVSROOT)
	@for i in ${CVS_CVSROOT_FILES}; do \
		if [ -f $(PTXDIST_WORKSPACE)/projectroot/cvsroot/$$i ]; then \
			$(call install_copy, cvs, 0, 0,0750, \
				${PTXDIST_WORKSPACE}/projectroot/cvsroot/$$i, \
				$(PTXCONF_CVS_SERVER_REPOSITORY)/CVSROOT/$$i,n); \
		fi; \
	done;

	@for i in config passwd readers writers; do \
		if [ -f $(PTXDIST_WORKSPACE)/projectroot/cvsroot/$$i ]; then \
			$(call install_copy, cvs, 0, 0,0640, \
				${PTXDIST_WORKSPACE}/projectroot/cvsroot/$$i, \
				$(PTXCONF_CVS_SERVER_REPOSITORY)/CVSROOT/$$i,n); \
		fi; \
	done;
endif
endif
endif
#
# Install the startup script on request only
#
ifdef PTXCONF_CVS_STARTUP_TYPE_STANDALONE
ifdef PTXCONF_ROOTFS_ETC_INITD_CVS_DEFAULT
# install the generic one
	@$(call install_copy, cvs, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/cvs, \
		/etc/init.d/cvs, n)
endif
ifdef PTXCONF_ROOTFS_ETC_INITD_CVS_USER
# install users one
	@$(call install_copy, cvs, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/cvs, \
		/etc/init.d/cvs, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_CVS_LINK),"")
	@$(call install_copy, cvs, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, cvs, ../init.d/cvs, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_CVS_LINK))
endif
endif

	@$(call install_copy, cvs, 0, 0, 0755, $(CVS_DIR)/src/cvs, /usr/bin/cvs)

	@$(call install_finish,cvs)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

cvs_clean:
	rm -rf $(STATEDIR)/cvs.*
	rm -rf $(IMAGEDIR)/cvs_*
	rm -rf $(CVS_DIR)

# vim: syntax=make
