# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 Ixia Corporation, by Milan Bobde
#               2005 Pengutronix, Marc Kleine-Budde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_LIBRN
PACKAGES += librn
endif

#
# Paths and names
#
LIBRN_VERSION	= 0.4.4
LIBRN		= librn-$(LIBRN_VERSION)
LIBRN_SUFFIX	= tar.bz2
LIBRN_URL	= http://www.pengutronix.de/software/librn/download/$(LIBRN).$(LIBRN_SUFFIX)
LIBRN_SOURCE	= $(SRCDIR)/$(LIBRN).$(LIBRN_SUFFIX)
LIBRN_DIR	= $(BUILDDIR)/$(LIBRN)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

librn_get: $(STATEDIR)/librn.get

librn_get_deps = $(LIBRN_SOURCE)

$(STATEDIR)/librn.get: $(librn_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(LIBRN))
	$(call touch, $@)

$(LIBRN_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(LIBRN_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

librn_extract: $(STATEDIR)/librn.extract

librn_extract_deps = $(STATEDIR)/librn.get

$(STATEDIR)/librn.extract: $(librn_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBRN_DIR))
	@$(call extract, $(LIBRN_SOURCE))
	@$(call patchin, $(LIBRN))
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

librn_prepare: $(STATEDIR)/librn.prepare

#
# dependencies
#
librn_prepare_deps = \
	$(STATEDIR)/librn.extract \
	$(STATEDIR)/virtual-xchain.install

LIBRN_PATH	=  PATH=$(CROSS_PATH)
LIBRN_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
LIBRN_AUTOCONF = \
	$(CROSS_AUTOCONF) \
	--prefix=$(CROSS_LIB_DIR) \
	--disable-debug

$(STATEDIR)/librn.prepare: $(librn_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(LIBRN_DIR)/config.cache)
	cd $(LIBRN_DIR) && \
		$(LIBRN_PATH) $(LIBRN_ENV) \
		./configure $(LIBRN_AUTOCONF)
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

librn_compile: $(STATEDIR)/librn.compile

librn_compile_deps = $(STATEDIR)/librn.prepare

$(STATEDIR)/librn.compile: $(librn_compile_deps)
	@$(call targetinfo, $@)
	cd $(LIBRN_DIR) && $(LIBRN_ENV) $(LIBRN_PATH) make
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

librn_install: $(STATEDIR)/librn.install

$(STATEDIR)/librn.install: $(STATEDIR)/librn.compile
	@$(call targetinfo, $@)
	cd $(LIBRN_DIR) && $(LIBRN_ENV) $(LIBRN_PATH) make install
	$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

librn_targetinstall: $(STATEDIR)/librn.targetinstall

librn_targetinstall_deps = $(STATEDIR)/librn.compile

$(STATEDIR)/librn.targetinstall: $(librn_targetinstall_deps)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,librn)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(LIBRN_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0644, $(LIBRN_DIR)/src/.libs/librn.so.0.0.0, /usr/lib/librn.so.0.0.0)
	@$(call install_link, librn.so.0.0.0, /usr/lib/librn.so.0)
	@$(call install_link, librn.so.0.0.0, /usr/lib/librn.so)

	@$(call install_finish)

	$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

librn_clean:
	rm -rf $(STATEDIR)/librn.*
	rm -rf $(IMAGEDIR)/librn_*
	rm -rf $(LIBRN_DIR)

# vim: syntax=make
