# -*-makefile-*-
# $Id: tcpwrapper.make,v 1.10 2003/10/26 21:59:07 mkl Exp $
#
# Copyright (C) 2003 by Pengutronix e.K., Hildesheim, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_TCPWRAPPER
PACKAGES += tcpwrapper
endif

#
# Paths and names 
#
TCPWRAPPER			= tcp_wrappers_7.6
TCPWRAPPER_URL			= ftp://ftp.porcupine.org/pub/security/$(TCPWRAPPER).tar.gz
TCPWRAPPER_SOURCE		= $(SRCDIR)/$(TCPWRAPPER).tar.gz
TCPWRAPPER_DIR			= $(BUILDDIR)/$(TCPWRAPPER)

TCPWRAPPER_PTXPATCH		= tcp_wrappers_7.6-ptx1
TCPWRAPPER_PTXPATCH_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(TCPWRAPPER_PTXPATCH).diff
TCPWRAPPER_PTXPATCH_SOURCE	= $(SRCDIR)/$(TCPWRAPPER_PTXPATCH).diff

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

tcpwrapper_get: $(STATEDIR)/tcpwrapper.get

$(STATEDIR)/tcpwrapper.get: $(TCPWRAPPER_SOURCE) $(TCPWRAPPER_PTXPATCH_SOURCE)
	@$(call targetinfo, $@)
	touch $@

$(TCPWRAPPER_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(TCPWRAPPER_URL))

$(TCPWRAPPER_PTXPATCH_SOURCE): 
	@$(call targetinfo, $@)
	@$(call get, $(TCPWRAPPER_PTXPATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tcpwrapper_extract: $(STATEDIR)/tcpwrapper.extract

$(STATEDIR)/tcpwrapper.extract: $(STATEDIR)/tcpwrapper.get
	@$(call targetinfo, $@)
	@$(call clean, $(TCPWRAPPER_DIR))
	@$(call extract, $(TCPWRAPPER_SOURCE))
	cd $(TCPWRAPPER_DIR) && patch -p1 < $(TCPWRAPPER_PTXPATCH_SOURCE)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tcpwrapper_prepare: $(STATEDIR)/tcpwrapper.prepare

$(STATEDIR)/tcpwrapper.prepare: $(STATEDIR)/virtual-xchain.install $(STATEDIR)/tcpwrapper.extract
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tcpwrapper_compile: $(STATEDIR)/tcpwrapper.compile

TCPWRAPPER_ENV	= $(CROSS_ENV)
TCPWRAPPER_PATH	= PATH=$(CROSS_PATH)

$(STATEDIR)/tcpwrapper.compile: $(STATEDIR)/tcpwrapper.prepare
	@$(call targetinfo, $@)
	$(TCPWRAPPER_PATH) $(TCPWRAPPER_ENV) \
		make -C $(TCPWRAPPER_DIR) linux 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tcpwrapper_install: $(STATEDIR)/tcpwrapper.install

$(STATEDIR)/tcpwrapper.install: $(STATEDIR)/tcpwrapper.compile
	@$(call targetinfo, $@)
	install -d $(CROSS_LIB_DIR)/lib
	install $(TCPWRAPPER_DIR)/libwrap.a $(CROSS_LIB_DIR)/lib
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tcpwrapper_targetinstall: $(STATEDIR)/tcpwrapper.targetinstall

$(STATEDIR)/tcpwrapper.targetinstall: $(STATEDIR)/tcpwrapper.install
	@$(call targetinfo, $@)
ifdef PTXCONF_TCPWRAPPER_INSTALL_TCPD
	mkdir -p $(ROOTDIR)/usr/sbin
	install $(TCPWRAPPER_DIR)/tcpd $(ROOTDIR)/usr/sbin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/sbin/tcpd
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tcpwrapper_clean: 
	rm -rf $(STATEDIR)/tcpwrapper.* $(TCPWRAPPER_DIR)

# vim: syntax=make
