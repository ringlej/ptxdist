# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Ixia Corporation, By Milan Bobde
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GAWK
PACKAGES += gawk
endif

#
# Paths and names
#
GAWK_VERSION	= 3.1.4
GAWK		= gawk-$(GAWK_VERSION)
GAWK_SUFFIX		= tar.gz
GAWK_URL		= http://ftp.gnu.org/gnu/gawk/$(GAWK).$(GAWK_SUFFIX)
GAWK_SOURCE		= $(SRCDIR)/$(GAWK).$(GAWK_SUFFIX)
GAWK_DIR		= $(BUILDDIR)/$(GAWK)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gawk_get: $(STATEDIR)/gawk.get

gawk_get_deps = $(GAWK_SOURCE)

$(STATEDIR)/gawk.get: $(gawk_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(GAWK_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GAWK_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gawk_extract: $(STATEDIR)/gawk.extract

gawk_extract_deps = $(STATEDIR)/gawk.get

$(STATEDIR)/gawk.extract: $(gawk_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GAWK_DIR))
	@$(call extract, $(GAWK_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gawk_prepare: $(STATEDIR)/gawk.prepare

#
# dependencies
#
gawk_prepare_deps = \
	$(STATEDIR)/gawk.extract \
	$(STATEDIR)/virtual-xchain.install

GAWK_PATH	=  PATH=$(CROSS_PATH)
GAWK_ENV 	=  $(CROSS_ENV)
#GAWK_ENV	+=

#
# autoconf
#
GAWK_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/gawk.prepare: $(gawk_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GAWK_DIR)/config.cache)
	cd $(GAWK_DIR) && \
		$(GAWK_PATH) $(GAWK_ENV) \
		./configure $(GAWK_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gawk_compile: $(STATEDIR)/gawk.compile

gawk_compile_deps = $(STATEDIR)/gawk.prepare

$(STATEDIR)/gawk.compile: $(gawk_compile_deps)
	@$(call targetinfo, $@)
	$(GAWK_PATH) make -C $(GAWK_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gawk_install: $(STATEDIR)/gawk.install

$(STATEDIR)/gawk.install: $(STATEDIR)/gawk.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gawk_targetinstall: $(STATEDIR)/gawk.targetinstall

gawk_targetinstall_deps = $(STATEDIR)/gawk.compile

$(STATEDIR)/gawk.targetinstall: $(gawk_targetinstall_deps)
	@$(call targetinfo, $@)
	$(GAWK_PATH) make -C $(GAWK_DIR) install
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gawk_clean:
	rm -rf $(STATEDIR)/gawk.*
	rm -rf $(GAWK_DIR)

# vim: syntax=make
