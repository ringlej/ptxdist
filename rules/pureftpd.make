# -*-makefile-*-
# $Id: template 2922 2005-07-11 19:17:53Z rsc $
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
PACKAGES-$(PTXCONF_PUREFTPD) += pureftpd

#
# Paths and names
#
PUREFTPD_VERSION	= 1.0.20
PUREFTPD		= pure-ftpd-$(PUREFTPD_VERSION)
PUREFTPD_SUFFIX		= tar.bz2
PUREFTPD_URL		= ftp://ftp.pureftpd.org/pub/pure-ftpd/releases/$(PUREFTPD).$(PUREFTPD_SUFFIX)
PUREFTPD_SOURCE		= $(SRCDIR)/$(PUREFTPD).$(PUREFTPD_SUFFIX)
PUREFTPD_DIR		= $(BUILDDIR)/$(PUREFTPD)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

pureftpd_get: $(STATEDIR)/pureftpd.get

$(STATEDIR)/pureftpd.get: $(PUREFTPD_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PUREFTPD))
	@$(call touch, $@)

$(PUREFTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PUREFTPD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

pureftpd_extract: $(STATEDIR)/pureftpd.extract

$(STATEDIR)/pureftpd.extract: $(pureftpd_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PUREFTPD_DIR))
	@$(call extract, $(PUREFTPD_SOURCE))
	@$(call patchin, $(PUREFTPD))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

pureftpd_prepare: $(STATEDIR)/pureftpd.prepare

PUREFTPD_PATH	=  PATH=$(CROSS_PATH)
PUREFTPD_ENV 	=  $(CROSS_ENV)
PUREFTPD_ENV	+= ac_cv_func_snprintf=yes

#
# autoconf
#
PUREFTPD_AUTOCONF = \
	$(CROSS_AUTOCONF_USR) \
	--with-standalone \
	--without-inetd \
	--without-ascii \
	--with-banner \
	--with-minimal \
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
	--without-privsep \
	--without-tls \

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

$(STATEDIR)/pureftpd.prepare: $(pureftpd_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PUREFTPD_DIR)/config.cache)
	cd $(PUREFTPD_DIR) && \
		$(PUREFTPD_PATH) $(PUREFTPD_ENV) \
		./configure $(PUREFTPD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

pureftpd_compile: $(STATEDIR)/pureftpd.compile

$(STATEDIR)/pureftpd.compile: $(pureftpd_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PUREFTPD_DIR) && $(PUREFTPD_ENV) $(PUREFTPD_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

pureftpd_install: $(STATEDIR)/pureftpd.install

$(STATEDIR)/pureftpd.install: $(STATEDIR)/pureftpd.compile
	@$(call targetinfo, $@)
	@$(call install, PUREFTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

pureftpd_targetinstall: $(STATEDIR)/pureftpd.targetinstall

$(STATEDIR)/pureftpd.targetinstall: $(pureftpd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,pureftpd)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PUREFTPD_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(PUREFTPD_DIR)/src/pure-ftpd, /usr/sbin/pure-ftpd)
	@$(call install_copy, 0, 0, 0775, $(PTXDIST_TOPDIR)/projects/generic/etc/init.d/pure-ftpd, /etc/init.d/pure-ftpd, n)

ifdef PTXCONF_PUREFTPD_UPLOADSCRIPT
	@$(call install_copy, 0, 0, 0755, $(PUREFTPD_DIR)/src/pure-uploadscript, /usr/sbin/pure-uploadscript, n)
endif

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

pureftpd_clean:
	rm -rf $(STATEDIR)/pureftpd.*
	rm -rf $(IMAGEDIR)/pureftpd_*
	rm -rf $(PUREFTPD_DIR)

# vim: syntax=make
