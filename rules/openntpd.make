# $Id: template 2680 2005-05-27 10:29:43Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENNTPD) += openntpd

#
# Paths and names
#
OPENNTPD_VERSION	= 3.7p1
OPENNTPD		= openntpd-$(OPENNTPD_VERSION)
OPENNTPD_SUFFIX		= tar.gz
OPENNTPD_URL		= http://www.zip.com.au/~dtucker/openntpd/release/$(OPENNTPD).$(OPENNTPD_SUFFIX)
OPENNTPD_SOURCE		= $(SRCDIR)/$(OPENNTPD).$(OPENNTPD_SUFFIX)
OPENNTPD_DIR		= $(BUILDDIR)/$(OPENNTPD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

openntpd_get: $(STATEDIR)/openntpd.get

$(STATEDIR)/openntpd.get: $(openntpd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(OPENNTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, OPENNTPD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

openntpd_extract: $(STATEDIR)/openntpd.extract

$(STATEDIR)/openntpd.extract: $(openntpd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENNTPD_DIR))
	@$(call extract, OPENNTPD)
	@$(call patchin, OPENNTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

openntpd_prepare: $(STATEDIR)/openntpd.prepare

OPENNTPD_PATH	=  PATH=$(CROSS_PATH)
OPENNTPD_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
OPENNTPD_AUTOCONF =  $(CROSS_AUTOCONF_USR) \
	--with-privsep-user=ntp \
	--with-privsep-path=/var/run/ntp

ifdef PTXCONF_OPENNTPD_ARC4RANDOM
OPENNTPD_AUTOCONF += --with-builtin-arc4random
else
OPENNTPD_AUTOCONF += --without-builtin-arc4random
endif

$(STATEDIR)/openntpd.prepare: $(openntpd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(OPENNTPD_DIR)/config.cache)
	cd $(OPENNTPD_DIR) && \
		$(OPENNTPD_PATH) $(OPENNTPD_ENV) \
		./configure $(OPENNTPD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

openntpd_compile: $(STATEDIR)/openntpd.compile

$(STATEDIR)/openntpd.compile: $(openntpd_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(OPENNTPD_DIR) && $(OPENNTPD_ENV) $(OPENNTPD_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

openntpd_install: $(STATEDIR)/openntpd.install

$(STATEDIR)/openntpd.install: $(openntpd_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME: does not work because of install -s
	# @$(call install, OPENNTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

openntpd_targetinstall: $(STATEDIR)/openntpd.targetinstall

$(STATEDIR)/openntpd.targetinstall: $(openntpd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, openntpd)
	@$(call install_fixup, openntpd,PACKAGE,openntpd)
	@$(call install_fixup, openntpd,PRIORITY,optional)
	@$(call install_fixup, openntpd,VERSION,$(OPENNTPD_VERSION))
	@$(call install_fixup, openntpd,SECTION,base)
	@$(call install_fixup, openntpd,AUTHOR,"Carsten Schlote c.schlote\@konzeptpark.de>")
	@$(call install_fixup, openntpd,DEPENDS,)
	@$(call install_fixup, openntpd,DESCRIPTION,missing)

	@$(call install_copy, openntpd, 0, 0, 0755, $(OPENNTPD_DIR)/ntpd, /usr/sbin/ntpd)

ifdef PTXCONF_OPENNTPD_USERS_CONFIG
	@$(call install_copy, openntpd, 0, 0, 0644, \
		${PTXDIST_WORKSPACE}/projectroot/etc/ntpd.conf, \
		/etc/ntpd.conf, n)
else
	@$(call install_copy, openntpd, 0, 0, 0644, \
		$(OPENNTPD_DIR)/ntpd.conf, \
		/etc/ntpd.conf, n)
endif

ifdef PTXCONF_OPENNTPD_INITD_SCRIPT
	# -- Initscript
	@$(call install_copy, openntpd, 0,0, 755, \
		${PTXDIST_WORKSPACE}/projectroot/etc/init.d/ntp, \
		/etc/init.d/ntp, n)
	@$(call install_copy, openntpd, 0, 0, 0755, /etc/rc.d)
	@$(call install_link, openntpd, ../init.d/ntp, \
		/etc/rc.d/S19_ntp)
endif

	@$(call install_finish, openntpd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

openntpd_clean:
	rm -rf $(STATEDIR)/openntpd.*
	rm -rf $(IMAGEDIR)/openntpd_*
	rm -rf $(OPENNTPD_DIR)

# vim: syntax=make
