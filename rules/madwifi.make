# -*-makefile-*-
# $Id: madwifi.make,v 1.1 2004/06/10 10:36:56 rsc Exp $
#
# Copyright (C) 2004 by Greg Brackley
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#
#
# The MADWIFI project doesn't have regular releases (yet). The easiest thing to do
# is to get a CVS release. I found some release here 
# http://debian.isg.ee.ethz.ch/public/pool/madwifi/
#
# The FAQ http://www.mattfoster.clara.co.uk/madwifi-faq.htm is useful.
#
#  > cd /tmp
#  > cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/madwifi co madwifi
#  > mv madwifi madwifi-20040504
#  > tar -czf madwifi-20040504.tar.gz madwifi-20040504 --exclude=CVS
#
#

ifdef PTXCONF_MADWIFI
PACKAGES += madwifi
endif

#
# Paths and names
#
MADWIFI_VERSION		= 20040504
MADWIFI			= madwifi-$(MADWIFI_VERSION)
MADWIFI_SUFFIX		= tar.gz
MADWIFI_URL		= file://tmp/$(MADWIFI).$(MADWIFI_SUFFIX)
MADWIFI_SOURCE		= $(SRCDIR)/$(MADWIFI).$(MADWIFI_SUFFIX)
MADWIFI_DIR		= $(BUILDDIR)/$(MADWIFI)

KERNEL                  = linux-$(KERNEL_VERSION)
KERNEL_DIR              = $(BUILDDIR)/$(KERNEL)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

madwifi_get: $(STATEDIR)/madwifi.get

madwifi_get_deps = $(MADWIFI_SOURCE)

$(STATEDIR)/madwifi.get: $(madwifi_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(MADWIFI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MADWIFI_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

madwifi_extract: $(STATEDIR)/madwifi.extract

madwifi_extract_deps = $(STATEDIR)/madwifi.get

$(STATEDIR)/madwifi.extract: $(madwifi_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MADWIFI_DIR))
	@$(call extract, $(MADWIFI_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

madwifi_prepare: $(STATEDIR)/madwifi.prepare

#
# dependencies
#
madwifi_prepare_deps = \
	$(STATEDIR)/madwifi.extract \
	$(STATEDIR)/virtual-xchain.install

MADWIFI_PATH	=  PATH=$(CROSS_PATH)
MADWIFI_ENV 	=  $(CROSS_ENV)
#MADWIFI_ENV	+= PKG_CONFIG_PATH=$(SYSROOT)/lib/pkgconfig
MADWIFI_ENV    += KERNELRELEASE=$(KERNEL_VERSION)
MADWIFI_ENV    += KERNELPATH=$(KERNEL_DIR)
MADWIFI_ENV    += DESTDIR=$(ROOTDIR)
MADWIFI_ENV    += TARGET=i386-elf

#
# autoconf
#
MADWIFI_AUTOCONF = \
	--build=$(HOST) \
	--host=$(TARGET) \
	--prefix=$(SYSROOT)

$(STATEDIR)/madwifi.prepare: $(madwifi_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

madwifi_compile: $(STATEDIR)/madwifi.compile

madwifi_compile_deps = $(STATEDIR)/madwifi.prepare

$(STATEDIR)/madwifi.compile: $(madwifi_compile_deps)
	@$(call targetinfo, $@)
	cd $(MADWIFI_DIR) && $(MADWIFI_ENV) $(MADWIFI_PATH) $(MAKE)
ifdef PTXCONF_MADWIFI_TOOLS_ATHEROS_STATS
	cd $(MADWIFI_DIR)/tools && $(MADWIFI_ENV) $(MADWIFI_PATH) $(MAKE) athstats
endif
ifdef PTXCONF_MADWIFI_TOOLS_80211_STATS
	cd $(MADWIFI_DIR)/tools && $(MADWIFI_ENV) $(MADWIFI_PATH) $(MAKE) 80211stats
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

madwifi_install: $(STATEDIR)/madwifi.install

$(STATEDIR)/madwifi.install: $(STATEDIR)/madwifi.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

madwifi_targetinstall: $(STATEDIR)/madwifi.targetinstall

madwifi_targetinstall_deps = $(STATEDIR)/madwifi.compile

# requires uudecode, which is part of sharutils
$(STATEDIR)/madwifi.targetinstall: $(madwifi_targetinstall_deps)
	@$(call targetinfo, $@)
ifdef PTXCONF_KERNEL_INSTALL
	cd $(MADWIFI_DIR) && $(MADWIFI_ENV) $(MADWIFI_PATH) $(MAKE) install
endif
ifdef PTXCONF_MADWIFI_TOOLS_ATHEROS_STATS
	install -m555  $(MADWIFI_DIR)/tools/athstats $(ROOTDIR)/usr/bin/
endif
ifdef PTXCONF_MADWIFI_TOOLS_80211_STATS
	install -m555  $(MADWIFI_DIR)/tools/80211stats $(ROOTDIR)/usr/bin/
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

madwifi_clean:
	rm -rf $(STATEDIR)/madwifi.*
	rm -rf $(MADWIFI_DIR)

# vim: syntax=make
