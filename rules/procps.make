# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 Ixia Corporation, by Milan Bobde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_PROCPS
PACKAGES += procps
endif

#
# Paths and names
#
PROCPS_VERSION	= 2.0.16
PROCPS		= procps-$(PROCPS_VERSION)
PROCPS_SUFFIX	= tar.gz
PROCPS_URL	= http://www.tech9.net/rml/procps/packages/2.0.16/$(PROCPS).$(PROCPS_SUFFIX)
PROCPS_SOURCE	= $(SRCDIR)/$(PROCPS).$(PROCPS_SUFFIX)
PROCPS_DIR	= $(BUILDDIR)/$(PROCPS)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

procps_get: $(STATEDIR)/procps.get

procps_get_deps	=  $(PROCPS_SOURCE)

$(STATEDIR)/procps.get: $(procps_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PROCPS))
	touch $@

$(PROCPS_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PROCPS_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

procps_extract: $(STATEDIR)/procps.extract

procps_extract_deps	=  $(STATEDIR)/procps.get

$(STATEDIR)/procps.extract: $(procps_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PROCPS_DIR))
	@$(call extract, $(PROCPS_SOURCE))
	@$(call patchin, $(PROCPS))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

procps_prepare: $(STATEDIR)/procps.prepare

#
# dependencies
#
procps_prepare_deps =  \
	$(STATEDIR)/procps.extract \
	$(STATEDIR)/ncurses.install \
	$(STATEDIR)/virtual-xchain.install

PROCPS_PATH	=  PATH=$(CROSS_PATH)
PROCPS_MAKEVARS	=  $(CROSS_ENV)
PROCPS_MAKEVARS += CFLAGS="-I$(subst $(quote),,$(PTXCONF_PREFIX))/$(subst $(quote),,$(PTXCONF_GNU_TARGET))/include -I$(subst $(quote),,$(PROCPS_DIR))"
PROCPS_MAKEVARS += LDFLAGS=-L$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/lib

#
# autoconf
#
PROCPS_AUTOCONF =  $(CROSS_AUTOCONF)
PROCPS_AUTOCONF	+= --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/procps.prepare: $(procps_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PROCPS_BUILDDIR))
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

procps_compile: $(STATEDIR)/procps.compile

procps_compile_deps =  $(STATEDIR)/procps.prepare

$(STATEDIR)/procps.compile: $(procps_compile_deps)
	@$(call targetinfo, $@)

ifdef PTXCONF_PROCPS_TOP
	cd $(PROCPS_DIR) && $(PROCPS_PATH) make $(PROCPS_MAKEVARS) top 
endif
ifdef PTXCONF_PROCPS_SLABTOP
	cd $(PROCPS_DIR) && $(PROCPS_PATH) make $(PROCPS_MAKEVARS) slabtop 
endif
ifdef PTXCONF_PROCPS_SYSCTL
	cd $(PROCPS_DIR) && $(PROCPS_PATH) make $(PROCPS_MAKEVARS) sysctl 
endif
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

procps_install: $(STATEDIR)/procps.install

$(STATEDIR)/procps.install: $(STATEDIR)/procps.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

procps_targetinstall: $(STATEDIR)/procps.targetinstall

procps_targetinstall_deps = \
	$(STATEDIR)/procps.compile \
	$(STATEDIR)/ncurses.targetinstall

$(STATEDIR)/procps.targetinstall: $(procps_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/bin
	install -d $(ROOTDIR)/sbin

	install -d $(ROOTDIR)/lib
	cp -d $(PROCPS_DIR)/proc/libproc*so* $(ROOTDIR)/lib

ifdef PTXCONF_PROCPS_TOP
	install -D $(PROCPS_DIR)/top  $(ROOTDIR)/usr/bin/top
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/top
endif

ifdef PTXCONF_PROCPS_SLABTOP
	install -D $(PROCPS_DIR)/slabtop  $(ROOTDIR)/usr/bin/slabtop
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/slabtop
endif
ifdef PTXCONF_PROCPS_SYSCTL
	install -D $(PROCPS_DIR)/sysctl  $(ROOTDIR)/sbin/sysctl
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/sbin/sysctl
endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

procps_clean:
	rm -rf $(STATEDIR)/procps.*
	rm -rf $(PROCPS_DIR)

# vim: syntax=make
