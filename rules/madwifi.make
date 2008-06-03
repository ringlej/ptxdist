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

ifdef PTXCONF_ARCH_X86
PACKAGES-$(PTXCONF_MADWIFI) += madwifi
endif

#
# Paths and names
#
MADWIFI_VERSION		= 0.9.3.3
MADWIFI			= madwifi-$(MADWIFI_VERSION)
MADWIFI_SUFFIX		= tar.gz
MADWIFI_URL		= $(PTXCONF_SETUP_SFMIRROR)/madwifi/$(MADWIFI).$(MADWIFI_SUFFIX)
MADWIFI_SOURCE		= $(SRCDIR)/$(MADWIFI).$(MADWIFI_SUFFIX)
MADWIFI_DIR		= $(BUILDDIR)/$(MADWIFI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

madwifi_get: $(STATEDIR)/madwifi.get

$(STATEDIR)/madwifi.get: $(madwifi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(MADWIFI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, MADWIFI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

madwifi_extract: $(STATEDIR)/madwifi.extract

$(STATEDIR)/madwifi.extract: $(madwifi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(MADWIFI_DIR))
	@$(call extract, MADWIFI)
	@$(call patchin, MADWIFI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

madwifi_prepare: $(STATEDIR)/madwifi.prepare

MADWIFI_PATH	=  PATH=$(CROSS_PATH)
MADWIFI_ENV = \
	$(CROSS_ENV) \
	KERNELRELEASE=$(KERNEL_VERSION) \
	KERNELPATH=$(KERNEL_DIR) \
	DESTDIR=$(ROOTDIR) \
	TARGET=i386-elf

#
# autoconf
#
MADWIFI_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/madwifi.prepare: $(madwifi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

madwifi_compile: $(STATEDIR)/madwifi.compile

$(STATEDIR)/madwifi.compile: $(madwifi_compile_deps_default)
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

$(STATEDIR)/madwifi.install: $(madwifi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

madwifi_targetinstall: $(STATEDIR)/madwifi.targetinstall

# requires uudecode, which is part of sharutils
$(STATEDIR)/madwifi.targetinstall: $(madwifi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, madwifi)
	@$(call install_fixup, madwifi,PACKAGE,madwifi)
	@$(call install_fixup, madwifi,PRIORITY,optional)
	@$(call install_fixup, madwifi,VERSION,$(MADWIFI_VERSION))
	@$(call install_fixup, madwifi,SECTION,base)
	@$(call install_fixup, madwifi,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup, madwifi,DEPENDS,)
	@$(call install_fixup, madwifi,DESCRIPTION,missing)

	# FIXME: ipkgize
ifdef PTXCONF_KERNEL_INSTALL
	cd $(MADWIFI_DIR) && $(MADWIFI_ENV) $(MADWIFI_PATH) $(MAKE) install
endif
ifdef PTXCONF_MADWIFI_TOOLS_ATHEROS_STATS
	@$(call install_copy, madwifi, 0, 0, 0555, $(MADWIFI_DIR)/tools/athstats, /usr/bin/athstats)
endif
ifdef PTXCONF_MADWIFI_TOOLS_80211_STATS
	@$(call install_copy, madwifi, 0, 0, 0555, $(MADWIFI_DIR)/tools/80211stats, /usr/bin/80211stats)
endif
	@$(call install_finish, madwifi)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

madwifi_clean:
	rm -rf $(STATEDIR)/madwifi.*
	rm -rf $(PKGDIR)/madwifi_*
	rm -rf $(MADWIFI_DIR)

# vim: syntax=make
