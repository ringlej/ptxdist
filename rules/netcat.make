# -*-makefile-*-
# $Id: netcat.make,v 1.3 2003/10/26 20:57:12 mkl Exp $
#
# Copyright (C) 2003 Ixia Corporation (www.ixiacom.com), by Milan Bobde
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_NETCAT
PACKAGES += netcat
endif

#
# Paths and names 
#
NETCAT			= netcat-1.10
NETCAT_FILE		= nc110
NETCAT_URL		= http://www.atstake.com/research/tools/network_utilities/nc110.tgz
NETCAT_SOURCE		= $(SRCDIR)/$(NETCAT_FILE).tgz
NETCAT_DIR		= $(BUILDDIR)/$(NETCAT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

netcat_get: $(STATEDIR)/netcat.get

netcat_get_deps  =  $(NETCAT_SOURCE)

$(STATEDIR)/netcat.get: $(netcat_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(NETCAT))
	touch $@

$(NETCAT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NETCAT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

netcat_extract: $(STATEDIR)/netcat.extract

$(STATEDIR)/netcat.extract: $(STATEDIR)/netcat.get
	@$(call targetinfo, $@)
	@$(call clean, $(NETCAT_DIR))
	@$(call extract, $(NETCAT_SOURCE), $(NETCAT_DIR))
	@$(call patchin, $(NETCAT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

netcat_prepare: $(STATEDIR)/netcat.prepare

netcat_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/libpcap.install \
	$(STATEDIR)/netcat.extract

$(STATEDIR)/netcat.prepare: $(netcat_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

netcat_compile: $(STATEDIR)/netcat.compile

netcat_compile_deps = $(STATEDIR)/netcat.prepare

NETCAT_PATH	= PATH=$(CROSS_PATH)
NETCAT_MAKEVARS	= CC="$(PTXCONF_GNU_TARGET)-gcc -DLINUX -lresolv"

$(STATEDIR)/netcat.compile: $(netcat_compile_deps) 
	@$(call targetinfo, $@)
	$(NETCAT_PATH) make $(NETCAT_MAKEVARS) nc -C $(NETCAT_DIR) 
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

netcat_install: $(STATEDIR)/netcat.install

$(STATEDIR)/netcat.install: $(STATEDIR)/netcat.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

netcat_targetinstall: $(STATEDIR)/netcat.targetinstall

$(STATEDIR)/netcat.targetinstall: $(STATEDIR)/netcat.install
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

netcat_clean: 
	rm -rf $(STATEDIR)/netcat.* $(NETCAT_DIR)

# vim: syntax=make
