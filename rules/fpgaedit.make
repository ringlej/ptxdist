# $Id$
#
# Copyright (C) 2004 by Robert Schwebel
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_FPGAEDIT
PACKAGES += fpgaedit
endif

#
# Paths and names
#
FPGAEDIT_VERSION	= 0.2
FPGAEDIT		= fpgaedit-$(FPGAEDIT_VERSION)
FPGAEDIT_SUFFIX		= tar.gz
FPGAEDIT_URL		= http://www.pengutronix.de/software/fpgaedit/downloads/$(FPGAEDIT).$(FPGAEDIT_SUFFIX)
FPGAEDIT_SOURCE		= $(SRCDIR)/$(FPGAEDIT).$(FPGAEDIT_SUFFIX)
FPGAEDIT_DIR		= $(BUILDDIR)/$(FPGAEDIT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

fpgaedit_get: $(STATEDIR)/fpgaedit.get

fpgaedit_get_deps = $(FPGAEDIT_SOURCE)

$(STATEDIR)/fpgaedit.get: $(fpgaedit_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(FPGAEDIT))
	touch $@

$(FPGAEDIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(FPGAEDIT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

fpgaedit_extract: $(STATEDIR)/fpgaedit.extract

fpgaedit_extract_deps = $(STATEDIR)/fpgaedit.get

$(STATEDIR)/fpgaedit.extract: $(fpgaedit_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FPGAEDIT_DIR))
	@$(call extract, $(FPGAEDIT_SOURCE))
	@$(call patchin, $(FPGAEDIT))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

fpgaedit_prepare: $(STATEDIR)/fpgaedit.prepare

#
# dependencies
#
fpgaedit_prepare_deps = \
	$(STATEDIR)/fpgaedit.extract \
	$(STATEDIR)/virtual-xchain.install

FPGAEDIT_PATH	=  PATH=$(CROSS_PATH)
FPGAEDIT_ENV 	=  $(CROSS_ENV)
#FPGAEDIT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig
#FPGAEDIT_ENV	+=

#
# autoconf
#
FPGAEDIT_AUTOCONF =  $(CROSS_AUTOCONF)
FPGAEDIT_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/fpgaedit.prepare: $(fpgaedit_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(FPGAEDIT_DIR)/config.cache)
	cd $(FPGAEDIT_DIR) && \
		$(FPGAEDIT_PATH) $(FPGAEDIT_ENV) \
		./configure $(FPGAEDIT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

fpgaedit_compile: $(STATEDIR)/fpgaedit.compile

fpgaedit_compile_deps = $(STATEDIR)/fpgaedit.prepare

$(STATEDIR)/fpgaedit.compile: $(fpgaedit_compile_deps)
	@$(call targetinfo, $@)
	cd $(FPGAEDIT_DIR) && $(FPGAEDIT_ENV) $(FPGAEDIT_PATH) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

fpgaedit_install: $(STATEDIR)/fpgaedit.install

$(STATEDIR)/fpgaedit.install: $(STATEDIR)/fpgaedit.compile
	@$(call targetinfo, $@)
	cd $(FPGAEDIT_DIR) && $(FPGAEDIT_ENV) $(FPGAEDIT_PATH) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

fpgaedit_targetinstall: $(STATEDIR)/fpgaedit.targetinstall

fpgaedit_targetinstall_deps = $(STATEDIR)/fpgaedit.compile

$(STATEDIR)/fpgaedit.targetinstall: $(fpgaedit_targetinstall_deps)
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

fpgaedit_clean:
	rm -rf $(STATEDIR)/fpgaedit.*
	rm -rf $(FPGAEDIT_DIR)

# vim: syntax=make
