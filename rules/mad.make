# -*-makefile-*-
# $Id: mad.make,v 1.1 2003/11/13 15:31:55 mkl Exp $
#
# Copyright (C) 2003 by Sascha Hauer <sascha.hauer@gyro-net.de>
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_MAD
PACKAGES += mad
endif

#
# Paths and names
#
MAD_VERSION	= 0.14.2b
MAD		= mad-$(MAD_VERSION)
MAD_SUFFIX	= tar.gz
MAD_URL		= ftp://ftp.mars.org/pub/mpeg/$(MAD).$(MAD_SUFFIX)
MAD_SOURCE	= $(SRCDIR)/$(MAD).$(MAD_SUFFIX)
MAD_DIR		= $(BUILDDIR)/$(MAD)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

mad_get: $(STATEDIR)/mad.get

mad_get_deps = $(MAD_SOURCE)

$(STATEDIR)/mad.get: $(mad_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(MAD_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(MAD_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

mad_extract: $(STATEDIR)/mad.extract

mad_extract_deps = $(STATEDIR)/mad.get

$(STATEDIR)/mad.extract: $(mad_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MAD_DIR))
	@$(call extract, $(MAD_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

mad_prepare: $(STATEDIR)/mad.prepare

#
# dependencies
#
mad_prepare_deps = \
	$(STATEDIR)/mad.extract \
	$(STATEDIR)/virtual-xchain.install

MAD_PATH	=  PATH=$(CROSS_PATH)
MAD_ENV 	=  $(CROSS_ENV)

#
# autoconf
#
MAD_AUTOCONF = \
	--build=$(GNU_HOST) \
	--host=$(PTXCONF_GNU_TARGET) \
	--prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/mad.prepare: $(mad_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(MAD_DIR)/config.cache)
	cd $(MAD_DIR) && \
		$(MAD_PATH) $(MAD_ENV) \
		./configure $(MAD_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

mad_compile: $(STATEDIR)/mad.compile

mad_compile_deps = $(STATEDIR)/mad.prepare

$(STATEDIR)/mad.compile: $(mad_compile_deps)
	@$(call targetinfo, $@)
	$(MAD_PATH) make -C $(MAD_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

mad_install: $(STATEDIR)/mad.install

$(STATEDIR)/mad.install: $(STATEDIR)/mad.compile
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

mad_targetinstall: $(STATEDIR)/mad.targetinstall

mad_targetinstall_deps = $(STATEDIR)/mad.compile

$(STATEDIR)/mad.targetinstall: $(mad_targetinstall_deps)
	@$(call targetinfo, $@)
	install $(MAD_DIR)/madplay $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) $(ROOTDIR)/usr/bin/madplay
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mad_clean:
	rm -rf $(STATEDIR)/mad.*
	rm -rf $(MAD_DIR)

# vim: syntax=make
