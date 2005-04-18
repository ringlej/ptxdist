# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_BING
PACKAGES += bing
endif

#
# Paths and names
#
BING_VERSION		= 1.0.5
BING			= bing-$(BING_VERSION)
BING_SUFFIX		= tar.gz
BING_URL		= http://www.freenix.org/reseau/$(BING).$(BING_SUFFIX)
BING_SOURCE		= $(SRCDIR)/$(BING).$(BING_SUFFIX)
BING_DIR		= $(BUILDDIR)/$(BING)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bing_get: $(STATEDIR)/bing.get

bing_get_deps = $(BING_SOURCE)

$(STATEDIR)/bing.get: $(bing_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(BING))
	touch $@

$(BING_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(BING_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bing_extract: $(STATEDIR)/bing.extract

bing_extract_deps = $(STATEDIR)/bing.get

$(STATEDIR)/bing.extract: $(bing_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(BING_DIR))
	@$(call extract, $(BING_SOURCE))
	@$(call patchin, $(BING))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bing_prepare: $(STATEDIR)/bing.prepare

#
# dependencies
#
bing_prepare_deps = \
	$(STATEDIR)/bing.extract \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/virtual-libc.targetinstall

BING_PATH	=  PATH=$(CROSS_PATH)
BING_ENV 	=  $(CROSS_ENV)
#BING_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#BING_ENV	+=

$(STATEDIR)/bing.prepare: $(bing_prepare_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bing_compile: $(STATEDIR)/bing.compile

bing_compile_deps = $(STATEDIR)/bing.prepare

$(STATEDIR)/bing.compile: $(bing_compile_deps)
	@$(call targetinfo, $@)
	cd $(BING_DIR) && $(BING_ENV) $(BING_PATH) make bing
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bing_install: $(STATEDIR)/bing.install

$(STATEDIR)/bing.install: $(STATEDIR)/bing.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bing_targetinstall: $(STATEDIR)/bing.targetinstall

bing_targetinstall_deps = $(STATEDIR)/bing.compile

$(STATEDIR)/bing.targetinstall: $(bing_targetinstall_deps)
	@$(call targetinfo, $@)

	install -d $(ROOTDIR)/usr/sbin

	$(call install_init,default)
	$(call install_fixup,PACKAGE,bing)
	$(call install_fixup,PRIORITY,optional)
	$(call install_fixup,VERSION,$(BING_VERSION))
	$(call install_fixup,SECTION,base)
	$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	$(call install_fixup,DEPENDS,libc)
	$(call install_fixup,DESCRIPTION,missing)
	$(call install_copy, 0, 0, 0755, $(BING_DIR)/bing, /usr/sbin/bing)
	$(call install_finish)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bing_clean:
	rm -rf $(STATEDIR)/bing.*
	rm -rf $(BING_DIR)

# vim: syntax=make
