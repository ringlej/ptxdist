# -*-makefile-*-
# $Id: dropbear.make,v 1.1 2003/07/20 23:38:37 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#             for Pengutronix e.K. <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_DROPBEAR
PACKAGES += dropbear
endif

#
# Paths and names
#
DROPBEAR_VERSION		= 0.33
DROPBEAR			= dropbear-$(DROPBEAR_VERSION)
DROPBEAR_SUFFIX			= tar.bz2
DROPBEAR_URL			= http://matt.ucc.asn.au/dropbear/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_SOURCE			= $(SRCDIR)/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_DIR			= $(BUILDDIR)/$(DROPBEAR)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

dropbear_get: $(STATEDIR)/dropbear.get

dropbear_get_deps	=  $(DROPBEAR_SOURCE)

$(STATEDIR)/dropbear.get: $(dropbear_get_deps)
	@$(call targetinfo, dropbear.get)
	touch $@

$(DROPBEAR_SOURCE):
	@$(call targetinfo, $(DROPBEAR_SOURCE))
	@$(call get, $(DROPBEAR_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

dropbear_extract: $(STATEDIR)/dropbear.extract

dropbear_extract_deps	=  $(STATEDIR)/dropbear.get

$(STATEDIR)/dropbear.extract: $(dropbear_extract_deps)
	@$(call targetinfo, dropbear.extract)
	@$(call clean, $(DROPBEAR_DIR))
	@$(call extract, $(DROPBEAR_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

dropbear_prepare: $(STATEDIR)/dropbear.prepare

#
# dependencies
#
dropbear_prepare_deps =  \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/zlib.install \
	$(STATEDIR)/dropbear.extract

DROPBEAR_PATH	=  PATH=$(CROSS_PATH)
DROPBEAR_ENV 	=  $(CROSS_ENV)
DROPBEAR_ENV	+= ac_cv_func_setpgrp_void=yes

#
# autoconf
#
DROPBEAR_AUTOCONF	=  --prefix=/usr
DROPBEAR_AUTOCONF	+= --build=$(GNU_HOST)
DROPBEAR_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
DROPBEAR_AUTOCONF	+= --disable-nls

$(STATEDIR)/dropbear.prepare: $(dropbear_prepare_deps)
	@$(call targetinfo, dropbear.prepare)
	@$(call clean, $(DROPBEAR_BUILDDIR))
	cd $(DROPBEAR_DIR) && \
		$(DROPBEAR_PATH) $(DROPBEAR_ENV) \
		$(DROPBEAR_DIR)/configure $(DROPBEAR_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

dropbear_compile: $(STATEDIR)/dropbear.compile

dropbear_compile_deps =  $(STATEDIR)/dropbear.prepare

$(STATEDIR)/dropbear.compile: $(dropbear_compile_deps)
	@$(call targetinfo, dropbear.compile)
	$(DROPBEAR_PATH) make -C $(DROPBEAR_DIR) $(DROPBEAR_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

dropbear_install: $(STATEDIR)/dropbear.install

$(STATEDIR)/dropbear.install: $(STATEDIR)/dropbear.compile
	@$(call targetinfo, dropbear.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

dropbear_targetinstall: $(STATEDIR)/dropbear.targetinstall

dropbear_targetinstall_deps	=  $(STATEDIR)/dropbear.compile
dropbear_targetinstall_deps	+= $(STATEDIR)/zlib.targetinstall

$(STATEDIR)/dropbear.targetinstall: $(dropbear_targetinstall_deps)
	@$(call targetinfo, dropbear.targetinstall)

	mkdir -p $(ROOTDIR)/usr/bin
	mkdir -p $(ROOTDIR)/usr/sbin

ifdef PTXCONF_DROPBEAR_DROPBEAR
	install $(DROPBEAR_DIR)/dropbear \
		$(ROOTDIR)/usr/sbin/dropbear
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/dropbear
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_KEY
	install $(DROPBEAR_DIR)/dropbearkey \
		$(ROOTDIR)/usr/bin/dropbearkey
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/dropbearkey
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_CONVERT
	install $(DROPBEAR_DIR)/dropbearconvert \
		$(ROOTDIR)/usr/sbin/dropbearconvert
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/dropbearconvert
endif

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

dropbear_clean:
	rm -rf $(STATEDIR)/dropbear.*
	rm -rf $(DROPBEAR_DIR)

# vim: syntax=make