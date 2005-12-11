# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 Jochen Striepe, Pengutronix e.K. <info@pengutronix.de>, Germany
# Copyright (C) 2003 Robert Schwebel, Pengutronix e.K. <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

# FIXME: ipkgize

#
# We provide this package
#
PACKAGES-$(PTXCONF_ZEBRA) += zebra

#
# Paths and names 
#
ZEBRA_VERSION		= 0.93b
ZEBRA			= zebra-$(ZEBRA_VERSION)
ZEBRA_SUFFIX		= tar.gz
ZEBRA_URL 		= ftp://ftp.sunet.se/pub/network/zebra/$(ZEBRA).$(ZEBRA_SUFFIX)
ZEBRA_SOURCE		= $(SRCDIR)/$(ZEBRA).tar.gz
ZEBRA_DIR 		= $(BUILDDIR)/$(ZEBRA)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

zebra_get: $(STATEDIR)/zebra.get

zebra_get_deps	= $(ZEBRA_SOURCE)

$(STATEDIR)/zebra.get: $(zebra_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(ZEBRA_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(ZEBRA_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

zebra_extract: $(STATEDIR)/zebra.extract

zebra_extract_deps	= $(STATEDIR)/zebra.get

$(STATEDIR)/zebra.extract: $(zebra_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(ZEBRA_DIR))
	@$(call extract, $(ZEBRA_SOURCE))
	@$(call patchin, $(ZEBRA))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

zebra_prepare: $(STATEDIR)/zebra.prepare

zebra_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zebra.extract

ZEBRA_AUTOCONF =  $(CROSS_AUTOCONF)
ZEBRA_AUTOCONF += \
	--with-cflags="$(TARGET_CFLAGS)" \
	--prefix=/usr \
	--exec-prefix=/usr \
	--sysconfdir=/etc/zebra \
	--localstatedir=/var

ZEBRA_ENV = \
	$(CROSS_ENV) \
	ac_cv_func_getpgrp_void=yes \
	ac_cv_func_setpgrp_void=yes \
	ac_cv_sizeof_long_long=8 \
	ac_cv_func_memcmp_clean=yes \
	ac_cv_func_getrlimit=yes

ZEBRA_PATH	=  PATH=$(CROSS_PATH)


$(STATEDIR)/zebra.prepare: $(zebra_prepare_deps)
	@$(call targetinfo, $@)
	cd $(ZEBRA_DIR) && \
		$(ZEBRA_PATH) $(ZEBRA_ENV) \
		./configure $(ZEBRA_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

zebra_compile: $(STATEDIR)/zebra.compile

$(STATEDIR)/zebra.compile: $(STATEDIR)/zebra.prepare 
	@$(call targetinfo, $@)
	$(ZEBRA_PATH) make -C $(ZEBRA_DIR)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

zebra_install: $(STATEDIR)/zebra.install

$(STATEDIR)/zebra.install: $(STATEDIR)/zebra.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

zebra_targetinstall: $(STATEDIR)/zebra.targetinstall

$(STATEDIR)/zebra.targetinstall: $(STATEDIR)/zebra.install
	@$(call targetinfo, $@)
	$(ZEBRA_PATH) make -C $(ZEBRA_DIR) DESTDIR=$(ROOTDIR)
	@$(call touch, $@)
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

zebra_clean: 
	rm -rf $(STATEDIR)/zebra.* 
	rm -rf $(IMAGEDIR)/zebra_* 
	rm -rf $(ZEBRA_DIR)

# vim: syntax=make
