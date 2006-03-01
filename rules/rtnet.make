# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de>
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
PACKAGES-$(PTXCONF_RTNET) += rtnet

#
# Paths and names
#
RTNET_VERSION	:= 0.7.0
RTNET		:= rtnet-$(RTNET_VERSION)
RTNET_SUFFIX	:= tar.bz2
RTNET_URL	:= http://www.rts.uni-hannover.de/rtnet/download/$(RTNET).$(RTNET_SUFFIX)
RTNET_SOURCE	:= $(SRCDIR)/$(RTNET).$(RTNET_SUFFIX)
RTNET_DIR	:= $(BUILDDIR)/$(RTNET)
RTNET_MODULEDIR	:= $(ROOTDIR)/lib/modules/$(KERNEL_VERSION)-adeos/kernel/drivers

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

rtnet_get: $(STATEDIR)/rtnet.get

$(STATEDIR)/rtnet.get: $(rtnet_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(RTNET_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(RTNET_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

rtnet_extract: $(STATEDIR)/rtnet.extract

$(STATEDIR)/rtnet.extract: $(rtnet_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(RTNET_DIR))
	@$(call extract, $(RTNET_SOURCE))
	@$(call patchin, $(RTNET))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

rtnet_prepare: $(STATEDIR)/rtnet.prepare

RTNET_PATH	=  PATH=$(CROSS_PATH)
RTNET_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
RTNET_AUTOCONF =  $(CROSS_AUTOCONF_USR)
RTNET_AUTOCONF += \
	--with-rtai=$(RTAI_BUILDDIR)/usr/realtime
#	--with-rtai=$(RTAI_DIR)

ifdef PTXCONF_RTNET_RTCFG
RTNET_AUTOCONF  += --enable-rtcfg
else
RTNET_AUTOCONF	+= --disable-rtcfg
endif
ifdef PTXCONF_RTNET_RTCFG_DEBUG
RTNET_AUTOCONF  += --enable-rtcfg-debug
else
RTNET_AUTOCONF	+= --disable-rtcfg-debug
endif
ifdef PTXCONF_RTNET_RTCAP
RTNET_AUTOCONF  += --enable-rtcap
else
RTNET_AUTOCONF	+= --disable-rtcap
endif
ifdef PTXCONF_RTNET_PROXY
RTNET_AUTOCONF  += --enable-proxy
else
RTNET_AUTOCONF	+= --disable-proxy
endif
ifdef PTXCONF_RTNET_RTDM
RTNET_AUTOCONF  += --enable-enclosed-rtdm
else
RTNET_AUTOCONF	+= --disable-enclosed-rtdm
endif
ifdef PTXCONF_RTNET_EXAMPLES
RTNET_AUTOCONF  += --enable-examples
else
RTNET_AUTOCONF	+= --disable-examples
endif
ifdef PTXCONF_RTNET_NET_ROUTING
RTNET_AUTOCONF  += --enable-net-routing
else
RTNET_AUTOCONF	+= --disable-net-routing
endif
ifdef PTXCONF_RTNET_ROUTER
RTNET_AUTOCONF  += --enable-router
else
RTNET_AUTOCONF	+= --disable-router
endif
ifdef PTXCONF_RTNET_BUG_CHECK
RTNET_AUTOCONF  += --enable-checks
else
RTNET_AUTOCONF	+= --disable-checks
endif

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

ifdef PTXCONF_RTNET_NATSEMI
RTNET_AUTOCONF	+= --enable-natsemi
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

ifdef PTXCONF_RTNET_SMC91111
RTNET_AUTOCONF	+= --enable-smc91111
endif

$(STATEDIR)/rtnet.prepare: $(rtnet_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(RTNET_DIR)/config.cache)
	cd $(RTNET_DIR) && \
		$(RTNET_PATH) $(RTNET_ENV) \
		./configure $(RTNET_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

rtnet_compile: $(STATEDIR)/rtnet.compile

$(STATEDIR)/rtnet.compile: $(rtnet_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(RTNET_DIR) && $(RTNET_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

rtnet_install: $(STATEDIR)/rtnet.install

$(STATEDIR)/rtnet.install: $(rtnet_install_deps_default)
	@$(call targetinfo, $@)
	# FIXME
	# @$(call install, RTNET)
# 	$(RTNET_PATH) make -C $(RTNET_DIR) install
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

rtnet_targetinstall: $(STATEDIR)/rtnet.targetinstall

$(STATEDIR)/rtnet.targetinstall: $(rtnet_targetinstall_deps_default)
	@$(call targetinfo, $@)

	# Network drivers
	install -d $(RTNET_MODULEDIR)/net

ifdef PTXCONF_RTNET_3C59X
	install $(RTNET_DIR)/driver/3c59x-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_8139
	install $(RTNET_DIR)/driver/8139too-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_EEPRO100
	install $(RTNET_DIR)/driver/eepro100-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_PCNET32
	install $(RTNET_DIR)/driver/pcnet32-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_VIA_RHINE
	install $(RTNET_DIR)/driver/via-rhine-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_NATSEMI
	install $(RTNET_DIR)/driver/natsemi-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_LOOPBACK
	install $(RTNET_DIR)/driver/loopback-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_TULIP
	install $(RTNET_DIR)/driver/tulip-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_FCC_ENET
	install $(RTNET_DIR)/driver/mpc8260_fcc_enet-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_SCC_ENET
	echo "FIXME!"
	exit -1
endif
ifdef PTXCONF_RTNET_FEC_ENET
	install $(RTNET_DIR)/driver/mpc8xx_fec-rt.*o $(RTNET_MODULEDIR)/net/
endif
ifdef PTXCONF_RTNET_SMC91111
	install $(RTNET_DIR)/driver/smc91111-rt.*o $(RTNET_MODULEDIR)/net/
endif

	# Optional features
	install -d $(RTNET_MODULEDIR)/rtnet
	install -d $(ROOTDIR)/etc/init.d
	install $(RTNET_DIR)/rtnet.*o $(RTNET_MODULEDIR)/rtnet/
	install $(RTNET_DIR)/tools/rtnet $(ROOTDIR)/etc/init.d/
	
ifdef PTXCONF_RTNET_RTCFG
	install $(RTNET_DIR)/rtcfg/rtcfg.*o $(RTNET_MODULEDIR)/rtnet/
endif
ifdef PTXCONF_RTNET_RTCAP
	install $(RTNET_DIR)/rtcap/rtcap.*o $(RTNET_MODULEDIR)/rtnet/
endif
ifdef PTXCONF_RTNET_PROXY
	install $(RTNET_DIR)/rtproxy.*o $(RTNET_MODULEDIR)/rtnet/
endif
ifdef PTXCONF_RTNET_RTDM
	install $(RTNET_DIR)/rtai_rtdm/rtdm.*o $(RTNET_MODULEDIR)/rtnet/
endif
ifdef PTXCONF_RTNET_EXAMPLES
	echo "FIXME!"
	exit -1
endif
ifdef PTXCONF_RTNET_NET_ROUTING
	echo "FIXME!"
	exit -1
endif
ifdef PTXCONF_RTNET_ROUTER
	echo "FIXME!"
	exit -1
endif
	install $(RTNET_DIR)/tools/rtifconfig $(ROOTDIR)/sbin
	install $(RTNET_DIR)/tools/rtroute $(ROOTDIR)/sbin
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

rtnet_clean:
	rm -rf $(STATEDIR)/rtnet.*
	rm -rf $(IMAGEDIR)/rtnet_*
	rm -rf $(RTNET_DIR)

# vim: syntax=make
