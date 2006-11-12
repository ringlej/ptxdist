# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation (www.ixiacom.com)
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_INETUTILS) += inetutils

#
# Paths and names
#
INETUTILS_VERSION	= 1.4.2
INETUTILS		= inetutils-$(INETUTILS_VERSION)
INETUTILS_SUFFIX	= tar.gz
INETUTILS_URL		= $(PTXCONF_SETUP_GNUMIRROR)/inetutils/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_SOURCE	= $(SRCDIR)/$(INETUTILS).$(INETUTILS_SUFFIX)
INETUTILS_DIR		= $(BUILDDIR)/$(INETUTILS)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

inetutils_get: $(STATEDIR)/inetutils.get

$(STATEDIR)/inetutils.get: $(inetutils_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(INETUTILS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, INETUTILS)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

inetutils_extract: $(STATEDIR)/inetutils.extract

$(STATEDIR)/inetutils.extract: $(inetutils_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(INETUTILS_DIR))
	@$(call extract, INETUTILS)
	@$(call patchin, INETUTILS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

inetutils_prepare: $(STATEDIR)/inetutils.prepare

INETUTILS_PATH	=  PATH=$(CROSS_PATH)
INETUTILS_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
INETUTILS_AUTOCONF =  $(CROSS_AUTOCONF_USR) \
	--with-PATH-CP=/bin/cp \
	--localstatedir=/var \
	--sysconfdir=/etc

$(STATEDIR)/inetutils.prepare: $(inetutils_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(INETUTILS_DIR) && \
		$(INETUTILS_PATH) $(INETUTILS_ENV) \
		./configure $(INETUTILS_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

inetutils_compile: $(STATEDIR)/inetutils.compile

$(STATEDIR)/inetutils.compile: $(inetutils_compile_deps_default)
	@$(call targetinfo, $@)
	$(INETUTILS_PATH) make -C $(INETUTILS_DIR)/libinetutils

# First the libraries:
ifdef PTXCONF_INETUTILS_PING
	cd $(INETUTILS_DIR)/libicmp && $(INETUTILS_PATH) make
endif

# Now the tools:
ifdef PTXCONF_INETUTILS_INETD
	cd $(INETUTILS_DIR)/inetd && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_PING
	cd $(INETUTILS_DIR)/ping && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RCP
	cd $(INETUTILS_DIR)/rcp && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RLOGIND
	cd $(INETUTILS_DIR)/rlogind && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RSH
	cd $(INETUTILS_DIR)/rsh && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_RSHD
	cd $(INETUTILS_DIR)/rshd && $(INETUTILS_PATH) make
endif
ifdef PTXCONF_INETUTILS_SYSLOGD
	cd $(INETUTILS_DIR)/syslogd && $(INETUTILS_PATH) make
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

inetutils_install: $(STATEDIR)/inetutils.install

$(STATEDIR)/inetutils.install: $(inetutils_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

inetutils_targetinstall: $(STATEDIR)/inetutils.targetinstall

$(STATEDIR)/inetutils.targetinstall: $(inetutils_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, inetutils)
	@$(call install_fixup, inetutils,PACKAGE,inetutils)
	@$(call install_fixup, inetutils,PRIORITY,optional)
	@$(call install_fixup, inetutils,VERSION,$(INETUTILS_VERSION))
	@$(call install_fixup, inetutils,SECTION,base)
	@$(call install_fixup, inetutils,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, inetutils,DEPENDS,)
	@$(call install_fixup, inetutils,DESCRIPTION,missing)

ifdef PTXCONF_INETUTILS_INETD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/inetd/inetd, /usr/sbin/inetd)
endif
ifdef PTXCONF_INETUTILS_PING
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/ping/ping, /bin/ping)
endif
ifdef PTXCONF_INETUTILS_RCP
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/rcp/rcp, /usr/bin/rcp)
endif
ifdef PTXCONF_INETUTILS_RLOGIND
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/rlogind/rlogind, /usr/sbin/rlogind)
endif
ifdef PTXCONF_INETUTILS_RSH
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/rsh/rsh, /usr/bin/rsh)
endif
ifdef PTXCONF_INETUTILS_RSHD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/rshd/rshd, /usr/sbin/rshd)
endif
ifdef PTXCONF_INETUTILS_SYSLOGD
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(INETUTILS_DIR)/syslogd/syslogd, /sbin/syslogd)
endif
#
# Install the startup script on request only
#
ifdef PTXCONF_INETUTILS_ETC_INITD_INETD
ifdef PTXCONF_INETUTILS_ETC_INITD_INETD_DEFAULT
# install the generic one
	@$(call install_copy, inetutils, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/inetd, \
		/etc/init.d/inetd, n)
endif

ifdef PTXCONF_INETUTILS_ETC_INITD_INETD_USER
# install users one
	@$(call install_copy, inetutils, 0, 0, 0755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/inetd, \
		/etc/init.d/inetd, n)
endif
#
# FIXME: Is this packet the right location for the link?
#
ifneq ($(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK),"")
	@$(call install_copy, inetutils, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, inetutils, ../init.d/inetd, \
		/etc/rc.d/$(PTXCONF_ROOTFS_ETC_INITD_INETD_LINK))
endif
endif

	@$(call install_finish, inetutils)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

inetutils_clean:
	rm -rf $(STATEDIR)/inetutils.*
	rm -rf $(IMAGEDIR)/inetutils_*
	rm -rf $(INETUTILS_DIR)

# vim: syntax=make
