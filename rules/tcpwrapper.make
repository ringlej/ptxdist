# -*-makefile-*-
# $Id: tcpwrapper.make,v 1.8 2003/09/17 23:43:59 mkl Exp $
#
# (c) 2003 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_TCPWRAPPER))
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
	@$(call targetinfo, tcpwrapper.get)
	touch $@

$(TCPWRAPPER_SOURCE):
	@$(call targetinfo, $(TCPWRAPPER_SOURCE))
	@$(call get, $(TCPWRAPPER_URL))

$(TCPWRAPPER_PTXPATCH_SOURCE): 
	@$(call targetinfo, $(TCPWRAPPER_PTXPATCH_SOURCE))
	@$(call get, $(TCPWRAPPER_PTXPATCH_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

tcpwrapper_extract: $(STATEDIR)/tcpwrapper.extract

$(STATEDIR)/tcpwrapper.extract: $(STATEDIR)/tcpwrapper.get
	@$(call targetinfo, tcpwrapper.extract)
	@$(call clean, $(TCPWRAPPER_DIR))
	@$(call extract, $(TCPWRAPPER_SOURCE))
	cd $(TCPWRAPPER_DIR) && patch -p1 < $(TCPWRAPPER_PTXPATCH_SOURCE)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

tcpwrapper_prepare: $(STATEDIR)/tcpwrapper.prepare

$(STATEDIR)/tcpwrapper.prepare: $(STATEDIR)/virtual-xchain.install $(STATEDIR)/tcpwrapper.extract
	@$(call targetinfo, tcpwrapper.prepare)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

tcpwrapper_compile: $(STATEDIR)/tcpwrapper.compile

TCPWRAPPER_ENV	= $(CROSS_ENV)
TCPWRAPPER_PATH	= PATH=$(CROSS_PATH)

$(STATEDIR)/tcpwrapper.compile: $(STATEDIR)/tcpwrapper.prepare
	@$(call targetinfo, tcpwrapper.compile)
	$(TCPWRAPPER_PATH) $(TCPWRAPPER_ENV) \
		make -C $(TCPWRAPPER_DIR) linux 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

tcpwrapper_install: $(STATEDIR)/tcpwrapper.install

$(STATEDIR)/tcpwrapper.install: $(STATEDIR)/tcpwrapper.compile
	@$(call targetinfo, tcpwrapper.install)
	install -d $(CROSS_LIB_DIR)/lib
	install $(TCPWRAPPER_DIR)/libwrap.a $(CROSS_LIB_DIR)/lib
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

tcpwrapper_targetinstall: $(STATEDIR)/tcpwrapper.targetinstall

$(STATEDIR)/tcpwrapper.targetinstall: $(STATEDIR)/tcpwrapper.install
	@$(call targetinfo, tcpwrapper.targetinstall)
ifdef PTXCONF_TCPWRAPPER_INSTALL_TCPD
	mkdir -p $(ROOTDIR)/usr/sbin
	install $(TCPWRAPPER_DIR)/tcpd $(ROOTDIR)/usr/sbin
	$(CROSSSTRIP) -R .notes -R .comment $(ROOTDIR)/usr/sbin/tcpd
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

tcpwrapper_clean: 
	rm -rf $(STATEDIR)/tcpwrapper.* $(TCPWRAPPER_DIR)

# vim: syntax=make
