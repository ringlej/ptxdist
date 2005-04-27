# $Id: template 2516 2005-04-25 10:29:55Z rsc $
#
# Copyright (C) 2005 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_MEMSTAT
PACKAGES += memstat
endif

#
# Paths and names
#
MEMSTAT_VERSION	= 0.4
MEMSTAT		= memstat_$(MEMSTAT_VERSION)
MEMSTAT_SUFFIX	= tar.gz
MEMSTAT_URL	= $(PTXCONF_SETUP_DEBMIRROR)/pool/main/m/memstat/$(MEMSTAT).$(MEMSTAT_SUFFIX)
MEMSTAT_SOURCE	= $(SRCDIR)/$(MEMSTAT).$(MEMSTAT_SUFFIX)
MEMSTAT_DIR	= $(BUILDDIR)/memstat-$(MEMSTAT_VERSION)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

memstat_get: $(STATEDIR)/memstat.get

memstat_get_deps = $(MEMSTAT_SOURCE)

$(STATEDIR)/memstat.get: $(memstat_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(MEMSTAT))
	touch $@

$(MEMSTAT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MEMSTAT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

memstat_extract: $(STATEDIR)/memstat.extract

memstat_extract_deps = $(STATEDIR)/memstat.get

$(STATEDIR)/memstat.extract: $(memstat_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MEMSTAT_DIR))
	@$(call extract, $(MEMSTAT_SOURCE))
	@$(call patchin, $(MEMSTAT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

memstat_prepare: $(STATEDIR)/memstat.prepare

#
# dependencies
#
memstat_prepare_deps = \
	$(STATEDIR)/memstat.extract \
	$(STATEDIR)/virtual-xchain.install

MEMSTAT_PATH	=  PATH=$(CROSS_PATH)
MEMSTAT_ENV 	=  $(CROSS_ENV)
#MEMSTAT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#MEMSTAT_ENV	+=

#
# autoconf
#
MEMSTAT_AUTOCONF =  $(CROSS_AUTOCONF)
MEMSTAT_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/memstat.prepare: $(memstat_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

memstat_compile: $(STATEDIR)/memstat.compile

memstat_compile_deps = $(STATEDIR)/memstat.prepare

$(STATEDIR)/memstat.compile: $(memstat_compile_deps)
	@$(call targetinfo, $@)
	cd $(MEMSTAT_DIR) && $(MEMSTAT_ENV) $(MEMSTAT_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

memstat_install: $(STATEDIR)/memstat.install

$(STATEDIR)/memstat.install: $(STATEDIR)/memstat.compile
	@$(call targetinfo, $@)
	cd $(MEMSTAT_DIR) && $(MEMSTAT_ENV) $(MEMSTAT_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

memstat_targetinstall: $(STATEDIR)/memstat.targetinstall

memstat_targetinstall_deps = $(STATEDIR)/memstat.compile

$(STATEDIR)/memstat.targetinstall: $(memstat_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,memstat)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(MEMSTAT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(MEMSTAT_DIR)/memstat, /usr/bin/memstat)
	
	@$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

memstat_clean:
	rm -rf $(STATEDIR)/memstat.*
	rm -rf $(IMAGEDIR)/memstat_*
	rm -rf $(MEMSTAT_DIR)

# vim: syntax=make
