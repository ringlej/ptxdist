# -*-makefile-*-
# $Id: pppd.make,v 1.1 2003/07/16 04:23:28 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_PPP
PACKAGES += ppp
endif

#
# Paths and names 
#
PPP		= ppp-2.4.1
PPP_URL		= ftp://ftp.samba.org/pub/ppp/$(PPP).tar.gz
PPP_SOURCE	= $(SRCDIR)/$(PPP).tar.gz
PPP_DIR		= $(BUILDDIR)/$(PPP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ppp_get:	$(STATEDIR)/ppp.get

ppp_get_deps	= $(PPP_SOURCE)

$(STATEDIR)/ppp.get: $(ppp_get_deps)
	@$(call targetinfo, ppp.get)
	touch $@

$(PPP_SOURCE):
	@$(call targetinfo, $(PPP_SOURCE))
	@$(call get, $(PPP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ppp_extract: $(STATEDIR)/ppp.extract

$(STATEDIR)/ppp.extract: $(STATEDIR)/ppp.get
	@$(call targetinfo, ppp.extract)
	@$(call clean, $(PPP_DIR))
	@$(call extract, $(PPP_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ppp_prepare: $(STATEDIR)/ppp.prepare

PPP_PATH	= PATH=$(CROSS_PATH)
PPP_MAKEVARS	= CROSS=$(CROSS_ENV)

$(STATEDIR)/ppp.prepare: \
		$(STATEDIR)/virtual-xchain.install \
		$(STATEDIR)/ppp.extract
	@$(call targetinfo, ppp.prepare)
	cd $(PPP_DIR) && \
		./configure
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ppp_compile: $(STATEDIR)/ppp.compile

ppp_compile_deps =  $(STATEDIR)/ppp.prepare

$(STATEDIR)/ppp.compile: $(ppp_compile_deps) 
	@$(call targetinfo, ppp.compile)
	cd $(PPP_DIR) && \
		$(PPP_PATH) make $(PPP_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ppp_install: $(STATEDIR)/ppp.install

$(STATEDIR)/ppp.install: $(STATEDIR)/ppp.compile
	@$(call targetinfo, ppp.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ppp_targetinstall: $(STATEDIR)/ppp.targetinstall

$(STATEDIR)/ppp.targetinstall: $(STATEDIR)/ppp.compile
	@$(call targetinfo, ppp.targetinstalll)
	install $(PPP_DIR)/pppd/pppd $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/pppd

	install $(PPP_DIR)/chat/chat $(ROOTDIR)/sbin/
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/chat

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ppp_clean: 
	-rm -rf $(STATEDIR)/ppp* 
	-rm -rf $(PPP_DIR) 

# vim: syntax=make