# -*-makefile-*-
# $Id: rtnet.make,v 1.3 2003/11/10 00:49:50 mkl Exp $
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_RTNET
PACKAGES += rtnet
endif

#
# Paths and names
#
RTNET_VERSION	= 0.5.5
RTNET		= rtnet-$(RTNET_VERSION)
RTNET_SUFFIX	= tar.gz
RTNET_URL	= http://www.rts.uni-hannover.de/rtnet/$(RTNET).$(RTNET_SUFFIX)
RTNET_SOURCE	= $(SRCDIR)/$(RTNET).$(RTNET_SUFFIX)
RTNET_DIR	= $(BUILDDIR)/$(RTNET)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rtnet_get: $(STATEDIR)/rtnet.get

rtnet_get_deps = $(RTNET_SOURCE)

$(STATEDIR)/rtnet.get: $(rtnet_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(RTNET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(RTNET_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rtnet_extract: $(STATEDIR)/rtnet.extract

rtnet_extract_deps = $(STATEDIR)/rtnet.get

$(STATEDIR)/rtnet.extract: $(rtnet_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(RTNET_DIR))
	@$(call extract, $(RTNET_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rtnet_prepare: $(STATEDIR)/rtnet.prepare

#
# dependencies
#
rtnet_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/kernel-modversions.prepare \
	$(STATEDIR)/rtai.prepare \
	$(STATEDIR)/ncurses.install \
	$(STATEDIR)/rtnet.extract

RTNET_PATH	=  PATH=$(CROSS_PATH)
RTNET_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
RTNET_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR) \
	--with-rtai=$(RTAI_DIR)

ifdef PTXCONF_RTNET_3C59X
RTNET_AUTOCONF	+= --enable-3c59x
endif

ifdef PTXCONF_RTNET_8139
RTNET_AUTOCONF	+= --enable-8139
endif

ifdef PTXCONF_RTNET_EEPRO100
RTNET_AUTOCONF	+= --enable-eepro100
endif

ifdef PTXCONF_RTNET_PCNET32
RTNET_AUTOCONF	+= --enable-pcnet32
endif

ifdef PTXCONF_RTNET_VIA_RHINE
RTNET_AUTOCONF	+= --enable-via-rhine
endif

ifdef PTXCONF_RTNET_LOOPBACK
RTNET_AUTOCONF	+= --enable-loopback
endif

ifdef PTXCONF_RTNET_TULIP
RTNET_AUTOCONF	+= --enable-tulip
endif

ifdef PTXCONF_RTNET_FCC_ENET
RTNET_AUTOCONF	+= --enable-fcc-enet
endif

ifdef PTXCONF_RTNET_SCC_ENET
RTNET_AUTOCONF	+= --enable-scc-enet
endif

ifdef PTXCONF_RTNET_FEC_ENET
RTNET_AUTOCONF	+= --enable-fec-enet
endif


$(STATEDIR)/rtnet.prepare: $(rtnet_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(RTNET_DIR)/config.cache)
	cd $(RTNET_DIR) && \
		$(RTNET_PATH) $(RTNET_ENV) \
		./configure $(RTNET_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rtnet_compile: $(STATEDIR)/rtnet.compile

rtnet_compile_deps = $(STATEDIR)/rtnet.prepare

$(STATEDIR)/rtnet.compile: $(rtnet_compile_deps)
	@$(call targetinfo, $@)
	$(RTNET_PATH) make -C $(RTNET_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rtnet_install: $(STATEDIR)/rtnet.install

$(STATEDIR)/rtnet.install: $(STATEDIR)/rtnet.compile
	@$(call targetinfo, $@)
# 	$(RTNET_PATH) make -C $(RTNET_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rtnet_targetinstall: $(STATEDIR)/rtnet.targetinstall

rtnet_targetinstall_deps = $(STATEDIR)/rtnet.compile

$(STATEDIR)/rtnet.targetinstall: $(rtnet_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rtnet_clean:
	rm -rf $(STATEDIR)/rtnet.*
	rm -rf $(RTNET_DIR)

# vim: syntax=make
