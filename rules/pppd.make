# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#             GYRO net GmbH <info@gyro-net.de>, Hannover, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_PPP) += ppp

#
# Paths and names 
#
PPP_VERSION	= 2.4.1
PPP		= ppp-$(PPP_VERSION)
PPP_URL		= ftp://ftp.samba.org/pub/ppp/$(PPP).tar.gz
PPP_SOURCE	= $(SRCDIR)/$(PPP).tar.gz
PPP_DIR		= $(BUILDDIR)/$(PPP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ppp_get:	$(STATEDIR)/ppp.get

ppp_get_deps	= $(PPP_SOURCE)

$(STATEDIR)/ppp.get: $(ppp_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PPP))
	@$(call touch, $@)

$(PPP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PPP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ppp_extract: $(STATEDIR)/ppp.extract

$(STATEDIR)/ppp.extract: $(STATEDIR)/ppp.get
	@$(call targetinfo, $@)
	@$(call clean, $(PPP_DIR))
	@$(call extract, $(PPP_SOURCE))
	@$(call patchin, $(PPP))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ppp_prepare: $(STATEDIR)/ppp.prepare

PPP_PATH	= PATH=$(CROSS_PATH)
PPP_MAKEVARS	= CROSS=$(CROSS_ENV)

$(STATEDIR)/ppp.prepare: \
		$(STATEDIR)/virtual-xchain.install \
		$(STATEDIR)/ppp.extract
	@$(call targetinfo, $@)
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
	@perl -p -i -e 's/-DIPX_CHANGE //' $(PPP_DIR)/pppd/Makefile
	@perl -p -i -e 's/ipxcp.o //' $(PPP_DIR)/pppd/Makefile
endif

ifndef PTXCONF_PPP_MULTILINK
	@perl -p -i -e 's/-DHAVE_MULTILINK //' $(PPP_DIR)/pppd/Makefile
	@perl -p -i -e 's/multilink.o //' $(PPP_DIR)/pppd/Makefile
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ppp_compile: $(STATEDIR)/ppp.compile

ppp_compile_deps =  $(STATEDIR)/ppp.prepare

$(STATEDIR)/ppp.compile: $(ppp_compile_deps) 
	@$(call targetinfo, $@)
	cd $(PPP_DIR) && \
		$(PPP_PATH) make $(PPP_MAKEVARS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ppp_install: $(STATEDIR)/ppp.install

$(STATEDIR)/ppp.install: $(STATEDIR)/ppp.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ppp_targetinstall: $(STATEDIR)/ppp.targetinstall

$(STATEDIR)/ppp.targetinstall: $(STATEDIR)/ppp.compile
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,ppp)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PPP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	@$(call install_copy, 0, 0, 0755, $(PPP_DIR)/pppd/pppd, /usr/sbin/pppd)
	@$(call install_copy, 0, 0, 0755, $(PPP_DIR)/chat/chat, /usr/sbin/chat)

	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ppp_clean: 
	-rm -rf $(STATEDIR)/ppp.* 
	-rm -rf $(IMAGEDIR)/ppp_* 
	-rm -rf $(PPP_DIR) 

# vim: syntax=make
