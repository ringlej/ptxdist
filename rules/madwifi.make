# -*-makefile-*-
# $Id$
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

PACKAGES-$(PTXCONF_MADWIFI) += madwifi

#
# Paths and names
#
MADWIFI_VERSION		= 20040504
MADWIFI			= madwifi-$(MADWIFI_VERSION)
MADWIFI_SUFFIX		= tar.gz
MADWIFI_URL		= file://tmp/$(MADWIFI).$(MADWIFI_SUFFIX)
MADWIFI_SOURCE		= $(SRCDIR)/$(MADWIFI).$(MADWIFI_SUFFIX)
MADWIFI_DIR		= $(BUILDDIR)/$(MADWIFI)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

madwifi_get: $(STATEDIR)/madwifi.get

madwifi_get_deps = $(MADWIFI_SOURCE)

$(STATEDIR)/madwifi.get: $(madwifi_get_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

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
	@$(call patchin, $(MADWIFI))
	@$(call touch, $@)

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
MADWIFI_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/madwifi.prepare: $(madwifi_prepare_deps)
	@$(call targetinfo, $@)
	@$(call touch, $@)

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
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

madwifi_install: $(STATEDIR)/madwifi.install

$(STATEDIR)/madwifi.install: $(STATEDIR)/madwifi.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

madwifi_targetinstall: $(STATEDIR)/madwifi.targetinstall

madwifi_targetinstall_deps = $(STATEDIR)/madwifi.compile

# requires uudecode, which is part of sharutils
$(STATEDIR)/madwifi.targetinstall: $(madwifi_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,madwifi)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(MADWIFI_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	
	# FIXME: ipkgize
ifdef PTXCONF_KERNEL_INSTALL
	cd $(MADWIFI_DIR) && $(MADWIFI_ENV) $(MADWIFI_PATH) $(MAKE) install
endif
ifdef PTXCONF_MADWIFI_TOOLS_ATHEROS_STATS
	@$(call install_copy, 0, 0, 0555, $(MADWIFI_DIR)/tools/athstats, /usr/bin/athstats)
endif
ifdef PTXCONF_MADWIFI_TOOLS_80211_STATS
	@$(call install_copy, 0, 0, 0555, $(MADWIFI_DIR)/tools/80211stats, /usr/bin/80211stats)
endif
	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

madwifi_clean:
	rm -rf $(STATEDIR)/madwifi.*
	rm -rf $(IMAGEDIR)/madwifi_*
	rm -rf $(MADWIFI_DIR)

# vim: syntax=make
