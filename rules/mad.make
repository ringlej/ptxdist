# -*-makefile-*-
# $Id$
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
	@$(call patchin, $(MAD_SOURCE))
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
MAD_AUTOCONF =  $(CROSS_AUTOCONF)
MAD_AUTOCONF += --prefix=$(CROSS_LIB_DIR)

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
	cd $(MAD_DIR) && $(MAD_PATH) make
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

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,mad)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(MAD_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,libc)
	@$(call install_fixup,DESCRIPTION,missing)

	@$(call install_copy, 0, 0, 0755, $(MAD_DIR)/madplay, /usr/bin/madplay)

	@$(call install_finish)
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

mad_clean:
	rm -rf $(STATEDIR)/mad.*
	rm -rf $(IMAGEDIR)/mad_*
	rm -rf $(MAD_DIR)

# vim: syntax=make
