# -*-makefile-*-
# $Id: proftpd.make,v 1.6 2003/10/23 20:41:41 mkl Exp $
#
# Copyright (C) 2002, 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_PROFTPD
PACKAGES += proftpd
endif

#
# Paths and names 
#
PROFTPD_VERSION		= 1.2.8
PROFTPD			= proftpd-$(PROFTPD_VERSION)
PROFTPD_TARBALL		= proftpd-$(PROFTPD_VERSION)p.$(PROFTPD_SUFFIX)
PROFTPD_SUFFIX		= tar.gz
PROFTPD_URL		= ftp://ftp.proftpd.org/distrib/source/$(PROFTPD_TARBALL)
PROFTPD_SOURCE		= $(SRCDIR)/$(PROFTPD_TARBALL)
PROFTPD_DIR		= $(BUILDDIR)/$(PROFTPD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

proftpd_get: $(STATEDIR)/proftpd.get

$(STATEDIR)/proftpd.get: $(PROFTPD_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(PROFTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PROFTPD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

proftpd_extract: $(STATEDIR)/proftpd.extract

$(STATEDIR)/proftpd.extract: $(STATEDIR)/proftpd.get
	@$(call targetinfo, $@)
	@$(call clean, $(PROFTPD_DIR))
	@$(call extract, $(PROFTPD_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

proftpd_prepare: $(STATEDIR)/proftpd.prepare

PROFTPD_AUTOCONF	=  --build=$(GNU_HOST)
PROFTPD_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
PROFTPD_AUTOCONF	+= --prefix=/usr
PROFTPD_AUTOCONF	+= --sysconfdir=/etc

PROFTPD_PATH		=  PATH=$(CROSS_PATH)
PROFTPD_ENV		=  $(CROSS_ENV) ac_cv_func_setgrent_void=yes
PROFTPD_MAKEVARS	=  $(CROSS_ENV_CC)

ifdef PTXCONF_PROFTPD_PAM
PROFTPD_AUTOCONF += --enable-pam
else
PROFTPD_AUTOCONF += --disable-pam
endif
ifdef PTXCONF_PROFTPD_SENDFILE
PROFTPD_AUTOCONF += --enable-sendfile
else
PROFTPD_AUTOCONF += --disable-sendfile
endif
ifdef PTXCONF_PROFTPD_SHADOW
PROFTPD_AUTOCONF += --enable-shadow
else
PROFTPD_AUTOCONF += --disable-shadow
endif
ifdef PTXCONF_PROFTPD_AUTOSHADOW
PROFTPD_AUTOCONF += --enable-autoshadow
else
PROFTPD_AUTOCONF += --disable-autoshadow
endif

proftpd_extract_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/proftpd.extract

$(STATEDIR)/proftpd.prepare: $(proftpd_extract_deps)
	@$(call targetinfo, $@)
	cd $(PROFTPD_DIR) && \
		$(PROFTPD_PATH) $(PROFTPD_ENV) \
		./configure $(PROFTPD_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

proftpd_compile: $(STATEDIR)/proftpd.compile

$(STATEDIR)/proftpd.compile: $(STATEDIR)/proftpd.prepare 
	@$(call targetinfo, $@)
	$(PROFTPD_PATH)	make -C $(PROFTPD_DIR) $(PROFTPD_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

proftpd_install: $(STATEDIR)/proftpd.install

$(STATEDIR)/proftpd.install: $(STATEDIR)/proftpd.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

proftpd_targetinstall: $(STATEDIR)/proftpd.targetinstall

$(STATEDIR)/proftpd.targetinstall: $(STATEDIR)/proftpd.install
	@$(call targetinfo, $@)
	install $(PROFTPD_DIR)/proftpd $(ROOTDIR)/usr/sbin/proftpd
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/proftpd
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

proftpd_clean: 
	rm -rf $(STATEDIR)/proftpd.* $(PROFTPD_DIR)

# vim: syntax=make
