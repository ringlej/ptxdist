# -*-makefile-*-
# $Id: distcc.make,v 1.1 2003/07/16 04:23:28 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# Paths and names 
#
DISTCC_VERSION	= 2.8
DISTCC		= distcc-$(DISTCC_VERSION)
DISTCC_SUFFIX	= tar.bz2
DISTCC_URL	= http://distcc.samba.org/ftp/distcc/$(DISTCC).$(DISTCC_SUFFIX)
DISTCC_SOURCE	= $(SRCDIR)/$(DISTCC).$(DISTCC_SUFFIX)
DISTCC_DIR 	= $(BUILDDIR)/$(DISTCC)
DISTCC_EXTRACT	= bzip2 -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

distcc_get: $(STATEDIR)/distcc.get

$(STATEDIR)/distcc.get: $(DISTCC_SOURCE)
	@$(call targetinfo, distcc.get)
	touch $@

$(DISTCC_SOURCE):
	@$(call targetinfo, $(DISTCC_SOURCE))
	@$(call get, $(DISTCC_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

distcc_extract: $(STATEDIR)/distcc.extract

$(STATEDIR)/distcc.extract: $(STATEDIR)/distcc.get
	@$(call targetinfo, distcc.extract)
	@$(call extract, $(DISTCC_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

distcc_prepare: $(STATEDIR)/distcc.prepare

DISTCC_ENV	= CC=$(HOSTCC)

DISTCC_AUTOCONF	= --prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/distcc.prepare: $(STATEDIR)/distcc.extract
	@$(call targetinfo, distcc.prepare)
	cd $(DISTCC_DIR) && $(DISTCC_ENV) \
		./configure $(DISTCC_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

distcc_compile: $(STATEDIR)/distcc.compile

$(STATEDIR)/distcc.compile: $(STATEDIR)/distcc.prepare 
	@$(call targetinfo, distcc.compile)
	make -C $(DISTCC_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

distcc_install: $(STATEDIR)/distcc.install

$(STATEDIR)/distcc.install: $(STATEDIR)/distcc.compile
	@$(call targetinfo, distcc.install)
	make -C $(DISTCC_DIR) install 
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

distcc_targetinstall: $(STATEDIR)/distcc.targetinstall

$(STATEDIR)/distcc.targetinstall: $(STATEDIR)/distcc.install
	@$(call targetinfo, distcc.targetinstall)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

distcc_clean: 
	rm -rf $(STATEDIR)/distcc.* 
	rm -rf $(DISTCC_DIR)

# vim: syntax=make
