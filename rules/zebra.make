# -*-makefile-*-
# $Id: zebra.make,v 1.1 2003/08/08 18:28:43 robert Exp $
#
# (c) 2003 Jochen Striepe, Pengutronix e.K. <info@pengutronix.de>, Germany
# (c) 2003 Robert Schwebel, Pengutronix e.K. <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y,$(PTXCONF_ZEBRA))
PACKAGES += zebra
endif

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
	@$(call targetinfo, zebra.get)
	touch $@

$(ZEBRA_SOURCE):
	@$(call targetinfo, $(ZEBRA_SOURCE))
	@$(call get, $(ZEBRA_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

zebra_extract: $(STATEDIR)/zebra.extract

zebra_extract_deps	= $(STATEDIR)/zebra.get

$(STATEDIR)/zebra.extract: $(zebra_extract_deps)
	@$(call targetinfo, zebra.extract)
	@$(call clean, $(ZEBRA_DIR))
	@$(call extract, $(ZEBRA_SOURCE))

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

zebra_prepare: $(STATEDIR)/zebra.prepare

zebra_prepare_deps	= $(STATEDIR)/zebra.extract

ZEBRA_AUTOCONF		=  --prefix=/usr
ZEBRA_AUTOCONF		+= --build=$(GNU_HOST)
ZEBRA_AUTOCONF		+= --host=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/zebra.prepare: $(zebra_prepare_deps)
	@$(call targetinfo, zebra.prepare)
	cd $(ZEBRA_DIR) && \
		ac_cv_func_getpgrp_void=yes	\
		ac_cv_func_setpgrp_void=yes	\
		ac_cv_sizeof_long_long=8	\
		ac_cv_func_memcmp_clean=yes	\
		ac_cv_func_getrlimit=yes	\
		$(ZEBRA_PATH) $(ZEBRA_ENV) $(ZEBRA_DIR)/configure $(ZEBRA_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

zebra_compile: $(STATEDIR)/zebra.compile

$(STATEDIR)/zebra.compile: $(STATEDIR)/zebra.prepare 
	@$(call targetinfo, zebra.compile)
	$(ZEBRA_PATH) make -C $(ZEBRA_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

zebra_install: $(STATEDIR)/zebra.install

$(STATEDIR)/zebra.install: $(STATEDIR)/zebra.compile
	@$(call targetinfo, zebra.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

zebra_targetinstall: $(STATEDIR)/zebra.targetinstall

$(STATEDIR)/zebra.targetinstall: $(STATEDIR)/zebra.install
	@$(call targetinfo, zebra.targetinstall)
# TODO
	touch $@
# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

zebra_clean: 
	rm -rf $(STATEDIR)/zebra.* $(ZEBRA_DIR)

# vim: syntax=make
