# -*-makefile-*-
# $Id$
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_PORTMAP
PACKAGES += portmap
endif

#
# Paths and names 
#
PORTMAP			= portmap_4
PORTMAP_URL		= ftp://ftp.porcupine.org/pub/security/$(PORTMAP).tar.gz
PORTMAP_SOURCE		= $(SRCDIR)/$(PORTMAP).tar.gz
PORTMAP_DIR		= $(BUILDDIR)/$(PORTMAP)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

portmap_get: $(STATEDIR)/portmap.get

$(STATEDIR)/portmap.get: $(PORTMAP_SOURCE)
	@$(call targetinfo, $@)
	@$(call get_patches, $(PORTMAP))
	touch $@

$(PORTMAP_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(PORTMAP_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

portmap_extract: $(STATEDIR)/portmap.extract

$(STATEDIR)/portmap.extract: $(STATEDIR)/portmap.get
	@$(call targetinfo, $@)
	@$(call clean, $(PORTMAP_DIR))
	@$(call extract, $(PORTMAP_SOURCE))
	@$(call patchin, $(PORTMAP))
#	apply some fixes
	@$(call disable_sh, $(PORTMAP_DIR)/Makefile, HOSTS_ACCESS)
	@$(call disable_sh, $(PORTMAP_DIR)/Makefile, CHECK_PORT)
	@$(call disable_sh, $(PORTMAP_DIR)/Makefile, AUX)
#	FIXME: uggly, make patch
	perl -i -p -e "s/const/__const/g" $(PORTMAP_DIR)/portmap.c
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

portmap_prepare: $(STATEDIR)/portmap.prepare

portmap_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/tcpwrapper.install \
	$(STATEDIR)/portmap.extract

$(STATEDIR)/portmap.prepare: $(portmap_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

portmap_compile: $(STATEDIR)/portmap.compile

PORTMAP_ENV		= $(CROSS_ENV)
PORTMAP_PATH		= PATH=$(CROSS_PATH)
PORTMAP_MAKEVARS	= WRAP_DIR=$(CROSS_LIB_DIR)/lib

$(STATEDIR)/portmap.compile: $(STATEDIR)/portmap.prepare
	@$(call targetinfo, $@)
	cd $(PORTMAP_DIR) && 						\
		$(PORTMAP_ENV) $(PORTMAP_PATH) make $(PORTMAP_MAKEVARS)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

portmap_install: $(STATEDIR)/portmap.install

$(STATEDIR)/portmap.install: $(STATEDIR)/portmap.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

portmap_targetinstall: $(STATEDIR)/portmap.targetinstall

$(STATEDIR)/portmap.targetinstall: $(STATEDIR)/portmap.install
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,portmap)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(PORTMAP_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_PORTMAP_INSTALL_PORTMAPPER

	@$(call install_copy, 0, 0, 0755, $(PORTMAP_DIR)/portmap, /sbin/portmap)
endif
	@$(call install_finish)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

portmap_clean: 
	rm -rf $(STATEDIR)/portmap.* 
	rm -rf $(IMAGEDIR)/portmap_* 
	rm -rf $(PORTMAP_DIR)

# vim: syntax=make
