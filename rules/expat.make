# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Robert Schwebel <r.schwebel@pengutronix.de>
#                       Pengutronix <info@pengutronix.de>, Germany
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_EXPAT
PACKAGES += expat
endif

#
# Paths and names
#
EXPAT_VERSION		= 1.95.8
EXPAT			= expat-$(EXPAT_VERSION)
EXPAT_SUFFIX		= tar.gz
EXPAT_URL		= http://mesh.dl.sourceforge.net/sourceforge/expat/$(EXPAT).$(EXPAT_SUFFIX)
EXPAT_SOURCE		= $(SRCDIR)/$(EXPAT).$(EXPAT_SUFFIX)
EXPAT_DIR		= $(BUILDDIR)/$(EXPAT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

expat_get: $(STATEDIR)/expat.get

expat_get_deps	=  $(EXPAT_SOURCE)

$(STATEDIR)/expat.get: $(expat_get_deps)
	@$(call targetinfo, $@)
	touch $@

$(EXPAT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(EXPAT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

expat_extract: $(STATEDIR)/expat.extract

expat_extract_deps = $(STATEDIR)/expat.get

$(STATEDIR)/expat.extract: $(expat_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(EXPAT_DIR))
	@$(call extract, $(EXPAT_SOURCE))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

expat_prepare: $(STATEDIR)/expat.prepare

#
# dependencies
#
expat_prepare_deps =  $(STATEDIR)/expat.extract
expat_prepare_deps += $(STATEDIR)/virtual-xchain.install

EXPAT_PATH	=  PATH=$(CROSS_PATH)
EXPAT_ENV 	=  $(CROSS_ENV)
EXPAT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig/

#
# autoconf
#
EXPAT_AUTOCONF  =  $(CROSS_AUTOCONF)
EXPAT_AUTOCONF	+= --prefix=$(CROSS_LIB_DIR)

$(STATEDIR)/expat.prepare: $(expat_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(EXPAT_BUILDDIR))
	cd $(EXPAT_DIR) && \
		$(EXPAT_PATH) $(EXPAT_ENV) \
		./configure $(EXPAT_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

expat_compile: $(STATEDIR)/expat.compile

expat_compile_deps =  $(STATEDIR)/expat.prepare

$(STATEDIR)/expat.compile: $(expat_compile_deps)
	@$(call targetinfo, $@)
	cd $(EXPAT_DIR) && \
	$(EXPAT_PATH) $(EXPAT_ENV) make
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

expat_install: $(STATEDIR)/expat.install

$(STATEDIR)/expat.install: $(STATEDIR)/expat.compile
	@$(call targetinfo, $@)
	cd $(EXPAT_DIR) && \
	$(EXPAT_PATH) $(EXPAT_ENV) make install
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

expat_targetinstall: $(STATEDIR)/expat.targetinstall

expat_targetinstall_deps	=  $(STATEDIR)/expat.compile

$(STATEDIR)/expat.targetinstall: $(expat_targetinstall_deps)
	@$(call targetinfo, $@)

	$(call copy_root, 0, 0, 0644, $(EXPAT_DIR)/.libs/libexpat.so.0.5.0, /lib/libexpat.so.0.5.0)
	$(call link_root, /lib/libexpat.so.0.5.0, /lib/libexpat.so.0)
	$(call link_root, /lib/libexpat.so.0.5.0, /lib/libexpat.so)

	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

expat_clean:
	rm -rf $(STATEDIR)/expat.*
	rm -rf $(EXPAT_DIR)

# vim: syntax=make
