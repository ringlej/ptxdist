# $Id: template 2224 2005-01-20 15:19:18Z rsc $
#
# Copyright (C) 2005 by mkl
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_CANCONFIG
PACKAGES += canconfig
endif

#
# Paths and names
#
CANCONFIG_VERSION	= 0.0.1
CANCONFIG		= canconfig-$(CANCONFIG_VERSION)
CANCONFIG_SUFFIX	= tar.gz
CANCONFIG_URL		= http://www.pengutronix.de/software/ptxdist/temporary-src/$(CANCONFIG).$(CANCONFIG_SUFFIX)
CANCONFIG_SOURCE	= $(SRCDIR)/$(CANCONFIG).$(CANCONFIG_SUFFIX)
CANCONFIG_DIR		= $(BUILDDIR)/$(CANCONFIG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

canconfig_get: $(STATEDIR)/canconfig.get

canconfig_get_deps = $(CANCONFIG_SOURCE)

$(STATEDIR)/canconfig.get: $(canconfig_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(CANCONFIG))
	touch $@

$(CANCONFIG_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(CANCONFIG_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

canconfig_extract: $(STATEDIR)/canconfig.extract

canconfig_extract_deps = $(STATEDIR)/canconfig.get

$(STATEDIR)/canconfig.extract: $(canconfig_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(CANCONFIG_DIR))
	@$(call extract, $(CANCONFIG_SOURCE))
	@$(call patchin, $(CANCONFIG))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

canconfig_prepare: $(STATEDIR)/canconfig.prepare

#
# dependencies
#
canconfig_prepare_deps = \
	$(STATEDIR)/canconfig.extract \
	$(STATEDIR)/virtual-xchain.install

CANCONFIG_PATH	=  PATH=$(CROSS_PATH)
CANCONFIG_ENV 	=  $(CROSS_ENV)
#CANCONFIG_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#CANCONFIG_ENV	+=


$(STATEDIR)/canconfig.prepare: $(canconfig_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

canconfig_compile: $(STATEDIR)/canconfig.compile

canconfig_compile_deps = $(STATEDIR)/canconfig.prepare

$(STATEDIR)/canconfig.compile: $(canconfig_compile_deps)
	@$(call targetinfo, $@)
	cd $(CANCONFIG_DIR) && $(CANCONFIG_ENV) $(CANCONFIG_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

canconfig_install: $(STATEDIR)/canconfig.install

$(STATEDIR)/canconfig.install: $(STATEDIR)/canconfig.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

canconfig_targetinstall: $(STATEDIR)/canconfig.targetinstall

canconfig_targetinstall_deps = $(STATEDIR)/canconfig.compile

$(STATEDIR)/canconfig.targetinstall: $(canconfig_targetinstall_deps)
	@$(call targetinfo, $@)
	
	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,canconfig)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(CANCONFIG_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(CANCONFIG_DIR)/canconfig, /usr/sbin/canconfig)

	@$(call install_finish)
	
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

canconfig_clean:
	rm -rf $(STATEDIR)/canconfig.*
	rm -rf $(IMAGEDIR)/canconfig_*
	rm -rf $(CANCONFIG_DIR)

# vim: syntax=make
