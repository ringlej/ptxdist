# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Werner Schmitt mail2ws@gmx.de
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_DB41
PACKAGES += db41
endif

#
# Paths and names
#
DB41_VERSION	= 4.1.25.NC
DB41		= db-$(DB41_VERSION)
DB41_SUFFIX	= tar.gz
DB41_URL	= http://www.sleepycat.com/update/snapshot/$(DB41).$(DB41_SUFFIX)
DB41_SOURCE	= $(SRCDIR)/$(DB41).$(DB41_SUFFIX)
DB41_DIR	= $(BUILDDIR)/$(DB41)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

db41_get: $(STATEDIR)/db41.get

db41_get_deps	=  $(DB41_SOURCE)

$(STATEDIR)/db41.get: $(db41_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(DB41_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(DB41_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

db41_extract: $(STATEDIR)/db41.extract

db41_extract_deps	=  $(STATEDIR)/db41.get

$(STATEDIR)/db41.extract: $(db41_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DB41_DIR))
	@$(call extract, $(DB41_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

db41_prepare: $(STATEDIR)/db41.prepare

#
# dependencies
#
db41_prepare_deps =  \
	$(STATEDIR)/db41.extract \
	$(STATEDIR)/virtual-xchain.install

DB41_PATH	=  PATH=$(PTXCONF_PREFIX)/$(PTXCONF_GNU_TARGET)/bin:$(CROSS_PATH)
DB41_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
DB41_AUTOCONF	=  $(CROSS_AUTOCONF)
DB41_AUTOCONF	=  --prefix=$(CROSS_LIB_DIR)
DB41_AUTOCONF	+= --enable-cxx 

$(STATEDIR)/db41.prepare: $(db41_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(DB41_BUILDDIR))
	cd $(DB41_DIR)/dist && \
		$(DB41_PATH) $(DB41_ENV) \
		./configure $(DB41_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

db41_compile: $(STATEDIR)/db41.compile

db41_compile_deps =  $(STATEDIR)/db41.prepare

$(STATEDIR)/db41.compile: $(db41_compile_deps)
	@$(call targetinfo, $@)
	$(DB41_PATH) $(DB41_ENV) make -C $(DB41_DIR)/dist
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

db41_install: $(STATEDIR)/db41.install

$(STATEDIR)/db41.install: $(STATEDIR)/db41.compile
	@$(call targetinfo, $@)
	$(DB41_PATH) $(DB41_ENV) make -C $(DB41_DIR)/dist install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

db41_targetinstall_deps: $(STATEDIR)/db41.targetinstall
	$(STATEDIR)/db41.install

$(STATEDIR)/db41.targetinstall: $(db41_targetinstall_deps)
	@$(call targetinfo, $@)
	install -d $(ROOTDIR)/usr/bin 
	install $(CROSS_LIB_DIR)/bin/db_* $(ROOTDIR)/usr/bin
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/db_* 

	install -d $(ROOTDIR)/usr/lib 
	cp -pd $(CROSS_LIB_DIR)/lib/libdb*.so* $(ROOTDIR)/usr/lib
	$(CROSS_STRIP) -R .note -R .comment $(ROOTDIR)/usr/lib/libdb*.so* 
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

db41_clean:
	rm -rf $(STATEDIR)/db41.*
	rm -rf $(DB41_DIR)

# vim: syntax=make
