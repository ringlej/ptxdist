# -*-makefile-*-
# $Id$
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
PACKAGES-$(PTXCONF_PROFTPD) += proftpd

#
# Paths and names
#
PROFTPD_VERSION		= 1.3.0a
PROFTPD			= proftpd-$(PROFTPD_VERSION)
PROFTPD_SUFFIX		= tar.gz
# PROFTPD_URL		= ftp://ftp.proftpd.org/distrib/source/proftpd-$(PROFTPD_VERSION).$(PROFTPD_SUFFIX)
PROFTPD_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(PROFTPD).$(PROFTPD_SUFFIX)
PROFTPD_SOURCE		= $(SRCDIR)/$(PROFTPD).$(PROFTPD_SUFFIX)
PROFTPD_DIR		= $(BUILDDIR)/$(PROFTPD)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

proftpd_get: $(STATEDIR)/proftpd.get

$(STATEDIR)/proftpd.get: $(proftpd_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(PROFTPD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, PROFTPD)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

proftpd_extract: $(STATEDIR)/proftpd.extract

$(STATEDIR)/proftpd.extract: $(proftpd_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(PROFTPD_DIR))
	@$(call extract, PROFTPD)
	@$(call patchin, PROFTPD)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

proftpd_prepare: $(STATEDIR)/proftpd.prepare

PROFTPD_AUTOCONF	=  $(CROSS_AUTOCONF_USR)
PROFTPD_AUTOCONF	+= --sysconfdir=/etc

PROFTPD_PATH		=  PATH=$(CROSS_PATH)
PROFTPD_ENV		=  $(CROSS_ENV) ac_cv_func_setgrent_void=yes
ifndef NATIVE
PROFTPD_MAKEVARS	=  $(CROSS_ENV_CC)
endif

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

$(STATEDIR)/proftpd.prepare: $(proftpd_prepare_deps_default)
	@$(call targetinfo, $@)
	cd $(PROFTPD_DIR) && \
		$(PROFTPD_PATH) $(PROFTPD_ENV) \
		./configure $(PROFTPD_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

proftpd_compile: $(STATEDIR)/proftpd.compile

$(STATEDIR)/proftpd.compile: $(proftpd_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(PROFTPD_DIR) && $(PROFTPD_PATH) $(PROFTPD_ENV) make $(PROFTPD_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

proftpd_install: $(STATEDIR)/proftpd.install

$(STATEDIR)/proftpd.install: $(proftpd_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

proftpd_targetinstall: $(STATEDIR)/proftpd.targetinstall

$(STATEDIR)/proftpd.targetinstall: $(proftpd_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, proftpd)
	@$(call install_fixup, proftpd,PACKAGE,proftpd)
	@$(call install_fixup, proftpd,PRIORITY,optional)
	@$(call install_fixup, proftpd,VERSION,$(PROFTPD_VERSION))
	@$(call install_fixup, proftpd,SECTION,base)
	@$(call install_fixup, proftpd,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, proftpd,DEPENDS,)
	@$(call install_fixup, proftpd,DESCRIPTION,missing)

	@$(call install_copy, proftpd, 0, 0, 0755, \
		$(PROFTPD_DIR)/proftpd, \
		/usr/sbin/proftpd)
	@$(call install_copy, proftpd, 0, 0, 0755, \
		$(PTXDIST_TOPDIR)/generic/etc/init.d/proftpd, \
		/etc/init.d/proftpd, n)

ifdef PTXCONF_PROFTPD_DEFAULTCONFIG
	@$(call install_copy, proftpd, 11, 101, 0644, \
		$(PTXDIST_TOPDIR)/generic/etc/proftpd.conf, \
		/etc/proftpd.conf, n)
endif

	@$(call install_finish, proftpd)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

proftpd_clean:
	rm -rf $(STATEDIR)/proftpd.* $(PROFTPD_DIR)
	rm -rf $(PKGDIR)/proftpd_*

# vim: syntax=make
