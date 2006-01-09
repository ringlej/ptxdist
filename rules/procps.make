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
PACKAGES-$(PTXCONF_PROCPS) += procps

#
# Paths and names
#
PROCPS_VERSION	= 3.2.4
PROCPS		= procps-$(PROCPS_VERSION)
PROCPS_SUFFIX	= tar.gz
PROCPS_URL	= http://procps.sourceforge.net/$(PROCPS).$(PROCPS_SUFFIX)
PROCPS_SOURCE	= $(SRCDIR)/$(PROCPS).$(PROCPS_SUFFIX)
PROCPS_DIR	= $(BUILDDIR)/$(PROCPS)

include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

procps_get: $(STATEDIR)/procps.get

procps_get_deps	=  $(PROCPS_SOURCE)

$(STATEDIR)/procps.get: $(procps_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PROCPS))
	@$(call touch, $@)

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
	@$(call touch, $@)

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
PROCPS_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/procps.prepare: $(procps_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(PROCPS_BUILDDIR))
	@$(call touch, $@)

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
ifdef PTXCONF_PROCPS_PS
	cd $(PROCPS_DIR) && $(PROCPS_PATH) make $(PROCPS_MAKEVARS) ps/ps
endif
ifdef PTXCONF_PROCPS_W
	cd $(PROCPS_DIR) && $(PROCPS_PATH) make $(PROCPS_MAKEVARS) w
endif
ifdef PTXCONF_PROCPS_PGREP
	cd $(PROCPS_DIR) && $(PROCPS_PATH) make $(PROCPS_MAKEVARS) pgrep
endif
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

procps_install: $(STATEDIR)/procps.install

$(STATEDIR)/procps.install: $(STATEDIR)/procps.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

procps_targetinstall: $(STATEDIR)/procps.targetinstall

procps_targetinstall_deps = \
	$(STATEDIR)/procps.compile \
	$(STATEDIR)/ncurses.targetinstall

$(STATEDIR)/procps.targetinstall: $(procps_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,procps)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PROCPS_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(PROCPS_DIR)/proc/libproc-3.2.4.so, /usr/lib/libproc-3.2.4.so)

ifdef PTXCONF_PROCPS_TOP
	@$(call install_copy, 0, 0, 0755, $(PROCPS_DIR)/top, /usr/bin/top)
endif

ifdef PTXCONF_PROCPS_SLABTOP
	@$(call install_copy, 0, 0, 0755, $(PROCPS_DIR)/slabtop, /usr/bin/slabtop)
endif
ifdef PTXCONF_PROCPS_SYSCTL
	@$(call install_copy, 0, 0, 0755, $(PROCPS_DIR)/sysctl, /sbin/sysctl)
endif
ifdef PTXCONF_PROCPS_PS
	@$(call install_copy, 0, 0, 0755, $(PROCPS_DIR)/ps/ps, /sbin/ps)
endif
ifdef PTXCONF_PROCPS_W
	@$(call install_copy, 0, 0, 0755, $(PROCPS_DIR)/w, /sbin/w)
endif
ifdef PTXCONF_PROCPS_PGREP
	@$(call install_copy, 0, 0, 0755, $(PROCPS_DIR)/pgrep, /sbin/pgrep)
endif
	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

procps_clean:
	rm -rf $(STATEDIR)/procps.*
	rm -rf $(IMAGEDIR)/procps_*
	rm -rf $(PROCPS_DIR)

# vim: syntax=make
