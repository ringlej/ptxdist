# -*-makefile-*-
# $Id: pppd.make,v 1.2 2003/07/23 12:01:24 mkl Exp $
#
# (c) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#             GYRO net GmbH <info@gyro-net.de>, Hannover, Germany
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

ifdef PTXCONF_PPP_MS_CHAP
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,CHAPMS=y)
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,USE_CRYPT=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,CHAPMS=y)
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,USE_CRYPT=y)
endif

ifdef PTXCONF_PPP_SHADOW
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,HAS_SHADOW=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,HAS_SHADOW=y)
endif

ifdef PTXCONF_PPP_PLUGINS
	@$(call enable_sh,$(PPP_DIR)/pppd/Makefile,PLUGIN=y)
else
	@$(call disable_sh,$(PPP_DIR)/pppd/Makefile,PLUGIN=y)
endif

ifndef PTXCONF_PPP_IPX
	perl -p -i -e 's/-DIPX_CHANGE //' $(PPP_DIR)/pppd/Makefile
	perl -p -i -e 's/ipxcp.o //' $(PPP_DIR)/pppd/Makefile
endif

ifndef PTXCONF_PPP_MULTILINK
	perl -p -i -e 's/-DHAVE_MULTILINK //' $(PPP_DIR)/pppd/Makefile
	perl -p -i -e 's/multilink.o //' $(PPP_DIR)/pppd/Makefile
endif
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